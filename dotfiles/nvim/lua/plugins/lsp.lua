return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      nil_ls = { mason = false },
      pyright = { mason = false },
      yamlls = { mason = false },
      dockerls = { mason = false },
      docker_compose_language_service = { mason = false },
      clangd = { mason = false },
      terraformls = { mason = false },
      tofuls = { mason = false },
      tinymst = { mason = false },
      rustfmt = { mason = false },
      ["rust-analyzer"] = { mason = false },
      cippy = { mason = false },
    },
  },
}
