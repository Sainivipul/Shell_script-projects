#!/bin/bash

#$ revision : 01 $

# Fri.28.06.2024

#variables

BASE=/home/mdrive/commandcentredocs/SL_monitoring_ss

DAYS=10

DEPTH=1

RUN=0

#chewck if dir exist or not 

if [ ! -d $BASE]

then 
    echo " Directory does not exist exit: $BASE"
    exit 1

fi 

#create archive folder if not present 

if [ ! -d $BASE/archive ]

then 
    mkdir $BASE/archive 
fi 

find the list of file larger then 20MB and older then 15 days 

for i in `find.$BASE -maxdepth $DEPTH -type f -size +20M `

do 
  
   if [ $RUN -eq 0 ]
   then 
       echo "[$date "+%y -%m -%d %H:%M:%S"] archiving $i ==> $BASE/archiving"
       gzip $i || exit 1
       mv $i.gz  $BASE/archive || exirt 1
   fi 
   


