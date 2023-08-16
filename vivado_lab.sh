#!/bin/bash
IMAGE_NAME="vivado_lab"
IMAGE_VERSION="2023.1"

WORK_PATH=$(cd $(dirname $0); pwd)

if [[ "$1" == "clean" ]]; then
  ${WORK_PATH}/tools/gdocker/gdocker.sh clean -n ${IMAGE_NAME} -v ${IMAGE_VERSION}
  sudo rm -rf ${WORK_PATH}/.tmp
  exit 0
fi

if [[ "$(sudo docker images -q "${IMAGE_NAME}:${IMAGE_VERSION}" 2> /dev/null)" == "" ]]; then
  ${WORK_PATH}/tools/gdocker/gdocker.sh install -n ${IMAGE_NAME} -v ${IMAGE_VERSION} -t ${WORK_PATH}/tools/tools.sh
fi

if [[ "$1" == "" ]]; then
  PROJECT=${WORK_PATH}/projects
else
  PROJECT=$1
fi

${WORK_PATH}/tools/gdocker/gdocker.sh start -n ${IMAGE_NAME} -v ${IMAGE_VERSION} -c "/bin/bash /home/${IMAGE_NAME}/workspace/sessions.sh" -p $PROJECT
