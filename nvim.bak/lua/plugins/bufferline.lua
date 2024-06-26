return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
        { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete Other Buffers" },
        { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
        { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
        { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
        { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
        { "öb",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
        { "äb",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
    },
    opts = {
        options = {
            close_command = function(n) require("mini.bufremove").delete(n, false) end,
            right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
            diagnostics = "nvim_lsp",
            always_show_bufferline = true,
            -- diagnostics_indicator = function(_, _, diag)
            --     local icons = require("lazyvim.config").icons.diagnostics
            --     local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            --         .. (diag.warning and icons.Warn .. diag.warning or "")
            --     return vim.trim(ret)
            -- end,
            -- offsets = {
            --     {
            --         filetype = "neo-tree",
            --         text = "Neo-tree",
            --         highlight = "Directory",
            --         text_align = "left",
            --     },
            -- },
            indicator = {
                style = 'underline'
            }
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
    end,
}
