-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local skynet = require "skynet"
local service = require "service"
local sock_logic = require "sock_logic"
--
local user = require "user"

local CMD = {}

function CMD.start(conf)
    sock_logic.dispatch_call[4097] = { func = user.login, obj = user }
    sock_logic:start(conf)
end

service:start({ 
    cmd = CMD,
    sock = sock_logic
})
