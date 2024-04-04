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