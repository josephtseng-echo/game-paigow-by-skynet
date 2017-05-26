-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local hub = require "hub"
local service = require "service"

local CMD = {}

function CMD.start()
    hub:init()
    hub:create_game_server_list()
    hub:start_game_server_list()
end

service:start({ 
    cmd = CMD, 
    regname = "hub"
})
