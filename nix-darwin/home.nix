{ config, pkgs, ... }:

{
    home.username = "rickvergunst";
    home.stateVersion = "23.05";
    home.homeDirectory = "/Users/rickvergunst";

    programs.home-manager.enable = true;

    home.file = {
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/zshrc/.zshrc";
        ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/tmux/.tmux.conf";
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
        ".config/nix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix";
        ".config/nix-darwin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix-darwin";
        ".config/k9s".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/k9s";
        ".config/yazi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/yazi";
        ".config/starship".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/starship";
    };
}
