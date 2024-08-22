{ config, pkgs, ...}: {
  home.packages = with pkgs; [
    pkgs.marksman
    pkgs.ripgrep
  ];

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
        p.bash
        p.markdown
        p.markdown-inline
        p.nix
      ]))
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          require'lspconfig'.marksman.setup{}
        '';
      }
      cmp-nvim-lsp
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require'cmp'
          cmp.setup{
            snippet = {
              expand = function(args)
                vim.snippet.expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              },
	      ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
		  cmp.select_next_item()
		else
		  fallback()
		end
	      end, { 'i', 's' }),
	      ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
		  cmp.select_prev_item()
		else
		  fallback()
		end
	      end, { 'i', 's' }),
            }),
            sources = {
              { name = 'nvim_lsp' },
            }
          }
        '';
      }
      plenary-nvim
      telescope-nvim
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

      vim.opt.conceallevel = 2
    '';
    extraConfig = ''
      :set number
      :set shiftwidth=2 smarttab
      :set expandtab
      :set tabstop=8 softtabstop=0
      :set mouse=
      nnoremap <C-L><C-L> :set invrelativenumber<CR>

      nnoremap <leader>ff <cmd>Telescope find_files<CR>
      nnoremap <leader>fb <cmd>Telescope buffers<CR>
      nnoremap <leader>fg <cmd>Telescope live_grep<CR>
      nnoremap <leader>fh <cmd>Telescope help_tags<CR>
      nnoremap <leader>ft <cmd>Telescope treesitter<CR>
    '';
  };
}

