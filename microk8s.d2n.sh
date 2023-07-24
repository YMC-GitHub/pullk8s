#!/usr/bin/env bash
rm -rf /var/snap/microk8s/5372/inspection-report*
microk8s.inspect
# move inspect result to /tmp
# sudo mv /var/snap/microk8s/current/inspection-report-*.tar.gz /tmp/inspect.tar.gz
sudo mv /var/snap/microk8s/5372/inspection-report-*.tar.gz /tmp/inspect.tar.gz
sudo chmod 666 /tmp/inspect.tar.gz
cd /tmp
# unzip and untar it
tar -zxf /tmp/inspect.tar.gz

# find missing images log lines in containerd and kubelite journal.log, and extract the missing images
echo "======== missing images ========="
MISSING_IMG_FILE=/tmp/.imgs
rm -rf ${MISSING_IMG_FILE}
grep -i "error" /tmp/inspection-report/snap.microk8s.daemon-containerd/journal.log|grep -i "image"|perl -ne 'if(/failed to pull image \\"(.*?)\\"/){printf("$1\n")}'| tail -100|uniq >> ${MISSING_IMG_FILE}
grep -i "err" /tmp/inspection-report/snap.microk8s.daemon-kubelite/journal.log|grep -i "image"|perl -ne 'if(/Back-off pulling image .*?"(.*?)\\.*$/){printf("$1\n")}'|tail -100|uniq >> ${MISSING_IMG_FILE}
uniq ${MISSING_IMG_FILE}