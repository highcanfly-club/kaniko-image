FROM gcr.io/kaniko-project/executor:latest as ImgSrc

FROM debian:latest
LABEL maintainer="ronan@highcanfly.club"
RUN apt update && apt install -y ca-certificates
RUN mkdir -p /kaniko && chmod 777 /kaniko &&  mkdir -p /cache && chmod 777 /cache
COPY --from=ImgSrc /kaniko /kaniko
ENV HOME /root
ENV USER root
ENV PATH /bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/kaniko
ENV SSL_CERT_DIR=/kaniko/ssl/certs
ENV DOCKER_CONFIG /kaniko/.docker/
ENV DOCKER_CREDENTIAL_GCR_CONFIG /kaniko/.config/gcloud/docker_credential_gcr_config.json
WORKDIR /workspace

ENTRYPOINT ["/kaniko/executor"]