#!/bin/sh

tar zxvf llvm-3.2.src.tar.gz
cd llvm-3.2.src/tools/
cp ../../clang-3.2.src.tar.gz ./
tar zxvf clang-3.2.src.tar.gz 
mv clang-3.2.src clang
rm -f clang-3.2.src.tar.gz 
cd ..
tar zxvf ../compiler-rt.tar.gz -C projects

LLVM=/home/tongpingliu/projects/doubletake/llvm/llvm-3.2.src/
#mkdir llvm_cmake_build 
cd llvm_cmake_build
CC="clang -I/usr/include/x86_64-linux-gnu/c++/4.9/" CXX="clang++ -I/usr/include/x86_64-linux-gnu/c++/4.9/" $LLVM/configure --prefix=/home/tongpingliu/projects/doubletake/llvm/llvm --enable-optimized
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=ON $LLVM
make check-asan -j10 TOOL_NO_EXPORTS= HAVE_LINK_VERSION_SCRIPT=0 
