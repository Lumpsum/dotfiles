{ pkgs, ... }: 

{
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = [
        pkgs.vim
        pkgs.eza
        pkgs.yazi
    ];

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    # services.karabiner-elements.enable = true;
    # nix.package = pkgs.nix;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh.enable = true;  # default shell on catalina
    # programs.fish.enable = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";

    users.users.rickvergunst = {
        name = "rickvergunst";
        home = "/Users/rickvergunst";
    };

    homebrew.enable = true;
    homebrew.taps = [
        {
            name = "zen-browser/browser";
            clone_target = "https://github.com/zen-browser/desktop.git";
        }
        ];
        homebrew.brews = [
        "helm"
    ];
    homebrew.casks = [
        "dbeaver-community"
        "font-hack-nerd-font"
        "rectangle"
        "slack"
        "whatsapp"
        "docker"
        "discord"
        "spotify"
    ];
}
