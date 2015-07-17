export LD_LIBRARY_PATH=SOURCE_DIR
./BARNES < inputs/input-barnes

# Number of Processors : Integer greater than 0
./FMM < inputs/input-fmm.16384

# ERROR: Maximum work limit 10000.00000 exceeded
./OCEAN -n258 -p8 -e1e-07 -r20000 -t28800

#?? Runs too fast???
./RADIOSITY

# Raytrace: balls4.env.Z  balls4.geo.Z  car.env.Z     car.geo.Z     teapot.env.Z  teapot.geo.Z 
# Remember to put balls4.env and balls4.geo in the current directory.
./RAYTRACE -m32 -p8 balls4.env

# ERROR: segmentation error.
./VOLREND 8 inputs/head-scaleddown2.den

# We have to put input-water-nsquared and randomin in the current directory.
./WATER-NSQUARED < input-water-nsquared
./WATER-SPATIAL < input-water-spatial

./CHOLESKY -p8 -B32 -C16384 inputs/tk29.O
./FFT
./LU
./RADIX
