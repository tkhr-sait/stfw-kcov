# scenario-test-framework
#---------------------------------------------------------------------
FROM ragnaroek/kcov:v33
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV TZ=Asia/Tokyo

RUN apt update
RUN apt install -y curl python python-pip
RUN apt install -y libyaml-dev python-dev

RUN pip install pyaml
RUN pip install docopt

RUN echo deb http://http.debian.net/debian jessie-backports main >> /etc/apt/sources.list 
RUN apt update && apt install -y -t jessie-backports ca-certificates-java openjdk-8-jdk 

RUN adduser stfwuser
USER stfwuser

ENTRYPOINT ["kcov"]
CMD ["--help"]
