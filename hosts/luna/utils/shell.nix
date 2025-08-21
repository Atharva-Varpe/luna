# Shell / terminal customization module.
{ config, pkgs, inputs, ... }:

{
  # 1. Install the required packages for your system
  environment.systemPackages = with pkgs; [ ];

  programs.fish.enable = true;

  # Starship prompt configured via Home Manager, not system level.

  # Foot terminal theming moved to Home Manager (programs.foot) to avoid
  # referencing a non-existent NixOS module here.

  # 2. Set the default shell for your user
  users.users.luna = {
    # Replace <username> with your actual username, e.g., users.users.luna
    shell = pkgs.fish;
  };
}
