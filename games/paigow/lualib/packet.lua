-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local cjson = require "cjson"
local crc32 = require "crc32"

local M = {}

function M:unpack(packet)
  local cmd, sessionid, crc32no, bodystr = string.unpack(">hLLs2", packet)
  crc32check = crc32.Hash(bodystr)
  if tonumber(crc32check) ~= tonumber(crc32no) then
    return false
  end
  local body = cjson.decode(bodystr)
  return cmd, sessionid, body
end

function M:pack(cmd, sessionid, body)
    local cmd = cmd or '0x0000'
    local body = cjson.encode(body)
    local sessionid = sessionid or 0
    local crc32no = tonumber(crc32.Hash(body))
    local bodystr = body
    local len = 20 + #bodystr
    local packet = string.pack(">HhLLs2", len, cmd, sessionid, crc32no, bodystr)
    return packet
end

return M
