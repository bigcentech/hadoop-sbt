FROM openjdk:8u181-slim-stretch
MAINTAINER luis@bigcente.ch

ENV REMOTE_SBT_VERSION=1.2.3
ENV REMOTE_HADOOP_VERSION=2.8.5

RUN apt-get update \
 && apt-get install -yq curl gosu liblzo2-2 \
 && curl -L https://piccolo.link/sbt-$REMOTE_SBT_VERSION.tgz -o /tmp/sbt-$REMOTE_SBT_VERSION.tgz \
 && curl -L https://archive.apache.org/dist/hadoop/common/hadoop-$REMOTE_HADOOP_VERSION/hadoop-$REMOTE_HADOOP_VERSION.tar.gz -o /tmp/hadoop-$REMOTE_HADOOP_VERSION.tar.gz \
 && tar -xzf /tmp/sbt-$REMOTE_SBT_VERSION.tgz -C /usr/local/ \
 && tar -xzf /tmp/hadoop-$REMOTE_HADOOP_VERSION.tar.gz -C /tmp/ \
 && mkdir /native-libs \
 && mv /tmp/hadoop-$REMOTE_HADOOP_VERSION/lib/native/lib* /native-libs/ \
 && apt-get autoclean -y \
 && rm -rf /tmp/*

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/native-libs
ENV PATH $PATH:/usr/local/sbt/bin

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "/bin/bash" ]
