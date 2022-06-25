#!/bin/sh

read -e -p "Game name: " TEMPLATE_NAME
read -e -p "Description: " TEMPLATE_DESC
read -e -p "Author: " TEMPLATE_AUTHOR
read -e -p "Bundle ID: " TEMPLATE_BUNDLEID

export TEMPLATE_NAME=$TEMPLATE_NAME
export TEMPLATE_DESC=$TEMPLATE_DESC
export TEMPLATE_AUTHOR=$TEMPLATE_AUTHOR
export TEMPLATE_BUNDLEID=$TEMPLATE_BUNDLEID

TEMPLATE_VARS='$TEMPLATE_NAME:$TEMPLATE_DESC:$TEMPLATE_AUTHOR:$TEMPLATE_BUNDLEID'

envsubst "$TEMPLATE_VARS" < "config/Makefile" > Makefile
envsubst "$TEMPLATE_VARS" < "config/CMakeLists.txt" > CMakeLists.txt
envsubst "$TEMPLATE_VARS" < "config/Source/pdxinfo" > Source/pdxinfo
