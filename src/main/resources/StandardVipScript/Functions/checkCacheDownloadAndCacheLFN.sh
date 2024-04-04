function checkCacheDownloadAndCacheLFN {

    local LFN=$1
    # the LFN is assumed to be in the /grid/biomed/... format (no leading lfn://lfc-biomed.in2p3.fr:5010/)
    # this variable is true <=> the file has to be downloaded again
    local download="true"
    # first check if the file is already in cache
    local LOCALPATH=$(awk -v L=${LFN} '$1==L {print $2}' "$cacheDir/$cacheFile")
    if [ "${LOCALPATH}" != "" ]; then
        info "There is an entry in the cache: test if the local file still here"
        local TIMESTAMP_LOCAL=""
        local TIMESTAMP_GRID=""
        local date_local=""
        if [ -f "${LOCALPATH}" ]; then
            info "The file exists: checking if it was modified since it was added to the cache"
            local YEAR=$(date +%Y)
            local YEARBEFORE=$(expr ${YEAR} - 1)
            local currentDate=$(date +%s)
            local TIMESTAMP_CACHE=$(awk -v L=${LFN} '$1==L {print $3}' "$cacheDir/$cacheFile")
            local LOCALMONTH=$(ls -la "${LOCALPATH}" | awk -F' ' '{print $6}')
            local MONTHTIME=$(date -d "${LOCALMONTH} 1 00:00" +%s)
            date_local=$(ls -la "${LOCALPATH}" | awk -F' ' '{print $6, $7, $8}')
            if [ "${MONTHTIME}" -gt "${currentDate}" ]; then
                TIMESTAMP_LOCAL=$(date -d "${date_local} ${YEARBEFORE}" +%s)
            else
                TIMESTAMP_LOCAL=$(date -d "${date_local} ${YEAR}" +%s)
            fi
            if [ "${TIMESTAMP_CACHE}" = "${TIMESTAMP_LOCAL}" ]; then
                info "The file was not touched since it was added to the cache: test if it is up up-to-date"
                local date_grid_s=$(lfc-ls -l "${LFN}" | awk -F' ' '{print $6, $7, $8}')
                local MONTHGRID=$(echo "${date_grid_s}" | awk -F' ' '{print $1}')
                MONTHTIME=$(date -d "${MONTHGRID} 1 00:00" +%s)
                if [ "${MONTHTIME}" != "" ] && [ "${date_grid_s}" != "" ]; then
                    if [ "${MONTHTIME}" -gt "${currentDate}" ]; then
                        # it must be last year
                        TIMESTAMP_GRID=$(date -d "${date_grid_s} ${YEARBEFORE}" +%s)
                    else
                        TIMESTAMP_GRID=$(date -d "${date_grid_s} ${YEAR}" +%s)
                    fi
                    if [ "${TIMESTAMP_LOCAL}" -gt "${TIMESTAMP_GRID}" ]; then
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
    if [ "${download}" = "false" ]; then
        info "Linking file from cache: ${LOCALPATH}"
        BASE=$(basename "${LFN}")
        info "ln -s ${LOCALPATH} ./${BASE}"
        ln -s "${LOCALPATH}" "./${BASE}"
        return 0
    fi
    if [ "${download}" = "true" ]; then
        downloadLFN "${LFN}"
        if [ $? != 0 ]; then
            return 1
        fi
        addToCache "${LFN}" $(basename "${LFN}")
        return 0
    fi
}

export -f checkCacheDownloadAndCacheLFN