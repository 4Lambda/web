FROM centos:7
MAINTAINER Russell Bunch <wm@4lambda.io>

EXPOSE 80

RUN yum -y makecache all \
    && yum -y install epel-release \
    && yum -y install \
        gcc \
        python-pip \
        python-devel \
    && yum clean all

ADD . /var/4l/www
WORKDIR /var/4l/www
RUN pip install -r requirements.txt

ENTRYPOINT ["python"]
CMD ["app.py"]
