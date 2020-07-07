#!/usr/bin/env bash

# KA

#  LSF submission parameters:
#BSUB -W 8:00
#BSUB -n 1
#BSUB -M 8000
#BSUB -R "span[hosts=1]"
#BSUB -e bwa_index_fa.sh.%J.err
#BSUB -o bwa_index_fa.sh.%J.out

#  Variables
SCRIPT_NAME=bwa_index_fa.sh
LOG=${SCRIPT_NAME/.sh/.log}
FILE=`find . -name *.fa -o -name *.fasta`

#  Load CCHMC LSF modules
module load bwa/0.7.17

#  Record the experiment info
printf "${SCRIPT_NAME} run by `whoami` on `date` in\n`pwd`\n\n" >> ${LOG} 2>&1
printf "`bwa`\n\n" >> ${LOG} 2>&1

#  Index database sequences in FASTA format
bwa index -p mm10 -a bwtsw ${FILE}
