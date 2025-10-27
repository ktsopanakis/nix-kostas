{ config, pkgs, lib, ... }:

{
  home.username = "ktsop";
  home.homeDirectory = "/home/ktsop";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # Apps you’ll use as a user (not root)
  home.packages = with pkgs; [
    kitty
    wofi
    waybar
    pavucontrol
    brightnessctl
    networkmanagerapplet
    wlogout
    hyprpaper
    swww
    kdePackages.dolphin
    kdePackages.kio-extras
    kdePackages.kde-cli-tools
    kdePackages.kdialog
    kdePackages.ark
    kdePackages.ffmpegthumbs
    kdePackages.kdegraphics-thumbnailers
  ];

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "org.kde.dolphin.desktop" ];
    "application/x-directory" = [ "org.kde.dolphin.desktop" ];
  };

  home.sessionVariables.TERMINAL = "kitty";

  # Kitty as terminal
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = "11.0";
      confirm_os_window_close = 0;
    };
  };

  # Hyprland config through Home Manager
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      monitor = [ ",preferred,auto,1" ];
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "GDK_BACKEND,wayland"
        "QT_QPA_PLATFORM,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
      ];

      input = {
        kb_layout = "us,gr";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        touchpad = { natural_scroll = true; };
        repeat_rate = 35;
        repeat_delay = 250;
      };

      general = {
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
        "col.active_border" = "rgb(88c0d0)";
        "col.inactive_border" = "rgba(888888aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 8;
        blur = { enabled = true; size = 6; passes = 2; };
        drop_shadow = true;
        shadow_range = 20;
      };

      animations = {
        enabled = true;
        bezier = [
          "ease, 0.05, 0.9, 0.1, 1.0"
        ];
        animation = [
          "windows, 1, 6, ease, popin 80%"
          "border, 1, 6, ease"
          "fade, 1, 6, ease"
          "workspaces, 1, 6, ease"
        ];
      };

      # Omarchy-like bindings
      "$mod" = "SUPER";

      bind = [
        # launchers / basics
        "$mod, RETURN, exec, kitty"
        "$mod, D, exec, wofi --show drun"
        "$mod, E, exec, thunar"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen, 1"
        "$mod, SPACE, togglefloating,"

        # focus HJKL
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # move windows
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # workspaces 1-9
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        # volume / brightness
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.3 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86MonBrightnessUp,  exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown,exec, brightnessctl set 5%-"

        # lock/logout
        "$mod, ESCAPE, exec, wlogout -p layer-shell"
      ];

      # start services on login
      exec-once = [
        "nm-applet --indicator"
        "waybar"
        "hyprpaper"
      ];
    };
  };

  # Hyprpaper simple wallpaper
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/Pictures/wall.jpg
    wallpaper = ,~/Pictures/wall.jpg
  '';

  # Waybar config files from this repo
  xdg.configFile."waybar/config".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
}
