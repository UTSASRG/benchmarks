#!/usr/bin/python

import os;
import sys;
import subprocess;
import re;
import random;

#input the data files in a array 

#Variables are listed here.
# The hourly unit to calculate the sum of usage
benchmarks= ['perlbench', 'bzip2', 'gcc', 'mcf', 'gobmk', 'hmmer', 'sjeng', 'libquantum', 'h264ref', 'omnetpp', 'astar', 'Xalan', 'milc', 'namd', 'dealII', 'soplex', 'povray', 'lbm', 'sphinx']
#runlist=perlbench, bzip2, gcc, mcf, gobmk, hmmer, sjeng, libquantum, h264ref, omnetpp, astar, xalancbmk, 433.milc, 444.namd, 447.dealII, 450.soplex, 453.povray, 470.lbm, 482.sphinx3

#benchmarks = ['histogram', 'kmeans','linear_regression', 'matrix_multiply', 'pca', 'reverse_index', 'string_match', 'word_count', 'blackscholes', 'bodytrack', 'dedup', 'ferret', 'fluidanimate', 'streamcluster', 'swaptions', 'x264'] 
#benchmarks = ['blackscholes', 'bodytrack', 'dedup', 'ferret', 'fluidanimate', 'histogram', 'kmeans', 'reverse_index', 'matrix_multiply', 'pca', 'streamcluster', 'swaptions', 'word_count'] 

def getMemUsage(dirname, filename):
  inputfile = open(dirname + '/' + filename, "rw");
  memuse = 0;
  #  Pss:                 72 kB 
  for line in inputfile:
    if line.startswith("Pss:"):
      words = line.split();
      if words[2] == "kB":
        memuse += int(words[1]);
      elif words[2] == "MB":
        memuse += int(words[1]) * 1024;
#  print filename, "with memusage:",  memuse, "\n"; 
  inputfile.close();
  return memuse;

for dir in benchmarks:
  allfiles=os.listdir(dir);
  maxmem = 0;
  for file in allfiles:
    mem=getMemUsage(dir, file);
    if maxmem < mem:
      maxmem = mem;
    
  print dir, "\t", maxmem;
