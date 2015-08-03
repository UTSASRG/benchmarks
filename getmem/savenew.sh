#!/bin/bash

times=0
appnum=0
Benchmarks=( perlbench bzip2 gcc mcf gobmk hmmer sjeng libquantum h264ref omnetpp astar xalancbmk milc namd dealII soplex povray lbm sphinx3 )

while true
do
  PROCESS=${Benchmarks[$appnum]}
  echo $PROCESS;
  mkdir -p results/$PROCESS;
  sleep 2;
  number=0;

  # We have to evaluate whether it is existing or not so that we won't exit too early
  while true
  do
    TESTPID=`ps cax | grep $PROCESS | grep -o '^[ ]*[0-9]*' | sed 's/^ *//g'`;
    if [ $TESTPID -ne 0 ]; then 
      break;
    fi
    sleep 60;
  done

  # Now it is time to collect memory data
  while true 
  do
    PID=`ps cax | grep $PROCESS | grep -o '^[ ]*[0-9]*' | sed 's/^ *//g'`;
    if [ $PID -ne 0 ]; then 
      savename="results/$PROCESS/smaps.$number";
      origname="/proc/$PID/smaps";
      cat $origname > $savename;
    else
      break;
    fi
    number=`expr $number + 1`;
    sleep 60;
  done
  appnum=`expr $appnum + 1`;
  if [ $appnum -eq 19 ]
  then
    exit;
  fi
done
# Check the process name and id.

# Do this periodically
# If the program is running, save /proc/pid/smaps to a separate directory.

# Otherwise, exit.
