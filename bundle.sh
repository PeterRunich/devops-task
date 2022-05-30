#!/bin/bash
REPORT_EMAIL=s.khalipa@tandp.ru
UNZIP_DIR=$HOME/src
APP_ROOT_DIR=front-user/front
ARCHIVE_PATH=./Front-User-master.tar.gz

WORK_DIR=$UNZIP_DIR/$APP_ROOT_DIR
DOCKER_TAG_NAME=react-app

pushd .
cd email
docker build -t email-image .
docker run -itd --network host --name email_pod email-image
popd

mkdir -p $UNZIP_DIR
tar -xzf $ARCHIVE_PATH -C $UNZIP_DIR

(
  ({
    cp Dockerfile $WORK_DIR

    pushd .
    cd $WORK_DIR

    yarn install &&\
    yarn build &&\

    docker build -t $DOCKER_TAG_NAME $WORK_DIR &&\
    popd &&\
    docker save -o $DOCKER_TAG_NAME.tar $DOCKER_TAG_NAME &&\

    ansible-playbook deploy.yml --extra-vars "arch_path=$DOCKER_TAG_NAME.tar" &&\
    docker exec -it email_pod bash -c "echo 'Success' | mail -s 'Bundle app' $REPORT_EMAIL"
  } || {
    docker cp $WORK_DIR/error.log email_pod:/
    docker exec -it email_pod bash -c "echo 'Failled' | mail -s 'Bundle app' -A /error.log $REPORT_EMAIL"
  } && {
    popd
    rm $DOCKER_TAG_NAME.tar
    rm -rf $UNZIP_DIR/front-user
    docker rm -f email_pod
    docker rmi $DOCKER_TAG_NAME email-image
  })
2>&1) | tee $WORK_DIR/error.log 
