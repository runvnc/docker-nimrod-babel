FROM ubuntu:saucy
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -q -y install gcc && apt-get clean
ADD https://codeload.github.com/Araq/Nimrod/tar.gz/master /opt/master.tgz
RUN cd /opt && tar -zxvf master.tgz
ADD https://codeload.github.com/nimrod-code/csources/tar.gz/master /opt/Nimrod-master/csources.tgz
RUN cd /opt/Nimrod-master && tar -zxvf csources.tgz && \
    cd csources-master && sh build.sh && \
    cd .. && \
    bin/nimrod c koch && \
    ./koch boot -d:release && \
    ln -s /opt/Nimrod-master/bin/nimrod /usr/bin/nimrod
ADD https://codeload.github.com/nimrod-code/babel/tar.gz/master /opt/babel-master.tgz
RUN cd /opt && \
    tar -zxvf babel-master.tgz && \
    cd babel-master && \
    nimrod c -r src/babel install
ENV PATH /.babel/bin:/usr/lib/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
ENTRYPOINT /bin/bash
