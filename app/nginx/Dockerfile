# Set the base image to Ubuntu
#FROM ubuntu:14.04
FROM dockerimages/ubuntu-core:14.04

# File Author / Maintainer
MAINTAINER Steven Mahana

# Update OS
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade

# Install necessary tools
RUN apt-get install -y nano wget gzip dialog net-tools supervisor geoip-database libgeoip1 software-properties-common

# Install Nginx
# Update to most recent stable version
RUN add-apt-repository ppa:nginx/stable

# Update the repository
RUN apt-get update

# Download and Install Nginx
RUN apt-get install -y nginx
RUN nginx -v

# install geo database
RUN wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
RUN gunzip GeoIP.dat.gz
RUN mv GeoIP.dat /usr/share/GeoIP/GeoIP.dat

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

# Append "daemon off;" to the configuration file
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports
EXPOSE 80

# Set the default command to execute when creating a new container
#CMD service nginx start
CMD ["/usr/bin/supervisord"]
