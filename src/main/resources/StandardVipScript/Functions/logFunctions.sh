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