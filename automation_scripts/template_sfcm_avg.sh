#!/bin/bash

x=512
y=512
z=512

pore
clay
rock

nlmParam

inFile
outFileSFCM="segAvg_rha02_2um_"$nlmParam"_8bu_"$x"x"$y"x"$z".raw"
outFileUncertain="finSegAvg_rha02_2um_"$nlmParam"_8bu_"$x"x"$y"x"$z".raw"

inPath="../nlmvols_2um/"$inFile
echo $inPath

./sFCM_optimized $inPath $outFileSFCM $x $y $z $pore $clay $rock

./Optimised_uncertain $inPath $outFileSFCM $outFileUncertain $x $y $z $pore $clay
