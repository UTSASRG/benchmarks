#!/bin/sh

LLVM=/home/tongpingliu/projects/doubletake/llvm/llvm-3.2.src/
#mkdir llvm_cmake_build 
cd llvm_cmake_build
CC="clang -I/usr/include/x86_64-linux-gnu/c++/4.9/" CXX="clang++ -I/usr/include/x86_64-linux-gnu/c++/4.9/" $LLVM/configure --prefix=/home/tongpingliu/projects/doubletake/llvm/llvm --enable-optimized
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=ON $LLVM
make check-asan -j10 TOOL_NO_EXPORTS= HAVE_LINK_VERSION_SCRIPT=0 
