FROM openresty/openresty:jammy
RUN \
    apt-get update && \
    apt-get install && nano &&\
    apt install git-all 
