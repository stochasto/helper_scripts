#!/bin/bash

ls > flist

while read -r line
do

if [ -d $line ]; then

	echo $line
	cd $line
	sbatch runSlurm_std1.sh
	cd ..

fi


done < flist
