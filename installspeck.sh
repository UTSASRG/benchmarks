#!/bin/sh

#STEPS to install spec2k6
sudo mount -o loop -t iso9660 -o ro,exec /home/tongpingliu/projects/benchmarks/CPU2K6.iso /mnt/
cd /mnt
./install.sh


