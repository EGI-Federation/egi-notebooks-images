#!/bin/sh

set -euo pipefail

DOCKER_REPO=$1
TAG=$2

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push $DOCKER_REPO/base &
docker push $DOCKER_REPO/base:$TAG &
docker push $DOCKER_REPO/single-user &
docker push $DOCKER_REPO/single-user:$TAG &
docker push $DOCKER_REPO/single-user-d4science &
docker push $DOCKER_REPO/single-user-d4science:$TAG &
docker push $DOCKER_REPO/d4science-storage &
docker push $DOCKER_REPO/d4science-storage:$TAG &

# Output to the screen every 9 minutes to prevent a travis timeout
#see https://stackoverflow.com/questions/39288834/travis-script-deployment-timeout
export PID=$!
while [[ `ps -p $PID | tail -n +2` ]]; do
  echo 'Deploying'
  sleep 540
done
