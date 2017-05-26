-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local skynet = require "skynet"

local M = {}

function M:init()
  self.game_server_list = {}
end

function M:create_game_server_list()
  local ip = skynet.getenv "server_listen_ip"
  local port = skynet.getenv "server_listen_port"
  local nums = skynet.getenv "server_listen_nums"
  for i=1, nums do
    local addr = skynet.newservice("logic", i)
    local port = port + i - 1
    local info = {
      addr = addr,
      port = port
    }
    skynet.error("create glist - " ..info.port)
    self.game_server_list[addr] = info

  end
end

function M:start_game_server_list()
  for _,v in pairs(self.game_server_list) do
    skynet.call(v.addr, "lua", "start", {
      port = v.port,
      maxclient = 1000,
      nodelay = true,
    })
    skynet.error("call glist - " .. v.port)
  end
end

function M:get_info(addr)
  return self.game_server_list[addr]
end

return M
