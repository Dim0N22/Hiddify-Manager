FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y dialog apt-utils curl sudo systemd python2 xxd lsof
ENV TERM xterm
ENV TZ Etc/UTC
ENV DEBIAN_FRONTEND noninteractive


WORKDIR /opt/hiddify-config/
COPY . .
# RUN mkdir -p ~/.ssh && echo "StrictHostKeyChecking no " > ~/.ssh/config
RUN bash -c "install.sh install-docker"
RUN curl -L https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py -o /usr/bin/systemctl
ENTRYPOINT ["bash apply_configs.sh && tail -f /opt/hiddify-config/log/system/*"]