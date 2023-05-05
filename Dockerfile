FROM alpine:3.11

RUN apk --no-cache add openssh-client rsync lsyncd gettext libintl

ARG UID=1001
ARG GID=1001
RUN addgroup -S -g $GID lsyncd
RUN adduser -S -h /home/lsyncd -s /bin/sh -u $UID -G lsyncd lsyncd
RUN echo 'StrictHostKeyChecking=no' >> /etc/ssh/ssh_config

RUN mkdir /home/lsyncd/data
RUN mkdir /root/.ssh

VOLUME ["/home/lsyncd/data"]

ENTRYPOINT ["/usr/bin/lsyncd"]
CMD ["-nodaemon","/etc/lsyncd/lsyncd.lua"]