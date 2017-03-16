local skynet = require "skynet"

function main()
    skynet.newservice("debug_console", 8000)

    -- 登陆服务
    local login = skynet.newservice("login")
    skynet.call(login, "lua", "start", {
        port = 8888,
        maxclient = 1000,
        nodelay = true,
    })

    -- base_app_mgr
    skynet.uniqueservice("base_app_mgr")

    -- room_mgr
    skynet.uniqueservice("room_mgr")

    skynet.exit()
end

skynet.start(main)
