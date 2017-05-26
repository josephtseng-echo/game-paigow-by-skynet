-- service.lua
-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local skynet = require "skynet"
require "skynet.manager"

local M = {}

function M:getenv(name)
    return skynet.getenv(name)
end

function M:main(data)
    skynet.start(function()
    skynet.newservice("debug_console", 8000)
        for _, val in ipairs(data.uniqueservicelist) do
            if val.name ~= nil then
                skynet.uniqueservice(val.name)
                if val.call ~= nil then
                    skynet.call(val.name, "lua", val.call)
                end
            end
        end
        skynet.exit()
    end)
end

function M:start(data)
    local CMD = data.cmd
    local SOCK = data.sock
    skynet.start(function()
        skynet.dispatch("lua", function(_, session, cmd, subcmd, ...)
            if SOCK ~= nil then
                if cmd == "socket" then
                    SOCK[subcmd](SOCK, ...)
                    return
                end
            end
            local f = CMD[cmd]
            assert(f, "Unknown cmd : [%s] ", cmd)
            if session > 0 then
                return skynet.ret(skynet.pack(f(subcmd, ...)))
            else
			    skynet.response()(false)
            end
        end)

        if data.callfuncs ~= nil then
            for _, val in ipairs(data.callfuncs) do
                val.func(val.param)
            end
        end
        if data.regname ~= nil then
            skynet.register(data.regname)
            skynet.error("service "..data.regname.." register success!")
        end
    end)
end

return M
