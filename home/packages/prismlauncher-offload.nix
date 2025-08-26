{ pkgs, ... }:

let
  # This wrapper ensures that prismlauncher always runs with nvidia-offload.
  prismlauncher-wrapped = pkgs.writeShellScriptBin "prismlauncher" ''
    #!${pkgs.bash}/bin/bash
    # The nvidia-offload script is in the system path, so we can call it directly.
    # We pass all arguments ("$@") to the real prismlauncher executable.
    exec nvidia-offload ${pkgs.prismlauncher}/bin/prismlauncher "$@"
  '';
in
{
  # This package will be installed for your user.
  home.packages = [ prismlauncher-wrapped ];
}
