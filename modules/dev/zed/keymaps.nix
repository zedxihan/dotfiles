[
  {
    context = "Workspace";
    bindings = {
      "1 2" = "terminal_panel::Toggle";
      "alt-p" = "project_panel::Toggle";
      "alt-l" = "workspace::ToggleRightDock";
      "ctrl-b" = null;

    };
  }
  {
    context = "Editor";
    bindings = {
      "alt-shift-up" = "editor::DuplicateLineUp";
      "alt-shift-down" = "editor::DuplicateLineDown";
      "alt-up" = "editor::MoveLineUp";
      "alt-down" = "editor::MoveLineDown";
      "ctrl-alt-up" = [
        "editor::AddSelectionAbove"
        {
          "skip_soft_wrap" = true;
        }
      ];
      "ctrl-alt-down" = [
        "editor::AddSelectionBelow"
        {
          "skip_soft_wrap" = true;
        }
      ];
    };
  }
]
