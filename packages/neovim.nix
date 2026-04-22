{ pkgs, neovim-config, ... }:

{
  home = {
    packages = with pkgs; [
      unstable.neovim
      tree-sitter
    ];
    sessionVariables.EDITOR = "${pkgs.unstable.neovim}/bin/nvim";
  };
  xdg.configFile.nvim = {
    source = neovim-config;
    recursive = true;
  };
}
