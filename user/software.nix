{ config, pkgs, ... }:
{
  home-manager.users.emmettkelleher = {
    home.packages = with pkgs; [
      # Desktop
      hyprland
      waybar
      mako
      hyprpaper
      # Apps
      wezterm
      firefox
      wofi
      discord
      spotify
      # Modding
      betterdiscordctl
      # CLI
      starship
      # idk where to put this
      grim
      slurp
    ];
    # You might be wondering why my hyprland config doesnt symlink from here. 
    # Well, it's because Hyprland can't watch symlinked config files. 
    # As such, I need to symlink the Hyprland config from .config/hypr/hyprland.conf, 
    # instead of the other way around.
    home.file.".nix/config/hyprland.conf".source = /home/emmettkelleher/.config/hypr/hyprland.conf;
    home.file.".config/hypr/hyprpaper.conf".source = ../config/hyprpaper.conf;
    home.file.".config/fish/config.fish".source = ../config/config.fish;
    home.file.".wezterm.lua".source = ../config/wezterm.lua;
    home.file.".config/mako/config".source = ../config/mako-config;    

    home.stateVersion = "22.11";
  };
}
