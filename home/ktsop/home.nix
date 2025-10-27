{ config, pkgs, lib, ... }:

{
  home.username = "ktsop";
  home.homeDirectory = "/home/ktsop";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # Basic packages
  home.packages = with pkgs; [
    kitty
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

  # Kitty terminal
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = "11.0";
      confirm_os_window_close = 0;
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
