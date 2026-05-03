return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      nix = { "nixfmt" },
      terraform = { "terraform_fmt" },
      yaml = { "prettier" },
      dockerfile = { "prettier" },
      python = { "ruff_format" },
      c = { "clang_format" },
    },
  },
}
