{ config, pkgs, ... }:

{
  home.username = "blakej";
  home.homeDirectory = "/home/blakej";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.firefox
  ];

  home.file = {
  };

  home.sessionVariables = {
    TERMINAL = "alacritty";
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
