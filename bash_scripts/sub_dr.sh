#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH -A dr
#SBATCH -C rhel8
#SBATCH -o "slurm.out" 
#SBATCH -e "slurm.err" 

[[ -r /apps/3rdparty/hpcrnd/envmodules/profile.d/shell-modules.sh ]] && . /apps/3rdparty/hpcrnd/envmodules/profile.d/shell-modules.sh
[[ -r /apps/3rdparty/hpcrnd/envmodules/profile.d/hpc-modules.sh ]] && . /apps/3rdparty/hpcrnd/envmodules/profile.d/hpc-modules.sh


. /glb/apps/hpc/EasyBuild/Public/Lmod/etc/profile.d/z01_lmod-hpcti.sh

#source /glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/anaconda3/etc/profile.d/conda.sh
eval "$(conda shell.bash hook)"
conda activate

#inDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/results/dpit_5mics/q_dpit_5mics_2'
inDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/results/dpit_8mics/std2'

#outDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/arg_out'
#outDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/results/dpit_5mics/final_results_dpit_5mics'
#outDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/results/dpit_5mics/r_2'
outDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/results/dpit_8mics/res_dr_1_to_8'
numProcs=32
dpit=8e-6

script='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/comsol_batch/Pitting_Corrosion/postproc/PostProcessingCode/postproc.py'

python $script --inDir $inDir --outDir $outDir --numProcs $numProcs --dpit $dpit
