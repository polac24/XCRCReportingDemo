#!/bin/bash

git remote add self .
git fetch self


git checkout -f
rm -rf ~/Library/Caches/XCRemoteCache/localhost
rm -rf /tmp/cache

# Download XCRC
XCRC_VERSION="${XCRC_VERSION:-0.3.17}"
curl -LC - "https://github.com/spotify/XCRemoteCache/releases/download/v${XCRC_VERSION}/XCRemoteCache-macOS-arm64-x86_64-v${XCRC_VERSION}.zip" -o "${XCRC_VERSION}.zip"
unzip -o "${XCRC_VERSION}.zip" -d "XCRC"

# start ngingx
nginx -s stop
nginx -c $PWD/nginx.conf 

# reset stats
XCRC/xcprepare stats --reset > /dev/null

## Producer
XCRC/xcprepare integrate --input DemoReferences.xcodeproj --mode producer --final-producer-target DemoReferences

echo "1. Preparing for a producer step...."
echo "1. Clean the project (⌘+⇧+B) and build the xcodeproj project in Xcode IDE for DemoReferences scheme and press [Enter] when ready:"
echo -n "> "
read USER_INPUT

## print & reset stats
XCRC/xcprepare stats
XCRC/xcprepare stats --reset > /dev/null

## Consumer
XCRC/xcprepare integrate --input DemoReferences.xcodeproj --mode consumer --final-producer-target DemoReferences

echo "2. Preparing for a consumer step...."
echo "Clean the project (⌘+⇧+B) and build the xcodeproj project in Xcode IDE for DemoReferences scheme and press [Enter] when ready:"
read USER_INPUT

## print stats
XCRC/xcprepare stats
XCRC/xcprepare stats --reset > /dev/null

## stop nginx (temporarly disabled)
nginx -s stop

echo "Verify if the cache hit is as expected and IDE experience is flawless."
