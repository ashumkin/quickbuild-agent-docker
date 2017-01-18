FROM java:openjdk-8

# maint details
MAINTAINER Alexey Shumkin <alex.crezoff@gmail.com>

# system installations
RUN apt-get update \
    && apt-get install -y wget less vim uuid-runtime \
    && rm -rf /var/lib/apt/lists/*

# set Moscow timezone
RUN ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

# set env vars
# Quickbuild
ENV QUICKBUILD_VERSION=6.1.3
ENV QUICKBUILD_BUILD_ID=2964
ENV QUICKBUILD_AGENT_GZ_FILE=buildagent.tar.gz

# product installations
COPY ${QUICKBUILD_AGENT_GZ_FILE} /
RUN tar -zxf ${QUICKBUILD_AGENT_GZ_FILE} -C /opt \
    && rm ${QUICKBUILD_AGENT_GZ_FILE}

# add config files
ADD *.properties /opt/buildagent/conf/
ADD buildagent-start /

# start Quickbuild build agent
ENTRYPOINT /buildagent-start
