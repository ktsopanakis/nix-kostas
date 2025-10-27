# VS Code Extensions Configuration
# This file contains the list of VS Code extensions to be installed via Nix

{ pkgs }:

with pkgs.vscode-extensions; [
  # Language support
  ms-python.python
  ms-vscode.cpptools
  rust-lang.rust-analyzer
  golang.go
  ms-vscode.cmake-tools
  
  # Nix support
  bbenoist.nix
  jnoortheen.nix-ide
  
  # Git integration
  eamodio.gitlens
  github.vscode-pull-request-github
  
  # Themes and UI
  catppuccin.catppuccin-vsc
  pkief.material-icon-theme
  
  # Productivity
  ms-vscode.live-server
  esbenp.prettier-vscode
  bradlc.vscode-tailwindcss
  ms-vscode.vscode-typescript-next
  
  # Utilities
  ms-vscode.hexeditor
  redhat.vscode-yaml
  tamasfe.even-better-toml
  
  # Docker and containers
  ms-azuretools.vscode-docker
  
  # Markdown
  yzhang.markdown-all-in-one
]