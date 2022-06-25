#!/bin/sh

read -e -p "Game name: " TEMPLATE_NAME
read -e -p "Description: " TEMPLATE_DESC
read -e -p "Author: " TEMPLATE_AUTHOR
read -e -p "Build ID: " TEMPLATE_BUILDID

export TEMPLATE_NAME=$TEMPLATE_NAME
export TEMPLATE_DESC=$TEMPLATE_DESC
export TEMPLATE_AUTHOR=$TEMPLATE_AUTHOR
export TEMPLATE_BUILDID=$TEMPLATE_BUILDID

TEMPLATE_VARS='$TEMPLATE_NAME:$TEMPLATE_DESC:$TEMPLATE_AUTHOR:$TEMPLATE_BUILDID'

envsubst "$TEMPLATE_VARS" < "config/Makefile" > Makefile
envsubst "$TEMPLATE_VARS" < "config/CMakeLists.txt" > CMakeLists.txt
envsubst "$TEMPLATE_VARS" < "config/Source/pdxinfo" > Source/pdxinfo
