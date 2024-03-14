# Python containerized development environment

A docker image that comes with common packages for science, especially for
machine learning with Nvidia + CUDA.

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

## Running as a standalone kernel (to use with your own editor)

### Minimum requirements for the connecting host

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
    "--gpus",
    "all",
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

In VSCode, Jupyter Lab, or whatever, you can select the "docker" kernel
instead.
