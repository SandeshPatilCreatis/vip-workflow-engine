#!/bin/bash

#     Functions     #

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
# Arguments parsing #

shift # first parameter is always results directory

cat << JSONPARAMETERS  > input_param_file.json
{
JSONPARAMETERS

firstParam=true
while [[ $# > 0 ]]
do
key="$1"
case $key in
    --inname)
        if [ "$2" != "No_value_provided" ]
        then
                        if [ "$firstParam" != true ]
                        then
                echo "," >> input_param_file.json
            fi
                         echo "\"inname\": \"$2\""  >> input_param_file.json
            firstParam=false
                    fi
    ;;
    *) # unknown option
esac
shift # past argument or value
shift
done

cat << JSONPARAMETERS  >> input_param_file.json
}
JSONPARAMETERS

# Command-line execution #

TOOLNAME="VIP_test"
JSONFILE="${TOOLNAME}.json"

# BOSH_CVMFS_PATH is defined by GASW from the settings file
checkBosh $BOSH_CVMFS_PATH

# Clone udocker (A basic user tool to execute simple docker containers in batch or interactive systems without root privileges)




# Change PYTHONPATH to make all strings unicode by default in python2 (as in python3)
# Otherwise `bosh exec` fails on any non-ascii characters in outputs
echo "import sys; sys.setdefaultencoding(\"UTF8\")" > sitecustomize.py
PYTHONPATH=".:$PYTHONPATH" $BOSHEXEC exec launch $JSONFILE input_param_file.json -v $PWD/../cache:$PWD/../cache

if [ $? != 0 ]
then
    error "VIP_test execution failed!"
    exit 1
fi

info "Execution of VIP_test completed."