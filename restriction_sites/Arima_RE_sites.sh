#!/usr/bin/env bash

#  KA

#  LSF submission parameters
#BSUB -W 8:00
#BSUB -n 1
#BSUB -M 1000
#BSUB -R "span[hosts=1]"
#BSUB -e Arima_RE_sites.sh.%J.err
#BSUB -o Arima_RE_sites.sh.%J.out

#  Run script in Bash "safe mode"
# set -Eeuxo pipefail

#  Set up variables for experiment name, LOG, directory
SCRIPT_NAME=Arima_RE_sites.sh
WORKDIR="/data/namekawa_hpc/HiC_TBR/code_etc"  # Can change via hard coding
         
#  Load necessary CCHMC LSF module
module load python3/3.7.1  # However, should work with Python 2 too

#  Record the experiment info
printf "${SCRIPT_NAME} run by `whoami` on `date` in\n`pwd`\n\n"
printf "`python --version`"

#  Call the ELA Lab code with appropriate arguments
python ${WORKDIR}"/juicer/misc/generate_site_positions.py" \
Arima \
mm10 \
${WORKDIR}"/juicer/references/mm10.fa"