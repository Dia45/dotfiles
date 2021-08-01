{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
#    displayManager.startx.enable = true;
    windowManager.xmonad = {
      enable = true;
      config = ./config.hs;
      extraPackages = hp: [
        hp.xmonad-contrib
      ];
    };
  };

  home-manager.users.dia45 = {

    home.packages = with pkgs; [
      flameshot # Screenshots
      wmctrl # Helper for window managers
      xorg.xmessage # Xmonad uses this to show help
      xmobar # Status bar for xmonad
      nitrogen # Wallpaper setter
      xbanish # Hides the mouse when using the keyboard
      betterlockscreen # Screen locker
    ];

    home.file = {
      ".xmobarrc".source = ./xmobar.hs;
    };
  };
}
