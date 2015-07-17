#!/bin/bash

APPS_DIR=$PWD
if [ "$APPS_DIR" = "" ]; then
	echo '$APPS_DIR not defined, do `export APPRS_DIR=`'
	exit 1
fi

CUR_DIR=$PWD
rm splash2 -rf
tar zxvf $APPS_DIR/sys/splash2.tar.gz

CODES_DIR=$CUR_DIR/splash2/codes
FFT_DIR=$CODES_DIR/kernels/fft
LU_DIR=$CODES_DIR/kernels/lu/non_contiguous_blocks
RADIX_DIR=$CODES_DIR/kernels/radix
CHOLESKY_DIR=$CODES_DIR/kernels/cholesky
BARNES_DIR=$CODES_DIR/apps/barnes
FMM_DIR=$CODES_DIR/apps/fmm
OCEAN_DIR=$CODES_DIR/apps/ocean/non_contiguous_partitions
RADIOSITY_DIR=$CODES_DIR/apps/radiosity
RAYTRACE_DIR=$CODES_DIR/apps/raytrace
VOLREND_DIR=$CODES_DIR/apps/volrend
WATER_NSQUARED_DIR=$CODES_DIR/apps/water-nsquared
WATER_SPATIAL_DIR=$CODES_DIR/apps/water-spatial

TARGET="$*"
if [ "$TARGET" = "" ]; then
	TARGET="FFT LU RADIX CHOLESKY BARNES FMM OCEAN RADIOSITY RAYTRACE VOLREND WATER-NSQUARED WATER-SPATIAL"
fi

echo "Target: $TARGET"

cd splash2

tar xzvf $APPS_DIR/sys/gmp-4.3.2.tar.gz
cd gmp-4.3.2
./configure --prefix=$PWD/install
make
make install
cd ..

tar xzvf $APPS_DIR/sys/mpfr-2.4.2.tar.gz
cd mpfr-2.4.2
./configure --prefix=$PWD/install --with-gmp=$PWD/../gmp-4.3.2/install
make
make install
cd ..

tar zxvf $APPS_DIR/sys/mpc-0.5.2.tar.gz
cd mpc-0.5.2
./configure --prefix=$PWD/install --with-gmp=$PWD/../gmp-4.3.2/install --with-mpfr=$PWD/../mpfr-2.4.2/install
make
make install
cd ..

if [[ $TARGET == *FFT* ]]; then
	cd $FFT_DIR
	make
fi

if [[ $TARGET == *LU* ]]; then
	cd $LU_DIR
	make
fi

if [[ $TARGET == *RADIX* ]]; then
	cd $RADIX_DIR
	make
fi

if [[ $TARGET == *CHOLESKY* ]]; then
	cd $CHOLESKY_DIR
	make
fi

if [[ $TARGET == *BARNES* ]]; then
	cd $BARNES_DIR
	make
fi

if [[ $TARGET == *FMM* ]]; then
	cd $FMM_DIR
	make
fi

if [[ $TARGET == *OCEAN* ]]; then
	cd $OCEAN_DIR
	make
fi

if [[ $TARGET == *RADIOSITY* ]]; then
	cd $RADIOSITY_DIR
	make
fi

if [[ $TARGET == *RAYTRACE* ]]; then
	cd $RAYTRACE_DIR
	make
fi

if [[ $TARGET == *VOLREND* ]]; then
	cd $VOLREND_DIR
	tar zxvf 
	cd libtiff
	make
	cd ..
	make
fi

if [[ $TARGET == *WATER-NSQUARED* ]]; then
	cd $WATER_NSQUARED_DIR
	make
fi

if [[ $TARGET == *WATER-SPATIAL* ]]; then
	cd $WATER_SPATIAL_DIR
	make
fi

# copy executables and input files to the current directory
cd $CUR_DIR
mkdir -p inputs

if [[ $TARGET == *FFT* ]]; then
	cp $FFT_DIR/FFT .
fi

if [[ $TARGET == *LU* ]]; then
	cp $LU_DIR/LU .
fi

if [[ $TARGET == *RADIX* ]]; then
	cp $RADIX_DIR/RADIX .
fi

if [[ $TARGET == *CHOLESKY* ]]; then
	cp $CHOLESKY_DIR/CHOLESKY .
	cp $CHOLESKY_DIR/inputs/* inputs && gzip -dvf inputs/*.O.Z
fi

if [[ $TARGET == *BARNES* ]]; then
	cp $BARNES_DIR/BARNES .
	cp $BARNES_DIR/input inputs/input-barnes
fi

if [[ $TARGET == *FMM* ]]; then
	cp $FMM_DIR/FMM .
	cp $FMM_DIR/inputs/* inputs
fi

if [[ $TARGET == *OCEAN* ]]; then
	cp $OCEAN_DIR/OCEAN .
fi

if [[ $TARGET == *RADIOSITY* ]]; then
	cp $RADIOSITY_DIR/RADIOSITY .
fi

if [[ $TARGET == *RAYTRACE* ]]; then
	cp $RAYTRACE_DIR/RAYTRACE .
	cp $RAYTRACE_DIR/inputs/* inputs/ && gzip -dvf inputs/*.Z
fi

if [[ $TARGET == *VOLREND* ]]; then
	cp $VOLREND_DIR/VOLREND .
	cp $VOLREND_DIR/inputs/* inputs/ && gzip -dvf inputs/*.den.Z
fi

if [[ $TARGET == *WATER-NSQUARED* ]]; then
	cp $WATER_NSQUARED_DIR/WATER-NSQUARED .
	cp $WATER_NSQUARED_DIR/input inputs/input-water-nsquared
	cp $WATER_NSQUARED_DIR/random.in inputs/random.in-water-nsquared
fi

if [[ $TARGET == *WATER-SPATIAL* ]]; then
	cp $WATER_SPATIAL_DIR/WATER-SPATIAL .
	cp $WATER_SPATIAL_DIR/input inputs/input-water-spatial
	cp $WATER_SPATIAL_DIR/random.in inputs/random.in-water-spatial
fi

