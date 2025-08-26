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
    ./packages/prismlauncher-offload.nix
  ./packages/ranger.nix
  ];

  # Home Manager manages itself
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # fonts
    nerd-fonts.jetbrains-mono

    # lammps & ovito for MM722
    lammps
    ovito

    # games
    mindustry-wayland
    
    # 7zip
    p7zip

  # ranger is enabled via ./packages/ranger.nix

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

  # Desktop entry to show Prism Launcher in menus, using the offload wrapper
  xdg.desktopEntries.prismlauncher = {
    name = "Prism Launcher (NVIDIA)";
    genericName = "Minecraft Launcher";
    comment = "Launch Prism Launcher using NVIDIA PRIME offload";
    exec = "prismlauncher %U"; # the wrapper installed by prismlauncher-offload.nix
    terminal = false;
    categories = [ "Game" ];
    # Try to use the upstream icon directly from the store path
    icon = "${pkgs.prismlauncher}/share/icons/hicolor/256x256/apps/prismlauncher.png";
    mimeType = [ "x-scheme-handler/minecraft" ];
  };
}
