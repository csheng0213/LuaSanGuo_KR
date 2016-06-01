local BaseModel = require("app.baseMVC.BaseModel")

local RewardData = class("RewardData", BaseModel)

RewardData.debug = false

--事件属性
RewardData.eventAttr = {}

RewardData.rewardInf = {}
RewardData.rewardInf.Accumulate= {}         --登陆领奖：积累的30天奖品数据  
RewardData.rewardInf.NewReward = {}         --签到领奖：5天数据

function RewardData:init()
    self.super.init(self)
    --注册网络监听，游戏开始初始化数据
    --游戏领奖数据初始化命令：idx ＝ { 2, 15 }
    local onRewardInit = function(event)

        local data = event.data
        
        for k, v in pairs(data) do
            self.rewardInf[k] = v
        end
    end
    NetWork:addNetWorkListener({ 2, 15 }, onRewardInit)
    
    -- GameEventCenter:addEventListener(PlayerData.PLAYER_LOGOUT_EVENT, function ( )
    --     RewardData.rewardInf = {}
    --     RewardData.rewardInf.Accumulate= {}         --登陆领奖：积累的30天奖品数据  
    --     RewardData.rewardInf.NewReward = {}         --签到领奖：5天数据
    -- end)
end
--发送30天领奖请求
function RewardData:RequestLoginReward(handler)
     --监听服务器数据
    local onServerRequest = function (event)
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({9,3}, Functions.createNetworkListener(onServerRequest, true, "ret"))
    local msg = {idx = {9, 3} }
    NetWork:sendToServer(msg)
end
--发送5天领奖请求
function RewardData:RequestSignReward(handler)
     --监听服务器数据
    local onServerRequest = function (event)
    
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({9,2}, Functions.createNetworkListener(onServerRequest, true, "ret"))
    local msg = {idx = {9, 2} }
    NetWork:sendToServer(msg)
end

--更新奖品数据
function RewardData:updatePrizeData(prizeType,prizeId,prizeNum,prizeMark)
    if prizeType == 1 then  --道具
        PropData:addProp({m_id = prizeId, m_count = prizeNum,script = prizeMark})
    elseif prizeType == 2 then --金币
        PlayerData.eventAttr.m_money = PlayerData.eventAttr.m_money + prizeNum
    elseif prizeType == 3 then --元宝
        PlayerData.eventAttr.m_gold = PlayerData.eventAttr.m_gold + prizeNum
    elseif prizeType == 4 then --武魂
        PlayerData.eventAttr.m_soul = PlayerData.eventAttr.m_soul + prizeNum
    elseif prizeType == 5 then --卡牌
        HeroCardData:addCard({slot = prizeMark, id = prizeId})    
    end
end
return RewardData