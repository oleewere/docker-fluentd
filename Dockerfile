FROM fluent/fluentd-kubernetes-daemonset:v1.3.3-debian-elasticsearch-1.0
MAINTAINER Oliver Szabo <oleewere@gmail.com>

EXPOSE 24284

ENV APPS_TO_INSTALL make gcc g++ libc-dev ruby-dev zlib1g-dev libz-dev git
ENV FLUENTD_PLUGINS_TO_INSTALL fluent-plugin-multiline-parser fluent-plugin-webhdfs fluent-plugin-s3 fluent-plugin-azurestorage fluent-plugin-gcs

RUN apt-get update && apt-get install -y --no-install-recommends $APPS_TO_INSTALL
RUN gem install $FLUENTD_PLUGINS_TO_INSTALL
RUN gem sources --clear-all
RUN apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $APPS_TO_INSTALL && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN rm -rf /home/fluent/.gem/ruby/*/cache/*.gem && rm -rf /var/lib/gems/*/cache/*.gem

WORKDIR  /home/fluent/
