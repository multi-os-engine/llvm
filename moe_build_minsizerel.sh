#!/bin/bash

realpath () {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

cd "$(dirname "$(realpath "$0")")";

cd ../

if [ ! -d "llvm-build-minsizerel" ]; then
    mkdir llvm-build-minsizerel
    cd llvm-build-minsizerel
    cmake -DCMAKE_BUILD_TYPE=MinSizeRel -G "Unix Makefiles" ../llvm
else
    cd llvm-build-minsizerel
fi

make "-j$(sysctl -n hw.ncpu)"
