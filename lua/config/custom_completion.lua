local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

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
ls.filetype_extend("cpp", { "c" })
