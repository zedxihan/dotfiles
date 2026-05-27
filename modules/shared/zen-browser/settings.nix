{
  "browser.uiCustomization.state" = builtins.toJSON {
    placements = {
      widget-overflow-fixed-list = [ ];
      unified-extensions-area = [
        "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"
        "sponsorblocker_ajay_app-browser-action"
        "_ddc62400-f22d-4dd3-8b4a-05837de53c2e_-browser-action"
        "_7c42eea1-b3e4-4be4-a56f-82a5852b12dc_-browser-action"
        "_e58d3966-3d76-4cd9-8552-1582fbc800c1_-browser-action"
        "addon_darkreader_org-browser-action"
        "search_kagi_com-browser-action"
        "_c84d89d9-a826-4015-957b-affebd9eb603_-browser-action"
      ];
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
        "_3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf_-browser-action"
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
    seen = [
      "developer-button"
      "screenshot-button"
      "_7c42eea1-b3e4-4be4-a56f-82a5852b12dc_-browser-action"
      "ublock0_raymondhill_net-browser-action"
      "_ddc62400-f22d-4dd3-8b4a-05837de53c2e_-browser-action"
      "sponsorblocker_ajay_app-browser-action"
      "_e58d3966-3d76-4cd9-8552-1582fbc800c1_-browser-action"
      "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
      "vpn_proton_ch-browser-action"
      "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"
      "addon_darkreader_org-browser-action"
      "_3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf_-browser-action"
      "search_kagi_com-browser-action"
      "_c84d89d9-a826-4015-957b-affebd9eb603_-browser-action"
    ];
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
    newElementCount = 3;
  };

  "general.autoScroll" = true;
  "services.sync.declinedEngines" = "history,forms,tabs";
  "services.sync.engine.history" = false;
  "services.sync.engine.tabs" = false;
  "signon.rememberSignons" = false;

  # --- SuperPins & Layout ---
  "uc.essentials.gap" = "Normal";
  "uc.essentials.transition-speed" = "100ms";
  "uc.essentials.width" = "Normal";
  "uc.pins.active-bg" = false;
  "uc.pins.separator-at-bottom" = false;
  "uc.pins.transition-speed" = "100ms";
  "uc.tabs.dim-type" = "both";
  "uc.tabs.strikethrough-on-pending" = false;

  # --- Zen Urlbar & View Settings ---
  "zen.urlbar.behavior" = "normal";
  "zen.urlbar.replace-newtab" = false;
  "zen.view.compact.enable-at-startup" = false;
  "zen.view.use-single-toolbar" = false;
  "zen.workspaces.show-workspace-indicator" = true;

  # --- Search & Bookmarks Settings ---
  "browser.search.defaultenginename" = "Kagi Search";
  "browser.search.selectedEngine" = "Kagi Search";
  "browser.search.official" = false;
  "browser.search.update" = false;
  "browser.search.region" = "US";
  "browser.search.countryCode" = "US";
  "browser.toolbars.bookmarks.visibility" = "always";
}
