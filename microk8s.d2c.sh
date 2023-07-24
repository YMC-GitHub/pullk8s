#!/usr/bin/env bash

# for example pause:3.1 by default will be pulled from k8s.gcr.io/pause:3.1
# but for some reason it is doom to fail
# this script will pull by available mirror then tag to the target name,

if [ $# -ne 3 ];then

    echo "usage: ./`basename $0` MIRROR PREFIX IMAGE"
    exit 1
fi

DOCKER=docker
CTR=microk8s.ctr

MIRROR=$1
PREFIX=$2
IMAGE=$3
echo $MIRROR
echo $PREFIX
echo $IMAGE
TAR_FILE=/tmp/img.tar


cmd="$DOCKER pull $MIRROR/$IMAGE"
echo $cmd
$cmd
## 将相关镜像tag为 $PREFIX/...
cmd="$DOCKER tag $MIRROR/$IMAGE $PREFIX/$IMAGE"
echo $cmd
$cmd

## 保存镜像为本地镜像文件
cmd="$DOCKER save $PREFIX/$IMAGE"
echo $cmd "> $TAR_FILE"
$cmd > $TAR_FILE
## ctr导入本地镜像
cmd="$CTR image import"
echo $cmd "$TAR_FILE"
$cmd $TAR_FILE
echo "============================================="