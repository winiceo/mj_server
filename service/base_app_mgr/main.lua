local skynet = require "skynet"
require "skynet.manager"
local base_app_mgr = require "base_app_mgr"
local account_mgr = require "account_mgr"

local CMD = {}

function CMD.start()
    -- 初始化玩家管理器
    account_mgr:init()

    -- 初始化base_app_mgr
    base_app_mgr:init()
    base_app_mgr:create_base_apps()
end

-- 玩家登陆成功
function CMD.on_login_success()

end

local function lua_dispatch(src, session, cmd, ...)
    local f = CMD[cmd]
    assert(f, "base_app_mgr can't dispatch cmd ".. (cmd or nil))

    if session > 0 then
        skynet.ret(skynet.pack(f(...)))
    else
        f(...)
    end
end

local function init()
    skynet.register("base_app_mgr")

    skynet.dispatch("lua", lua_dispatch)
end

skynet.start(init)
