local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local t = ls.text_node

local function header_guard()
    local filename = vim.fn.expand("%:t:r") -- 文件名(无扩展名)

    filename = filename
        :gsub("([a-z])([A-Z])", "%1_%2") -- CamelCase -> Camel_Case
        :gsub("[^%w]", "_")
        :upper()

    return "__" .. filename .. "_H__"
end

ls.add_snippets("c", {
    s("guard", fmt([[
#ifndef {}
#define {}

#ifdef __cplusplus
extern "C" {{
#endif

{}

#ifdef __cplusplus
}}
#endif

#endif /* {} */
]], {
        f(header_guard),
        f(header_guard),
        ls.insert_node(1),
        f(header_guard),
    })),
})

-- For循环快速补全
ls.add_snippets("c", {
    s("foru8", fmt([[
    for (uint8_t i = 0; i < {}; i++){{

    }}
    ]], { i(1)}))
})

ls.add_snippets("c", {
    s("foru16", fmt([[
    for (uint16_t i = 0; i < {}; i++){{

    }}
    ]], { i(1)}))
})

ls.add_snippets("c", {
    s("foru32", fmt([[
    for (uint32_t i = 0; i < {}; i++){{

    }}
    ]], { i(1)}))
})

-- 快速注释
ls.add_snippets("c", {
    s("cmt", fmt([[
    /*{}*/
    ]], { i(1)}))
})


ls.filetype_extend("cpp", { "c" })
