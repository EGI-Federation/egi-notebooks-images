#!/bin/bash

FUSE_JAR="/sh-fuse-integration-1.0.0-20190312.161452-1-jar-with-dependencies.jar"
CONTEXT="/d4science.research-infrastructures.eu"

echo "Mounting filesystem at $MNTPATH"

java -jar $FUSE_JAR $GCUBE_TOKEN $CONTEXT $MNTPATH
