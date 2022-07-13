FROM            ghcr.io/4lambda/python:3.8 AS base

# Install system packages.
RUN             yum install -y \
                    pcre-devel-8.42-6.el8 \
                    nginx-1:1.14.1-9.module_el8.0.0+1060+3ab382d3 \
                    supervisor-4.2.2-1.el8 \
                && yum clean -q all

FROM base as app-base
# Add system configuration and run files.
COPY            nginx.conf /etc/nginx/
COPY            supervisord.conf /etc/
VOLUME          /var/log/nginx

# Setup the virtual env directory.
# NOTE: Need to callout python3.8 because supervisor installs python36 which overwrites the python3 symlink
RUN             python3.8 -m virtualenv /env
ENV             VIRTUAL_ENV=/env PATH=/env/bin:$PATH

# Add the web app, install it, and then compile assets.
COPY            --chown=nginx:nginx . /app
WORKDIR         /app
RUN             python3 setup.py install && \
                python3 -m pip --no-cache-dir install .[server] && \
                for file in assets/scss/*; do \
                    python3 -mscss "$file" > "static/css/$(basename ${file/\.scss/.css})"; \
                done

# Done; expose and run the app but allow circumvention of launch for poking around.
EXPOSE          8080
USER            nginx
ENTRYPOINT      '/usr/bin/supervisord'
