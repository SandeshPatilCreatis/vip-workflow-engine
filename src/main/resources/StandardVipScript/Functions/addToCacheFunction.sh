function addToCache {
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