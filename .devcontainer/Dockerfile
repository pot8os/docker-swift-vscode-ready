FROM node:16 AS node_base
FROM swift:5.4.3
COPY --from=node_base . .

USER root

# Build sourcekit-lsp extension
RUN apt update && apt install -y npm && \
  git clone https://github.com/apple/sourcekit-lsp.git /root/sourcekit-lsp && \
  cd /root/sourcekit-lsp/Editors/vscode && \
  npm install && \
  npm run dev-package

# Install sourcekit-lsp extension. Although it requires `code` it's not available until logging in. 
RUN echo "code --install-extension /root/sourcekit-lsp/Editors/vscode/sourcekit-lsp-development.vsix" >> /root/.bashrc

# Build SwiftFormat and copy to /usr/local/bin where VSCode plugin expects as default
RUN git clone https://github.com/nicklockwood/SwiftFormat /root/SwiftFormat && \
  cd /root/SwiftFormat && \
  swift build -c release && \
  cp .build/release/swiftformat /usr/local/bin/
