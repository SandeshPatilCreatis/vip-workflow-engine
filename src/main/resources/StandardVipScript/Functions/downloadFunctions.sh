function downloadLFN {

    local LFN=$1

    # Sanitize LFN:
    # - "lfn:" at the beginning is optional for dirac-dms-* commands,
    #    but does not work as expected with comdirac commands like
    #    dmkdir.
    # - "//" are not accepted, neither by dirac-dms-*, nor by dmkdir.
    LFN=$(echo ${LFN} | sed -r -e 's/^lfn://' -e 's#//#/#g')

    echo "getting file size and computing sendReceiveTimeout"
    local size=$(dirac-dms-lfn-metadata ${LFN} | grep Size | sed -r 's/.* ([0-9]+)L,/\1/')
    local sendReceiveTimeout=$((${size:-0} / ${minAvgDownloadThroughput} / 1024))
    
    if [ -z "$sendReceiveTimeout" ] || [ $sendReceiveTimeout -le 900 ]; then
        echo "sendReceiveTimeout empty or too small, setting it to 900s"
        sendReceiveTimeout=900
    else
        echo "sendReceiveTimeout is $sendReceiveTimeout"
    fi

    local LOCAL=${PWD}/`basename ${LFN}`
    echo "Removing file ${LOCAL} in case it is already here"
    \rm -f ${LOCAL}

    local totalTimeout=$((${timeout} + ${srmTimeout} + ${sendReceiveTimeout}))

    local LINE="time -p dirac-dms-get-file -d -o /Resources/StorageElements/GFAL_TIMEOUT=${totalTimeout} ${LFN}"
    echo ${LINE}
    (${LINE}) &> get-file.log

    if [ $? = 0 ]; then
        echo "dirac-dms-get-file worked fine"
        local source=$(grep "generating url" get-file.log | tail -1 | sed -r 's/^.* (.*)\.$/\1/')
        local duration=$(grep -P '^real[ \t]' get-file.log | sed -r 's/real[ \t]//')
        echo "DownloadCommand=dirac-dms-get-file Source=${source} Destination=$(hostname) Size=${size} Time=${duration}"
        RET_VAL=0
    else
        echo "dirac-dms-get-file failed"
        echo "`cat get-file.log`"
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
    local URI_LOWER=$(echo $1 | awk '{print tolower($0)}')

    if [[ ${URI_LOWER} == lfn* ]] || [[ $URI_LOWER == /* ]]; then
        ## Extract the path part from the uri, and remove // if
        ## present in path.
        LFN=$(echo "${URI}" | sed -r -e 's%^\w+://[^/]*(/[^?]+)(\?.*)?$%\1%' -e 's#//#/#g')

        checkCacheDownloadAndCacheLFN $LFN
        validateDownload "Cannot download LFN file"
    fi

    if [[ ${URI_LOWER} == file:/* ]]; then
        local FILENAME=$(echo $URI | sed 's%file://*%/%')
        cp $FILENAME .
        validateDownload "Cannot copy input file: $FILENAME"
    fi

    if [[ ${URI_LOWER} == http://* ]]; then
        curl --insecure -O ${URI}
        validateDownload "Cannot download HTTP file"
    fi

    if [[ ${URI_LOWER} == girder:/* ]]; then
        downloadGirderFile ${URI}
        validateDownload "Cannot download Girder file"
    fi

    if [[ ${URI_LOWER} == shanoir:/* ]]; then
        if [[ "$REFRESHING_JOB_STARTED" == false ]]; then
           #set( $D = '$' )
           refresh_token ${URI} &
           REFRESH_PID=${D}!
           REFRESHING_JOB_STARTED=true
        fi
        downloadShanoirFile ${URI}
        validateDownload "Cannot download shanoir file"
    fi

    if [[ ${URI_LOWER} == srm:/* ]]; then
            if [[ $(mountGfal ${URI}) -eq 0 ]]; then
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