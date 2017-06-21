-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local skynet = require "skynet"
local service = require "service"
local sock_logic = require "sock_logic"
--
local user = require "user"
local tbl = require "tbl"
local player = require "player"
local push = require "push"

local CMD = {}

function CMD.start(conf)
    -- 0x101 user login
    sock_logic.dispatch_call[257] = { func = user.login, obj = user }
    -- 0x102 user info
    sock_logic.dispatch_call[258] = { func = user.info, obj = user }
    -- 0x103 user logout
    sock_logic.dispatch_call[259] = { func = user.logout, obj = user }
    -- 0x104 user update
    sock_logic.dispatch_call[260] = { func = user.update, obj = user }
    -- 0x201 user create table
    sock_logic.dispatch_call[513] = { func = tbl.create, obj = tbl } 
    -- 0x202 user join table
    sock_logic.dispatch_call[514] = { func = tbl.join, obj = tbl }
    -- 0x203 user delete table
    sock_logic.dispatch_call[515] = { func = tbl.delete, obj = tbl }
    -- 0x301 player kick 
    sock_logic.dispatch_call[769] = { func = player.kick, obj = player }
    -- 0x302 player ready 
    sock_logic.dispatch_call[770] = { func = player.ready, obj = player }
    -- 0x303 player start
    sock_logic.dispatch_call[771] = { func = player.start, obj = player }
    -- 0x304 player deal
    sock_logic.dispatch_call[772] = { func = player.deal, obj = player }
    -- 0x305 player play
    sock_logic.dispatch_call[773] = { func = player.play, obj = player }
    -- 0x306 player take
    sock_logic.dispatch_call[774] = { func = player.take, obj = player }
    -- 0x306 player finish
    sock_logic.dispatch_call[775] = { func = player.finish, obj = player }
    -- 0x401 push send
    sock_logic.dispatch_call[1025] = { func = push.send, obj = push }
    sock_logic:start(conf)
end

service:start({ 
    cmd = CMD,
    sock = sock_logic
})
