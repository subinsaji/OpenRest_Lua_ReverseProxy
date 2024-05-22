FROM openresty/openresty:jammy
RUN apt-get update
RUN apt-get install nano
RUN apt install git-all
