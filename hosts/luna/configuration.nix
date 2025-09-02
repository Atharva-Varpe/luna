{ config, pkgs, ... }:

{
  # Main system configuration for host 'luna'.
  # This file is used via flakes (see flake.nix) so you normally do NOT need
  # to run 'nixos-generate-config' again; just edit and rebuild with:
  #   nixos-rebuild switch --flake .#luna
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./utils/audio.nix
      ./utils/gnome.nix
      ./utils/nvidia.nix
      ./utils/garbage_collector.nix
      ./utils/tailscale.nix
      ./utils/shell.nix
      ./utils/python.nix
      ./utils/autoupgrade.nix
      ./utils/nvidia-offload.nix
      ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "luna"; # Hostname matches flake output name.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # User account (set password with: passwd luna)
  users.users.luna = {
    isNormalUser = true;
    description = "luna";
    # Add docker group so the user can access the Docker daemon.
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      # Per-user packages (system-wide ones go in environment.systemPackages)
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    nano
    jq # Required for Tailscale auto-connect script
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Allow unfree packages (needed for VSCode and other proprietary software)
  nixpkgs.config.allowUnfree = true;
}
