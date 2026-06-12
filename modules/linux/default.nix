{ pkgs, ... }:

{
  imports = [
  ];

  # Linux packages
  home.packages = with pkgs; [
  ];

  # --- Hyprland Custom Configs ---
  xdg.configFile."hypr/custom/keybinds.lua".text = ''
    hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("zeditor ~/GitHub/dotfiles/modules/linux/default.nix"), {description = "Edit user keybinds"} )

    -- App shortcuts
    hl.bind("F1", hl.dsp.exec_cmd("kitty"))
    hl.bind("F2", hl.dsp.exec_cmd("zen-beta"))
    hl.bind("F3", hl.dsp.exec_cmd("equibop"))
    hl.bind("F4", hl.dsp.exec_cmd("spotify"))
    hl.bind("F5", hl.dsp.exec_cmd("zeditor"))
  '';

  xdg.configFile."hypr/custom/general.lua".text = ''
    hl.config({
        input = {
            sensitivity = 5
        }
    })
  '';

  # --- Fish ---
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting "" # Disable the welcome message
    '';
  };

}
