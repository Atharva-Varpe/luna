{ inputs, config, pkgs, ... }:
{
  imports = [
    ./packages/wget.nix
    ./packages/vscode.nix
    ./packages/zen-browser.nix
    ./packages/btop.nix
    ./packages/utils/git.nix
    ./packages/utils/python.nix
    ./packages/prismlauncher-offload.nix
    ./packages/ranger.nix
    inputs.nixvim.homeModules.default
    ./packages/nixvim.nix
  ];  # Home Manager manages itself
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # fonts
    nerd-fonts.jetbrains-mono

    # notes
    obsidian

    # lammps & ovito for MM722
    lammps
    ovito

    # games
    mindustry-wayland
    
    # 7zip
    p7zip

    # tree
    tree

    # latex and xelatex
    texliveFull

    # ai-ide
    windsurf
    code-cursor

  # ranger is enabled via ./packages/ranger.nix

    # docker
    docker_28
    docker-compose

    # Discord w/ theme
    discord

    # clipboard
    wl-clipboard
    wl-clipboard-x11

    # Formatters for nixvim
    black
    isort
    alejandra
    prettier
    stylua

    # LSP servers for nixvim
    nixd
    basedpyright
    lua-language-server
    typescript-language-server
    rust-analyzer
    clang-tools

    # Additional tools for development
    nodePackages.typescript
    nodejs
    cargo
    rustc
    gcc
    
    # Terminal tools for nixvim
    bat  # For fzf-lua previews
    fd   # Better find for fzf-lua
    ripgrep  # Better grep for fzf-lua
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
    name = "Prism Launcher";
    genericName = "Minecraft Launcher";
    comment = "A custom launcher for Minecraft that makes it easy to manage multiple installations of Minecraft at once";
    exec = "prismlauncher %U"; # the wrapper installed by prismlauncher-offload.nix
    terminal = false;
    categories = [ "Game" ];
    # Try to use the upstream icon directly from the store path
    icon = "prismlauncher";
    mimeType = [ "x-scheme-handler/minecraft" ];
  };
}
