local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    "tpope/vim-fugitive", -- Git wrapper for vim
    "rhysd/conflict-marker.vim", -- weapon to fight against merge conflicts
    "rhysd/git-messenger.vim", -- Shows commit message under cursor
    {
      "lewis6991/gitsigns.nvim", -- Similar to fugitive, but adds additiona functionality
      event = "VeryLazy",
      config = function()
        require("gitsigns").setup({
          signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
          },
        })
      end,
    },
    {
      "mfussenegger/nvim-lint",
      event = {
        "BufReadPre",
        "BufNewFile",
      },
      config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
          javascript = { "eslint_d" },
          typescript = { "eslint_d" },
          javascriptreact = { "eslint_d" },
          typescriptreact = { "eslint_d" },
          svelte = { "eslint_d" },
          kotlin = { "ktlint" },
          terraform = { "tflint" },
          ruby = { "standardrb" },
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
          group = lint_augroup,
          callback = function()
            lint.try_lint()
          end,
        })

        vim.keymap.set("n", "<leader>ll", function()
          lint.try_lint()
        end, { desc = "Trigger linting for current file" })
      end,
    },
    {
      "ErickKramer/nvim-ros2",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      opts = {
        -- Add any custom options here
        autocmds = true,
        telescope = true,
        treesitter = true,
      },
    },
    {
      "sindrets/diffview.nvim", -- Single tabpage interface for easily cycling through diffs
      event = "VeryLazy",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    { -- Quick selection of co-authors
      "ErickKramer/git-coauthors.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
      },
    },

    -- INFO: Enhance Editor Experience
    {
      "iamcco/markdown-preview.nvim", -- Markdown previewer
      -- event = "VeryLazy",
      build = function()
        vim.fn["mkdp#util#install"]()
      end,
      config = function()
        -- Refresh markdown when saving the buffer or leaving insert mode
        vim.g.mkdp_refresh_slow = 1

        -- Fancy title
        vim.g.mkdp_page_title = "「${name}」"

        -- Dark mode (of course)
        vim.g.mkdp_theme = "dark"

        -- Avoid auto close
        vim.g.mkdp_auto_close = 0

        vim.g.mkdp_combine_preview = 1
        vim.g.mkdp_combine_preview_auto_refresh = 1
      end,
    },
    "mg979/vim-visual-multi", -- Enable multicursor
    --=========================================================

    -- import/override with your plugins
    { import = "plugins" },
  },

  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
