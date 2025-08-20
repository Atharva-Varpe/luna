{ inputs, config, pkgs, ... }:
{
  # Install LunarVim and Neovide
  home.packages = with pkgs; [
    lunarvim
    neovide
  ];

  # Set LunarVim as the default editor
  home.sessionVariables = {
    EDITOR = "lvim";
  };

  # Create a desktop entry for Neovide with LunarVim
  xdg.desktopEntries."neovide-lunarvim" = {
    name = "Neovide (LunarVim)";
    comment = "Neovim GUI with LunarVim configuration";
    exec = "${pkgs.neovide}/bin/neovide --neovim-bin ${pkgs.lunarvim}/bin/lvim";
    icon = "neovide";
    terminal = false;
    type = "Application";
    categories = [ "Utility" "TextEditor" "Development" ];
  };
}
