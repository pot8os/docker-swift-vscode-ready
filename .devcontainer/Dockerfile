FROM swift:5.3.3
USER root

# Build sourcekit-lsp extension
RUN apt update && apt install -y npm && \
  git clone https://github.com/apple/sourcekit-lsp.git /root/sourcekit-lsp && \
  cd /root/sourcekit-lsp/Editors/vscode && \
  npm run createDevPackage

# Install sourcekit-lsp extension. Although it requires `code` it's not available until logging in. 
RUN echo "code --install-extension /root/sourcekit-lsp/Editors/vscode/out/sourcekit-lsp-vscode-dev.vsix" >> /root/.bashrc
