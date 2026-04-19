return {
    "lualine.nvim",
    lazy = false,
    after = function()
        local function hello()
            return [[hello world]]
        end

        require("lualine").setup({
        })
    end
}
