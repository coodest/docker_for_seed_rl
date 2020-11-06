FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
MAINTAINER Heptagram <350526878@qq.com>

# Install basic dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends tzdata
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        wget \
        vim \
        openssh-server \
        libfreetype6 \
        libgl1-mesa-dev \
        libglu1-mesa \
        libxi6 \
        libxrender1 \
        git \
        libsdl2-dev \
        libsdl2-image-dev \
        libsdl2-ttf-dev \
        libsdl2-gfx-dev \
        libboost-all-dev \
        libdirectfb-dev \
        libst-dev \
        glee-dev \
        mesa-utils \
        xvfb \
        x11vnc \
        libsdl-sge-dev \
        libboost-python-dev \
        python-dev \
        python3-dev \
        tmux \
        curl \
        zip \
        unzip \
        software-properties-common \
        pkg-config \
        g++-4.8 \
        zlib1g-dev \
        lua5.1 \
        liblua5.1-0-dev \
        libffi-dev \
        gettext \
        freeglut3 \
        libosmesa6-dev \
        libjpeg-dev \
        libsm6 \
        libxext6 \
        libxrender-dev \
        graphviz
        
# install ffmpeg
RUN apt-get update ; apt-get install -y git build-essential gcc make yasm autoconf automake cmake libtool checkinstall libmp3lame-dev pkg-config libunwind-dev zlib1g-dev libssl-dev libavcodec-extra-53
RUN wget https://www.ffmpeg.org/releases/ffmpeg-4.0.2.tar.gz
RUN tar -xzf ffmpeg-4.0.2.tar.gz; rm -r ffmpeg-4.0.2.tar.gz
RUN cd ./ffmpeg-4.0.2; ./configure --enable-gpl --enable-libmp3lame --enable-decoder=mjpeg,png --enable-encoder=png --enable-openssl --enable-nonfree
RUN cd ./ffmpeg-4.0.2; make
RUN  cd ./ffmpeg-4.0.2; make install

# Install bazel
RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | \
    tee /etc/apt/sources.list.d/bazel.list && \
    curl https://bazel.build/bazel-release.pub.gpg | \
    apt-key add - && \
    apt-get update && apt-get install -y bazel

# Set locale
ENV LANG C.UTF-8 LC_ALL=C.UTF-8
ENV SHELL /bin/bash

ENTRYPOINT ["/bin/bash", "-c", "/root/docker-runner-startup"]

# Initialize workspace
RUN mkdir /workspace
WORKDIR /workspace
