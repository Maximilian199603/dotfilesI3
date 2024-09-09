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

  networking.hostName = "TheMachine"; # Define your hostname.
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

  hardware.opengl.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  services.xserver.enable = true;
  services.xserver.resolutions = [
  	{
  		x = 1920;
  		y = 1080;
  	}
	{
		x = 1920;
		y = 1080;
	}
  ];
  services.xserver.displayManager.lightdm.greeters.gtk.enable = true;
  services.xserver.displayManager.lightdm.background = "/$HOME/Pictures/Wallpapers/Akiakane-2.jpg";
  services.xserver.windowManager.i3.enable = true;
  programs.i3lock.enable = true;
  services.picom = {
   enable = true;
  };
  environment.localBinInPath = true;

  hardware.bluetooth.enable = true; # Enables bluetooth support
  #hardware.bluetooth.powerOnboot = true; # does not work
  services.blueman.enable = true;
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
  	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	jack.enable = true;
  };

  programs.zsh.enable = true; # enable zsh system wide
  users.defaultUserShell = pkgs.zsh;

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
    # File Manager
    yazi
    # Terminals
    tmux
    kitty
    #Shell
    zsh 
    # GUI Enviroment
    mesa
    picom
    rofi
    starship
    feh
    lxappearance
    wallust
    i3blocks
    # Gtk Themes
    arc-theme
    # Cursor Themes
    quintom-cursor-theme
    # Icon Themes
    papirus-icon-theme
    # Web
    firefox
    # Misc
    obsidian
    pika-backup
    # In Testing
    alejandra
    # Coding
    dotnet-sdk_8
    jdk17
    rustup
    # ShellApps
    stow
    tree
    neofetch
    fastfetch
    ookla-speedtest
    wget
    bottom
    #ncmcpp
    gnupg1orig
    killall
    inxi
  ] ++ (with unstable-pkgs; [
     
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

  environment.variables =
  {
  	EDITOR = "nvim";
	TERMINAL = "kitty";
  };

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
  system.stateVersion = "24.05"; # Did you read the comment?

}
