# CentOS Based Website Image.
FROM centos:7
MAINTAINER 4Lambda Developers <d@4lambda.io>

# HTTP.
EXPOSE 80

# Setup gpg keys for yum.
RUN  rpm --import http://mirror.centos.org/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7 && \
     rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7

# Setup YUM and install needed system packages.
RUN yum -y makecache all && \
    yum -y install \
        epel-release && \
    yum -y install \
        gcc \
        python-pip \
        python-devel \
        pcre-devel && \
    yum clean all

# Install gninx with no GPG check.
RUN yum -y --nogpgcheck install \
        nginx && \
    yum clean all

# Localize the web files and install Python requirements.
ADD . /var/4l/www
WORKDIR /var/4l/www
RUN pip install -r app/requirements.txt

# Forward request and error logs to Docker log collector.
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# Add configuration files to installed packages.
COPY nginx.conf /etc/nginx/
COPY uwsgi.ini /etc/uwsgi/
COPY supervisord.conf /etc/supervisor/conf.d/

# Start the secure gateway.
ENTRYPOINT
CMD ["/usr/bin/supervisord"]
