#!/bin/bash

ls > flist

counter=1

script="runSlurm_std2.sh"


JID=235928

while read -r line
do

if [ -d $line ]; then
	cd $line
	echo $counter
	echo $line
	JID=$(sbatch --dependency=afterany:${JID} -w bngstcb-n-cp021a01 --parsable $script)
	cd ..

fi

counter=$((counter + 1))

done < flist
