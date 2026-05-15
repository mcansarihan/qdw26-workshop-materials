FROM ubuntu:22.04

LABEL maintainer="Sadman Ahmed Shanto <shanto@usc.edu>"

ENV DEBIAN_FRONTEND=noninteractive


ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gfortran \
    git \
    curl \
    wget \
    libopenblas-dev \
    liblapack-dev \
    libfftw3-dev \
    libhdf5-dev \
    libopenmpi-dev \
    openmpi-bin \
    pkg-config \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir notebook jupyterlab

# Set environment variables to allow OpenMPI to run as root
ENV OMPI_ALLOW_RUN_AS_ROOT=1
ENV OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1


# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}


# Set working directory
WORKDIR /home/${NB_USER}/workspace

# Clone and build Palace
RUN git clone https://github.com/awslabs/palace.git && \
    cd palace && \
    mkdir build && cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
             -DCMAKE_C_COMPILER=mpicc \
             -DCMAKE_CXX_COMPILER=mpicxx \
             -DCMAKE_Fortran_COMPILER=gfortran && \
    make -j$(nproc)


COPY binder/postBuild /tmp/postBuild
RUN chmod +x /tmp/postBuild && /tmp/postBuild && rm /tmp/postBuild

# To check palace executions
RUN mkdir -p /home/${NB_USER}/workspace/example && \
    cp -r palace/examples/cpw/* /home/${NB_USER}/workspace/example/

# Set working directory to the example
WORKDIR /home/${NB_USER}

USER ${NB_USER}
# Set default command to display Palace help
# CMD ["palace", "--help"]