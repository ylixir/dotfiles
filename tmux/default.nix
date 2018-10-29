# Tmux with ./tmux.conf baked in
{ tmux, tmuxPlugins, writeText, symlinkJoin, makeWrapper }:
let
  customConf = builtins.toFile "custom.conf" ''
    ${builtins.readFile ./base.conf}
    run-shell ${tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux
  '';
in
symlinkJoin {
  name = "tmux";
  buildInputs = [makeWrapper];
  paths = [ tmux ];
  postBuild = ''
    mkdir $out/etc

    cat << EOF > $out/etc/tmux.conf

    ${builtins.readFile ./base.conf}
    set-option -g default-command "reattach-to-user-namespace -l bash"
    run-shell ${tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux
    bind-key -t vi-copy MouseDragEnd1Pane copy-pipe "reattach-to-user-namespace pbcopy"
    bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"

    EOF

    wrapProgram "$out/bin/tmux" \
      --add-flags "-f $out/etc/tmux.conf"
  '';
}
