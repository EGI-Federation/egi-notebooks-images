#!/bin/bash

FUSE_JAR="/sh-fuse-integration-jar-with-dependencies.jar"
CONTEXT="/d4science.research-infrastructures.eu"

echo "Mounting filesystem at $MNTPATH"

java -jar "$FUSE_JAR" "$D4SCIENCE_TOKEN" "$CONTEXT" "$MNTPATH"
