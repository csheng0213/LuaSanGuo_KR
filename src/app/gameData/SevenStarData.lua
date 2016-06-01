local BaseModel = require("app.baseMVC.BaseModel")

local SevenStarData = class("SevenStarData", BaseModel)

SevenStarData.debug = false

SevenStarData.sevenStarData = {}
SevenStarData.heroMark = 0
function SevenStarData:init()
    self.super.init(self)
    --注册网络监听，游戏开始初始化数据
    --英雄七星数据初始化命令：idx ＝ { 2, 10 }
    
    local onSevenStarInit = function(event)
       local data = event.data.m_altar
       self.sevenStarData = {}
       for k, v in pairs(data) do
            self.sevenStarData[k] = v
       end
    end
    NetWork:addNetWorkListener({ 2, 10 }, onSevenStarInit)

end
--发送刷新英雄卡属性请求
function SevenStarData:RequestRefrashAtrr(heroMark,hunType,handler)
     --监听服务器数据
    local onServerRequest = function (event)
        local consumeType = event.bgold
            local consumption = event.price
            if consumeType == 1 then --消耗元宝
                if consumption > 0 then
                    -- PlayerData.eventAttr["m_gold"] = PlayerData.eventAttr["m_gold"] - consumption
                    PlayerData.eventAttr["m_gold"] = event.price
                end
            elseif consumeType == 0 then -- 消耗符印
                local fuyinNum ,fuyinIndex = PropData:getPropNumOfId(4)
                if fuyinIndex ~= nil then
                    -- PropData.propInf.m_itemBag[fuyinIndex].eventAttr.m_count = PropData.propInf.m_itemBag[fuyinIndex].eventAttr.m_count - 1  --更新背包符印
                    -- PropData.propInf.m_itemBag[fuyinIndex].eventAttr.m_count = event.price
                    PropData:miuProp({m_id = 4,m_count = 1})
                end
            end
            -- if SevenStarData.sevenStarData[SevenStarData:getSevenStarIdOfSlot(event["data"]["m_slot"])] ~= nil then
            local id = SevenStarData:getSevenStarIdOfSlot(event["data"]["m_slot"])
            if id ~= nil then
                SevenStarData.sevenStarData[id]["m_stamp"] = event["data"]["m_stamp"]--更新魂属性
            else
                table.insert(SevenStarData.sevenStarData,event["data"])
            end
            HeroCardData:updateHeroExAttr(event.data.m_card.slot,{attackEX = event.data.m_card.m_attack,hpEx = event.data.m_card.m_hp, fasEx = event.data.m_card.m_mp ,fafEx = event.data.m_card.m_soldier})
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({21,1}, Functions.createNetworkListener(onServerRequest, true, "ret"))
    local msg = {idx = {21,1},slot = heroMark, index = hunType, gold = 0}
    NetWork:sendToServer(msg)
end
--根据英雄卡在背包中的slot返回英雄卡属性
function SevenStarData:getSevenStarIdOfSlot(slot)
    for k, v in pairs(self.sevenStarData) do
        if v.m_slot == slot then 
          return k
        end
    end
end

return SevenStarData