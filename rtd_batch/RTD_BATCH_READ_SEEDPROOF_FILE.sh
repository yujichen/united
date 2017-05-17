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

if [ ! -f $DataFileHome/SBN_EM_CRZMON_* ]; then
        exit 2 # File does not exist yet, exit shell script and set exit status code for Control-M
fi

FileName=$(ls $DataFileHome/SBN_EM_CRZMON_* -b | head -1 | xargs -n1 basename)
FileName_NoSuffix=$(echo "$FileName" | rev | cut -d "." -f2 | rev)
List_Type=$(echo "$FileName_NoSuffix" | cut -d "_" -f4 )
CampaignCode=$(echo "$FileName_NoSuffix" |  cut -d "_" -f3 )
ChannelCode=$(echo "$FileName_NoSuffix" |  cut -d "_" -f2 )
CompanyName=$(echo "$FileName_NoSuffix" |  cut -d "_" -f1 )
CompanyCode="H"
CampaignCodeFull="$ChannelCode"_"$CompanyName"_"$CampaignCode"

# sqldr setup
SQLLDRCTLPath="SBN_EM_CRZMON_SEEDPROOF"

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
                        Insert into RTD_BATCH_HEADER_STAGING (FILE_NAME,CAMPAIGN,CAMPAIGN_VERSION,COMPANY_CODE,RECORD_COUNT,SUCCESS_COUNT,ERROR_COUNT,BATCH_STATUS) values ('$FileName_NoSuffix','$CampaignCodeFull','$List_Type','$CompanyCode',$ActualNoOfRecords,$NoOfSuccess,$NoOfError,'$BATCH_STATUS');
                        commit;
						exit
EOF


if [ ! $NoOfRecords -eq  $NoOfSuccess ]; then
  #gzip_file $DataFileHome/$FileName $DataFileHome/$FileName.gz $ArchiveDirectory_Failed
  python3 sendErrorMail.py "$FileName" "number of records successful loaded in DB not match to the number of records in the file."
  exit 3 # NoOfRecords not match to NoOfSuccess loaded
fi

$SQLPlusApp/sqlplus $DBCredentials << EOF
set serveroutput on
whenever sqlerror exit 3
exec RTD_BATCH_LOAD_SEEDPROOF_SP
exit
EOF

gzip_file $DataFileHome/$FileName $DataFileHome/$FileName.gz $ArchiveDirectory


# Exit and set successful Control-M status
exit 0

