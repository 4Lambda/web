# CentOS Based Website Image.
FROM centos:7
MAINTAINER 4Lambda Developers <d@4lambda.io>

# HTTP.
EXPOSE 80

# Setup YUM and install needed system packages.
RUN yum -y makecache all \
    && yum -y install \
        epel-release \
    && yum -y install \
        gcc \
        python-pip \
        python-devel \
        pcre-devel \
    && yum clean all

# Localize the web files and install Python requirements.
ADD . /var/4l/www
WORKDIR /var/4l/www
RUN pip install -r requirements.txt

# Start the secure gateway.
ENTRYPOINT ["uwsgi"]
CMD ["app.ini"]
