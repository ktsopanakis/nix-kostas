{ config, pkgs, lib, ... }:

{
  home.username = "ktsop";
  home.homeDirectory = "/home/ktsop";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # Basic packages
  home.packages = with pkgs; [
    wofi
    rofi  # Alternative launcher
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
    rustdesk  # Remote desktop software
    # Wallpaper tools
    swww  # Wayland wallpaper daemon
    wget  # For downloading wallpapers
    curl  # Alternative download tool
    xorg.xhost  # X11 forwarding support
    wl-clipboard  # Wayland clipboard utilities
    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # Chromium with proper Wayland flags
  programs.chromium = {
    enable = true;
  };

  # Firefox with Wayland support
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };

  # Alacritty terminal with external configuration
  programs.alacritty = {
    enable = true;
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

  xdg.configFile."alacritty/alacritty.toml" = {
    source = ./alacritty/alacritty.toml;
    force = true;
  };

  xdg.configFile."waybar/config" = {
    source = ./waybar/config.jsonc;
    force = true;
  };
  
  xdg.configFile."waybar/style.css" = {
    source = ./waybar/style.css;
    force = true;
  };

  xdg.configFile."hypr/hyprland.conf" = {
    source = ./hyprland/hyprland.conf;
    force = true;
  };  xdg.configFile."wofi/config" = {
    source = ./wofi/config;
    force = true;
  };

  xdg.configFile."wofi/style.css" = {
    source = ./wofi/style.css;
    force = true;
  };
}
