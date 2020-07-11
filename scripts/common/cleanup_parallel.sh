#!/bin/bash
##########
#The MIT License (MIT)
#
# Copyright (c) 2015 Aiden Lab
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
##########
# Script to clean up big repetitive files and zip fastqs. Run after you are 
# sure the pipeline ran successfully.  Run from top directory (HIC001 e.g.).
# Juicer version 1.6

cat <<< 'echo "Remove aligned/merged_sort.txt." && rm aligned/merged_sort.txt
echo "Remove splits." && rm -r splits
echo "Zip up aligned/merged_nodups.txt." && gzip aligned/merged_nodups.txt
echo "Zip up aligned/dups.txt." && gzip aligned/dups.txt
echo "Zip up aligned/opt_dups.txt." && gzip aligned/opt_dups.txt
echo "Zip up aligned/abnormal.txt." && gzip aligned/abnormal.sam
echo "Zip up aligned/collisions.txt." && gzip aligned/collisions.txt
echo "Zip up aligned/collisions_dups.txt." && gzip aligned/collisions_dups.txt
echo "Zip up aligned/collisions_nodups.txt." && gzip aligned/collisions_nodups.txt
echo "Zip up aligned/unmapped.txt." && gzip aligned/unmapped.sam' > commands.txt

total=`ls -l aligned/merged_sort.txt | awk '{print $5}'`
total2=`ls -l aligned/merged_nodups.txt aligned/dups.txt aligned/opt_dups.txt | awk '{sum = sum + $5}END{print sum}'`

if [ $total -eq $total2 ]; then
    parallel -k --jobs 2 < commands.txt
    testname=$(ls -l fastq | awk 'NR==1{print $9}')
    if [ "${testname: -5}" == ".fastq" ]; then
        echo "Zip up .fastq files."
        parallel -k --jobs 2 'gzip {}' ::: `find -L . -name '*.fastq' -type f`
    fi
else 
    echo "Problem: The sum of merged_nodups.txt, dups.txt, and opt_dups.txt is not the same size as merged_sort.txt."
    echo "Stopped clean-up. You need to look into this.";
fi

rm commands.txt
