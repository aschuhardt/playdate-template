cmake_minimum_required(VERSION 3.14)

set(CMAKE_C_STANDARD 11)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(ENVSDK $ENV{PLAYDATE_SDK_PATH})

if (NOT ${ENVSDK} STREQUAL "")
  # Convert path from Windows
  file(TO_CMAKE_PATH ${ENVSDK} SDK)
else()
  execute_process(
    COMMAND bash -c "egrep '^\\s*SDKRoot' $HOME/.Playdate/config"
    COMMAND head -n 1
    COMMAND cut -c9-
    OUTPUT_VARIABLE SDK
    OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

if (NOT EXISTS ${SDK})
  message(FATAL_ERROR "SDK Path not found; set ENV value PLAYDATE_SDK_PATH")
  return()
endif()

# get all the arm-none-eabi-gcc standard header directories so that
# we can include them and have them included in compile_commands.json
# (for YCM goodness)
execute_process(
  COMMAND bash -c "arm-none-eabi-gcc -xc /dev/null -E -Wp,-v 2>&1 | sed -n 's,^ ,,p' | tr '\\n' ';'"
  OUTPUT_VARIABLE ARM_INCLUDES
  OUTPUT_STRIP_TRAILING_WHITESPACE)
foreach(ARM_DIR ${ARM_INCLUDES})
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -I${ARM_DIR}")
endforeach()

set(CMAKE_CONFIGURATION_TYPES "Debug;Release")
set(CMAKE_XCODE_GENERATE_SCHEME TRUE)

# Game Name Customization
set(PLAYDATE_GAME_NAME ${TEMPLATE_NAME})
set(PLAYDATE_GAME_DEVICE ${TEMPLATE_NAME}_DEVICE)

project(${PLAYDATE_GAME_NAME} C ASM)

if (TOOLCHAIN STREQUAL "armgcc")
  add_executable(${PLAYDATE_GAME_DEVICE} ${SDK}/C_API/buildsupport/setup.c src/main.c)
else()
  add_library(${PLAYDATE_GAME_NAME} SHARED src/main.c )
endif()

include(${SDK}/C_API/buildsupport/playdate_game.cmake)
