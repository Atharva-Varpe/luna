{ config, pkgs, ... }:

{
  # Enable automatic system upgrades
  system.autoUpgrade = {
    enable = true;
    upgrade = true;
    # Automatically upgrade the flake inputs and rebuild the system
    flake = "/home/luna/luna";
    # updates flake as well
    flags = [ "--recreate-lock-file" ];
    # Set the schedule for upgrades (e.g., "daily", "weekly", "monthly", or a specific time)
    dates = "daily";
    # Allow the system to automatically reboot after an upgrade if necessary
    allowReboot = true;
  };
}
