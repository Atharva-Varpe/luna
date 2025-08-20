{ config, lib, pkgs, ... }:

{
  # Allow unfree software (required for Nvidia drivers)
  nixpkgs.config.allowUnfree = true;

  # Enable OpenGL/graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Enable 32-bit support for games
  };

  # Default configuration: Nvidia GPU enabled with PRIME Sync
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia = {
    # Modesetting is required
    modesetting.enable = true;
    
    # Nvidia power management. Can cause sleep/suspend issues but may fix graphical corruption
    powerManagement.enable = false;
    
    # Fine-grained power management for modern GPUs (Turing or newer)
    # Your RTX 3060 supports this, but it's experimental
    powerManagement.finegrained = false;
    
    # Use open-source kernel module for RTX 3060 (recommended for Turing+)
    # RTX 3060 is Ampere architecture, so this should be set to true
    open = true;
    
    # Enable Nvidia settings menu
    nvidiaSettings = true;
    
    # Use stable driver with RTX Super support
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    # PRIME configuration for hybrid graphics
    prime = {
      # Enable sync mode by default (better performance, higher power consumption)
      sync.enable = true;
      
      # Bus IDs - YOU MUST UPDATE THESE FOR YOUR SYSTEM
      # Run: sudo lshw -c display
      # Convert hex to decimal, remove leading zeros, replace dot with colon
      # Example conversion: pci@0000:00:02.0 becomes PCI:0:2:0
      #                    pci@0000:01:00.0 becomes PCI:1:0:0
      intelBusId = "PCI:0:2:0";    # Update this with your Intel GPU bus ID
      nvidiaBusId = "PCI:1:0:0";   # Update this with your Nvidia GPU bus ID
    };
    
    # Force full composition pipeline to reduce screen tearing
    forceFullCompositionPipeline = true;
  };

  # Specialisation for Intel-only mode (power saving, longer battery life)
  specialisation = {
    intel-only.configuration = {
      system.nixos.tags = [ "intel-only" ];
      
      # Disable Nvidia completely and use only Intel
      services.xserver.videoDrivers = lib.mkForce [ "modesetting" ];
      
      # Override Nvidia settings
      hardware.nvidia = {
        prime.sync.enable = lib.mkForce false;
        prime.offload.enable = lib.mkForce false;
      };
      
      # Blacklist Nvidia modules to ensure they don't load
      boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
      
      # Blacklist Nvidia kernel modules via modprobe
      boot.extraModprobeConfig = ''
        blacklist nouveau
        blacklist nvidia
        blacklist nvidia_drm  
        blacklist nvidia_modeset
        options nouveau modeset=0
      '';
      
      # Use power-saving settings for Intel GPU
      services.xserver.deviceSection = ''
        Option "TearFree" "true"
        Option "AccelMethod" "glamor"
      '';
      
      # Disable Nvidia GPU completely with udev rules
      services.udev.extraRules = ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
        
        # Remove NVIDIA USB Type-C UCSI devices, if present  
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
        
        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
        
        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
      '';
    };

    # Optional: Offload mode specialisation (for when you want Nvidia available but not always active)
    nvidia-offload.configuration = {
      system.nixos.tags = [ "nvidia-offload" ];
      
      services.xserver.videoDrivers = lib.mkForce [ "modesetting" "nvidia" ];
      
      hardware.nvidia.prime = {
        # Disable sync and enable offload mode
        sync.enable = lib.mkForce false;
        offload = {
          enable = lib.mkForce true;
          enableOffloadCmd = lib.mkForce true;
        };
      };
    };
  };

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

  # Create nvidia-offload script for manual offloading when in offload mode
  environment.shellAliases = {
    nvidia-offload = "env __NV_PRIME_RENDER_OFFLOAD=1 __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only";
  };

  # Kernel parameters to help with boot issues
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  
  # Optional: Enable Docker with CDI support for GPU access
  virtualisation.docker = {
    enable = true;
    daemon.settings.features.cdi = true;
  };
}