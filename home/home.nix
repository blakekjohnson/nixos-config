{ config, pkgs, ... }:

{
  home.username = "blakej";
  home.homeDirectory = "/home/blakej";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.dmenu
    pkgs.firefox
    pkgs.killall
  ];

  home.file = {
  };

  home.sessionVariables = {
    TERMINAL = "alacritty";
  };

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
  
  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "Full";
      font.normal = {
        family = "Fira Code";
      };
      font.bold = {
        family = "Fira Code";
      };
      font.italic = {
        family = "Fira Code";
      };
      font.bold_italic = {
        family = "Fira Code";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [];
      theme = "lukerandall";
    };
  };

  programs.git = {
    enable = true;
    userName = "Blake Johnson";
    userEmail = "blakekjohnson4@gmail.com";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = ''
          require('neo-tree').setup({
            event_handlers = {
              -- Close Neotree when file opened
              {
                event = 'file_open_requested',
                handler = function()
                  require('neo-tree.command').execute({ action = 'close' })
                end
              },
            }
          })
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup(
            {
              options = { theme = 'dracula-nvim' },
              sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
              }
            }
          )
        '';
      }
      {
        plugin = dracula-nvim;
        type = "lua";
        config = ''
          require("dracula").setup{}
          vim.cmd[[colorscheme dracula]]
        '';
      }
    ];
    extraConfig = ''
      :set number
      :set shiftwidth=2 smarttab
      :set expandtab
      :set tabstop=8 softtabstop=0
      nnoremap <C-1> <cmd>Neotree<CR>
    '';
  };

  programs.xmobar = {
    enable = true;
    extraConfig = ''
      Config {
          font = "Fira Code"
        , borderWidth = 3
        , bgColor = "#272a3b"
        , fgColor = "#f8f8f2"
        , position = TopSize C 100 24
        , persistent = True
        , commands =
            [ Run Cpu ["-t", "cpu: (<total>%)", "-H", "50", "--high", "red"] 10
            , Run Memory ["-t", "mem: (<usedratio>%)"] 10
            , Run Date "date: %a %d %b %Y %H:%M:%S" "date" 10
            ]
        }
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%cpu% | %memory% }{%date%"
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}