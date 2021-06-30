FROM ubuntu:18.04 as builder

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow
ENV CONAN_USER_HOME /home

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
    ninja-build pkg-config git \
    g++-8 gcc-8 gfortran-8 gfortran python3-dev python3-pip python3 \
    ocl-icd-opencl-dev \
    autoconf automake libtool libdrm-dev&& \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install --no-cache-dir conan==1.34.1  cmake==3.18.4 && \
    alias python=python3

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

WORKDIR /app

RUN conan profile new default --detect && \
    conan profile update settings.compiler=gcc default && \
    conan profile update settings.compiler.libcxx=libstdc++11 default && \
    conan profile update settings.compiler.version=8 default && \
    conan profile update env.CXX=g++-8 default && \
    conan profile update env.CC=gcc-8 default

RUN pip3 install mkl opencl_rt

COPY recipes recipes
COPY conan_add.sh conan_add.sh

RUN ./conan_add.sh opencv_mkl       4.5.1           4.5.1 4.5.1

COPY conanfile.txt conanfile.txt
COPY CMakeLists.txt CMakeLists.txt
COPY main.cpp main.cpp

RUN CONAN_LOGGING_LEVEL=debug conan install . --build=missing -s build_type=Release

RUN cmake . -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=gcc-8 -DCMAKE_CXX_COMPILER=g++-8
RUN cmake --build . --parallel

CMD export OMP_NUM_THREADS=1 && \
    export MKL_NUM_THREADS=1 && \
    export OPENCV_OPENCL_DEVICE=:CPU: && \
    ./ocl-test
