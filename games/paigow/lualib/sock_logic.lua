-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local skynet = require "skynet"
local cjson = require "cjson"
local socket = require "socket"
local packet = require "packet"

local M = {
    dispatch_call = {}
}

function M:start(conf)
    self.gate = skynet.newservice("gate")
    skynet.call(self.gate, "lua", "open", conf)
    skynet.error("login service listen on port "..conf.port)
end

function M:open(fd, addr)
    skynet.error("New client from : " .. addr)
    skynet.call(self.gate, "lua", "accept", fd)
end

function M:close(fd)
    self:close_conn(fd)
    skynet.error("socket close "..fd)
end

function M:error(fd, msg)
    self:close_conn(fd)
    skynet.error("socket error "..fd.." msg "..msg)
end

function M:warning(fd, size)
    self:close_conn(fd)
    skynet.error(string.format("%dK bytes havn't send out in fd=%d", size, fd))
end

function M:data(fd, msg)
    local len = string.len(msg)
    if len <= 24 then
        -- packet len < 24
        socket.write(fd, packet:pack(0x7001, sessionid, { status=0, msgtype=7001 }))
        return
    end
    local cmd, sessionid, body = packet:unpack(msg)
    if cmd == false then
        -- packet unpack false
        socket.write(fd, packet:pack(0x7002, sessionid, { status=0, msgtype=7002 }))
        return
    end
    --local token = mredis:getInstance():get(rediskey:user_token(sessionid), data)
    --if token ~= body.token then
    --	  socket.write(fd, packet:pack(0x7004, sessionid, { status=0, msgtype=9004 }))
    --	  return
    --end
    --table.remove(body, token)
    --if sessionid then
    --    mredis:getInstance():set(rediskey:user_use_fd(sessionid), fd)
    --end
    self:dispatch(fd, cmd, sessionid, body)
end

function M:close_conn(fd)
    fd = nil
end

function M:dispatch(fd, cmd, sessionid, body)
    local c = self.dispatch_call[cmd]
    if c == nil then
        socket.write(fd, packet:pack(0x7003, sessionid, { status=0, msgtype=7003 }))
    else
        local result = c.func(c.obj, fd, cmd, sessionid, body)
        if result then
            socket.write(fd, result)
        else
            socket.write(fd, packet:pack(0x7003, sessionid, { status=0, msgtype=7005 }))
        end
    end
end

return M
