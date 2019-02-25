FROM debian
MAINTAINER Santiago Velasco <docker@sanxiago.com>


RUN export RUNLEVEL=1
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; exit 0
RUN apt-get update
RUN apt-get install -y  asterisk asterisk-mysql sudo
RUN apt-get install -y coreutils procps
RUN apt-get install -y iaxmodem hylafax-server

RUN touch /etc/hylafax/config

RUN echo '#!/bin/bash\n\
/etc/init.d/iaxmodem start;\n\
/etc/init.d/hylafax start;\n\
/usr/sbin/safe_asterisk -U asterisk;\n\
while true; do sleep 86400;done' > /tmp/run.sh

RUN chmod +x /tmp/run.sh

ENTRYPOINT ["/tmp/run.sh"]
