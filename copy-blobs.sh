#!/usr/bin/env bash

if [[ -z  $1 ]] ; then
   echo "Error: Target directory is not provided!"
   exit 1;
fi

if [[ -z $BITNESS ]] ;then
   echo "Error: BITNESS envar must be specified"
   exit 1;
fi

TARGET_DIR=$1/

WORK_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

UNAME="$(uname -s)"
case "${UNAME}" in
    Linux*)     PLATFORM=linux;;
    Darwin*)    PLATFORM=darwin;;
    MSYS*)      PLATFORM=windows;;
    MINGW*)     PLATFORM=windows;;
    *)          PLATFORM="UNKNOWN:${UNAME}";;
esac

if [ "$PLATFORM" = "linux" ]; then

    if [ "$BITNESS" = "32" ]; then
        LIBRARIES="/usr/lib32/libstdc++.so.6"
    else
        LIBRARIES="/usr/lib/x86_64-linux-gnu/libstdc++.so.6"
    fi

elif [ "$PLATFORM" = "darwin" ]; then

    LIBRARIES="/usr/lib/libc++.1.dylib"

elif [ "$PLATFORM" = "windows" ]; then

    LIBRARIES="/mingw$BITNESS/bin/libstdc++-6.dll
/mingw$BITNESS/bin/libgcc_s_seh-1.dll
/mingw$BITNESS/bin/libwinpthread-1.dll"

else
    echo "Error: Unrecognized platform $PLATFORM";
    exit 1;
fi

mkdir -p $TARGET_DIR
while read -r lib; do
    cp $lib $TARGET_DIR
done <<< "$LIBRARIES"
