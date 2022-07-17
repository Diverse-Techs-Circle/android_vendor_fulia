#!/bin/bash

START_DIR=$(pwd)
cd ${ANDROID_BUILD_TOP}/packages/apps/Bromite

TARGET_ARCH=$1
BROMITE_VERSION_FILE=${TARGET_ARCH}_current_bromite_version.txt
BROMITE_LATEST_TAG=$(curl -s -L https://github.com/bromite/bromite/releases/latest | grep "download/[0-9\.]*" | cut -d '/' -f6 | head -n 1)

function get_latest_bromite () {
    echo "info: Downloading latest Bromite"
    if [ $TARGET_ARCH = x86_64 ]; then
        curl -H 'Accept: application/octet-stream' -L -O https://github.com/bromite/bromite/releases/download/${BROMITE_LATEST_TAG}/x64_ChromePublic.apk
    elif [ $TARGET_ARCH = x86 ]; then
        curl -H 'Accept: application/octet-stream' -L -O https://github.com/bromite/bromite/releases/download/${BROMITE_LATEST_TAG}/x86_ChromePublic.apk
    else
        curl -H 'Accept: application/octet-stream' -L -O https://github.com/bromite/bromite/releases/download/${BROMITE_LATEST_TAG}/${TARGET_ARCH}_ChromePublic.apk
    fi
    echo ${BROMITE_LATEST_TAG} > ${BROMITE_VERSION_FILE}
}

if [ -f $BROMITE_VERSION_FILE ]; then
    if [ $(cat ${BROMITE_VERSION_FILE}) = ${BROMITE_LATEST_TAG} ]; then
        echo "info: No need to get latest Bromite"
    else
        get_latest_bromite
    fi
else
    get_latest_bromite
fi

cd ${START_DIR}
