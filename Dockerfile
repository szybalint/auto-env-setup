FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y && apt install sudo -y
RUN useradd -s /bin/bash -m -G sudo nonroot
RUN passwd -d nonroot
USER nonroot
COPY ./* /workdir/
ENTRYPOINT bash