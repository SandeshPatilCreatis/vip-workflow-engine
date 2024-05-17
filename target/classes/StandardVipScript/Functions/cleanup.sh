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