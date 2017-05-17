set -x
#function


retn_code=0
# Call script to set variables
. /rtd/rtd_batch/Common_Variables.sh
#. Common_Variables.sh



if ls $DataFileHome/REQ_EM_* 1> /dev/null 2>&1; then
      ./RTD_BATCH_READ_FILE.sh
	  retn_code=$?
elif ls $DataFileHome/REQ_DM_* 1> /dev/null 2>&1; then 
    ./RTD_SBN_BATCH.sh
	retn_code=$?
elif ls $DataFileHome/SBN_* 1> /dev/null 2>&1; then 
    ./RTD_BATCH_READ_SEEDPROOF_FILE.sh
	retn_code=$?
else
    exit 2 # File does not exist yet, exit shell script and set exit status code for Control-M
fi




# Exit and set successful Control-M status
exit $retn_code

