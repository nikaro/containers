FROM alpine:3.18.2

RUN \
  apk add --no-cache \
    curl=8.1.2-r0 \
    doas=6.8.2-r4 \
    fish=3.6.1-r2 \
    git=2.40.1-r0 \
    helix=23.03-r2 \
    jq=1.6-r3 \
    openssh-client=9.3_p1-r3 \
    tree-sitter-grammars=0.20.8-r0 \
    && \
    :

RUN \
  addgroup -g 1000 vscode && \
  adduser -u 1000 -G vscode -s /usr/bin/fish -D vscode && \
  echo "permit nopass vscode" >> /etc/doas.d/vscode.conf && \
  :

USER vscode
WORKDIR /workspace
