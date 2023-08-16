#!/bin/bash
IMAGE_NAME="vivado_lab"
IMAGE_VERSION="2023.1"

WORK_PATH=$(cd $(dirname $0); pwd)
echo "WORK_PATH: ${WORK_PATH}"

export PROJECTS_PATH=/home/${MY_NAME}/projects

session=${MY_NAME}

tmux has-session -t $session >/dev/null 2>&1
if [ $? = 0 ];then
    tmux attach-session -t $session
    exit
fi

tmux new-session -d -s $session -n $session
tmux split-window -t $session:0 -h

tmux send-keys -t $session:0.0 'cd ${PROJECTS_PATH};vivado_lab' C-m
tmux send-keys -t $session:0.1 'cd ${PROJECTS_PATH};' C-m

tmux select-pane -t $session:0.1
tmux attach-session -t $session
