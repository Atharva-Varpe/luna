{ config, pkgs, ... }:

{
  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily"; # Run weekly, can be changed to "daily" or a cron expression
    options = "--delete-older-than 7d"; # Delete generations older than 7 days
  };
}
