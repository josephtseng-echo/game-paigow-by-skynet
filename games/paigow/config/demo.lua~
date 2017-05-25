-- 牌九
-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--
game_name = "paigow"

server_listen_ip = "127.0.0.1"
server_maxclient = 1000
server_listen_port = 9001
-- example 9001 9002 9003 9004 9005
server_listen_nums = 5

-- config settings
thread = 8
harbor = 0
--address = "127.0.0.1:2526"
--master = "127.0.0.1:2013"
start = "main"
bootstrap = "snlua bootstrap"
--standalone = "0.0.0.0:2013"

-- config root path
root = "./"
game_root = root .. "games/" .. game_name .. "/"
skynet_name = "skynet/"
skynet_root = root .. skynet_name
luaservice = game_root .. "service/?.lua;" .. game_root .. "service/?/main.lua;" .. skynet_root .."service/?.lua"
lualoader = skynet_root .. "lualib/loader.lua"
lua_path = game_root .. "lualib/?.lua;" .. skynet_root .. "lualib/?.lua;" .. skynet_root .. "lualib/?/init.lua"
lua_cpath = game_root .. "luaclib/?.so;" .. skynet_root .. "luaclib/?.so"
cpath = game_root .. "cservice/?.so;"..skynet_root.."cservice/?.so"
logpath = game_root .. "logs"
-- logger = game_root .. "logs/skynet.log"
-- daemon = game_root .. "run/skynet.pid"
