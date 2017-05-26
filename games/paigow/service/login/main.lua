-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local service = require "service"
local user = require "user"
local utils = require "utils"
local serverlist = {}
local user_online_lists = {}
local CMD = {}

local function serverlist_data_init(param)
    local ip = service:getenv("server_listen_ip")
    local port = service:getenv("server_listen_port")
    local nums = service:getenv("server_listen_nums")
    for i = 1, nums do
        local c = {
            ip = ip,
            port = port + i - 1
        }
        table.insert(serverlist, c)
    end
end

function CMD.login(param)
    local r = {}
    r.row = user:login(param, user_online_lists)
    r.serverlist = serverlist
    return r
end

service:start({ 
    cmd = CMD, 
    regname = "login",
    callfuncs = { 
        {func = serverlist_data_init, param = {} }
    }
})
