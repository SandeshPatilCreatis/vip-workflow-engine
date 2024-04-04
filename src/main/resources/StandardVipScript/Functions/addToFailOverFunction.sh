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