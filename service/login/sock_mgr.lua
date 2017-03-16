local skynet = require "skynet"
local utils = require "utils"

local M = {}

function M:start(conf)
    self.gate = skynet.newservice("gate")

    skynet.call(gate, "lua", "open", conf)

    skynet.error("login service listen on port "..conf.port)
end

-------------------处理socket消息开始--------------------
function M:open(fd, addr)
    skynet.error("New client from : " .. addr)
end

function M:close(fd)
    skynet.error("socket close "..fd)
end

function M:error(fd, msg)
    skynet.error("socket error "..fd)
end

function M:warning(fd, size)
    -- size K bytes havn't send out in fd
    skynet.error("socket warning "..fd)
end

function M:data(fd, msg)
    skynet.error("socket data fd "..fd)
    local proto_id, params = string.unpack(">Hs2", msg)

    params = utils.str_2_table(params)

    self:dispatch(proto_id, params)
end
-------------------处理socket消息结束--------------------

-------------------网络消息回调函数开始------------------
function M:register_callback()
    self.dispatch_tbl = {
        [1] = self.login,
        [2] = self.register
    }
end

function M:dispatch(proto_id, params)
    local f = self.dispatch_tbl[proto_id]
    if not f then
        return
    end

    f(self, skynet.unpack(params))
end

function M:login(account, passwd)

end

function M:register(account, passwd)

end
-------------------网络消息回调函数结束------------------

return M

