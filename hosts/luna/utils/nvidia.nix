{ config, lib, pkgs, ... }:

{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # VDPAU and VAAPI support
      vaapiVdpau
      libvdpau-va-gl
      # Vulkan support
      nvidia-vaapi-driver
    ];
  };

  # Load NVIDIA driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  # NVIDIA configuration
  hardware.nvidia = {
    # Modesetting is required
    modesetting.enable = true;

    # Enable power management (do not disable this unless you have a reason to)
    # Likely to cause problems on laptops and with screen tearing
    powerManagement.enable = true;
    
    # Fine-grained power management. Turns off GPU when not in use
    # Experimental and only works on modern Nvidia GPUs (Turing+)
    # RTX 3060 Mobile supports this - enabling for better battery life
    powerManagement.finegrained = true;

    # Use the open source version of the kernel module (for driver version 515.43.04+)
    # Currently alpha-quality/buggy, so false is currently the recommended setting
    open = false;

    # Enable the Nvidia settings menu
    # Accessible via `nvidia-settings`
    nvidiaSettings = true;

    # Use the latest production driver
    # RTX 3060 Mobile works best with latest drivers
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    # PRIME configuration for laptops with hybrid graphics
    prime = {
      # Enable NVIDIA Optimus PRIME
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      
      # Enable sync mode instead of offload mode (better performance but higher power usage)
      # Uncomment the following lines and comment out the offload section above if you prefer sync mode:
      # sync.enable = true;

      # Bus ID of the NVIDIA GPU. You can find it using lspci
      # Your RTX 3060 Mobile is at 01:00.0
      nvidiaBusId = "PCI:1:0:0";
      
      # Bus ID of the Intel GPU. You can find it using lspci
      # Your Intel Iris Xe Graphics is at 00:02.0
      intelBusId = "PCI:0:2:0";
      
      # For AMD iGPU, use amdgpuBusId instead of intelBusId
      # amdgpuBusId = "PCI:0:2:0";
    };
  };

  # Environment variables for NVIDIA
  environment.sessionVariables = {
    # For Wayland support
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    
    # For better Wayland support
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # NVIDIA specific
    NVIDIA_DISABLE_PREEMPTION = "1";
  };

  # System packages for NVIDIA utilities
  environment.systemPackages = with pkgs; [
    # NVIDIA utilities
    nvidia-system-monitor-qt  # GUI system monitor for NVIDIA GPUs
    nvitop                   # Interactive NVIDIA GPU process viewer (htop for GPUs)
    nvtopPackages.nvidia     # GPU process monitoring tool (NVIDIA-specific)
    gpu-viewer               # Simple GPU information viewer
    
    # CUDA toolkit for RTX 3060 Mobile (supports CUDA 8.6)
    cudatoolkit
    cudaPackages.cudnn
    
    # Vulkan tools (RTX 3060 has excellent Vulkan support)
    vulkan-tools             # Vulkan utilities (vulkaninfo, vkcube)
    vulkan-loader            # Vulkan loader
    vulkan-validation-layers # Vulkan validation layers
    vulkan-extension-layer   # Additional Vulkan extensions
    
    # OpenGL utilities
    glxinfo                  # OpenGL information utility
    mesa-demos               # OpenGL demos and utilities
    
    # Video acceleration (RTX 3060 supports NVENC/NVDEC)
    libva-utils              # VA-API utilities (vainfo)
    vdpauinfo               # VDPAU information utility
    
    # Additional GPU monitoring tools
    radeontop                # Works for general GPU monitoring
  ];

  # Enable CUDA support for RTX 3060 Mobile
  nixpkgs.config.cudaSupport = true;
  
  # Enable unfree packages for NVIDIA drivers and CUDA
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "nvidia-x11"
    "nvidia-settings"
    "nvidia-persistenced"
    "cudatoolkit"
    "cudnn"
  ];

  # Boot configuration for NVIDIA
  boot.kernelParams = [
    # NVIDIA DRM kernel mode setting
    "nvidia-drm.modeset=1"
    # Disable nouveau (open source NVIDIA driver)
    "nouveau.modeset=0"
    # Improve NVIDIA performance
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    # Enable NVIDIA power management for RTX 3060 Mobile
    "nvidia.NVreg_DynamicPowerManagement=0x02"
    # Better memory management for modern GPUs
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
  ];

  # Services configuration
  services.xserver = {
    # Screen tearing prevention
    screenSection = ''
      Option "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option "AllowIndirectGLXProtocol" "off"
      Option "TripleBuffer" "on"
    '';
  };

  # Systemd services for NVIDIA
  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  # Udev rules for NVIDIA
  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/wakeup}="disabled", ATTR{remove}="1"

    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/wakeup}="disabled", ATTR{remove}="1"

    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/wakeup}="disabled", ATTR{remove}="1"

    # Enable runtime PM for NVIDIA VGA/3D controller devices on driver bind
    ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
    ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"

    # Disable runtime PM for NVIDIA VGA/3D controller devices on driver unbind
    ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="on"
    ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="on"
  '';
}
