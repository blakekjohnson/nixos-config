{ config, pkgs, ...}: {
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = haskellPackages: [
      haskellPackages.xmobar
    ];
    config = pkgs.writeText "xmonad.hs" ''
      import XMonad

      import XMonad.Hooks.DynamicLog
      import XMonad.Hooks.EwmhDesktops
      import XMonad.Hooks.StatusBar
      import XMonad.Hooks.StatusBar.PP

      import XMonad.Util.EZConfig

      import XMonad.Layout.ThreeColumns

      import Graphics.X11.ExtraTypes.XF86

      main :: IO ()
      main = xmonad
           . ewmhFullscreen
           . ewmh
           . withEasySB (
              statusBarProp "xmobar" (pure blakeXmobarPP)) defToggleStrutsKey
           $ blakeConfig

      blakeLayout = threeCol ||| Full ||| tiled 
        where
          threeCol = ThreeColMid nmaster delta ratio
          tiled = Tall nmaster delta ratio
          nmaster = 1
          ratio = 1/2
          delta = 3/100

      xmonadCommand = "xmonad --recompile; killall xmobar; xmonad --restart; xmobar &"

      blakeConfig = def
          { borderWidth = 5
          , layoutHook = blakeLayout
          }
        `additionalKeysP`
          [("M-q", spawn xmonadCommand)
          , ("M-S-<Return>", spawn "alacritty")
          , ("M-P", spawn "dmenu_run")
          ]

      blakeXmobarPP :: PP
      blakeXmobarPP = def
    '';
  };
}

