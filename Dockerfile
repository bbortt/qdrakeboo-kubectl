FROM alpine:3.13
LABEL maintainer="Timon Borter <bbortt.github.io>"

ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/bbortt/qdrakeboo-kubectl" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile"

CMD ["kubectl", "help"]

ENV KUBECTL_VERSION="v1.20.6"

ENV KUBE_SCORE_VERSION="v1.11.0"
ENV VAULT_SYNC_PLUGIN_VERSION="0.2.4"
ENV GIT_SECRETS_VERSION="1.3.0"

COPY --from=zegl/kube-score:v1.2.1 /kube-score /usr/local/bin/kube-score

RUN \
    mkdir /home/deployer && \
    adduser -S -h /home/deployer deployer && \
    apk update && \
    apk add --update bash ca-certificates git gettext && \
    apk add --update -t deps make curl && \
    curl -fsSL https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

RUN \
    curl -fsSLO https://github.com/postfinance/kubectl-vault_sync/releases/download/v${VAULT_SYNC_PLUGIN_VERSION}/kubectl-vault-sync_linux_x86_64-${VAULT_SYNC_PLUGIN_VERSION}.zip && \
    unzip kubectl-vault-sync_linux_x86_64-${VAULT_SYNC_PLUGIN_VERSION}.zip && \
    mv kubectl-vault_sync /usr/local/bin/kubectl-vault_sync && \
    chmod +x /usr/local/bin/kubectl-vault_sync && \
    rm kubectl-vault-sync_linux_x86_64-${VAULT_SYNC_PLUGIN_VERSION}.zip *.md

RUN \
    curl -fsSLO https://github.com/awslabs/git-secrets/archive/${GIT_SECRETS_VERSION}.zip && \
    unzip ${GIT_SECRETS_VERSION}.zip && \
    cd git-secrets-${GIT_SECRETS_VERSION} && \
    make install && \
    cd ..

RUN \
  	apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli && \
    apk del --purge deps && \
    rm -rf /var/cache/apk/*

RUN \
    kubectl version --client && \
    kubectl plugin list && \
    kube-score version && \
	secrethub --version

USER deployer
WORKDIR /home/deployer
