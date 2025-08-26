{ config, lib, pkgs, ... }:

{
  # Allow unfree software (required for Nvidia drivers)
  nixpkgs.config.allowUnfree = true;

  # Enable OpenGL/graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Enable 32-bit support for games
  };

  # Default: PRIME offload mode (Intel is always used, NVIDIA only when requested)
  # This avoids sleep/suspend issues and saves power. Use the nvidia-offload alias for games/apps.
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      sync.enable = false;
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Bus IDs - update for your system (see comments below)
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    forceFullCompositionPipeline = true;
  };

  # Usage:
  # - By default, Intel GPU is used for all rendering (power saving, reliable suspend/sleep).
  # - To run a program on NVIDIA GPU, use:
  #     nvidia-offload <program>
  #   Example: nvidia-offload prismlauncher
  # - For Minecraft, launch with nvidia-offload for best performance.

  # Environment packages for GPU utilities
  environment.systemPackages = with pkgs; [
    # Nvidia utilities (only installed when nvidia drivers are active)
    #nvidia-smi
    nvtopPackages.full
    # General GPU utilities
    glxinfo
    vulkan-tools
    mesa-demos
  ];

  # Kernel parameters to help with boot issues
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  
  # Optional: Enable Docker with CDI support for GPU access
  virtualisation.docker = {
    enable = true;
    daemon.settings.features.cdi = true;
  };
}