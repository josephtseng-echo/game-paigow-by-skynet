local skynet = require "skynet"
local utils = require "utils"
local cjson = require "cjson"
local mdb = require "mdb"
local mredis = require "mredis"
local md5 = require "md5"

local M = {}

function M:login(param, user_online_lists)
	local name = param.name
	local mokey = param.mokey
	local siteid  = utils:toInt(param.siteid)
    local sitetype = utils:toInt(param.sitetype) or 1
    local sid = utils:toInt(param.sid) or 1
    local nowtime = os.time()
    local client_ip = "127.0.0.1"
    local sql = ""
    local sql_where = " WHERE site_id="..
        siteid.." AND user_sid="..sid.." AND site_type="..sitetype.." "
    sql = "UPDATE `user_info` SET user_lastlogintime="..nowtime..
    ", user_lastloginip='"..client_ip.."' "..sql_where
	local res = mdb:getInstance():query(sql)
	if res.affected_rows ~= 1 then
        -- TODO 第一次注册 需要入库操作
        sql = "INSERT INTO `user_info`(site_id, user_sid, site_type, user_name,"..
        "user_createtime, user_updatetime, user_lastlogintime, user_lastloginip,"..
        "user_channel, site_channel, user_icon) VALUES('"..siteid.."', '"..sid.."',"..
        "'"..sitetype.."', '"..name.."', "..nowtime..","..nowtime..","..nowtime..","..
        "'"..client_ip.."','1', '1', 'icon')"
        res = mdb:getInstance():query(sql)
        if res.affected_rows == 1 then
            local insert_id = res.insert_id
            if insert_id then
                sql = "INSERT INTO `user_game`(user_id) VALUES("..insert_id..")"
                res = mdb:getInstance():query(sql)
            end
        else
        end
    end
    sql = "SELECT a.*, b.* FROM `user_info` AS a"..
        " LEFT JOIN `user_game` AS b ON a.user_id = b.user_id WHERE "..
        " a.user_sid="..sid.." AND a.site_type="..sitetype.." AND a.site_id='"..siteid.."' LIMIT 0, 1"
    res = mdb:getInstance():query(sql)
    return res[1]
end

return M
