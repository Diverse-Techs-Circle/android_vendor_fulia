#!/bin/bash

START_DIR=$(pwd)
cd ${ANDROID_BUILD_TOP}/external/bromite-webview

TARGET_ARCH=$1
BROMITE_VERSION_FILE=${TARGET_ARCH}_current_bromite_version.txt
BROMITE_LATEST_TAG=$(curl -s -L https://github.com/bromite/bromite/releases/latest | grep "download/[0-9\.]*" | cut -d '/' -f6 | head -n 1)

function get_latest_bromite () {
    echo "info: Downloading latest BromiteWebView"
    if [ $TARGET_ARCH = x86_64 ]; then
        curl -H 'Accept: application/octet-stream' -L -O https://github.com/bromite/bromite/releases/download/${BROMITE_LATEST_TAG}/x64_SystemWebView.apk
        mv x64_SystemWebView.apk x86_64_SystemWebView.apk
    else
        curl -H 'Accept: application/octet-stream' -L -O https://github.com/bromite/bromite/releases/download/${BROMITE_LATEST_TAG}/${TARGET_ARCH}_SystemWebView.apk
    fi
    echo ${BROMITE_LATEST_TAG} > ${BROMITE_VERSION_FILE}
}

if [ -f $BROMITE_VERSION_FILE ]; then
    if [ $(cat ${BROMITE_VERSION_FILE}) = ${BROMITE_LATEST_TAG} ]; then
        echo "info: No need to get latest BromiteWebView"
    else
        get_latest_bromite
    fi
else
    get_latest_bromite
fi

cd ${START_DIR}