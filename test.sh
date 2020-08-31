#!/bin/bash

set -ueo pipefail

# test notebooks in these directories
IMGS="single-user single-user-d4science"

for img in $IMGS ; do
    for f in $img/tests/*.ipynb; do
        if [ -e "$f" ]; then
            docker run -v $PWD/$img/tests:/tests $DOCKER_REPO/$img \
                jupyter nbconvert --to rst --execute --stdout /tests/$(basename $f)
        else
            true
        fi
    done
done
