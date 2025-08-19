{ config, pkgs, ... }:
{
  # Install git and GitHub Desktop
  home.packages = with pkgs; [
    git
    gh
  ];

  # Git user configuration
  programs.git = {
    enable = true;
    userName = "Atharva Varpe";
    userEmail = "atharva.varpe2019@gmail.com";
  };
}
