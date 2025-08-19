{ inputs, config, pkgs, ... }:
{
  imports = [
    ./packages/nixvim.nix
    ./packages/wget.nix
    ./packages/vscode.nix
    ./packages/zen-browser.nix
    ./packages/btop.nix
    ./packages/utils/git.nix
  ];

  # Home Manager manages itself
  programs.home-manager.enable = true;

  # Install fonts
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Required for Home Manager
  home.username = "luna";
  home.homeDirectory = "/home/luna";

  # Allow unfree packages for Home Manager
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.05";
  # You can add more Home Manager options below
}
