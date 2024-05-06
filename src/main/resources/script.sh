#!/bin/bash


: ' This block is under testing and currently only used for Dirac, and not for local execution.

mkdir -p config inv

# Find files ending with -configuration.json and move them to config folder
config_files=$(find . -type f -name "*-configuration.json")
for file in $config_files; do
    echo "Moving $file to config folder"
    mv "$file" config/
done

# Find files ending with -invocation.json and move them to inv folder
inv_files=$(find . -type f -name "*-invocation.json")
for file in $inv_files; do
    echo "Moving $file to inv folder"
    mv "$file" inv/
done

# Save the names of the files in variables
configurationJson=$(find config/ -type f -exec basename {} \;)
'

#!/bin/bash

# Extract filename without extension
filename=$(basename "${0%.sh}")

# Path to the configuration JSON file
configurationJson="config/$filename-configuration.json"

jsonFileName=$(grep -Po '"jsonFileName": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
applicationName=$(grep -Po '"applicationName": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
jobId=$(grep -Po '"jobId": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
invocationJson=$(grep -Po '"invocationJson": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
serviceCall=$(grep -Po '"serviceCall": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
downloads=$(grep -Po '"downloads": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
invocationString=$(grep -Po '"invocationString": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
envVariables=$(grep -Po '"envVariables": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
parameters=$(grep -Po '"parameters": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
uploads=$(grep -Po '"uploads": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
downloadFiles=$(grep -Po '"downloadFiles": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
outputDirName=$(grep -Po '"outputDirName": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')

LAB_DEFAULT_BACKGROUD_SCRIPT=$(grep -Po '"LAB_DEFAULT_BACKGROUD_SCRIPT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_DEFAULT_CPUTIME=$(grep -Po '"LAB_DEFAULT_CPUTIME": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_DEFAULT_ENVIRONMENT=$(grep -Po '"LAB_DEFAULT_ENVIRONMENT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_DEFAULT_EXECUTOR=$(grep -Po '"LAB_DEFAULT_EXECUTOR": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_DEFAULT_REQUIREMENTS=$(grep -Po '"LAB_DEFAULT_REQUIREMENTS": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_DEFAULT_RETRY_COUNT=$(grep -Po '"LAB_DEFAULT_RETRY_COUNT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_DEFAULT_SLEEPTIME=$(grep -Po '"LAB_DEFAULT_SLEEPTIME": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_DEFAULT_TIMEOUT=$(grep -Po '"LAB_DEFAULT_TIMEOUT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_FAILOVER_ENABLED=$(grep -Po '"LAB_FAILOVER_ENABLED": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_FAILOVER_HOME=$(grep -Po '"LAB_FAILOVER_HOME": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_FAILOVER_HOST=$(grep -Po '"LAB_FAILOVER_HOST": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_FAILOVER_PORT=$(grep -Po '"LAB_FAILOVER_PORT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_FAILOVER_RETRY=$(grep -Po '"LAB_FAILOVER_RETRY": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_MINORSTATUS_ENABLED=$(grep -Po '"LAB_MINORSTATUS_ENABLED": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_PLUGIN_DB=$(grep -Po '"LAB_PLUGIN_DB": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_PLUGIN_EXECUTOR=$(grep -Po '"LAB_PLUGIN_EXECUTOR": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_PLUGIN_LISTENER=$(grep -Po '"LAB_PLUGIN_LISTENER": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_VO_DEFAULT_SE=$(grep -Po '"LAB_VO_DEFAULT_SE": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_VO_NAME=$(grep -Po '"LAB_VO_NAME": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_VO_USE_CLOSE_SE=$(grep -Po '"LAB_VO_USE_CLOSE_SE": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_BOSH_CVMFS_PATH=$(grep -Po '"LAB_BOSH_CVMFS_PATH": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_CONTAINERS_CVMFS_PATH=$(grep -Po '"LAB_CONTAINERS_CVMFS_PATH": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_UDOCKER_TAG=$(grep -Po '"LAB_UDOCKER_TAG": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
LAB_MIN_AVG_DOWNLOAD_THROUGHPUT=$(grep -Po '"LAB_MIN_AVG_DOWNLOAD_THROUGHPUT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
CONNECT_TIMEOUT=$(grep -Po '"CONNECT_TIMEOUT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
BDII_TIMEOUT=$(grep -Po '"BDII_TIMEOUT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
SRM_TIMEOUT=$(grep -Po '"SRM_TIMEOUT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
SCRIPT_ROOT=$(grep -Po '"SCRIPT_ROOT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
JDL_ROOT=$(grep -Po '"JDL_ROOT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
OUT_ROOT=$(grep -Po '"OUT_ROOT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
ERR_ROOT=$(grep -Po '"ERR_ROOT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
CACHE_DIR=$(grep -Po '"CACHE_DIR": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
CACHE_FILE=$(grep -Po '"CACHE_FILE": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
INV_DIR=$(grep -Po '"INV_DIR": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
CONFIG_DIR=$(grep -Po '"CONFIG_DIR": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
OUT_EXT=$(grep -Po '"OUT_EXT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
ERR_EXT=$(grep -Po '"ERR_EXT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
ERR_APP_EXT=$(grep -Po '"ERR_APP_EXT": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
ENV_EXECUTOR=$(grep -Po '"ENV_EXECUTOR": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
numberOfReplicas=$(grep -Po '"numberOfReplicas": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')

defaultSleeptime=$(grep -Po '"defaultSleeptime": *\K[^,]*' "$configurationJson")
simulationID=$(grep -Po '"simulationID": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
workflowID=$(grep -Po '"workflowID": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
executionPath=$(grep -Po '"executionPath": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
defaultBackgroundScript=$(grep -Po '"defaultBackgroundScript": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
defaultCPUTime=$(grep -Po '"defaultCPUTime": *\K[^,]*' "$configurationJson")
defaultEnvironment=$(grep -Po '"defaultEnvironment": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
defaultExecutor=$(grep -Po '"defaultExecutor": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
voDefaultSE=$(jq -r '.gaswConfiguration.voDefaultSE' "$configurationJson" | tr -d '"')
voUseCloseSE=$(grep -Po '"voUseCloseSE": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
boshCVMFSPath=$(grep -Po '"boshCVMFSPath": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
containersCVMFSPath=$(grep -Po '"containersCVMFSPath": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
udockerTag=$(grep -Po '"udockerTag": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
failOverEnabled=$(grep -Po '"failOverEnabled": *\K[^,]*' "$configurationJson")
failOverHost=$(grep -Po '"failOverHost": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
failOverPort=$(grep -Po '"failOverPort": *\K[^,]*' "$configurationJson")
failOverHome=$(grep -Po '"failOverHome": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
minorStatusEnabled=$(grep -Po '"minorStatusEnabled": *\K[^,]*' "$configurationJson")
minAvgDownloadThroughput=$(grep -Po '"minAvgDownloadThroughput": *\K[^,]*' "$configurationJson")
defaultRetryCount=$(grep -Po '"defaultRetryCount": *\K[^,]*' "$configurationJson")
executorPlugins=$(grep -Po '"executorPlugins": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
listenerPlugins=$(grep -Po '"listenerPlugins": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
sessionFactory=$(grep -Po '"sessionFactory": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')
failOverMaxRetry=$(grep -Po '"failOverMaxRetry": *\K[^,]*' "$configurationJson")
config=$(grep -Po '"config": *\K"[^"]*"' "$configurationJson" | sed 's/"//g')




# Now you have all variables assigned from the JSON file
# You can use them as needed in your script


#jsonFileName="../workflow.json" #temporary variable

function info {
  local D=`date`
  echo [ INFO - $D ] $*
}

function warning {
  local D=`date`
  echo [ WARN - $D ] $*
}

function error {
  local D=`date`
  echo [ ERROR - $D ] $* >&2
}

function startLog {
  echo "<$*>" >&1
  echo "<$*>" >&2
}

function stopLog {
  local logName=$1
  echo "</${logName}>" >&1
  echo "</${logName}>" >&2
}


function cleanup {
    if [[ $isGfalmountExec -eq 0 ]]    #flag checks if directories are mounted with gfal
    then
        unmountGfal    #unmounts all gfal mounted directories
        unlink /tmp/*_$(basename $PWD)
    fi
    startLog cleanup
    info "=== ls -a ==="
    ls -a
    info "=== ls $cacheDir/$cacheFile ==="
    ls $cacheDir/$cacheFile
    info "=== cat $cacheDir/$cacheFile === "
    cat $cacheDir/$cacheFile
    info "Cleaning up: rm * -Rf"
    #\rm * -Rf
    if [ "${BACKPID}" != "" ]
    then
        for i in `ps --ppid ${BACKPID} -o pid | grep -v PID`
        do
            info "Killing child of background script (pid ${i})"
            kill -9 ${i}
        done
        info "Killing background script (pid ${BACKPID})"
        kill -9 ${BACKPID}
    fi
    info "END date:"
    date +%s
    stopLog cleanup
    check_cleanup=true
}

export -f cleanup
trap 'echo "trap activation" && stopRefreshingToken | \
if [ "$check_cleanup" = true ]; then \
    echo "cleanup was already executed successfully"; \
else \
    echo "Executing cleanup" && cleanup; \
fi' INT EXIT


function checkCacheDownloadAndCacheLFN {

    local LFN=$1
    # the LFN is assumed to be in the /grid/biomed/... format (no leading lfn://lfc-biomed.in2p3.fr:5010/)
    # this variable is true <=> the file has to be downloaded again
    local download="true"
    # first check if the file is already in cache
    local LOCALPATH=`awk -v L=${LFN} '$1==L {print $2}' ${BASEDIR}/cache/cache.txt`
    if [ "${LOCALPATH}" != "" ]
    then
        info "There is an entry in the cache: test if the local file still here"
        local TIMESTAMP_LOCAL=""
        local TIMESTAMP_GRID=""
        local date_local=""
        test -f ${LOCALPATH}
        if [ $? = 0 ]
        then
            info "The file exists: checking if it was modified since it was added to the cache"
            local YEAR=`date +%Y`
            local YEARBEFORE=`expr ${YEAR} - 1`
            local currentDate=`date +%s`
            local TIMESTAMP_CACHE=`awk -v L=${LFN} '$1==L {print $3}' ${BASEDIR}/cache/cache.txt`
            local LOCALMONTH=`ls -la ${LOCALPATH} | awk -F' ' '{print $6}'`
            local MONTHTIME=`date -d "${LOCALMONTH} 1 00:00" +%s`
            date_local=`ls -la ${LOCALPATH} | awk -F' ' '{print $6, $7, $8}'`
            if [ "${MONTHTIME}" -gt "${currentDate}" ]
            then
                TIMESTAMP_LOCAL=`date -d "${date_local} ${YEARBEFORE}" +%s`
            else
                TIMESTAMP_LOCAL=`date -d "${date_local} ${YEAR}" +%s`
            fi
            if [ "${TIMESTAMP_CACHE}" = "${TIMESTAMP_LOCAL}" ]
            then
                info "The file was not touched since it was added to the cache: test if it is up up-to-date"
                local date_grid_s=`lfc-ls -l ${LFN} | awk -F' ' '{print $6, $7, $8}'`
                local MONTHGRID=`echo ${date_grid_s} | awk -F' ' '{print $1}'`
                MONTHTIME=`date -d "${MONTHGRID} 1 00:00" +%s`
                if [ "${MONTHTIME}" != "" ] && [ "${date_grid_s}" != "" ]
                then
                    if [ "${MONTHTIME}" -gt "${currentDate}" ]
                    then
                        # it must be last year
                        TIMESTAMP_GRID=`date -d "${date_grid_s} ${YEARBEFORE}" +%s`
                    else
                        TIMESTAMP_GRID=`date -d "${date_grid_s} ${YEAR}" +%s`
                    fi
                    if [ "${TIMESTAMP_LOCAL}" -gt "${TIMESTAMP_GRID}" ]
                    then
                        info "The file is up-to-date ; there is no need to download it again"
                        download="false"
                    else
                        warning "The cache entry is outdated (local modification date is ${TIMESTAMP_LOCAL} - ${date_local} while grid is ${TIMESTAMP_GRID} ${date_grid_s})"
                    fi
                else
                    warning "Cannot determine file timestamp on the LFC"
                fi
            else
                warning "The cache entry was modified since it was created (cache time is ${TIMESTAMP_CACHE} and file time is ${TIMESTAMP_LOCAL} - ${date_local})"
            fi
        else
            warning "The cache entry disappeared"
        fi
    else
        info "There is no entry in the cache"
    fi
    if [ "${download}" = "false" ]
    echo FALSEEEEEEEE
    downloadLFN ${LFN}
    then
        info "Linking file from cache: ${LOCALPATH}"
        BASE=`basename ${LFN}`
        info "ln -s ${LOCALPATH} ./${BASE}"
        ln -s  ${LOCALPATH} ./${BASE}
        return 0
    fi
    if [ "${download}" = "true" ]
    echo TRUEEEEEE
    then
        downloadLFN ${LFN}
        if  [ $? != 0 ]
        then
            return 1
        fi
        addToCache ${LFN} `basename ${LFN}`
        return 0
    fi
}

export -f checkCacheDownloadAndCacheLFN


SHANOIR_TOKEN_LOCATION="${PWD}/cache/SHANOIR_TOKEN.txt"
SHANOIR_REFRESH_TOKEN_LOCATION="${PWD}/cache/SHANOIR_REFRESH_TOKEN.txt"
REFRESHING_JOB_STARTED=false
REFRESH_PID=""

#
# This is a background process to refresh shanoir token
# URIs are of the form of the following example. A single "/", instead
# of 3, after "shanoir:" is also allowed.
# shanoir:/path/to/file/filename?&refreshToken=eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lk....&keycloak_client_id=....&keycloak_client_secret=...
# The mandatory arguments are: keycloak_client_id, keycloak_client_secret.
#
function refresh_token {
    touch "$SHANOIR_TOKEN_LOCATION"
    touch "$SHANOIR_REFRESH_TOKEN_LOCATION"

    local subshell_refresh_token=$(cat "$SHANOIR_REFRESH_TOKEN_LOCATION")

    echo "refresh token process started !"

    local URI=$1
    local keycloak_client_id=$(echo "$URI" | sed -r 's/^.*[?&]keycloak_client_id=([^&]*)(&.*)?$/\1/i')
    local refresh_token_url=$(echo "$URI" | sed -r 's/^.*[?&]refresh_token_url=([^&]*)(&.*)?$/\1/i')

    if [[ ! "$subshell_refresh_token" ]]; then
        # initializing the refresh token
        subshell_refresh_token=$(echo "$URI" | sed -r 's/^.*[?&]refreshToken=([^&]*)(&.*)?$/\1/i')
        echo "$subshell_refresh_token" > "$SHANOIR_REFRESH_TOKEN_LOCATION"
    fi

    while :; do

        # get the new refresh token
        subshell_refresh_token=$(cat "$SHANOIR_REFRESH_TOKEN_LOCATION")

        # the response format is "{"status":"status"}"
        # this response format is made to handle error while getting the refreshed token in the same time
        COMMAND() {
            curl -w "{\"status\":\"%{http_code}\"}" -sb -o --request POST "${refresh_token_url}" --header "Content-Type: application/x-www-form-urlencoded" --data-urlencode "client_id=${keycloak_client_id}" --data-urlencode "grant_type=refresh_token" --data-urlencode "refresh_token=${subshell_refresh_token}"
        }

        refresh_response=$(COMMAND)
        status_code=$(echo "$refresh_response" | grep -o '"status":"[^"]*' | grep -o '[^"]*$')

        if [[ "$status_code" -ne 200 ]]; then
            error_message=$(echo "$refresh_response" | grep -o '"error_description":"[^"]*' | grep -o '[^"]*$')
            error "error while refreshing the token with status : ${status_code} and message error : ${error_message}"
            exit 1
        fi

        # setting the new tokens
        echo "$refresh_response" | grep -o '"access_token":"[^"]*' | grep -o '[^"]*$' > "$SHANOIR_TOKEN_LOCATION"
        echo "$refresh_response" | grep -o '"refresh_token":"[^"]*' | grep -o '[^"]*$' > "$SHANOIR_REFRESH_TOKEN_LOCATION"

        sleep 240
    done

}
#
# Cleanup method: stop the refreshing process
#

function stopRefreshingToken {
    if [ "${REFRESH_PID}" != "" ]; then
        info "Killing background refresh token process with id : ${REFRESH_PID}"
        kill -9 "${REFRESH_PID}"
        REFRESH_PID=""
        echo "refresh token process ended !"
    fi
}
#
# The refresh token may take some time, this method is for that purpose
# and it exit the program if it's timed out
#

function wait_for_token {
    local token=""
    local attempts=0

    while [[ "${attempts}" -ne 3 ]]; do
        token=$(cat "$SHANOIR_TOKEN_LOCATION")
        if [[ "${token}" == "" ]]; then
            echo "token is not refreshed yet, waiting for 3 seconds..."
            echo "attempts : ${attempts}"
            attempts=$((attempts + 1))
            sleep 3
        else
            echo "token is refreshed !"
            break
        fi
    done
}


function downloadLFN {

    local LFN=$1
    echo "LFN : ${LFN}"

    # Sanitize LFN:
    # - "lfn:" at the beginning is optional for dirac-dms-* commands,
    #    but does not work as expected with comdirac commands like
    #    dmkdir.
    # - "//" are not accepted, neither by dirac-dms-*, nor by dmkdir.
    LFN=$(echo ${LFN} | sed -r -e 's/^lfn://' -e 's#//#/#g')

    info "getting file size and computing sendReceiveTimeout"
    local size=$(dirac-dms-lfn-metadata ${LFN} | grep Size | sed -r 's/.* ([0-9]+)L,/\1/')
            local sendReceiveTimeout=`echo $[${size:-0}/150/1024]`
    if [ "$sendReceiveTimeout" = "" ] || [ $sendReceiveTimeout -le 900 ]
    then
        info "sendReceiveTimeout empty or too small, setting it to 900s"
        sendReceiveTimeout=900
    else
        info "sendReceiveTimeout is $sendReceiveTimeout"
    fi

    local LOCAL=${PWD}/`basename ${LFN}`
    info "Removing file ${LOCAL} in case it is already here"
    \rm -f ${LOCAL}

    local totalTimeout=$((10 + 30 + ${sendReceiveTimeout}))

    local LINE="time -p dirac-dms-get-file -d -o /Resources/StorageElements/GFAL_TIMEOUT=${totalTimeout} ${LFN}"
    info ${LINE}
    (${LINE}) &> get-file.log

    if [ $? = 0 ]
    then
        info "dirac-dms-get-file worked fine"
        local source=$(grep "generating url" get-file.log | tail -1 | sed -r 's/^.* (.*)\.$/\1/')
        local duration=$(grep -P '^real[ \t]' get-file.log | sed -r 's/real[ \t]//')
        info "DownloadCommand=dirac-dms-get-file Source=${source} Destination=$(hostname) Size=${size} Time=${duration}"
        RET_VAL=0
    else
        error "dirac-dms-get-file failed"
        error "`cat get-file.log`"
        RET_VAL=1
    fi

    \rm get-file.log
    return ${RET_VAL}
}
export -f downloadLFN
#
# URI are of the form of the following example. A single "/", instead
# of 3, after "girder:" is also allowed.
# girder:///control_3DT1.nii?apiurl=http://localhost:8080/api/v1&fileId=5ae1a8fc371210092e0d2936&token=TFT2FdxP9hzM7WKsidBjMJMmN69
#
#
# The code is quite the same as the uploadGirderFile function.  Any
# changes should be done the same in both functions.
#
function downloadGirderFile {
    local URI=$1

    # The regexpes are written so that case is ignored and the
    # arguments can be in any order.
    local fileName=$(echo $URI | sed -r 's#^girder:/(//)?([^/].*)\?.*$#\2#i')
    local apiUrl=$(echo $URI | sed -r 's/^.*[?&]apiurl=([^&]*)(&.*)?$/\1/i')
    local fileId=$(echo $URI | sed -r 's/^.*[?&]fileid=([^&]*)(&.*)?$/\1/i')
    local token=$(echo $URI | sed -r 's/^.*[?&]token=([^&]*)(&.*)?$/\1/i')

    if [ ! $(which girder-client) ]; then
        pip install --user girder-client
        if [ $? != 0 ]; then
            echo "girder-client not in PATH, and an error occurred while trying to install it."
            echo "Exiting with return value 1"
            exit 1
        fi
    fi

    COMMLINE="girder-client --api-url ${apiUrl} --token ${token} download --parent-type file ${fileId} ./${fileName}"
    echo "downloadGirderFile, command line is ${COMMLINE}"
    ${COMMLINE}
}

export -f downloadGirderFile


# This function identifies the gfal path and extracts the basename of the directory to be mounted,
# and creates a directory with the exact name on $PWD of the node. This directory gets mounted with
# the corresponding directory on the SE.
#
# This function checks for all the gfal mounts in the current folder.

check_mount='$(test -z $(for file in *; do findmnt -t fuse.gfalFS -lo Target -n -T $(realpath ${file}); done) && echo 1 || echo 0)'
isGfalmountExec=1

function mountGfal {
    local URI=$1

    local fileName=$(echo $URI | sed -r 's#^srm:/(//)?([^/].*)\?.*$#\2#i')
    local gfal_basename=$(basename ${fileName})
    local job_id=${gfal_basename}_$(basename $PWD)

    CREATE_DIR_COMMAND="mkdir -p $gfal_basename"
    SYM_LINK_COMMAND="ln -s $PWD/$gfal_basename /tmp/$job_id"
    GFAL_COMMAND="gfalFS -s /tmp/$job_id ${fileName}"

    ${CREATE_DIR_COMMAND}
    ${SYM_LINK_COMMAND}
    ${GFAL_COMMAND}
    # Let nfs-kernel-server export the directory and write logs
    sleep 30
    eval echo $check_mount
}

export -f mountGfal


# This function un-mounts all the gfal mounted directories by searching them with 'findmnt'
# and filtering them with FSTYPE 'fuse.gfalFS'. This function gets called in the cleanup function,
# either after the execution of the job, failure of the job, or interruptions of the job.
function unmountGfal {
    START=$SECONDS
    while [ $(eval echo $check_mount) = 0 ]; do
        for file in $PWD/*; do
            findmnt -t fuse.gfalFS -lo Target -n -T $(realpath ${file}) && gfalFS_umount $(realpath ${file})
        done
        sleep 2
        if [[ $(($SECONDS - $START)) -gt 600 ]]; then # while loop breaks automatically after 10 minutes
            echo "WARNING - gfal directory couldn't be unmounted: timeout"
            break
        fi

    done
    eval echo $check_mount
}

export -f unmountGfal


# URI are of the form of the following example. A single "/", instead
# of 3, after "shanoir:" is also allowed.
# shanoir:/download.dcm?apiurl=https://shanoir-ng-nginx/shanoir-ng/datasets/carmin-data/path&format=dcm&datasetId=1
#
# This method depends on the refresh token process to refresh the token when it needs
#
function downloadShanoirFile {
    local URI=$1
    
    wait_for_token

    local token=$(cat $SHANOIR_TOKEN_LOCATION)

    echo "token inside download : ${token}"

    local fileName=$(echo $URI | sed -r 's#^shanoir:/(//)?([^/].*)\?.*$#\2#i')
    local apiUrl=$(echo $URI | sed -r 's/^.*[?&]apiurl=([^&]*)(&.*)?$/\1/i')
    local format=$(echo $URI | sed -r 's/^.*[?&]format=([^&]*)(&.*)?$/\1/i')
    local datasetId=$(echo $URI | sed -r 's/^.*[?&]datasetId=([^&]*)(&.*)?$/\1/i')

    COMMAND(){
        curl --write-out '%{http_code}' -o ${fileName} --request GET "${apiUrl}/${datasetId}?format=${format}" --header "Authorization: Bearer ${token}"
    }

    status_code=$(COMMAND)
    echo "downloadShanoirFIle, status code is : ${status_code}"
    
    if [[ "$status_code" -ne 200 ]]; then
       echo "error while downloading the file with status : ${status_code}"
       stopRefreshingToken
       exit 1
    fi

    if [[ $format = "nii" ]]; then
       echo "its a nifti, shanoir has zipped it"
       TMP_UNZIP_DIR="tmp_unzip_dir"
       mkdir $TMP_UNZIP_DIR
       mv $fileName $TMP_UNZIP_DIR/tmp.zip
       cd $TMP_UNZIP_DIR
       unzip tmp.zip
       if [[ $(ls -1q *.nii.gz | wc -l) -ne 1 ]]; then
            echo "too many files in shanoir nifti, supporting only 1"
            stopRefreshingToken
            exit 1
       fi
       cd ..
       mv $TMP_UNZIP_DIR/*.nii.gz $fileName
       rm -rf $TMP_UNZIP_DIR
    fi
}
function downloadURI {

    local URI=$1
    local URI_LOWER=`echo $1 | awk '{print tolower($0)}'`

    if [[ ${URI_LOWER} == lfn* ]] || [[ $URI_LOWER == /* ]]
    then
                        LFN=`echo "${URI}" | sed -r -e 's%^\w+://[^/]*(/[^?]+)(\?.*)?$%\1%' -e 's#//#/#g'`

        checkCacheDownloadAndCacheLFN $LFN
        validateDownload "Cannot download LFN file"
    fi

    if [[ ${URI_LOWER} == file:/* ]]
    then
        local FILENAME=`echo $URI | sed 's%file://*%/%'`
        cp $FILENAME .
        validateDownload "Cannot copy input file: $FILENAME"
    fi

    if [[ ${URI_LOWER} == http://* ]]
    then
        curl --insecure -O ${URI}
        validateDownload "Cannot download HTTP file"
    fi

    if [[ ${URI_LOWER} == girder:/* ]]
    then
        downloadGirderFile ${URI}
        validateDownload "Cannot download Girder file"
    fi

    if [[ ${URI_LOWER} == shanoir:/* ]]
    then
        if [[ "$REFRESHING_JOB_STARTED" == false ]]; then
                      refresh_token ${URI} & 
           REFRESH_PID=$!  
           REFRESHING_JOB_STARTED=true
        fi
        downloadShanoirFile ${URI}
        validateDownload "Cannot download shanoir file"
    fi

    if [[ ${URI_LOWER} == srm:/* ]] 
    then
            if [[ $(mountGfal ${URI}) -eq 0 ]]
                then
                    isGfalmountExec=0
                else
                    echo "Cannot download gfal file"
            fi
    fi
}
function validateDownload() {

    if [ $? != 0 ]; then
        echo "$1"
        echo "Exiting with return value 1"
        exit 1
    fi
}


function addToCache {
    cacheDir=${BASEDIR}/cache
    mkdir -p "$cacheDir"
    touch "$cacheDir/$cacheFile"
    local LFN="$1"
    local FILE=$(basename "$2")
    local i=0
    local exist="true"
    local NAME=""
    while [ "$exist" = "true" ]; do
        NAME="$cacheDir/${FILE}-cache-${i}"
        test -f "${NAME}"
        if [ $? != 0 ]; then
            exist="false"
        fi
        i=$(expr $i + 1)
    done
    info "Removing all cache entries for ${LFN} (files will stay locally in case anyone else needs them)"
    local TEMP=$(mktemp temp.XXXXXX)
    awk -v L="${LFN}" '$1!=L {print}' "$cacheDir/$cacheFile" > "${TEMP}"
    \mv -f "${TEMP}" "$cacheDir/$cacheFile"
    info "Adding file ${FILE} to cache and setting the timestamp"
    \cp -f "${FILE}" "${NAME}"
    local date_local=$(ls -la "${NAME}" | awk -F' ' '{print $6, $7, $8}')
    local TIMESTAMP=$(date -d "${date_local}" +%s)
    echo "${LFN} ${NAME} ${TIMESTAMP}" >> "$cacheDir/$cacheFile"
}

export -f addToCache


function addToFailOver {
    local LFN="$1"
    local FILE="$2"
    local REMOTEFILE=$(lcg-lr "lfn:${LFN}" | grep "$failOverHost")
    generated=${REMOTEFILE#*generated}
    local RPFILE="${generated}"

    lcg-del --nobdii --defaultsetype srmv2 -v "srm://$failOverHost:$failOverPort/srm/managerv2?SFN=$failOverHome${RPFILE}" &>/dev/null
    lfc-ls "${LFN}"
    if [ $? = 0 ]; then
        lfc-rename "${LFN}" "${LFN}-garbage-$(date +"%Y-%m-%d-%H-%M-%S")"
    fi
    lfc-mkdir -p "$(dirname "${LFN}")"
    local FILENAME=$(echo "$RANDOM$RANDOM" | md5sum | awk '{print $1}')
    local FOLDERNAME=$(date +"%Y-%m-%d")
    local OPTS="--nobdii --defaultsetype srmv2"
    DM_DEST="srm://$failOverHost:$failOverPort/srm/managerv2?SFN=$failOverHome/${FOLDERNAME}/file-${FILENAME}"
    GUID=$(lcg-cr ${OPTS} -d "${DM_DEST}" "file:${FILE}")
    if [ $? = 0 ]; then
        lcg-aa "${GUID}" "lfn:${LFN}"
        if [ $? = 0 ]; then
            info "Data successfully copied to Fail Over."
        else
            error "Unable to create LFN alias ${LFN} to ${GUID}"
            return 1
        fi
    else
        error "Unable to copy data to Fail Over."
        return 1
    fi
}

export -f addToFailOver


#!/bin/bash

nSEs() {
    local i=0
    for n in ${SELIST}; do
        i=$((i + 1))
    done
    return $i
}

getAndRemoveSE() {
    local index=$1
    local i=0
    local NSE=""
    RESULT=""
    for n in ${SELIST}; do
        if [ "$i" = "${index}" ]; then
            RESULT=$n
            info "result: $RESULT"
        else
            NSE="${NSE} $n"
        fi
        i=$((i + 1))
    done
    SELIST=${NSE}
    return 0
}

chooseRandomSE() {
    nSEs
    local n=$?
    if [ "$n" = "0" ]; then
        info "SE list is empty"
        RESULT=""
    else
        local r=${RANDOM}
        local id=$((r % n))
        getAndRemoveSE ${id}
    fi
}

uploadLfnFile() {
    local LFN=$1
    local FILE=$2
    local nrep=$3
    local SELIST=${SE}

    

    LFN=$(echo ${LFN} | sed -r -e 's/^lfn://' -e 's#//#/#g')

    info "getting file size and computing sendReceiveTimeout"
    local size=$(ls -l ${FILE} | awk -F' ' '{print $5}')
    local sendReceiveTimeout=$((size / minAvgDownloadThroughput / 1024))
    if [ -z "$sendReceiveTimeout" ] || [ "$sendReceiveTimeout" -le 900 ]; then
        info "sendReceiveTimeout empty or too small, setting it to 900s"
        sendReceiveTimeout=900
    else
        info "sendReceiveTimeout is $sendReceiveTimeout"
    fi

    local totalTimeout=$((timeout + srmTimeout + sendReceiveTimeout))

    local OPTS="-o /Resources/StorageElements/GFAL_TIMEOUT=${totalTimeout}"
    chooseRandomSE
    local DEST=${RESULT}
    local done=0
    while [ $nrep -gt $done ] && [ "${DEST}" != "" ]; do
        if [ "${done}" = "0" ]; then
            local command="dirac-dms-add-file"
            local source=$(hostname)
            dirac-dms-remove-files ${OPTS} ${LFN} &>/dev/null
            (time -p dirac-dms-add-file ${OPTS} ${LFN} ${FILE} ${DEST}) &> dirac.log
            local error_code=$?
        else
            local command="dirac-dms-replicate-lfn"
            (time -p dirac-dms-replicate-lfn -d ${OPTS} ${LFN} ${DEST}) &> dirac.log
            local error_code=$?

            local source=$(grep "operation 'getFileSize'" dirac.log | tail -1 | sed -r 's/^.* StorageElement (.*) is .*$/\1/')
        fi
        if [ ${error_code} = 0 ]; then
            info "Copy/Replication of ${LFN} to SE ${DEST} worked fine."
            done=$((done + 1))
            local duration=$(grep -P '^real[ \t]' dirac.log | sed -r 's/real[ \t]//')
            info "UploadCommand=${command} Source=${source} Destination=${DEST} Size=${size} Time=${duration}"
            if [ -z "${duration}" ]; then
                info "Missing duration info, printing the whole log file."
                cat dirac.log
            fi
        else
            error "$(cat dirac.log)"
            warning "Copy/Replication of ${LFN} to SE ${DEST} failed"
        fi
        \rm dirac.log
        chooseRandomSE
        DEST=${RESULT}
    done
    if [ "${done}" = "0" ]; then
        error "Cannot copy file ${FILE} to lfn ${LFN}"
        error "Exiting with return value 2"
        exit 2
    else
        addToCache ${LFN} ${FILE}
    fi
}

uploadShanoirFile() {
    local URI=$1

    wait_for_token

    local token=$(cat $SHANOIR_TOKEN_LOCATION)

    local upload_url=$(echo $URI | sed -r 's/^.*[?&]upload_url=([^&]*)(&.*)?$/\1/i')
    local fileName=$(echo $URI | sed -r 's#^shanoir:/(//)?(.*/(.+))\?.*$#\3#i')
    local filePath=$(echo $URI | sed -r 's#^shanoir:/(//)?([^/].*)\?.*$#\2#i')
   
    local type=$(echo $URI | sed -r 's/^.*[?&]type=([^&]*)(&.*)?$/\1/i')
    local md5=$(echo $URI | sed -r 's/^.*[?&]md5=([^&]*)(&.*)?$/\1/i')

    COMMAND() { 
        (echo -n '{"base64Content": "'; base64 ${fileName}; echo '", "type":"'; echo ${type}; echo '", "md5":"'; echo ${md5} ; echo '"}') | curl --write-out '%{http_code}' --request PUT "${upload_url}/${filePath}"  --header "Authorization: Bearer ${token}"  --header "Content-Type: application/carmin+json" --header 'Accept: application/json, text/plain, */*' -d @-
    }

    status_code=$(COMMAND)
    echo "uploadShanoirFIle, status code is : ${status_code}"
    
    if [[ "$status_code" -ne 201 ]]; then
        error "error while uploading the file with status : ${status_code}"
        stopRefreshingToken
        exit 1
    fi
}

uploadGirderFile() {
    local URI=$1

    local fileName=$(echo $URI | sed -r 's#^girder:/(//)?(.*/)?([^/].*)\?.*$#\3#i')
    local apiUrl=$(echo $URI | sed -r 's/^.*[?&]apiurl=([^&]*)(&.*)?$/\1/i')
    local fileId=$(echo $URI | sed -r 's/^.*[?&]fileid=([^&]*)(&.*)?$/\1/i')
    local token=$(echo $URI | sed -r 's/^.*[?&]token=([^&]*)(&.*)?$/\1/i')

    if [ ! $(which girder-client) ]; then
        pip install --user girder-client
        if [ $? != 0 ]; then
            error "girder-client not in PATH, and an error occured while trying to install it."
            error "Exiting with return value 1"
            exit 1
        fi
    fi

    COMMLINE="girder-client --api-url ${apiUrl} --token ${token} upload --parent-type folder ${fileId} ./${fileName}"
    echo "uploadGirderFile, command line is ${COMMLINE}"
    ${COMMLINE}
    if [ $? != 0 ]; then
        error "Error while uploading girder file"
        error "Exiting with return value 1"
        exit 1
    fi
}

function upload {

    local URI=$1
    local ID=$2
    local NREP=$3
    local TEST=$4

    startLog file_upload uri="${URI}"

        if [[ ${URI} == shanoir:/* ]]
    then
        if [ "${TEST}" != "true" ]
        then
            if [[ "$REFRESHING_JOB_STARTED" == false ]]; then
                                refresh_token ${URI} & 
                REFRESH_PID=$!  
                REFRESHING_JOB_STARTED=true
            fi
            uploadShanoirFile ${URI}
        fi
    elif [[ ${URI} == girder:/* ]]
    then
        if [ "${TEST}" != "true" ]
        then
            uploadGirderFile ${URI}
        fi
    elif [[ ${URI} == file:/* ]]
    then
        local FILENAME=`echo $URI | sed 's%file://*%/%'`
        local NAME=`basename ${FILENAME}`

        if [ -e $FILENAME ]
        then
            error "Result file already exists: $FILENAME"
            error "Exiting with return value 1"
            exit 1
        fi

        if [ "${TEST}" = "true" ]
        then
            echo "test result" > ${NAME}
        fi

        \mv $NAME $FILENAME
        if [ $? != 0 ]
        then
            error "Error while moving result local file."
            error "Exiting with return value 1"
            exit 1
        fi
    else
                local LFN=`echo "${URI}" | sed -r 's%^\w+://[^/]*(/[^?]+)(\?.*)?$%\1%'`
        local NAME=${LFN##*/}

        if [ "${TEST}" = "true" ]
        then
            LFN=${LFN}-uploadTest
            echo "test result" > ${NAME}
        fi

        uploadLfnFile ${LFN} ${PWD}/${NAME} ${NREP}

        if [ "${TEST}" = "true" ]
        then
            \rm -f ${NAME}
        fi
    fi
    stopLog file_upload
}


function delete {

    local URI="$1"
    local TEST="$2"

    startLog file_delete uri="${URI}"

    ## The pattern must NOT be put between quotation marks.
    if [[ ${URI} == girder:* ]]; then
        info "delete not supported for girder"
    elif [[ ${URI} == file:* ]]; then
        local FILENAME=$(echo "$URI" | sed 's%file://*%/%')

        info "Removing local file ${FILENAME}..."
        \rm -f "$FILENAME"
    else
        ## Extract the path part from the uri, and sanitize it.
        ## "//" are not accepted by dirac commands.
        local LFN=$(echo "${URI}" | sed -r -e 's%^\w+://[^/]*(/[^?]+)(\?.*)?$%\1%' -e 's#//#/#g')

        if [ "${TEST}" = true ]; then
            LFN="${LFN}-uploadTest"
        fi

        info "Deleting file ${LFN}..."
        dirac-dms-remove-files "${LFN}"
    fi

    stopLog file_delete
}


startLog header
# Start log
START=$(date +%s)
echo "START date is ${START}"

# Execution environment setup
export GASW_JOB_ENV=NORMAL
export GASW_EXEC_ENV=EGEE

# Builds the custom environment
BASEDIR=${PWD}
ENV=$defaultEnvironment
export $ENV
__MOTEUR_ENV=$defaultEnvironment
export SE=$voDefaultSE
USE_CLOSE_SE=$voUseCloseSE
export BOSH_CVMFS_PATH=$boshCVMFSPath
export CONTAINERS_CVMFS_PATH=$containersCVMFSPath
export UDOCKER_TAG=$udockerTag

export MOTEUR_WORKFLOWID="$simulationID"
export MOTEUR_WORKFLOWID="$workflowID"

# If the execution environment is a cluster, add the vlet binaries to the path
if [[ "$GASW_EXEC_ENV" == "PBS" ]]; then
    export PATH=${VLET_INSTALL}/bin:$PATH
fi

DIAG=/home/grid/session/$(basename ${PWD}).diag

# Create execution directory
DIRNAME=$(basename $0 .sh)
mkdir ${DIRNAME}
if [ $? -eq 0 ]; then
    echo "cd ${DIRNAME}"
    cd ${DIRNAME} || exit 7
else
    echo "Unable to create directory ${DIRNAME}"
    echo "Exiting with return value 7"
    exit 7
fi

if [[ $minorStatusEnabled == true && $serviceCall ]]; then
    $serviceCall ${MOTEUR_WORKFLOWID} ${JOBID} 1
fi

BACKPID=""

# DIRAC may wrongly position this variable
if [ ! -d ${X509_CERT_DIR} ]; then
    echo "Unsetting invalid X509_CERT_DIR (${X509_CERT_DIR})"
    unset X509_CERT_DIR
fi

echo "END date is $(date +%s)"

stopLog header


startLog host_config

echo "SE Linux mode is:"
/usr/sbin/getenforce
echo "gLite Job Id is ${GLITE_WMS_JOBID}"
echo "===== uname ===== "
uname -a
domainname -a
echo "===== network config ===== "
/sbin/ifconfig eth0
dmesg_line=$(dmesg | grep 'Link is Up' | uniq)
netspeed=$(echo $dmesg_line | grep -o '[0-9]*[[:space:]][a-zA-Z]bps'| awk '{gsub(/ /,"",$0);print}')
echo "NetSpeed = $netspeed ($dmesg_line)"
echo "===== CPU info ===== "
cat /proc/cpuinfo
echo "===== Memory info ===== "
cat /proc/meminfo
echo "===== lcg-cp location ===== "
which lcg-cp
echo "===== ls -a . ===== "
ls -a
echo "===== ls -a .. ===== "
ls -a ..
echo "===== env ====="
env
echo "===== rpm -qa  ===="
rpm -qa

mkdir -p $cacheDir

stopLog host_config


startLog background

# Execute service call if minor status is enabled and service call is provided
if [[ "$minorStatusEnabled" == true && -n "$serviceCall" ]]; then
    $serviceCall $MOTEUR_WORKFLOWID $JOBID 2
fi

# Check cache, download, and cache LFN for the background script
checkCacheDownloadAndCacheLFN $backgroundScript

# Execute the background script
bash $(basename $backgroundScript) 1>background.out 2>background.err &
BACKPID=$!

# Stop log
stopLog background


startLog inputs_download

echo $invocationString
Job_Id="$0"
echo $Job_Id

# Print a message indicating the JSON file has been created
# This part needs to be handled in the code that processes the VTL template

echo $invocationString
invocationParameters='$invocationString'

# Execute service call if minor status is enabled and service call is provided
if [[ "$minorStatusEnabled" == true && -n "$serviceCall" ]]; then
    $serviceCall $MOTEUR_WORKFLOWID $JOBID 3
fi

# Create a file to disable watchdog CPU wallclock check
touch ../DISABLE_WATCHDOG_CPU_WALLCLOCK_CHECK

###################################################################################
#temporary lines
# Download each file specified in $downloads
#dirac-dms-get-file "/biomed/user/a/abonnet/vip-tutorial-sbg/groups/Support/Applications/GrepTest/0.1/json/GrepTest.json"
#dirac-dms-get-file "/biomed/user/a/abonnet/vip-tutorial-sbg/users/localadminfirstname_localadminlastname/grep.json"
#dirac-dms-get-file "/biomed/user/a/abonnet/vip-tutorial-sbg/users/localadminfirstname_localadminlastname/grep_local.json"
#uploads="file:///vip/grida/downloads/biomed/user/a/abonnet/vip-tutorial-sbg/users/localadminfirstname_localadminlastname/"

# Remove square brackets and leading/trailing whitespace from downloads
downloads="${downloads#[}"
downloads="${downloads%]}"
downloads="${downloads// /}"
downloadFiles="${downloadFiles#[}"
downloadFiles="${downloadFiles%]}"
downloadFiles="${downloadFiles// /}"

IFS=',' read -ra download_array <<< "$downloads" && IFS=',' read -ra downloadFiles_array <<< "$downloadFiles"

# Iterate over each URL in the 'downloads' array
for download in "${download_array[@]}"; do
    # Remove leading and trailing whitespace
    download="$(echo -e "${download}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    # Process the URL using downloadURI function
    downloadURI "$download"
    # Print the processed URL
    echo "$download"
done

# Iterate over each URL in the 'downloadFiles' array
for download in "${downloadFiles_array[@]}"; do
    # Remove leading and trailing whitespace
    download="$(echo -e "${download}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    # Process the URL using downloadURI function
    downloadURI "$download"
    # Print the processed URL
    echo "$download"
done


#downloadLFN "/biomed/user/a/abonnet/vip-tutorial-sbg/users/localadminfirstname_localadminlastname/grep.json"
###################################################################################
#temporary lines



# Change permissions of all files in the directory
chmod 755 *

# Record the timestamp after downloads
AFTERDOWNLOAD=$(date +%s)

# Stop log for inputs download
stopLog inputs_download


startLog application_environment
echo "$variables"

# Iterate through each variable in $variables and export them
# Assuming $variables is a string containing key-value pairs separated by space
for variable in $variables; do
    key=$(echo "$variable" | cut -d'=' -f1)
    value=$(echo "$variable" | cut -d'=' -f2)
    export "$key"="$value"
done

# Stop log for application environment
stopLog application_environment


function download_udocker {
  #installation of udocker
  info "cloning udocker ${UDOCKER_TAG} "
  git clone --depth=1 --branch ${UDOCKER_TAG} https://github.com/indigo-dc/udocker.git
  (cd udocker/udocker; ln -s maincmd.py udocker)
  export PATH=`pwd`/udocker/udocker:$PATH
  
  #creating a temporary directory for udocker containers
  mkdir -p containers
  export UDOCKER_CONTAINERS=$PWD/containers
  
  #find pre-deployed containers on CVMFS, and create a symlink to the udocker containers directory
  ## use a global velocity escape to avoid velocity escaping issue
  for d in ${CONTAINERS_CVMFS_PATH}/*/ ;
     do mkdir containers/$(basename "${d%/}") && ln -s "${d%/}"/* containers/$(basename "${d%/}")/
  done
  cat >docker <<'EOF'
        #!/bin/bash
        MYARGS=$*
        echo "executing ./udocker/udocker/udocker $MYARGS"
        ./udocker/udocker/udocker $MYARGS
EOF
  chmod a+x docker
  export PATH=$PWD:$PATH
}

if ! command -v docker
then
    download_udocker
fi
####################################################################################################
####################################################################################################
function checkBosh {
  local BOSH_CVMFS_PATH=$1
  #by default, use CVMFS bosh
  ${BOSH_CVMFS_PATH}/bosh create foo.sh
  if [ $? != 0 ]
  then
    info "CVMFS bosh in ${BOSH_CVMFS_PATH} not working, checking for a local version"
    bosh create foo.sh
    if [ $? != 0 ]
    then
        info "bosh is not found in PATH or it is does not work fine, searching for another local version"
        local HOMEBOSH=`find $HOME -name bosh`
        if [ -z "$HOMEBOSH" ]
        then
            info "bosh not found, trying to install it"
            pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org boutiques --prefix $PWD 
            if [ $? != 0 ]
            then
                error "pip install boutiques failed"
                exit 1
            else
                export BOSHEXEC="$PWD/bin/bosh"
            fi
        else
            info "local bosh found in $HOMEBOSH"
            export BOSHEXEC=$HOMEBOSH
        fi
    else # bosh is found in PATH and works fine
        info "local bosh found in $PATH"
        export BOSHEXEC="bosh"
    fi
  else # if bosh CVMFS works fine
    export BOSHEXEC="${BOSH_CVMFS_PATH}/bosh"
  fi
}
checkBosh $BOSH_CVMFS_PATH
####################################################################################################
function boutiques_exec {
#jsonFileName="../workflow.json"
echo "import sys; sys.setdefaultencoding(\"UTF8\")" > sitecustomize.py
COMMAND_LINE="PYTHONPATH=".:$PYTHONPATH" $BOSHEXEC exec launch -x --provenance_path ./provenance_file.json $jsonFileName ../inv/$invocationJson -v $PWD/../cache:$PWD/../cache"
# Execute the command and store the output in a temporary file
eval "$COMMAND_LINE" > temp_output.txt

# Read the lines from the temporary file into the array
readarray -t lines < temp_output.txt

# Remove the temporary file
rm temp_output.txt

Boutiques_provenance_logs="[ INFO ] Data capture from execution saved to cache as"
for line in "${lines[@]}"; do
    echo "$line"
    if [[ $line == "$Boutiques_provenance_logs"* ]];
    then
    Provenance_file=${line#*"$Boutiques_provenance_logs"}
    fi
done

if [ $? != 0 ]
then
    error "VIP_test execution failed!"
    exit 1
fi

info "Execution of VIP_test completed."
echo "Provenance file: $Provenance_file"
}


# Perform service call if minor status is enabled
if [[ $minorStatusEnabled == true && $serviceCall ]]; then
    $serviceCall ${MOTEUR_WORKFLOWID} ${JOBID} 4
fi

# Add a delay to ensure file creation before proceeding
echo "BEFORE_EXECUTION_REFERENCE" > BEFORE_EXECUTION_REFERENCE_FILE
sleep 1
echo "$params parameters"


# Export current directory to LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${PWD}:${LD_LIBRARY_PATH}


# Check if execution was successful
if [ $? -ne 0 ]; then
    error "Exiting with return value 6"
    BEFOREUPLOAD=$(date +%s)
    info "Execution time: $(expr ${BEFOREUPLOAD} - ${AFTERDOWNLOAD}) seconds"
    stopLog application_execution
    cleanup
    exit 6
fi

BEFOREUPLOAD=$(date +%s)
stopLog application_execution

info "Execution time was $(expr ${BEFOREUPLOAD} - ${AFTERDOWNLOAD})s"

__MOTEUR_ARGS="$params"
__MOTEUR_EXE="$executableName"
####################################################################################################
####################################################################################################
# Function to process provenance and extract output file names
function provenance() {
    Provenance_file=$PWD/provenance_file.json
    keys_with_file_name=$(jq -r '."public-output"."output-files" | to_entries[] | "\(.key) \(.value."file-name")"' $Provenance_file)
    output_name=($(echo ${keys_with_file_name}))
    for (( c=0; c<=$(wc -w <<< "$keys_with_file_name")-1; c++))
    do
        c=$(expr $c + 1)
        echo ${output_name[$c]}
        outputs_to_be_uploaded+=(${output_name[$c]})
    done
}

boutiques_exec
provenance


startLog results_upload

# Perform service call if minor status is enabled
if [[ $minorStatusEnabled == true && $serviceCall ]]; then
    $serviceCall ${MOTEUR_WORKFLOWID} ${JOBID} 5
fi


# Iterate through output files to upload
function createOutputDir() {
    uploads=${uploads}
    input=$uploads
    path=$(echo "$input" | sed -E 's/(lfn|file):\/\///')
    dmkdir "$path"
    echo "upload path: $path"
}
createOutputDir

for output_to_be_uploaded in "${outputs_to_be_uploaded[@]}"
do
    upload_path="${uploads}/${output_to_be_uploaded}"
    upload "$upload_path" "$(tr -dc '[:alpha:]' < /dev/urandom 2>/dev/null | head -c 32)" "$numberOfReplicas" false

done

__MOTEUR_OUT="$uploadsList"

stopLog results_upload


startLog footer
# Perform service call if minor status is enabled
if [[ $minorStatusEnabled == true && $serviceCall ]]; then
    $serviceCall ${MOTEUR_WORKFLOWID} ${JOBID} 6
fi

cleanup

STOP=$(date +%s)
info "Stop date is ${STOP}"
TOTAL=$((STOP - START))
info "Total running time: $TOTAL seconds"
UPLOAD=$((STOP - BEFOREUPLOAD))
DOWNLOAD=$((AFTERDOWNLOAD - START))
info "Input download time: ${DOWNLOAD} seconds"
info "Execution time: $(expr $BEFOREUPLOAD - $AFTERDOWNLOAD) seconds"
info "Results upload time: ${UPLOAD} seconds"
info "Exiting with return value 0"
info "(HACK for ARC: writing it in ${DIAG})"
echo "exitcode=0" >> ${DIAG}
exit 0

stopLog footer