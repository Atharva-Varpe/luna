# /etc/nixos/python.nix
# This file defines the system's Python environment.

{ pkgs, ... }:

let
  # Define the list of Python packages you want to install.
  # You can find more packages by searching on https://search.nixos.org/packages
  my-python-packages = ps: with ps; [
    # Core scientific computing
    numpy
    pandas
    matplotlib

    # Web development & APIs
    requests
    flask

    # Utilities
    pip
    virtualenv
    ipython # A powerful interactive Python shell
  ];

  # Create a Python environment with the specified packages.
  python-with-packages = pkgs.python3.withPackages my-python-packages;

in
{
  # Make the Python environment available to all users on the system.
  environment.systemPackages = [
    python-with-packages
  ];
}
