{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    package = null;

    # Static theme on Mac
    themeFile = if pkgs.stdenv.isDarwin then "Tokyo_Night" else null;

    font = {
      name = "JetBrains Mono Nerd Font";
      size = 15.0;
    };

    settings = {
      cursor_shape = "beam";
      cursor_trail = "1";
      window_margin_width = "21.75";
      confirm_os_window_close = "0";
      shell = "${pkgs.nushell}/bin/nu";
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";

      "ctrl+plus" = "change_font_size all +1";
      "ctrl+equal" = "change_font_size all +1";

      "ctrl+minus" = "change_font_size all -1";
      "ctrl+underscore" = "change_font_size all -1";

      "ctrl+0" = "change_font_size all 0";

      "ctrl+f" = "show_scrollback";
    };

    # Load Quickshell theme on illogical-impulse
    extraConfig =
      if pkgs.stdenv.isLinux then
        ''
          include ~/.local/state/quickshell/user/generated/terminal/kitty-theme.conf
        ''
      else
        "";
  };

}
