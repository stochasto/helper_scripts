#!/bin/bash -f

#SCRIPT TO READ PARAMETERS FROM SHEET AND RUN SFCM SEQUENTIALLY


awk '{

print($1);
inFile=$1
nlm=$2
sPore=$6
sClay=$7
sRock=$8
   while ((getline < "template_sfcm_avg.sh") > 0)
	{
		if ($1 == "inFile"){sub($1,"inFile="inFile)}
		if ($1 == "pore"){sub($1,"pore="sPore)}
		if ($1 == "clay"){sub($1,"clay="sClay)}
		if ($1 == "rock"){sub($1,"rock="sRock)}
		if ($1 == "nlmParam"){sub($1,"nlmParam="nlm)}
		print $0 > "run_sfcm_avg.sh"
	}

	close("template_sfcm_avg.sh")		
	close("run_sfcm_avg.sh")		

	system("./run_sfcm_avg.sh")


}' 2um_rha02_threshlist.txt
  
