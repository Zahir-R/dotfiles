return {
  {
    "benlubas/molten-nvim",
    dependencies = { "3rd/image.nvim" },
    build = function()
      local plugin = vim.fn.stdpath("data") .. "/lazy/molten-nvim"
      local patch = vim.fn.stdpath("config") .. "/lua/plugins/molten.patch"
      if vim.fn.filereadable(patch) == 1 then
        vim.fn.system("patch -d " .. vim.fn.shellescape(plugin) .. " -p1 -N < " .. vim.fn.shellescape(patch))
      end
      vim.cmd("UpdateRemotePlugins")
    end,
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 50
      vim.g.molten_output_win_max_width = 999999
      -- vim.g.molten_output_win_hide_on_leave = false
      vim.g.molten_enter_output_behavior = "no_open"
      vim.g.molten_auto_open_output = false
      vim.g.molten_use_border_highlights = true
      vim.g.molten_output_virt_lines = false
    end,
    config = function()
      local map = vim.keymap.set
      map("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Molten: init kernel" })
      map("n", "<localleader>mr", function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        local start, finish
        for i, line in ipairs(lines) do
          if line:match("^# %%") then
            if i <= cur then
              start = i
            elseif not finish then
              finish = i - 1
            end
          end
        end
        if not start then start = 1 end
        if not finish then finish = #lines end
        if lines[start]:match("^# %%%s*\\[markdown\\]") then
          vim.notify("Markdown cell - not evaluated", vim.log.levels.INFO)
          return
        end
        vim.fn["MoltenEvaluateRange"](start, finish)
      end, { desc = "Molten: run cell" })
      map("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", { desc = "Molten: evaluate line" })
      map("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "Molten: re-evaluate cell" })
      map("n", "<localleader>mR", ":MoltenRestart!<CR>", { desc = "Molten: restart kernel" })
      map("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "Molten: delete cell" })
      map("n", "<localleader>mh", ":MoltenShowOutput<CR>", { desc = "Molten: show cell output" })
      map("n", "<localleader>me", ":MoltenEnterOutput<CR>", { desc = "Molten: enter output window" })
      map("n", "<localleader>mo", ":MoltenExportOutput!<CR>", { desc = "Molten: export output to notebook" })
      map("n", "<localleader>mO", ":MoltenImportOutput<CR>", { desc = "Molten: import notebook output" })
      map("v", "<localleader>mr", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Molten: run selection" })
    end,
  },
  {
    "3rd/image.nvim",
    opts = {
      backend = "ueberzug",
    },
  },
}
