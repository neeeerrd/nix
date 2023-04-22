# This file has all of the essential software aside from the bootloader. This handles wifi, sound, users, and all the drivers.

{ config, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{ 
  environment.systemPackages = [ 
    nvidia-offload
    pkgs.vim
    pkgs.wget
    pkgs.git
    pkgs.xdg-utils 
  ];

  networking.networkmanager.enable = true; 

  nixpkgs.config.allowUnfree = true;
  
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    offload.enable = true;
  
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };   

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  services.xserver.libinput.enable = true;
    
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    inter
  ];
}

