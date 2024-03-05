# Python containerized development environment

A docker image that comes with common packages for science, especially for
machine learning with Nvidia + CUDA.

## Base container

This image was built from [nvidia/cuda:11.8.0-base-ubuntu20.04](https://hub.docker.com/layers/nvidia/cuda/11.8.0-base-ubuntu20.04/images/sha256-25940548e6b26be76a73a25684be543ecb5a2eea72d096c877407f0902ee083b?context=explore).

## Packages

- tensorflow
- keras
- numpy
- matplotlib
- h5py
- cmcrameri
- scipy
- seaborn
- pyyaml
- tqdm
- ipython
- ipykernel
- jupyterlab


## Requirements

- docker
- docker-compose (optional)
- nvidia-container-toolkit configured for docker

```sh
$ nvidia-ctk runtime configure --runtime=docker
$ sudo systemctl restart docker
```

## Installation

```sh
$ git pull github.com/mstcl/pycde
$ cd pycde
$ docker compose up -d
```

You can change the bind mount inside `docker-compose.yml` to mount your project
folder.

### Docker run

```sh
$ docker build -t pycde
$ docker run -p 127.0.0.1:8888:8888 -v /srv/projects:/projects --restart unless-stopped --security-opt=no-new-privileges --log-opt max-size=1g --gpus 1 pycde
```

## Usage

Go to [http://localhost:8888](http://localhost:8888) to access Jupyter Lab. There are
no login tokens. To access remotely, use SSH tunnelling.
