{
  pkgs,
  inputs ? { },
  ...
}:

let
  nixGL = if inputs ? nixgl then inputs.nixgl.packages.${pkgs.system}.nixGLDefault else null;

  zed-pkg =
    if pkgs.stdenv.isLinux && nixGL != null then
      import ./wrapped.nix { inherit pkgs nixGL; }
    else
      pkgs.zed-editor;
in
{
  programs.zed-editor = {
    enable = true;
    package = zed-pkg;
    mutableUserSettings = true;
    userKeymaps = import ./keymaps.nix;

    extensions = [
      "nix"
      "lua"
      "yaml"
      "json"
      "bash"
      "html"
      "css"
      "catppuccin"
      "catppuccin-icons"
      "macos-classic"
      "git-firefly"
    ];

    userSettings = {
      # --- Appearance ---
      theme = "Catppuccin Macchiato";
      icon_theme = "Catppuccin Latte";
      vim_mode = false;
      buffer_font_size = 16;
      buffer_font_weight = 450;
      ui_font_size = 18;
      ui_font_weight = 500;

      # --- Agent ---
      agent = {
        # default_model = {
        #   provider = "google";
        #   model = "gemini-3.5-flash";
        # };
        enable_feedback = false;
        dock = "right";
      };
      agent_servers = {
        gemini = {
          type = "registry";
        };
      };
      edit_predictions = {
        allow_data_collection = "no";
      };

      # --- Panels ---
      project_panel = {
        dock = "left";
        git_status_indicator = true;
      };
      git_panel = {
        dock = "left";
        tree_view = true;
        file_icons = true;
      };
      collaboration_panel = {
        button = false;
      };

      # --- Layout ---
      tab_bar = {
        show = true;
        show_nav_history_buttons = false;
      };
      tabs = {
        show_close_button = "always";
        file_icons = true;
        git_status = true;
      };

      # --- Terminal ---
      terminal = {
        dock = "bottom";
        cursor_shape = "bar";
        default_height = 400;
        font_size = 18;
        shell = {
          program = "nu";
        };
        env = {
          TERM = "kitty";
        };
        working_directory = "current_project_directory";
      };

      # --- LSP ---
      load_direnv = "shell_hook";
      base_keymap = "VSCode";

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
      };

      # --- Privacy ---
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
    };
  };
}
