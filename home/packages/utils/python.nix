{ config, pkgs, ... }:
{
  # Install git and GitHub Desktop
  home.packages = with pkgs; [
    # latest python 3
    python3

    # python 310 for cipla
    python310
  ];
}
