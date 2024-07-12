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
      import XMonad.Layout.Spacing

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
          { borderWidth = 0
          , layoutHook = spacingWithEdge 5 $ blakeLayout
          }
        `additionalKeysP`
          [("M-q", spawn xmonadCommand)
          , ("M-S-<Return>", spawn "alacritty")
          , ("C-S-c", spawn "scrot")
          , ("M-p", spawn "rofi -show run")
          , ("C-M-l", spawn "dm-tool lock")
          ]

      blakeXmobarPP :: PP
      blakeXmobarPP = def
    '';
  };
}

