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
        nginx \
    && yum clean all

# Localize the web files and install Python requirements.
ADD . /var/4l/www
WORKDIR /var/4l/www
RUN pip install -r requirements.txt

# Forward request and error logs to Docker log collector.
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# Add configuration files to installed packages.
RUN echo "deamon off;" >> /etc/nginx/nginx.conf \
    rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/
COPY uwsgi.ini /etc/uwsgi/
COPY supervisord.conf /etc/supervisor/conf.d/

# Start the secure gateway.
ENTRYPOINT ["bash"]
CMD ["supervisord"]
