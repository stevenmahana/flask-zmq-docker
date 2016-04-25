FROM dockerimages/ubuntu-core:14.04

# File Author / Maintainer
MAINTAINER Steven Mahana

# Update OS
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list

# Install Software
RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    python3.4 \
    python3.4-dev \
    python3-setuptools \
    python3-pip \
    build-essential \
    python-software-properties \
    git \
    curl \
    clean \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
ADD . /v1app

# Set the default directory for our environment
ENV HOME /v1app
WORKDIR /v1app

# clone our main project repo
RUN git clone https://github.com/stevenmahana/models-test.git /tmp/models-test/
RUN cp -R /tmp/models-test/* /v1app

# Install zeromq
RUN python3.4 -m pip install pyzmq --install-option="--zmq=bundled"

# Add requirements.txt
ADD requirements.txt /v1app

# Install app requirements
RUN python3.4 -m pip install -r requirements.txt

# Expose port
EXPOSE 5570

# run supervisor
CMD ["python3.4","server.py"]