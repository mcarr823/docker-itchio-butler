FROM debian:bookworm-slim

ARG USER=butler
ARG UID=101
ARG GID=101

RUN addgroup \
    --gid "$GID" \
    "$USER"

RUN adduser \
    --disabled-password \
    --gecos "" \
    --ingroup "$USER" \
    --uid "$UID" \
    "$USER"

# As user root, install the commands we'll need
USER root
RUN apt update
RUN apt install -y git golang-go

# As non-root user, grab latest butler, unzip, and chmod
USER $USER
WORKDIR /home/$USER
RUN git clone --depth 1 --branch v15.21.0 https://github.com/itchio/butler/ src
RUN cd src; go build -o ../butler .; cd ../;
RUN rm -rf src
RUN chmod +x butler

# Create an input directory, which is where files will be uploaded from
RUN mkdir in

#As root again, copy the docker entrypoint script and chmod it
USER root
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
