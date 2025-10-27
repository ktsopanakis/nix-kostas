{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];


  # Time & locale
  time.timeZone = "Europe/Athens";
  i18n.defaultLocale = "en_US.UTF-8";

  # Flakes + nix tweaks
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # User
  users.users.ktsop = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "input" "networkmanager" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Graphics (AMD + Intel iGPU work fine with Mesa)
  services.xserver.enable = false; # Wayland only
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ vaapiVdpau libva libvdpau-va-gl ];
  };

  # Sound / media
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Portals (for screenshots, screen share, etc.)
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Hyprland executable in system (HM will configure it)
  programs.hyprland.enable = true;

  # Login manager (tuigreet on greetd for Wayland)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Power & laptop niceties (okay on desktop too)
  services.power-profiles-daemon.enable = true;

  # Packages available system-wide
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
    fastfetch
    # For Wayland convenience
    wl-clipboard grim slurp swappy
    # Fonts (nice defaults)
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
  ];

  # Allow proprietary if you need e.g. codecs or Steam later
  nixpkgs.config.allowUnfree = true;

  # Sane default ulimits (Wayland/Hyprland sometimes benefit)
  security.pam.loginLimits = [
    { domain = "*"; type = "soft"; item = "nofile"; value = "1048576"; }
    { domain = "*"; type = "hard"; item = "nofile"; value = "1048576"; }
  ];

  system.stateVersion = "25.05";  # set to your installed release
}
