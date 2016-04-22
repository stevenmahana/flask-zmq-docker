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
    apt-get install -y libssl-dev libxslt-dev libxml2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk && \
    apt-get -y install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev python3-lxml && \
    apt-get -y install supervisor wget

# Create app directory
ADD . /v1app

# Set the default directory for our environment
ENV HOME /v1app
WORKDIR /v1app

# clone our main project repo
RUN git clone https://github.com/stevenmahana/events-test.git /tmp/events-test/
RUN cp -R /tmp/events-test/* /v1app

# Add requirements.txt
ADD requirements.txt /v1app

# Add uwsgi.ini
#ADD uwsgi.ini /v1app

# Install uwsgi Python web server
#RUN python3.4 -m pip install uwsgi

RUN python3.4 -m pip install pyzmq --install-option="--zmq=bundled"

# Install app requirements
RUN python3.4 -m pip install -r requirements.txt

#RUN mkdir -p libzmq
#RUN git clone https://github.com/zeromq/libzmq.git /tmp/libzmq/
#RUN cp -R /tmp/libzmq/* /v1app/libzmq
#RUN cd libzmq && ./autogen.sh && ./configure && make -j 4
#RUN cd libzmq && make check && make install && sudo ldconfig

# supervisord.conf
#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#COPY server.py /tmp/server.py

# Expose port
EXPOSE 5556

# run supervisor
CMD ["python3.4","server.py"]
#ENTRYPOINT ["uwsgi", "--ini", "uwsgi.ini"]