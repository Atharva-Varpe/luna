{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-vscode.cpptools
        ms-python.python
        esbenp.prettier-vscode
        bradlc.vscode-tailwindcss
        jnoortheen.nix-ide
      ];
      
      userSettings = {
        "editor.fontSize" = 14;
  "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace'";
        "editor.fontLigatures" = true;
        "editor.minimap.enabled" = false;
        "editor.wordWrap" = "on";
        "workbench.colorTheme" = "Default Dark+";
        "files.autoSave" = "afterDelay";
        "editor.formatOnSave" = true;
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
      };
    };
  };
}
