#!/usr/bin/env bash

#  rename_output.sh
#  KA
#  2020-0708

PARENT_DIR=$(dirname `pwd` | xargs basename)

echo "The parent directory is ${PARENT_DIR}"

parallel --keep-order 'echo -e "{1/}\t{2/}_{1/}"' ::: `find . -name '*' ! -name '*.sh' -type f` ::: `echo ${PARENT_DIR}` > `echo "${PARENT_DIR}_file_rename.txt"`
find . -name '*' ! -name '*.sh' ! -name '.' -type f -print0 | parallel -0 --keep-order echo "mv {/} ${PARENT_DIR}_{/}"
find . -name '*' ! -name '*.sh' -type f -print0 | parallel -0 --keep-order mv {/} ${PARENT_DIR}_{/}

parallel --keep-order 'echo -e "{1/}\t{2/}_{1/}"' ::: `find . -name '*' ! -name '*.sh' -type d` ::: `echo ${PARENT_DIR}` > `echo "${PARENT_DIR}_dir_rename.txt"`
find . -name '*' ! -name '*.sh' ! -name '.' -type d -print0 | parallel -0 --keep-order echo "mv {/} ${PARENT_DIR}_{/}"
find . -name '*' ! -name '*.sh' -type d -print0 | parallel -0 --keep-order mv {/} ${PARENT_DIR}_{/}
