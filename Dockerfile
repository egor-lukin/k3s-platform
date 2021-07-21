FROM hashicorp/terraform:0.13.0

RUN apk add --no-cache \
    curl=~7 \
    bash=~5 \
    openssh=~8 \
    git=~2 \
    curl=~7 \
    openssl=~1

RUN curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.18.3/bin/linux/amd64/kubectl && \
  chmod +x /usr/bin/kubectl && \
  kubectl version --client

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh

ARG SOPS_VERSION=3.5.0
RUN curl -qsL https://github.com/mozilla/sops/releases/download/v$SOPS_VERSION/sops-v$SOPS_VERSION.linux -o /usr/bin/sops && \
    chmod +x /usr/bin/sops

RUN helm plugin install https://github.com/zendesk/helm-secrets

ARG HELMFILE_VERSION=0.130.0
RUN curl -qsL https://github.com/roboll/helmfile/releases/download/v$HELMFILE_VERSION/helmfile_linux_amd64 -o /usr/bin/helmfile && \
    chmod +x /usr/bin/helmfile

RUN curl -sLS https://get.k3sup.dev | sh

RUN helm plugin install https://github.com/databus23/helm-diff

WORKDIR /terraform

COPY . .

ENTRYPOINT ["/bin/bash", "-c"]
