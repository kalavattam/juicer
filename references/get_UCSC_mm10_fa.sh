#!/usr/bin/env bash

# KA

#  LSF submission parameters:
#BSUB -W 4:00
#BSUB -n 1
#BSUB -M 1000
#BSUB -R "span[hosts=1]"
#BSUB -e get_UCSC_mm10_fa.sh.%J.err
#BSUB -o get_UCSC_mm10_fa.sh.%J.out

#  Variables
SCRIPT_NAME=get_UCSC_mm10_fa.sh
LOG=${SCRIPT_NAME/.sh/.log}
FILE=mm10.fa.gz

#  Record the experiment info
printf "${SCRIPT_NAME} run by `whoami` on `date` in\n`pwd`\n\n" >> ${LOG} 2>&1
printf "`wget --version`\n\n" >> ${LOG} 2>&1
printf "`gzip --version`\n\n" >> ${LOG} 2>&1

#  Get the file for Juicer alignment, mm10.fa.gz
wget -nv "http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/"${FILE}

#  Unzip the file for Juicer alignment, mm10.fa.gz
gzip -d ${FILE}
