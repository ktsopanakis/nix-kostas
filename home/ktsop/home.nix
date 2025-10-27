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

  # Alacritty terminal with configuration
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
        size = 11.0;
        offset = {
          x = 0;
          y = 1;
        };
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
