{ pkgs, config, ... }:

{
  imports = [
      ../hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "three";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  
 
  programs.fish.enable = true;

  time.timeZone = "Asia/Hong_Kong";

  users.users.emmettkelleher = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    shell = pkgs.fish;
  };

  environment.shells = with pkgs; [ fish ];  

  system.stateVersion = "22.11";
}

