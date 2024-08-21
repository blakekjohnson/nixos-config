{ config, pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup(
            {
              options = { theme = 'dracula-nvim' },
              sections = {
                lualine_a = { 'mode' },
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
          require('dracula').setup{}
          vim.cmd[[colorscheme dracula]]
        '';
      }
      lsp-zero-nvim
      nvim-lspconfig
    ];
    extraLuaConfig = ''
      local lsp_zero = require('lsp-zero');
      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({buffer = bbufnr})
      end)
    '';
    extraConfig = ''
      :set number
      :set shiftwidth=2 smarttab
      :set expandtab
      :set tabstop=8 softtabstop=0
      nnoremap <C-L><C-L> :set invrelativenumber<CR>
    '';
  };
}

