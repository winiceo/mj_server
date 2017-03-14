
local M = {}

function M:init()
    self.base_app_tbl = {}
end

-- 创建baseapp
function M:create_base_apps()
    for i=1,20 do
        local addr = skynet.newservice("base_app", i)
        local info = {
            addr = addr
        }

        self.base_app_tbl[addr] = info
    end
end

function M:get_base_app_info(addr)
    return self.base_app_tbl[addr]
end

return M
