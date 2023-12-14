FROM azul/zulu-openjdk:11

LABEL maintainer="opslead"
LABEL repository="https://github.com/opslead/docker-metabase"

ARG METABASE_VERSION

WORKDIR /opt/metabase

ENV METABASE_USER="metabase" \
    METABASE_UID="8983" \
    METABASE_GROUP="metabase" \
    METABASE_GID="8983" \
    MB_JETTY_PORT="8080"

COPY entrypoint /opt/metabase

RUN groupadd -r --gid "$METABASE_GID" "$METABASE_GROUP"
RUN useradd -r --uid "$METABASE_UID" --gid "$METABASE_GID" "$METABASE_USER"

RUN apt-get update && \
    apt-get -y install curl && \
    curl -f -L https://downloads.metabase.com/v$METABASE_VERSION/metabase.jar --output /opt/metabase/app.jar && \
    chown $METABASE_USER:$METABASE_GROUP -R /opt/metabase && \
    chmod +x /opt/metabase/entrypoint && \
    apt-get clean

USER $METABASE_USER

ENTRYPOINT ["/opt/metabase/entrypoint"]