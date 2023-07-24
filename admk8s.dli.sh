#!/usr/bin/env bash


#zero:task:s:out-cli-version
if [ $1"_" = "version_" ];then
    echo "./`basename $0` version 1.0.0"
    exit 0
fi
#zero:task:e:out-cli-version

#zero:task:s:out-usage
zero_app_dli_usage="usage: ./`basename $0` KUBERNETES-VERSION <huburl> <likedockercli>
subcommand:
    version -- output cli version
    help -- output usage
"

if [ $# -ne 1 ];then
    echo "$zero_app_dli_usage"
    exit 1
fi
if [ $1"_" = "help_" ];then
    echo "$zero_app_dli_usage"
    exit 0
fi
#zero:task:e:out-usage


#zero:task:s:set-default-value
# version="1.27.2"
# 1.26.3,1.27.2
# huburl="gcr.azk8s.cn/google-containers/"
huburl="registry.aliyuncs.com/google_containers/"
dockercli="docker"
#zero:task:e:set-default-value

#zero:task:s:bind-scr-level-args-value
[ -n "$1" ] && version=$1
[ -n "$2" ] && huburl=$2
[ -n "$3" ] && dockercli=$3
#zero:task:e:bind-scr-level-args-value


images=`kubeadm config images list --kubernetes-version=${version} |awk -F'/' '{print $2}'`

for imageName in ${images[@]};do
    $dockercli pull ${huburl}$imageName
    $dockercli tag  ${huburl}$imageName k8s.gcr.io/$imageName
    $dockercli rmi  ${huburl}$imageName
done