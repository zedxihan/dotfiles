{
  pkgs,
  lib,
  inputs,
  wrapGPU,
  ...
}:
let
  inherit (lib) attrsToList toList;

  profileAssets = import ./settings.nix;

  createEngine = name: alias: url: params: {
    inherit name;
    definedAliases = [ alias ];
    urls = toList {
      template = url;
      params = attrsToList params;
    };
  };
in
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    package = wrapGPU { pkg = inputs.zen-browser.packages.${pkgs.system}.default; };

    profiles.default = {
      id = 0;
      inherit (profileAssets) settings userChrome;

      search = {
        force = true;
        default = "kagi";
        engines = {
          kagi = createEngine "Kagi Search" "@kagi" "https://kagi.com/search" { q = "{searchTerms}"; };
          "google".metaData.alias = "@g";
          "wikipedia".metaData.alias = "@wiki";
          youtube = createEngine "YouTube" "@yt" "https://youtube.com/results" {
            search_query = "{searchTerms}";
          };
          github = createEngine "GitHub" "@gh" "https://github.com/search" {
            type = "repositories";
            q = "{searchTerms}";
          };
          nixwiki = createEngine "NixOS Wiki" "@nw" "https://wiki.nixos.org/w/index.php" {
            search = "{searchTerms}";
          };
          nyaa = createEngine "Nyaa" "@ny" "https://nyaa.si/" {
            f = "0";
            c = "0_0";
            q = "{searchTerms}";
          };
          anime = createEngine "Anilist Anime" "@anime" "https://anilist.co/search/anime" {
            search = "{searchTerms}";
          };
          manga = createEngine "Anilist Manga" "@manga" "https://anilist.co/search/manga" {
            search = "{searchTerms}";
          };
        };
      };
    };

    policies = {
      AppAutoUpdate = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      BackgroundAppUpdate = false;
      BlockAboutConfig = false;
      BlockAboutProfiles = true;
      BlockAboutSupport = true;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Cryptomining = true;
        EmailTracking = true;
        Fingerprinting = true;
        Locked = true;
        Value = true;
      };
      FirefoxSuggest = {
        ImproveSuggest = false;
        Locked = true;
        SponsoredSuggestions = false;
        Value = true;
        WebSuggestions = false;
      };
      GenerativeAI.Enabled = false;
      NewTabPage = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PictureInPicture.Eanbled = true;
      SkipTermsOfUse = true;
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        FirefoxLabs = false;
        MoreFromMozilla = false;
        Locked = true;
        SkipOnboarding = true;
      };
    };
  };
}
