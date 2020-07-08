#!/usr/bin/env bash

#  rename_output.sh
#  KA
#  2020-0708

PARENT_DIR=$(dirname `pwd` | xargs basename)

echo "The parent directory is ${PARENT_DIR}"

find . -name '*' -type f -print0 | parallel -0 --keep-order echo "mv {/} ${PARENT_DIR}_{/}"
find . -name '*' -type f -print0 | parallel -0 --keep-order mv {/} ${PARENT_DIR}_{/}
parallel --keep-order 'echo -e "{1/}\t{2/}_{1/}"' ::: `find . -name '*' -type f` ::: `echo ${PARENT_DIR}` > `echo "${PARENT_DIR}_rename.txt"`
