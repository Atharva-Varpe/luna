{ inputs, config, pkgs, ... }:
{
  imports = [
    ./packages/lunarvim.nix
    ./packages/wget.nix
    ./packages/vscode.nix
    ./packages/zen-browser.nix
    ./packages/btop.nix
    ./packages/utils/git.nix
    ./packages/utils/python.nix
  ];

  # Home Manager manages itself
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # fonts
    nerd-fonts.jetbrains-mono

    # lammps & ovito for MM722
    lammps
    ovito

    mindustry-wayland
    
    # 7zip
    p7zip

    # ranger
    ranger

    # docker
    docker_28
    docker-compose

    # Discord w/ theme
    discord

    # clipboard
    wl-clipboard
    wl-clipboard-x11
  ];

  # Required for Home Manager
  home.username = "luna";
  home.homeDirectory = "/home/luna";

  home.stateVersion = "25.05";
  # You can add more Home Manager options below

  programs.fish.enable = true;
  programs.starship = { enable = true; enableFishIntegration = true; };
}
