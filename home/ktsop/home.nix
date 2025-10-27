{ config, pkgs, lib, ... }:

{
  home.username = "ktsop";
  home.homeDirectory = "/home/ktsop";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # Basic packages
  home.packages = with pkgs; [
    wofi
    waybar
    pavucontrol
    brightnessctl
    networkmanagerapplet
    wlogout
    xfce.thunar
    # Additional applications
    firefox
    brave
    btop
    signal-desktop
    docker
    lazydocker
    lazygit
    vscode  # Keep VS Code available while programs.vscode is configured
  ];

  # Chromium with proper Wayland flags
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
      "--gtk-version=4"
    ];
  };

  # Firefox with Wayland support
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };

  # Alacritty terminal with configuration
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 11.0;
      };
      window = {
        opacity = 0.95;
        padding = {
          x = 10;
          y = 10;
        };
      };
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
      };
    };
  };

  # VS Code with extensions and settings
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
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
      ];
      userSettings = {
        "editor.fontSize" = 14;
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Droid Sans Mono', 'monospace'";
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.minimap.enabled" = false;
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "material-icon-theme";
        "terminal.integrated.fontSize" = 13;
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
      };
    };
  };

  # Shell aliases for convenience
  home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /home/ktsop/Projects/ktsopanakis/nix-kostas";
    rebuild-test = "sudo nixos-rebuild test --flake /home/ktsop/Projects/ktsopanakis/nix-kostas";
  };

  # Config files from this repo
  xdg.configFile."waybar/config".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
  xdg.configFile."hypr/hyprland.conf" = {
    source = ./hyprland/hyprland.conf;
    force = true;  # Allow overwriting existing file
  };
}
