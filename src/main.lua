
cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")

--添加update更新路径
require("cocos.init")

local versionStr = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath().. "version.ini")
local version = nil

local strSplit = function(str, flag)
    local tab = {}
    while true do
        local n = nil
        for i=1, #str do
            local temp = string.sub(str, i, i)
            if temp == flag then
                n = i
                break
            end
        end
        if n then
            local first = string.sub(str, 1, n-1) 
            str = string.sub(str, n+1, #str) 
            table.insert(tab, first)
        else
            table.insert(tab, str)
            break
        end
    end
    return tab
end

if versionStr and #versionStr >=5 and #versionStr < 30 then
     local verStrs = strSplit(versionStr, ".")
     version = {}
     version.big = tonumber(verStrs[1])
     version.mid = tonumber(verStrs[2])
     version.min = tonumber(verStrs[3])
end

if version and (version.big > CurrentBigVersion or (version.big == CurrentBigVersion 
            and version.mid > CurrentMidVersion) or (version.big == CurrentBigVersion and 
            version.mid == CurrentMidVersion and version.min > CurrentMinVersion)) then
	--添加update更新路径
	cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "up/src/", true)
	cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "up/res/", true)
else
    local path = cc.FileUtils:getInstance():getWritablePath() .. "up/"
    if lfs then
        require("app.common.CommonTool")
        local ret = os.rmdir(path)
        print("remove oldFile : " .. path .. " " .. tostring(ret))
    end
end

require("config")

cc.UserDefault:getInstance():setStringForKey("CurGameBgMusic_s", "")
cc.UserDefault:getInstance():setBoolForKey("forceUpdate_b", false)
			
PRELOAD_INIT_MODEL = clone(package.loaded)
require("main_lua")