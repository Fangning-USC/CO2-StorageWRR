#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=300:00:00
#SBATCH --account=jafarpou_227 
#SBATCH --partition=jafarpour 

module purge
module load gcc/8.3.0
module load python

python main_opt_3var_avg_det.py