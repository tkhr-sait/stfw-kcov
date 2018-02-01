# scenario-test-framework
#---------------------------------------------------------------------
FROM debian:stretch
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV TZ=Asia/Tokyo

RUN apt update
RUN apt install -y curl python python-pip
RUN apt install -y libyaml-dev python-dev
RUN pip install pyaml
RUN pip install docopt

RUN apt install -y openjdk-8-jdk 

# based https://github.com/Ragnaroek/kcov_docker/blob/master/Dockerfile
# kcov build & install
RUN apt install -y binutils-dev libcurl4-openssl-dev \
                   zlib1g-dev libdw-dev libiberty-dev \
                   g++ pkg-config git cmake
# unstable
ENV SRC_DIR=/home/kcov-src \
    URL_GIT_KCOV=https://github.com/SimonKagstrom/kcov.git
RUN git clone $URL_GIT_KCOV $SRC_DIR; \
    cd $SRC_DIR;

RUN cd $SRC_DIR && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

RUN adduser stfwuser
USER stfwuser

ENTRYPOINT ["kcov"]
CMD ["--help"]
