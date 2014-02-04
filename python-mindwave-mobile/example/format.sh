#!/bin/bash

i=1
while read p; do
	if ((i == 1)); then
	  tmp=${p#*: }
	  output="$tmp"
	elif ((i == 3)); then
	  tmp=""
	elif ((i == 13)); then
	  tmp=${p#*: }
	  output="$output, $tmp"
	  echo "$output"
	  i=0
	else
	  tmp=${p#*: }
	  output="$output, $tmp"
	fi
	i=`expr $i + 1`
done < "$1" 

