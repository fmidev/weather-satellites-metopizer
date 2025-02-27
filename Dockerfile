FROM ubuntu:22.04

RUN apt update && \
    apt -y upgrade && \
    apt -y install tar unzip bzip2 libbz2-dev gcc make curl g++ cpp libxml2 libxml2-dev && \
    apt -y clean

RUN cd /tmp && \
    curl -o fec-3.0.1.tar.bz2 http://www.ka9q.net/code/fec/fec-3.0.1.tar.bz2 && \
    tar -xjvf fec-3.0.1.tar.bz2 && \
    cd /tmp/fec-3.0.1 && \
    ./configure && \
    make CFLAGS=-fPIC && \
    make install

RUN cd /tmp && \
    curl -o metopizer_3_57_tar_9b77fef66a.zip https://user.eumetsat.int/s3/eup-strapi-media/metopizer_3_57_tar_9b77fef66a.zip && \
    unzip metopizer_3_57_tar_9b77fef66a.zip && \
    tar -xvf metopizer-3.57.tar && \
    cd /tmp/metopizer-3.57 && \
    ./configure && \
    make CPPFLAGS=-std=c++11 && \
    make install

RUN cd /tmp && \
    rm -rf fec* && \
    rm -rf metopizer*

COPY mphr_configs/ /usr/local/share/mphr_configs/
COPY entrypoint.sh /usr/bin
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
