#!/usr/bin/env bash

set -ex

python -c "import torch; import sys; sys.exit(0 if torch.cuda.is_available() else 1)" || (echo "CUDA is not found" && exit 1)

MODEL=$1

apt update

apt install -y vim git-lfs screen less

pushd /workspace/rulm
(pip install -r requirements.txt && echo "Install done") &
popd

pushd /workspace
wget --quiet --show-progress https://github.com/Run-Pod/runpodctl/releases/download/v1.9.0/runpodctl-linux-amd -O runpodctl && chmod +x runpodctl && mv runpodctl /usr/bin/runpodctl
popd

mkdir /workspace/rulm/self_instruct/models

pushd /workspace/rulm/self_instruct/models
git clone https://huggingface.co/AlexeyChe/$MODEL
popd

echo "Checkout model done"

wait