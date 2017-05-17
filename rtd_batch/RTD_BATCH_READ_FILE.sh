set -x
#function

gzip_file()
{
gzip -f $1 #$DataFileHome/$FileName
mv $2 $3  #$DataFileHome/$FileName.gz $ArchiveDirectory
}

# Call script to set variables
. /rtd/rtd_batch/Common_Variables.sh
#. Common_Variables.sh


export ORACLE_HOME=$ORACLEHOME

if [ ! -f $DataFileHome/REQ_EM_* ]; then
        exit 2 # File does not exist yet, exit shell script and set exit status code for Control-M
fi

FileName=$(ls $DataFileHome/REQ_EM_* -b | head -1 | xargs -n1 basename)
FileName_NoSuffix=$(echo "$FileName" | rev | cut -d "." -f2 | rev)
NoOfRecords=$(echo "$FileName_NoSuffix" |  cut -d "_" -f7 )
CampaignVersion=$(echo "$FileName_NoSuffix" | cut -d "_" -f6 )
Campaign=$(echo "$FileName_NoSuffix" | cut -d "_" -f4 )
CompanyName=$(echo "$FileName_NoSuffix" |  cut -d "_" -f3 )
CompanyCode="H"
CampaignWithCompany="EM_"$CompanyName"_"$Campaign

# sqldr setup
SQLLDRCTLPath="REQ_EM_"$CompanyName"_"$Campaign

if [ "$CompanyName" == "SBN" ]; then
   CompanyCode="S"
fi

model_count=`$SQLPlusApp/sqlplus -S $DBCredentials <<EOF
    set head off
	SELECT count(1) FROM RTD_BATCH_HEADER_STAGING WHERE BATCH_STATUS='LOADED';
	exit;
EOF`

model_count="$(echo -e "${model_count}" | tr -d '[:space:]')"

if [ $model_count != 0 ]; then
    python3 sendErrorMail.py "$FileName" "other file still processing."
    exit 2 # Other file still processing, exit shell script and set exit status code for Control-M
fi







ActualNoOfRecords=$(wc -l $DataFileHome/$FileName | cut -d " " -f1)

if [ ! $NoOfRecords -eq $(expr $ActualNoOfRecords - 1) ]; then
  #gzip_file $DataFileHome/$FileName $DataFileHome/$FileName.gz $ArchiveDirectory_Failed
  python3 sendErrorMail.py "$FileName" "no of record send not match the no of line number."
  exit 3 # NoOfRecords not match ActualNoOfRecords
fi

echo $NoOfRecords -eq $ActualNoOfRecords



# Use SQL*Loader to load files.  Check status of SQL*Loader after each call.  Large loads sometime cause an Exit status of 2.  Not sure why, but does not represent a bad load.
$SQLLoaderApp/sqlldr $DBCredentials $SQLLoaderHome/$SQLLDRCTLPath $SQLLoaderHome/logs/$SQLLDRCTLPath.log $SQLLoaderHome/logs/$SQLLDRCTLPath.bad $DataFileHome/$FileName rows=1000 bindsize=8000000 errors=100000 skip=1 
ExitStatus=$?
if [ $ExitStatus != 0 -a $ExitStatus != 2 ]; then
       # gzip_file $DataFileHome/$FileName $DataFileHome/$FileName.gz $ArchiveDirectory_Failed
	    python3 sendErrorMail.py "$FileName" "having problem loading data into DB."
        exit 3
else
cd $SQLLoaderHome/logs
File_service1=$(cat $SQLLDRCTLPath.log | grep 'Rows successfully loaded')
File_service2=$(cat $SQLLDRCTLPath.log | grep 'Rows not loaded due to data errors')
fi

NoOfSuccess=$(echo "$File_service1" | egrep -o '[[:digit:]]+' | head -n1)
NoOfError=$(echo "$File_service2" | egrep -o '[[:digit:]]+' | head -n1)
BATCH_STATUS="LOADED"
if [ ! $NoOfRecords -eq  $NoOfSuccess ]; then
 BATCH_STATUS="FAILED";
fi

$SQLPlusApp/sqlplus $DBCredentials <<EOF
        set serveroutput on
                        Insert into RTD_BATCH_HEADER_STAGING (FILE_NAME,CAMPAIGN,CAMPAIGN_VERSION,COMPANY_CODE,RECORD_COUNT,SUCCESS_COUNT,ERROR_COUNT,BATCH_STATUS) values ('$FileName_NoSuffix','$CampaignWithCompany','$CampaignVersion','$CompanyCode',$NoOfRecords,$NoOfSuccess,$NoOfError,'$BATCH_STATUS');
						update RTD_BATCH_INPUTFILE_STAGING set FILE_NAME='$FileName_NoSuffix';
                        commit;
						exit
EOF


if [ ! $NoOfRecords -eq  $NoOfSuccess ]; then
  cd /rtd/rtd_batch
  #gzip_file $DataFileHome/$FileName $DataFileHome/$FileName.gz $ArchiveDirectory_Failed  
  python3 sendErrorMail.py "$FileName" "number of records successful loaded in DB not match to the number of records in the file."
  exit 3 # NoOfRecords not match to NoOfSuccess loaded!
fi

$SQLPlusApp/sqlplus $DBCredentials << EOF
set serveroutput on
whenever sqlerror exit 3
exec RTD_BATCH_LOADFILE_SP
exit
EOF

sql_return_code=$?

if [ $sql_return_code -eq  3 ]; then 
  cd /rtd/rtd_batch
  python3 sendErrorMail.py "$FileName" "error when copy data from staging to actual table."
  exit 3 # NoOfRecords not match to NoOfSuccess loaded
fi

gzip_file $DataFileHome/$FileName $DataFileHome/$FileName.gz $ArchiveDirectory


# Exit and set successful Control-M status
exit 0

