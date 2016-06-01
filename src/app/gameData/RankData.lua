local BaseModel = require("app.baseMVC.BaseModel")

local RankData = class("RankData", BaseModel)

--combat Time
local scheduler = require("app.common.scheduler")

RankData.debug = false

RankData.PlayerData = {}
RankData.GuildData = {}
--获取公会信息标志
RankData.GuildRank = false

function RankData:init()
    self.super.init(self)
end

--玩家排名信息标志
--{"allfight":8866,"imgID":6,"level":1,"soul":500,"xzlyPassBest":0,"tongID":0,"sid":105,
--"gold":2105,"uid":10598745,"vipLevel":0,"linkID":"","tianTiScore":51368,"money":79917509,
--"battleinfo":[{"level":1,"id":44,"class":1,"fight":7783,"recharge": 0,"hunjing": 77345,"name": "Hero10598771","tongName": "0","energy": 150}

--获取玩家排名信息
function RankData:sendPlayerDatas()

    local onPalyer = function(state, data)
         if state == -1 then
            --弹出报错信息
            PromptManager:openTipPrompt(LanguageConfig.language_Rank_2)
        elseif #data == 0 then
            --弹出报错信息
            PromptManager:openTipPrompt(LanguageConfig.language_Rank_7)
        else
            self.PlayerData = data
            GameCtlManager:push("app.ui.rankSystem.RankViewController")
--            scheduler.performWithDelayGlobal( function ()
--                self:sendGuildrDatas()	
--            end, 0.2)
        end
    end
    local failCB = function()
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_Login_1)
    end
    Functions.getPlayerRankList(onPalyer,failCB)
end

--公会排名信息标志
--{"state":1,"Info":[{"gcount":1,"allfight":0,"gid":1000,"gpic":110,"chairmanname":"Hero10598739","curlive":66000,"gname":"q32e123","maxFB":6,"sid":105},


--获取公会排名信息
function RankData:sendGuildDatas(listener)
    local onGuild = function(state,data)
        if state == -1 then 
            --弹出报错信息
            PromptManager:openTipPrompt(LanguageConfig.language_Rank_3)
        elseif #data == 0 then
            --弹出报错信息
            PromptManager:openTipPrompt(LanguageConfig.language_Rank_6)
        else
            self.GuildData = data
            RankData.GuildRank = true
            listener()
        end
    end
    local failCB = function()
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_Login_1)
    end
    Functions.getGuildRankList(onGuild,failCB)
end

--获取玩家排名信息
function RankData:getPlayerDatas()
    return self.PlayerData
end

--获取公会排名信息
function RankData:getGuildDatas()
    return self.GuildData
end

--获取玩家排名里我的位置
function RankData:getPlayerNum()
    local num = 0
    local oooo = PlayerData.eventAttr.m_uid
    for k, v in pairs(self.PlayerData) do
        if v.uid == PlayerData.eventAttr.m_uid then
            num = k
            return num
    	end
    end
    return num
end

--获取我的公会排名位置
function RankData:getGuildNum()
    local num = 0
    for k, v in pairs(self.GuildData) do
        if v.gid == PlayerData.eventAttr.m_tongID then
            num = k
            return num
        end
    end
    return num
end

return RankData