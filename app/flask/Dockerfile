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
    && rm -rf /var/lib/apt/lists/*

# Create app directory
ADD . /v1app

# Set the default directory for our environment
ENV HOME /v1app
WORKDIR /v1app

# clone our main project repo
RUN git clone https://github.com/stevenmahana/zeromq-client.git /tmp/zeromq-client/
RUN cp -R /tmp/zeromq-client/* /v1app

RUN chmod -R 777 /v1app/logs/

# Add requirements.txt
ADD requirements.txt /v1app

# Add uwsgi.ini
ADD uwsgi.ini /v1app

# Install uwsgi Python web server
RUN python3.4 -m pip install uwsgi
# Install app requirements
RUN python3.4 -m pip install -r requirements.txt

# supervisord.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port 8080 for uwsgi
EXPOSE 8080

# run supervisor
CMD ["/usr/bin/supervisord"]

# use this in the absence of supervisor
#ENTRYPOINT ["uwsgi", "--ini", "uwsgi.ini"]