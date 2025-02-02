FROM nvcr.io/nvidia/pytorch:20.06-py3

RUN apt-get update && \
        apt-get install -y \
        wget \
        zlib1g-dev \
        libssl-dev \
        curl\
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        yasm \
        pkg-config \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libavformat-dev \
        libpq-dev \
        libgl1-mesa-glx \
        vim

RUN ln -s /opt/conda/bin/pip /opt/conda/bin/pip3 && conda install -c conda-forge opencv -y
RUN pip3 install --upgrade pip && \
        pip3 install --no-cache-dir \
        torchvision\
        numpy \
        opencv-python \
        visdom \
        pandas \
        scikit-learn


ENV LANG C.UTF-8
WORKDIR /