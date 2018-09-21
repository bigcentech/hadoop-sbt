#!/bin/bash

USRID=${USER_ID:-9001}
GRPID=${GROUP_ID:-9001}

getent group ${GRPID} 2>&1 > /dev/null || groupadd -g ${GRPID} sbt
useradd --shell /bin/bash -u ${USRID} -g ${GRPID} -o -c "sbt user" -m sbt
export HOME=/home/sbt

chown -R ${USRID}:${GRPID} $HOME

exec gosu sbt "$@"
