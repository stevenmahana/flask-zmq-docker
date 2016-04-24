#FROM ubuntu:14.04
#FROM dockerimages/ubuntu-core:14.04
FROM gliderlabs/alpine

# File Author / Maintainer
MAINTAINER Steven Mahana

# Update OS
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade

# Install Software
RUN apt-get install -y python3.4 python3.4-dev python3-setuptools python3-pip git curl zlib1g-dev && \
    apt-get install -y uwsgi-plugin-python3 python-software-properties python-mysqldb libpcre3 libpcre3-dev && \
    apt-get install -y libssl-dev libxslt-dev libxml2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk wget  && \
    apt-get install -y libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev python3-lxml build-essential

# Create app directory
ADD . /v1app

# Set the default directory for our environment
ENV HOME /v1app
WORKDIR /v1app

# clone our main project repo
RUN git clone https://github.com/stevenmahana/messaging-test.git /tmp/messaging-test/
RUN cp -R /tmp/messaging-test/* /v1app

# Install zeromq
RUN python3.4 -m pip install pyzmq --install-option="--zmq=bundled"

# Add requirements.txt
ADD requirements.txt /v1app

# Install app requirements
RUN python3.4 -m pip install -r requirements.txt

## Clean up
RUN apt-get remove -y python3-pip curl git wget
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

# Expose port
EXPOSE 5557

# run supervisor
CMD ["python3.4","server.py"]