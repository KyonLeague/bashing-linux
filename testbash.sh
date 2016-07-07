#! /bin/sh

getMemoryPerCore() {
    echo $(expr $2 / $1) "GB RAM per Core"
}

#getCpuCore() {
#    core=$(grep -c ^processor /proc/cpuinfo)
#    echo $core
#}

getTotalMemory() {
    totalMem=$(awk '/^MemTotal:/{print $2}' /proc/meminfo)
    echo $(expr $totalMem / 1000 / 1000 )
}

getMetrics() {
    res=$1
    ress=$(getTotalMemory)
    getMemoryPerCore $res $ress
}

#if [ -n "$1" ] && [ "$1" = "getCpuCore" ]; then
#    getCpuCore
#    exit 0
#elif [ -n "$1" ] && [ "$1" = "getTotalMemory" ]; then
#    getTotalMemory
#    exit 0
#elif [ -n "$1" ] && [ "$1" = "getMetrics" ]; then
#    getMetrics
#    exit 0
#elif [ -n "$1" ] && [ "$1" != "getCpuCore" ] && [ "$1" != "getTotalMemory" ] && [ "$1" != "getMetrics" ]; then
#    if [ -n "$2" ]; then
#        getMemoryPerCore $1 $2
#        exit 0
#    else
#        echo "The [RAM] parameter are missing."
#    fi
#else
#    echo "The [Core] [RAM] parameter are missing."
#fi

if [ -n "$1" ]; then
    getMetrics $1
else
    echo "Missing Parameter: [CORES] !"
fi
