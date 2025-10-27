# VS Code Extensions Configuration
# This file contains the list of VS Code extensions to be installed via Nix

{ pkgs }:

with pkgs.vscode-extensions; [
  # Language support
  ms-python.python
  ms-vscode.cpptools
  rust-lang.rust-analyzer
  golang.go

  # Nix support
  bbenoist.nix

  # Git integration
  eamodio.gitlens

  # Themes and UI
  catppuccin.catppuccin-vsc
  pkief.material-icon-theme

  # Productivity
  ms-vscode.live-server
  esbenp.prettier-vscode
  bradlc.vscode-tailwindcss
]
