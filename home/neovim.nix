{ config, pkgs, ...}: {
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
}

