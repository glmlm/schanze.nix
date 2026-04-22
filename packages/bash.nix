{
  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ../dotfiles/.bashrc;
  };
}
