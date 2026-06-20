{ pkgs, wrapNixGL, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in
{
  programs.kitty = {
    enable = true;
    package = wrapNixGL (if isDarwin then pkgs.kitty else null);

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

      macos_option_as_alt = "both";
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";

      "ctrl+plus" = "change_font_size all +1";
      "ctrl+minus" = "change_font_size all -1";
      "ctrl+0" = "change_font_size all 0";

      "ctrl+f" = "show_scrollback";
    };

    extraConfig = ''
      include ~/.config/kitty/matugen-theme.conf
    '';
  };
}
