{
  settings = {
    "browser.uiCustomization.state" = builtins.toJSON {
      placements = {
        widget-overflow-fixed-list = [ ];
        unified-extensions-area = [ ];
        nav-bar = [
          "back-button"
          "forward-button"
          "stop-reload-button"
          "vertical-spacer"
          "urlbar-container"
          "unified-extensions-button"
          "fxa-toolbar-menu-button"
          "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
          "vpn_proton_ch-browser-action"
          "ublock0_raymondhill_net-browser-action"
          "sponsorblocker_ajay_app-browser-action"
        ];
        toolbar-menubar = [ "menubar-items" ];
        TabsToolbar = [ "tabbrowser-tabs" ];
        vertical-tabs = [ ];
        PersonalToolbar = [ "personal-bookmarks" ];
        zen-sidebar-top-buttons = [
          "zen-toggle-compact-mode"
          "preferences-button"
          "privatebrowsing-button"
        ];
        zen-sidebar-foot-buttons = [
          "downloads-button"
          "zen-workspaces-button"
          "zen-create-new-button"
        ];
      };
      dirtyAreaCache = [
        "nav-bar"
        "vertical-tabs"
        "zen-sidebar-foot-buttons"
        "PersonalToolbar"
        "unified-extensions-area"
        "zen-sidebar-top-buttons"
        "toolbar-menubar"
        "TabsToolbar"
      ];
      currentVersion = 23;
    };

    "general.autoScroll" = true;
    "services.sync.declinedEngines" = "history,forms,tabs";
    "services.sync.engine.history" = false;
    "services.sync.engine.tabs" = false;
    "signon.rememberSignons" = false;

    # --- Search & Bookmarks ---
    "browser.search.defaultenginename" = "Kagi Search";
    "browser.search.selectedEngine" = "Kagi Search";
    "browser.search.official" = false;
    "browser.search.update" = false;
    "browser.search.region" = "US";
    "browser.search.countryCode" = "US";
    "browser.toolbars.bookmarks.visibility" = "always";

    # --- Urlbar & View ---
    "zen.urlbar.behavior" = "normal";
    "zen.urlbar.replace-newtab" = false;
    "zen.view.compact.enable-at-startup" = false;
    "zen.view.use-single-toolbar" = false;

    # --- SuperPins Layout ---
    "browser.sessionstore.restore_on_demand" = true;
    "browser.sessionstore.restore_pinned_tabs_on_demand" = true;
    "browser.startup.page" = 3;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };

  userChrome = ''
    /* Dim pending/unloaded tabs (both icon and text) */
    .tab-icon-image[pending="true"],
    .tabbrowser-tab[pending="true"] .tab-text {
      opacity: 0.5 !important;
    }

    /* Essentials Gap (Normal = 2px) */
    @media (-moz-pref("zen.view.sidebar-expanded")) {
      .zen-essentials-container {
        gap: 2px 2px !important;
      }
    }
  '';
}
