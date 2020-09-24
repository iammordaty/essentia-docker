FROM ubuntu:18.04

# env's

ENV ESSENTIA_SVM_MODELS_VERSION 2.1_beta5
ENV ESSENTIA_VERSION 4237da97237397caf837dc79020f34af8dfc35b2
ENV GAIA_VERSION 2.4.6

ENV PYTHONPATH /usr/local/lib/python3/dist-packages

ENV LANG C.UTF-8
ENV TERM=xterm

# copy required dirs

COPY ./essentia /essentia

# install common dependencies and utils

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl

# install gaia dependencies

RUN apt-get install -y --no-install-recommends \
    libeigen3-dev \
    libqt4-dev \
    libyaml-dev \
    pkg-config \
    python-dev \
    swig

# compile and install gaia

RUN curl -L# https://github.com/MTG/gaia/archive/v${GAIA_VERSION}.tar.gz | tar xz -C /tmp && \
    (cd /tmp/gaia-${GAIA_VERSION} && \
    ./waf configure --with-python-bindings && \
    ./waf && \
    ./waf install)

# install essentia dependencies

RUN apt-get install -y --no-install-recommends \
    libavcodec-dev \
    libavcodec57 \
    libavformat-dev \
    libavformat57 \
    libavresample-dev \
    libavresample3 \
    libavutil55 \
    libchromaprint-dev \
    libfftw3-3 \
    libfftw3-dev \
    libsamplerate0 \
    libsamplerate0-dev \
    libtag1-dev \
    libtag1v5 \
    libyaml-0-2 \
    libyaml-dev \
    python3-dev \
    python3-numpy \
    python3-six \
    python3-yaml

RUN (cd /usr/include && \
    ln -sf eigen3/Eigen Eigen && \
    ln -sf eigen3/unsupported unsupported)

# compile and install essentia

RUN curl -L# https://github.com/MTG/essentia/archive/${ESSENTIA_VERSION}.tar.gz | tar xz -C /tmp && \
    (cd /tmp/essentia-${ESSENTIA_VERSION} && \
    ./waf configure --mode=release --with-gaia --with-example=streaming_extractor_music && \
    ./waf && \
    cp ./build/src/examples/essentia_streaming_extractor_music /usr/local/bin && \
    cp ./build/src/libessentia.so /usr/local/lib)

RUN ldconfig /usr/local/lib

# download svm models

RUN curl -L# https://essentia.upf.edu/svm_models/essentia-extractor-svm_models-v${ESSENTIA_SVM_MODELS_VERSION}.tar.gz | tar xz -C /tmp && \
    mv /tmp/essentia-extractor-svm_models-v${ESSENTIA_SVM_MODELS_VERSION}/* /essentia/svm_models/

# clean up

RUN apt-get autoremove && \
    apt-get clean && \
    rm -rf /tmp/*

# setup workdir

WORKDIR /essentia
