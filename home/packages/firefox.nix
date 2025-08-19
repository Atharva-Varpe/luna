{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.zen-browser;
    
    profiles.default = {
      settings = {
        "browser.startup.homepage" = "https://nixos.org";
        "browser.search.defaultenginename" = "DuckDuckGo";
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
        "browser.download.useDownloadDir" = false;
        "browser.download.alwaysOpenPanel" = false;
        "browser.download.manager.showWhenStarting" = false;
        "browser.tabs.warnOnClose" = false;
      };
      
      extensions = with pkgs.firefox-addons; [
        bitwarden
        ublock-origin
        video-speed-controller
        dark-reader
      ];
      
      bookmarks = {
        force = true;
        settings = [
          {
            name = "NixOS";
            tags = [ "nix" ];
            keyword = "nixos";
            url = "https://nixos.org/";
          }
          {
            name = "Home Manager";
            tags = [ "nix" ];
            keyword = "hm";
            url = "https://nix-community.github.io/home-manager/";
          }
        ];
      };
    };
  };
}
