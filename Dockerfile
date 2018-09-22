FROM            registry.gitlab.com/rustydb/docker/python
MAINTAINER      Russell Bunch <rusty@4lambda.io>

# Install system packages.
RUN             yum install -y \
                    pcre-devel \
                    nginx \
                    supervisor \
                && yum clean -q all

# Add system configuration and run files.
ADD             nginx.conf /etc/nginx
ADD             supervisord.conf /etc/
VOLUME          /var/log/nginx

# Setup the virtual env directory.
RUN             pip install virtualenv && virtualenv -p python36 /env
ENV             VIRTUAL_ENV=/env PATH=/env/bin:$PATH

# Add the web app, install it, and then compile assets.
COPY            --chown=nginx:nginx . /app
WORKDIR         /app
RUN             python setup.py install \
                && pip install .[server]
RUN             for file in assets/scss/*; do \
                    python3 -mscss "$file" > "static/css/$(basename ${file/\.scss/.css})"; \
                done

# Done; expose and run the app but allow circumvention of launch for poking around.
EXPOSE          8080
USER            nginx
ENTRYPOINT      '/usr/bin/supervisord'
