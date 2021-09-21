#!/usr/bin/env bash

set -e

# add atlassian ssh key
mkdir /root/.ssh
cp /opt/atlassian/pipelines/agent/ssh/..data/id_rsa_tmp /root/.ssh/id_rsa
chmod 400 /root/.ssh/id_rsa
cp /opt/atlassian/pipelines/agent/ssh/..data/known_hosts /root/.ssh/known_hosts

USER=${USER:?'USER environment variable missing.'}
HOST=${HOST:?'HOST environment variable missing.'}
PORT=${PORT:="21"}
PROJECT=${PROJECT:?'PROJECT environment variable missing.'}
TEST=${TEST:="false"}
STAGING=${STAGING:="false"}
DEPLOY=${DEPLOY:="false"}
MODIFIER=${MODIFIER:=""}
BRANCH=${BRANCH:="devel"}

if [ $TEST != "false" ]; then
    ssh $USER@$HOST -p $PORT "/home/riesenia/bin/deploy-test-project $PROJECT $BRANCH"
fi

if [ $STAGING != "false" ]; then
    ssh $USER@$HOST -p $PORT "/home/riesenia/bin/staging $PROJECT $MODIFIER"
fi

if [ $DEPLOY != "false" ]; then
    ssh $USER@$HOST -p $PORT "/home/riesenia/bin/deploy $PROJECT"
fi