FROM node:16 AS node_base
FROM swift:5.4.3
COPY --from=node_base . .

USER root

# Build sourcekit-lsp extension
RUN apt update && apt install -y npm && \
  git clone https://github.com/apple/sourcekit-lsp.git /root/sourcekit-lsp
RUN cd /root/sourcekit-lsp/Editors/vscode && \
  npm install && \
  npm run dev-package

# Install sourcekit-lsp extension. Although it requires `code` it's not available until logging in. 
RUN echo "code --install-extension /root/sourcekit-lsp/Editors/vscode/sourcekit-lsp-development.vsix" >> /root/.bashrc

# Build apple/swift-format and copy to /usr/local/bin where VSCode plugin expects as default
RUN git clone -b swift-5.4-branch --single-branch https://github.com/apple/swift-format.git /root/swift-format
RUN cd /root/swift-format && \
  swift build -c release && \
  cp .build/release/swift-format /usr/local/bin/
