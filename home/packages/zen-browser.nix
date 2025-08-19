{ inputs, config, pkgs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.beta ];
  
  programs.zen-browser = {
    enable = true;
    
    policies = {
      # Privacy and security settings
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      
      # Browser preferences
      Preferences = {
        "browser.startup.homepage" = {
          Value = "https://nixos.org";
          Status = "default_unavailable";
        };
        "browser.search.defaultenginename" = {
          Value = "DuckDuckGo";
          Status = "default_unavailable";
        };
        "browser.urlbar.placeholderName" = {
          Value = "DuckDuckGo";
          Status = "default_unavailable";
        };
        "browser.ctrlTab.recentlyUsedOrder" = {
          Value = false;
          Status = "locked";
        };
        "privacy.trackingprotection.enabled" = {
          Value = true;
          Status = "locked";
        };
        "dom.security.https_only_mode" = {
          Value = true;
          Status = "locked";
        };
        "browser.download.useDownloadDir" = {
          Value = false;
          Status = "locked";
        };
        "browser.download.alwaysOpenPanel" = {
          Value = false;
          Status = "locked";
        };
        "browser.download.manager.showWhenStarting" = {
          Value = false;
          Status = "locked";
        };
        "browser.tabs.warnOnClose" = {
          Value = false;
          Status = "locked";
        };
      };
    };
  };
}
