{ pkgs, ... }:
{
  # Install Neovide (GPU-accelerated Neovim GUI) and the JetBrains Mono Nerd Font
  # so the GUI can use the patched Nerd font.
  home.packages = with pkgs; [ neovide nerd-fonts.jetbrains-mono ];

  # Desktop entry to launch Neovide as the editor
  xdg.desktopEntries.neovide = {
    name = "Neovide";
    genericName = "Neovim GUI";
    comment = "Fast, smooth, and GPU-accelerated Neovim GUI";
    exec = "neovide %F";
    terminal = false;
    categories = [ "Utility" "Development" "TextEditor" ];
    icon = "nvim";
    mimeType = [
      "text/plain"
      "text/x-csrc"
      "text/x-chdr"
      "text/x-c++src"
      "text/x-c++hdr"
      "text/x-python"
      "application/x-shellscript"
      "text/x-lua"
      "text/x-go"
      "text/x-rustsrc"
      "application/json"
      "text/html"
      "text/css"
      "application/javascript"
      "text/markdown"
      "text/x-nix"
      "text/yaml"
      "application/x-yaml"
      "application/x-toml"
    ];
  };

  # Optional: environment variables to tweak Neovide behavior
  # You can adjust these in your shell profile or here if you prefer them globally
  home.sessionVariables = {
    NEOVIDE_MULTIGRID = "1";       # Better rendering for popups
    NEOVIDE_NO_IDLE = "1";         # Reduce input latency
    NEOVIDE_CURSOR_ANIMATION_LENGTH = "0.05";  # Snappy cursor
    NEOVIDE_REFRESH_RATE = "120";  # Match high refresh displays
    NEOVIDE_FRAME = "full";        # Full window frame
    NEOVIDE_REMEMBER_WINDOW_SIZE = "1";
    NEOVIDE_FONT_FAMILY = "JetBrainsMono Nerd Font";  # Use JetBrains Mono Nerd Font
    NEOVIDE_FONT_SIZE = "14";      # Default font size
  };
}
