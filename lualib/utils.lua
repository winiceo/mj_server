local M = {}

function M.str_2_table(str)
    local func_str = "return "..str
    local func = load(func_str)
    return func()
end

return M
