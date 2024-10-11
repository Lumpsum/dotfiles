{ config, pkgs, ... }:

{
    imports = [
        ./k9s.nix
        ./tmux.nix
        ./wezterm.nix
        ./zsh.nix
    ];

    home.username = "rickvergunst";
    home.stateVersion = "24.05";
    home.homeDirectory = "/Users/rickvergunst";

    home.file = {
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
        ".config/nix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix";
        ".config/starship".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/starship";
    };

    home.packages = with pkgs; [
        slides
        zoxide
        fd
        google-cloud-sdk
        dive
        cue
        fzf
        neovim
        httpie
        lazygit
        kind
        opentofu
        ripgrep
        tmux
        watch
        pipx
        starship
        # oh-my-posh
    ];

    programs.git = {
        enable = true;
        userEmail = "vergunstje@hotmail.com";
        userName = "Lumpsum";
    };

    programs.yazi = {
        enable = true;
        enableZshIntegration = true;
    };

    home.sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "zen-browser";
    };

    programs.home-manager.enable = true;
}
