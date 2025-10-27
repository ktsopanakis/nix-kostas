{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    
    # Use system VS Code with Home Manager profiles
    package = pkgs.vscode;
    
    # Extensions
    extensions = with pkgs.vscode-extensions; [
      # Language support
      ms-python.python
      ms-vscode.cpptools
      rust-lang.rust-analyzer
      bradlc.vscode-tailwindcss
      ms-vscode.vscode-typescript-next
      
      # Git
      eamodio.gitlens
      
      # Themes
      catppuccin.catppuccin-vsc
      pkief.material-icon-theme
      
      # Utilities
      ms-vsliveshare.vsliveshare
      ms-vscode-remote.remote-ssh
      ms-azuretools.vscode-docker
      
      # Nix support
      bbenoist.nix
      jnoortheen.nix-ide
    ];
    
    # User settings
    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Droid Sans Mono', 'monospace'";
      "editor.fontSize" = 14;
      "editor.lineHeight" = 1.5;
      "editor.fontLigatures" = true;
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.detectIndentation" = true;
      "editor.renderWhitespace" = "boundary";
      "editor.rulers" = [ 80 120 ];
      "editor.wordWrap" = "on";
      "editor.minimap.enabled" = false;
      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = true;
      "editor.formatOnSave" = true;
      "editor.formatOnPaste" = true;
      "editor.codeActionsOnSave" = {
        "source.organizeImports" = "explicit";
        "source.fixAll" = "explicit";
      };
      
      # Terminal settings
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font'";
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.lineHeight" = 1.2;
      "terminal.integrated.shell.linux" = "${pkgs.bash}/bin/bash";
      
      # File associations
      "files.associations" = {
        "*.nix" = "nix";
        "flake.lock" = "json";
      };
      
      # Git settings
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;
      "git.autofetch" = true;
      
      # Python settings
      "python.defaultInterpreterPath" = "/usr/bin/python3";
      "python.linting.enabled" = true;
      "python.linting.pylintEnabled" = true;
      "python.formatting.provider" = "black";
      
      # Nix settings
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      
      # UI settings
      "window.zoomLevel" = 0;
      "workbench.startupEditor" = "newUntitledFile";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      
      # Telemetry
      "telemetry.telemetryLevel" = "off";
      "update.showReleaseNotes" = false;
    };
    
    # Keybindings
    keybindings = [
      {
        "key" = "ctrl+shift+t";
        "command" = "workbench.action.terminal.new";
      }
      {
        "key" = "ctrl+shift+`";
        "command" = "workbench.action.terminal.toggleTerminal";
      }
    ];
  };
}