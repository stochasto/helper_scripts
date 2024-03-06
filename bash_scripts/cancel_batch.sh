#!/bin/bash

first=324722

last=324817

while [ $first -le $last ]; do

scancel $first

first=$((first + 1))


done
