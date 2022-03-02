FROM alpine:latest
RUN adduser kustomize -D \
  && apk add curl git openssh \
  && git config --global url.ssh://git@github.com/.insteadOf https://github.com/
RUN  curl -L --output /tmp/kustomize_v4.5.2_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.5.2/kustomize_v4.5.2_linux_amd64.tar.gz \
  && echo "c4215332da8da16ddeb88e218d8dceb76c85b366a5c58d012bc5ece904bf2fd0  /tmp/kustomize_v4.5.2_linux_amd64.tar.gz" | sha256sum -c \
  && tar -xvzf /tmp/kustomize_v4.5.2_linux_amd64.tar.gz -C /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize \
  && mkdir ~/.ssh \
  && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
USER kustomize
WORKDIR /src
