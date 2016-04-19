#FROM ubuntu:14.04
FROM dockerimages/ubuntu-core:14.04

# File Author / Maintainer
MAINTAINER Steven Mahana

# Update OS
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade

# Install Software
RUN apt-get install -y python3.4 python3.4-dev python3-setuptools python3-pip git curl build-essential zlib1g-dev && \
    apt-get -y install uwsgi-plugin-python3 python-software-properties python-mysqldb libpcre3 libpcre3-dev && \
    apt-get -y install libssl-dev libxslt-dev libxml2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk && \
    apt-get -y install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev python3-lxml && \
    apt-get -y install supervisor wget

# Create app directory
ADD . /v1app

# Set the default directory for our environment
ENV HOME /v1app
WORKDIR /v1app

# clone our main project repo
RUN git clone https://github.com/sceene/test-flask-app.git /tmp/test-flask-app/
RUN cp -R /tmp/test-flask-app/* /v1app

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