{
  lib,
  inputs,
  ...
}:
let
  inherit (lib) attrsToList toList;
in
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    profiles.default =
      let
        profileAssets = import ./settings.nix;
      in
      {
        id = 0;
        inherit (profileAssets) settings userChrome;
        search = {
          force = true;
          default = "kagi";
          engines =
            let
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
