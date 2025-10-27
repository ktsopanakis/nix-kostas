{ config, pkgs, lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./vscode.nix
  ];

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

  # Wofi configuration directly in Home Manager
  xdg.configFile."wofi/config".text = ''
    width=600
    height=400
    location=center
    show=drun
    prompt=Search...
    filter_rate=100
    allow_markup=true
    no_actions=true
    halign=fill
    orientation=vertical
    content_halign=fill
    insensitive=true
    allow_images=true
    image_size=24
    gtk_dark=true
  '';

  xdg.configFile."wofi/style.css".text = ''
    /* Wofi Configuration */
    window {
        margin: 0px;
        border: 2px solid #88c0d0;
        border-radius: 12px;
        background-color: rgba(30, 30, 46, 0.95);
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
    }

    #input {
        margin: 8px;
        padding: 12px;
        border: none;
        color: #cdd6f4;
        background-color: rgba(49, 50, 68, 0.8);
        border-radius: 8px;
        font-size: 16px;
    }

    #input:focus {
        border: 2px solid #89b4fa;
        outline: none;
    }

    #inner-box {
        margin: 8px;
        padding: 0px;
        border: none;
        background-color: transparent;
    }

    #outer-box {
        margin: 0px;
        padding: 0px;
        border: none;
        background-color: transparent;
    }

    #scroll {
        margin: 0px;
        border: none;
        background-color: transparent;
    }

    #text {
        margin: 0px;
        padding: 0px;
        border: none;
        color: #cdd6f4;
    }

    #entry {
        padding: 8px 12px;
        margin: 2px 4px;
        border-radius: 6px;
        background-color: transparent;
        color: #cdd6f4;
    }

    #entry:selected {
        background-color: #89b4fa;
        color: #1e1e2e;
        font-weight: bold;
    }

    #entry:hover {
        background-color: rgba(137, 180, 250, 0.3);
    }

    #text:selected {
        color: #1e1e2e;
    }
  '';
}
