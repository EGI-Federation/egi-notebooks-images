#!/bin/bash

FUSE_JAR="/sh-fuse-integration-jar-with-dependencies.jar"

echo "Mounting filesystem at $MNTPATH"

cd /tmp || exit

java -jar "$FUSE_JAR" "$D4SCIENCE_TOKEN" "$MNTPATH"
