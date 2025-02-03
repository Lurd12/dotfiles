#!/bin/bash
my_array=(/home/lur/wallpapers/*)
wal -q -i  ${my_array[$(( $RANDOM % ${#my_array[@]}))]}


