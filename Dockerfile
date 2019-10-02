FROM alpine:3.10
LABEL maintainer="Timon Borter <bbortt.github.io>"

ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/bbortt/qdrakeboo-kubectl" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile"

CMD ["kubectl", "help"]

ENV KUBECTL_VERSION="v1.16.0"

RUN \
    mkdir /home/deployer && \
    adduser -S -h /home/deployer deployer && \
    apk add --update bash ca-certificates && \
    apk add --update -t deps curl && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    apk del --purge deps && \
    rm /var/cache/apk/*

COPY --from=zegl/kube-score:v1.2.1 /kube-score /usr/local/bin/kube-score

RUN \
    kubectl version --client && \
    kube-score version

USER deployer
WORKDIR /home/deployer
