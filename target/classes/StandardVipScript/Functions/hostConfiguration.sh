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
