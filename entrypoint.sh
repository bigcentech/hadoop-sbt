#!/bin/bash

USER_ID=${USER_ID:-9001}
GROUP_ID=${GROUP_ID:-9001}

getent group $GROUP_10 2>&1 > /dev/null || groupadd -g ${GROUP_ID:-9001} sbt
useradd --shell /bin/bash -u ${USER_ID:-9001} -o -c "sbt user" -m sbt
export HOME=/home/sbt

exec gosu sbt "$@"
