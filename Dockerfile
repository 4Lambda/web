# CentOS Based Website Image.
FROM            centos:7
MAINTAINER      4Lambda Developers <d@4lambda.io>

# Add volume for security things.
VOLUME          ["/etc/pki/4l", "/var/log/nginx"]

# Setup gpg keys for yum.
RUN             rpm --import http://mirror.centos.org/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7 && \
                rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7

# Setup YUM and install needed system packages.
RUN             yum -y -q makecache all \
                && yum -y -q install epel-release \
                && yum -y -q install \
                    gcc \
                    python-pip \
                    python-devel \
                    pcre-devel \
                && yum -y -q --nogpgcheck install nginx \
                && yum -q clean all

# Forward request and error logs to Docker log collector.
RUN             ln -sf /dev/stdout /var/log/nginx/access.log \
                && ln -sf /dev/stderr /var/log/nginx/error.log

# Add configuration files to installed packages.
COPY            nginx.conf /etc/nginx/
COPY            uwsgi.ini /etc/uwsgi/
COPY            supervisord.conf /etc/supervisor/conf.d/

# HTTP/S.
EXPOSE          8080

# Localize the web files and install Python requirements.
COPY            app /var/4l/www/
WORKDIR         /var/4l/www
RUN             pip -q install -r requirements.txt
RUN             for file in assets/scss/*; do \
                    python -mscss "$file" > "static/css/$(basename ${file/\.scss/.css})"; \
                done

# Start the secure gateway.
CMD             ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
