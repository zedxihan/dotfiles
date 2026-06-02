{ pkgs, nixGL }:

pkgs.symlinkJoin {
  name = "zed-wrapped";
  paths = [ pkgs.zed-editor ];
  postBuild = ''
    rm $out/bin/zeditor
    echo -e "#!/bin/sh\nexec ${nixGL}/bin/nixGL ${pkgs.zed-editor}/bin/zeditor \"\$@\"" > $out/bin/zeditor
    chmod +x $out/bin/zeditor
    ln -sf zeditor $out/bin/zed
  '';
}
