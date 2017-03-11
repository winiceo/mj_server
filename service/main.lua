local skynet = require "skynet"

function main()
    skynet.newservice("debug_console", 8000)

    skynet.newservice("login")

    local watchdog = skynet.newservice("watchdog")
    skynet.call(watchdog, "lua", "start", {
        port = 8888,
        maxclient = 1000,
        nodelay = true,
    })
    skynet.error("Watchdog listen on", 8888)

    skynet.exit()
end

skynet.start(main)
