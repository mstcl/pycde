FROM nvidia/cuda:11.8.0-base-ubuntu22.04

RUN apt-get update && apt-get install -y wget ca-certificates \
    git curl vim python-is-python3 python3-dev python3-pip \
    libfreetype6-dev libpng-dev libhdf5-dev

WORKDIR /

RUN pip3 install --no-cache-dir --upgrade pip

COPY requirements.txt /

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8888

WORKDIR /project

RUN useradd -m jupyter
RUN chown -R jupyter:jupyter /project && chmod 755 /project

USER jupyter

RUN mkdir -p /home/jupyter/.local/share/fonts
ADD --chown=jupyter:jupyter https://github.com/google/fonts/raw/c7fa7c4bbf5fb08ba0464aa672aa3a9deea36c2b/ofl/sourceserif4/SourceSerif4%5Bopsz,wght%5D.ttf /home/jupyter/.local/share/fonts/SourceSerif4.ttf

COPY run_jupyter.sh /
