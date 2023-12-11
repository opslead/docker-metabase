FROM azul/zulu-openjdk:11

LABEL maintainer="opslead"
LABEL repository="https://github.com/opslead/docker-metabase"

WORKDIR /opt/metabase

ENV METABASE_USER="metabase" \
    METABASE_UID="8983" \
    METABASE_GROUP="metabase" \
    METABASE_GID="8983" \
    METABASE_DIST_URL="https://downloads.metabase.com/v0.47.9/metabase.jar" \
    MB_JETTY_PORT="8080"

RUN groupadd -r --gid "$METABASE_GID" "$METABASE_GROUP"
RUN useradd -r --uid "$METABASE_UID" --gid "$METABASE_GID" "$METABASE_USER"

RUN apt-get -y update; \
    apt-get -y install curl; \
    curl -L $METABASE_DIST_URL --output /opt/metabase/app.jar; \
    chown $METABASE_USER:$METABASE_GROUP -R /opt/metabase

COPY entrypoint /opt/metabase
RUN chmod +x /opt/metabase/entrypoint

USER $METABASE_USER

ENTRYPOINT ["/opt/metabase/entrypoint"]