#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH -A compsc
#SBATCH -p pt
#SBATCH -C rhel8
#SBATCH -o "slurm.out" 
#SBATCH -e "slurm.err" 
[[ -r /apps/3rdparty/hpcrnd/envmodules/profile.d/shell-modules.sh ]] && . /apps/3rdparty/hpcrnd/envmodules/profile.d/shell-modules.sh
[[ -r /apps/3rdparty/hpcrnd/envmodules/profile.d/hpc-modules.sh ]] && . /apps/3rdparty/hpcrnd/envmodules/profile.d/hpc-modules.sh


. /glb/apps/hpc/EasyBuild/Public/Lmod/etc/profile.d/z01_lmod-hpcti.sh

#[[ -r /apps/3rdparty/hpcrnd/envmodules/profile.d/shell-modules.sh ]] && . /apps/3rdparty/hpcrnd/envmodules/profile.d/shell-modules.sh
#[[ -r /apps/3rdparty/hpcrnd/envmodules/profile.d/hpc-modules.sh ]] && . /apps/3rdparty/hpcrnd/envmodules/profile.d/hpc-modules.sh

#. /glb/apps/hpc/EasyBuild/Public/Lmod/etc/profile.d/z01_lmod-hpcti.sh

#source /glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/anaconda3/etc/profile.d/conda.sh
eval "$(conda shell.bash hook)"
conda activate

#inDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/results/dpit_5mics/q_dpit_5mics_2'
#inDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/results/dpit_8mics/std2'
#inDir='/glb/home/invmfj/workdir_ir7/Code/Phase_Field/test/qlog/psweep/comsol_batch/results/single_pit/repass_final'
#inDir='/glb/home/invmfj/workdir_ir7/Code/Phase_Field/test/qlog/psweep/comsol_batch/results/single_pit/std2_rp_long'
#inDir='/glb/home/invmfj/workdir_ir7/Code/Phase_Field/test/qlog/psweep/comsol_batch/results/single_pit/repass_final_2'
inDir='/glb/home/invmfj/workdir_ir7/Code/Phase_Field/test/qlog/psweep/comsol_batch/results/single_pit/repass_final_3'

#outDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/arg_out'
#outDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/results/dpit_5mics/final_results_dpit_5mics'
#outDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/results/dpit_5mics/r_2'
#outDir='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/bng_backup/comsol_batch/results/dpit_8mics/res_dr_1_to_8'
#outDir='/glb/home/invmfj/workdir_ir7/Code/Phase_Field/test/qlog/psweep/comsol_batch/results/single_pit/repass_results'
#outDir='/glb/home/invmfj/workdir_ir7/Code/Phase_Field/test/qlog/psweep/comsol_batch/results/single_pit/repass_results_long'
#outDir='/glb/home/invmfj/workdir_ir7/Code/Phase_Field/test/qlog/psweep/comsol_batch/results/single_pit/repass_results_4um'
outDir='/glb/home/invmfj/workdir_ir7/Code/Phase_Field/test/qlog/psweep/comsol_batch/results/single_pit/repass_results_4um_long'
dpit=0

numProcs=32
# Set total text and Depth processes equal to the number of files
numProcsText=1
numProcsUnorg=32
numProcsDepth=1

#script='/glb/data/drs1/users/Bangalore/invmfj/iterativeRecon/B1M4/mlem_test/fdk_centershift/rocks/json/comsol_batch/Pitting_Corrosion/postproc/PostProcessingCode/postproc.py'
script='/glb/home/invmfj/workdir_ir7/Code/Phase_Field/test/qlog/psweep/comsol_batch/Pitting_Corrosion/postproc/PostProcessingCode/postproc.py'

python $script --inDir $inDir --outDir $outDir --numProcs $numProcs --dpit $dpit --numProcsText $numProcsText --numProcsUnorg $numProcsUnorg --numProcsDepth $numProcsDepth
