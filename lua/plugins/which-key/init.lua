return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({})
    local groups = require("core.whichkey_groups")
    groups.register()
  end,
}
