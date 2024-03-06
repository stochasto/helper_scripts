#!/bin/bash

ls > flist

counter=1

script="runSlurm_std2.sh"

while read -r line
do

if [ -d $line ] && [ "$counter" != 2 ]; then
	cd $line
	echo $counter
	echo $line
	JID=$(sbatch --dependency=afterany:${JID} -w bngstcb-n-cp021a06 --parsable $script)
	cd ..

elif [ -d $line ] && [ "$counter" == 2 ]; then
	cd $line
	echo $counter
	echo $line
	JID=$(sbatch -w bngstcb-n-cp021a06 --parsable $script)
	cd ..
else 
	echo "yoyo"
fi
counter=$((counter + 1))


done < flist
