require("url-open").setup({
    open_app = "default",
    open_only_when_cursor_on_url = false,
    highlight_url = {
        all_urls = {
            enabled = false,
            fg = "#ffb86c", -- "text" or "#rrggbb"
            -- fg = "text", -- text will set underline same color with text
            bg = nil, -- nil or "#rrggbb"
            underline = true,
        },
        cursor_move = {
            enabled = true,
            fg = "#ffb86c", -- "text" or "#rrggbb"
            -- fg = "text", -- text will set underline same color with text
            bg = nil, -- nil or "#rrggbb"
            underline = true,
        },
    },
    deep_pattern = false,
    -- a list of patterns to open url under cursor
    extra_patterns = {
        -- {
        -- 	  pattern = '["]([^%s]*)["]:%s*"[^"]*%d[%d%.]*"',
        -- 	  prefix = "https://www.npmjs.com/package/",
        -- 	  suffix = "",
        -- 	  file_patterns = { "package%.json" },
        -- 	  excluded_file_patterns = nil,
        -- 	  extra_condition = function(pattern_found)
        -- 	    return not vim.tbl_contains({ "version", "proxy" }, pattern_found)
        -- 	  end,
        -- },
		-- so the url will be https://www.npmjs.com/package/[pattern_found]


        -- {
        -- 	  pattern = '["]([^%s]*)["]:%s*"[^"]*%d[%d%.]*"',
        -- 	  prefix = "https://www.npmjs.com/package/",
        -- 	  suffix = "/issues",
        -- 	  file_patterns = { "package%.json" },
        -- 	  excluded_file_patterns = nil,
        -- 	  extra_condition = function(pattern_found)
        -- 	    return not vim.tbl_contains({ "version", "proxy" }, pattern_found)
        -- 	  end,
        -- },
		--
		-- so the url will be https://www.npmjs.com/package/[pattern_found]/issues
    },
})
