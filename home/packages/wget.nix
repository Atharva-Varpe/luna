{ config, pkgs, ... }:
{
  home.packages = [ pkgs.wget ];
  
  # Configure wget aliases
  home.shellAliases = {
    wget-continue = "wget -c";
    wget-mirror = "wget -m -p -E -k -K -np";
    wget-page = "wget -p -k";
  };
}
