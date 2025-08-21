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

  # Install fonts
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    
    # for minecraft
    prismlauncher

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
