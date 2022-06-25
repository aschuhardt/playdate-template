#!/bin/sh

read -e -p "Game name: " TEMPLATE_NAME
read -e -p "Description: " TEMPLATE_DESC
read -e -p "Author: " TEMPLATE_AUTHOR
read -e -p "Build ID: " TEMPLATE_BUILDID
envsubst < "config/Makefile" > Makefile
envsubst < "config/CMakeLists.txt" > CMakeLists.txt
envsubst < "config/Source/pdxinfo" > Source/pdxinfo
