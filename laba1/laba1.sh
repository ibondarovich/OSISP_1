#!/bin/bash

find $1 -type d 2>errors.txt | while read line; do
        count=0
        size=0
        for file in $(find $line -maxdepth 1 -type f -name "*$2*" 2>>errors.txt);
        do
                let count=count+1
                let size=$(stat -c %s $file 2>>errors.txt)+size
        done
        echo "$line $count $size"
done
IFS=$(printf '\n\t')
for error in $(cat errors.txt );
	do
		echo $(basename $0): ${error} >&2
	done
rm errors.txt
