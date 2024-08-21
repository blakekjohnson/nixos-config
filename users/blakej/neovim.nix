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
              options = { theme = 'everforest' },
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
        plugin = kanagawa-nvim;
        type = "lua";
        config = ''
          require('kanagawa').setup{}
          vim.cmd[[colorscheme kanagawa]]
        '';
      }
      (nvim-treesitter.withPlugins (p: [
        p.markdown
        p.nix
      ]))
    ];
    extraLuaConfig = ''
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      }
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

