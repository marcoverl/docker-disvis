# docker build -t opencl_disvis .

FROM ubuntu_nvidia_opencl

MAINTAINER Mario David <mariojmdavid@gmail.com>

RUN apt-get update && \
    apt-get -y upgrade

RUN apt-get -y install \
      build-essential \
      cmake \
      cython \
      git \
      libffi-dev \
      libfftw3-dev \
      libfftw3-double3 \
      libfftw3-long3 \
      libfftw3-single3 \
      python-dev \
      python-pip

RUN pip install --upgrade pip
RUN pip install mako
RUN pip install numpy
RUN pip install	pyfftw
RUN pip install	pyopencl==2015.1

RUN mkdir -p /tmp/pymods && \
    cd /tmp/pymods && \
    git clone https://github.com/clMathLibraries/clFFT.git && \
    cd /tmp/pymods/clFFT/src && \
    cmake CMakeLists.txt && make install

RUN cd /tmp/pymods && \
    git clone https://github.com/geggo/gpyfft.git && \
    cd gpyfft && \
    python setup.py install

RUN cd /tmp/pymods && \
    git clone https://github.com/haddocking/disvis.git && \
    cd disvis && \
    python setup.py install

