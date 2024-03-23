# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


let  
 unstable-pkgs = import <nixpkgs-unstable> {config.allowUnfree = true;};  
in  
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;

  hardware.bluetooth.enable = true; # Enables bluetooth support
  #hardware.bluetooth.powerOnboot = true; # does not work
  services.blueman.enable = true;

  programs.zsh.enable = true; # enable zsh system wide
  users.defaultUserShell = pkgs.zsh;

  enviroment.sessionVariables = rec {
  	XDG_CONFIG_HOME = "$HOME/.config";
	XDG_BIN_HOME = "$Home/.local/bin";
	Path = [
	"${XDG_BIN_HOME}"
	];
  }
  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.edgelordkirito = {
    isNormalUser = true;
    description = "Till Leiteritz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Calculator 
    bc
    gnome.gnome-calculator
    # Image Processing
    gimp
    krita
    # Text Processing
    neovim
    # Version Control
    git
    # File Interaction
    lf
    yazi
    pcmanfm
    # Terminals
    tmux
    #Shel};l
    zsh # might conflict with the added option for zsh
    # GUI Enviroment
    picom
    rofi
    starship
    feh
    lxappearance
    wallust
    # Gtk Themes
    arc-theme
    # Cursor Themes
    quintom-cursor-theme
    # Icon Themes
    papirus-icon-theme
    # Web
    firefox
    #Fonts
    #nerdfonts # Test if this is needed if fonts are listed separetly
    # Misc
    obsidian
    pika-backup
    # In Testing
    i3blocks
    alejandra
    # Coding
    dotnet-sdk_8
    jdk17
    rustup
    # ShellApps
    stow
    tree
    neofetch
    ookla-speedtest
    wget
    bottom
    #ncmcpp
    gnupg1orig
    killall
    inxi
  ] ++ (with unstable-pkgs; [
    alacritty
  ]);

  nixpkgs.config.permittedInsecurePackages = [
        "electron-25.9.0"
  ];

  programs.neovim = {
  	enable = true;
  	defaultEditor = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
  	fira-code
	fira-code-symbols
	nerdfonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


#  programs.nix-ld.eable = true;
#  programs.nix-ld.libraries = with pkgs; [
#	# Add any missing dynamic libraries for unpackaged
#	# programs here, Not in enviroment.systemPackages
#  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
