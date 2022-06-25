#!/bin/sh

mkdir -p build
pushd build
cmake -DCMAKE_TOOLCHAIN_FILE="$PLAYDATE_SDK_PATH/C_API/buildsupport/arm.cmake" ..
mv compile_commands.json ..
popd
make simulator
