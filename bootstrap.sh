#!/usr/bin/env bash

set -ex

apt update

apt install -y vim git-lfs screen

pushd /workspace/rulm
(pip install -r requirements.txt && echo "Install done") &
popd

pushd /workspace
wget --quiet --show-progress https://github.com/Run-Pod/runpodctl/releases/download/v1.9.0/runpodctl-linux-amd -O runpodctl && chmod +x runpodctl && mv runpodctl /usr/bin/runpodctl
popd

mkdir /workspace/rulm/self_instruct/models

pushd /workspace/rulm/self_instruct/models
git clone https://huggingface.co/AlexeyChe/llama-7b-lora
popd

echo "Checkout model done"

wait