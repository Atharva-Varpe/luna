{ config, pkgs, ... }:
{
  # Enable Wayland and GNOME Desktop Environment.
  services.xserver.enable = true;
  
  # Enable GNOME with Wayland
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;
  services.desktopManager.gnome.enable = true;

  # GNOME Shell Extensions
  environment.gnome.excludePackages = [ ]; # Optional: don't exclude any by default
  environment.systemPackages = with pkgs.gnomeExtensions; [
    forge # for hyprland like tiling
    space-bar
    blur-my-shell
    just-perfection
    clipboard-indicator
  ];
}
