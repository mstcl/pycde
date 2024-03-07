# Python containerized development environment

A docker image that comes with common packages for science, especially for
machine learning with Nvidia + CUDA.

The base image comes from
[nvidia/cuda:11.8.0-base-ubuntu20.04](https://hub.docker.com/layers/nvidia/cuda/11.8.0-base-ubuntu20.04/images/sha256-25940548e6b26be76a73a25684be543ecb5a2eea72d096c877407f0902ee083b?context=explore).

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

## Running with Jupyter Lab

```sh
$ git pull github.com/mstcl/pycde
$ cd pycde
$ docker compose up -d --build
```

You can change the bind mount inside `docker-compose.yml` to mount your project
folder.

### Docker run

```sh
$ docker build -t pycde
$ docker run -p 127.0.0.1:8888:8888 -v /srv/projects:/projects --restart unless-stopped --security-opt=no-new-privileges --log-opt max-size=1g --gpus 1 pycde
```

## Running as a standalone kernel

### Minimum requirements for the connection host

- ipykernel
- ipython

### Creating a custom ipython kernelspec

```sh
$ python -m ipykernel install --user --name=docker
```

Then edit `~/.local/share/jupyter/kernels/docker/kernel.json` to look something
like (also in [examples/kernel.json](./examples/kernel.json) ):

```json
{
 "argv": [
  "/usr/bin/docker",
  "run",
  "--rm",
  "--network=host",
  "-v",
  "{connection_file}:/connection-spec",
  "-v",
  "/projects:/project",
  "pycde-pycde",
  "python",
  "-m",
  "ipykernel_launcher",
  "-f",
  "/connection-spec"
 ],
 "display_name": "docker",
 "language": "python"
}
```
