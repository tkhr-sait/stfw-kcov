# scenario-test-framework
#---------------------------------------------------------------------
FROM debian:stretch

RUN apt update
RUN apt install -y curl python python-pip openjdk-8-jdk 
RUN apt install -y libyaml-dev python-dev
RUN pip install pyaml docopt

# based https://github.com/Ragnaroek/kcov_docker/blob/master/Dockerfile
# kcov build & install
RUN apt install -y binutils-dev libcurl4-openssl-dev \
                   zlib1g-dev libdw-dev libiberty-dev \
                   g++ pkg-config git cmake

# unstable latest version
ENV SRC_DIR=/home/kcov-src \
    URL_GIT_KCOV=https://github.com/SimonKagstrom/kcov.git
RUN git clone $URL_GIT_KCOV $SRC_DIR; \
    cd $SRC_DIR;

RUN cd $SRC_DIR && \
    mkdir build && \
    cd build    && \
    cmake ..    && \
    make        && \
    make install

# shunit2
RUN git clone https://github.com/kward/shunit2.git

ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo

RUN adduser stfwuser
USER stfwuser

ENTRYPOINT ["kcov"]
CMD ["--help"]
