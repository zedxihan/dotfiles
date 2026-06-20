{ ... }:

{
  # --- Hyprland Custom Configs ---
  # Keybinds
  xdg.configFile."hypr/custom/keybinds.lua".text = ''
    hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("zeditor ~/GitHub/dotfiles/modules/linux/hyprland.nix"), {description = "Edit user keybinds"} )

    -- App shortcuts
    hl.bind("F1", hl.dsp.exec_cmd("kitty"))
    hl.bind("F2", hl.dsp.exec_cmd("zen-beta"))
    hl.bind("F3", hl.dsp.exec_cmd("equibop"))
    hl.bind("F4", hl.dsp.exec_cmd("com.spotify.Client"))
    hl.bind("F5", hl.dsp.exec_cmd("zeditor"))
  '';

  # General
  xdg.configFile."hypr/custom/general.lua".text = ''
    hl.config({
        input = {
            sensitivity = 5
        }
    })
  '';

  # Execs
  xdg.configFile."hypr/custom/execs.lua".text = ''
    hl.on("hyprland.start", function()
        hl.exec_cmd("kdeconnect-indicator")
    end)
  '';
}
