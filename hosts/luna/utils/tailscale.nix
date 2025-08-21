{ config, pkgs, ... }:

{
  # Enable Tailscale service
  services.tailscale = {
    enable = true;
    # Enable the web interface for easier management
    openFirewall = true;
  };

  # Add tailscale package to system packages
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  # Configure firewall for Tailscale
  networking.firewall = {
    # Always allow traffic from the Tailscale interface
    trustedInterfaces = [ "tailscale0" ];
    
    # Allow Tailscale UDP port
    allowedUDPPorts = [ 41641 ];
    
    # Enable checksum offloading (helps with performance)
    checkReversePath = "loose";
  };

  # Optional: Enable IP forwarding if you want to use this machine as a subnet router
  # Uncomment the following lines if you want this machine to route traffic for other devices
  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_forward" = 1;
  #   "net.ipv6.conf.all.forwarding" = 1;
  # };

  # Optional: Auto-start Tailscale on boot
  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";
    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];
    
    # Set Type to oneshot so that we can restart it if it fails
    serviceConfig.Type = "oneshot";
    
    script = ''
      # Wait for tailscaled to settle
      sleep 2
      
      # Check if already authenticated
      status="$(${pkgs.tailscale}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then
        exit 0
      fi
      
      # If not authenticated, you'll need to run 'sudo tailscale up' manually after the first boot
      echo "Tailscale is not authenticated. Please run 'sudo tailscale up' to authenticate."
    '';
  };
}
