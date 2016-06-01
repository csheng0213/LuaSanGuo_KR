local BaseModel = require("app.baseMVC.BaseModel")
local sharedScheduler = require("app.common.scheduler")

local EnlistData = class("EnlistData", BaseModel)

EnlistData.debug = false

EnlistData.ENLIST_CRAD_EVENT = "ENLIST_CRAD_EVENT"

EnlistData.ENLIST_CRAD_TIME = "ENLIST_CRAD_TIME"

EnlistData.ENLIST_CRAD_TIME = "ENLIST_CRAD_MONEY"--金币监听
EnlistData.ENLIST_CRAD_TIME = "ENLIST_CRAD_BAO"--元宝监听

--抽卡标志
EnlistData.eventAttr.EnlistDataBZ = 0

EnlistData.m_sampleFTime = 0          --免费抽卡 次数回复时间
EnlistData.m_sampleFNum = 0           --免费抽卡 抽卡次数                    
EnlistData.m_sampleFCount = 0         --免费抽卡 玩家已抽卡次数
EnlistData.m_sampleLuck = 0           --幸运抽卡 幸运数
EnlistData.m_sampleLNum = 0           --幸运抽卡 抽卡次数

--btype:1-金币免费抽 2-元宝免费抽 3-金币抽 4-元宝抽 stype：10-十连抽

EnlistData.m_CardNum = 0            -- 抽卡个数
EnlistData.m_CardType = 0           -- 抽卡类型（1为免费，2为元宝）


function EnlistData:init()
    self.super.init(self)

    --招募
    self.enlistDatas = {}
    local onEnlistData = function (event)
        self.m_sampleFTime = event.data.m_sampleFTime           --免费抽卡 次数回复时间
        local ooooo = event.data.m_sampleFNum 
        self.m_sampleFNum = event.data.m_sampleFNum             --免费抽卡 抽卡次数                    
        --self.m_sampleFCount = event.data.m_sampleFCount         --免费抽卡 玩家已抽卡次数
        self.m_sampleFDCount = event.data.m_sampleFDCount       --金币免费当日已抽卡数
        
        self.m_sampleGTime = event.data.m_sampleGTime           --元宝抽卡 次数回复时间
        self.m_sampleGNum = event.data.m_sampleGNum             --元宝抽卡 抽卡次数                   
        self.m_sampleGCount = event.data.m_sampleGCount         --元宝抽卡 玩家已抽卡次数
        --self.m_sampleGDCount = event.data.m_sampleGDCount       --元宝免费当日已抽卡数
        self.m_AllCount = event.data.AllCount                   --元宝免费当日已抽卡数
       
    	--更新标志
        self:setEnlistDataBZ()
        
    end
    
    NetWork:addNetWorkListener({2, 9},onEnlistData)
end

--刷新抽卡标志
function EnlistData:setEnlistDataBZ()
    if (self.m_sampleFNum ~= nil and self.m_sampleFNum > 0) or (self.m_sampleGNum ~= nil and self.m_sampleGNum > 0) then
        EnlistData.eventAttr.EnlistDataBZ = 1
    else
        EnlistData.eventAttr.EnlistDataBZ = 0
    end
end

--清空申请数据
function EnlistData:clearEnlistData()
    self.enlistDatas = {}
end

function EnlistData:sendGetCard(listener)
    Functions.printInfo(self.debug,"sendGetCard")

    local onSendGetCard = function (event)
        if event.ret == 1 then
            if self.m_CardType == 3 and self.m_CardNum == 1 then
                Functions.setAdbrixTag("retension","herohof_buy_sliver_1_nonfree", tostring(PlayerData.eventAttr.m_level))
            end
            if self.m_CardType == 3 and self.m_CardNum == 10 then
                Functions.setAdbrixTag("retension","herohof_buy_sliver_10", tostring(PlayerData.eventAttr.m_level))
            end
            if self.m_CardType == 4 and self.m_CardNum == 1 then
                Functions.setAdbrixTag("retension","herohof_buy_gold_1_nonfree", tostring(PlayerData.eventAttr.m_level))
            end
            if self.m_CardType == 4 and self.m_CardNum == 10 then
                Functions.setAdbrixTag("retension","herohof_buy_gold_10", tostring(PlayerData.eventAttr.m_level))
            end

        
            PlayerData.eventAttr.m_gold = event.gold
            PlayerData.eventAttr.m_money = event.money
            
            self.m_sampleFDCount = event.m_sampleFDCount
            self.m_sampleFNum    = event.m_sampleFNum
            self.m_sampleGDCount = event.m_sampleGDCount
            self.m_sampleGNum    = event.m_sampleGNum
            self.m_AllCount      = event.AllCount
            
            if self.m_CardType == 1 then
                if self.m_CardType == 1 then
                    Functions.setAdbrixTag("retension","herohof_buy_sliver_1_free", tostring(PlayerData.eventAttr.m_level) )
                end
                if event.MoneyTime ~= nil and event.MoneyTime ~= 0 then
                    TimerManager:setCurrentSecond(event.MoneyTime)
                    self.m_sampleFTime = event.MoneyTime
                end
            end
            
            if self.m_CardType == 2 then
                if self.m_CardType == 2 then
                    Functions.setAdbrixTag("retension","herohof_buy_gold_1_free",tostring(PlayerData.eventAttr.m_level))
                end
                if event.GoldTime ~= nil and event.GoldTime ~= 0 then
                    TimerManager:setCurrentSecond(event.GoldTime)
                    self.m_sampleGTime = event.GoldTime
                end
            end
            local tmp = event.tmp
            for k, v in pairs(tmp) do
                --向武将里加卡
                HeroCardData:addCard({id = v.id, slot = v.slot})
            end
            --数据更新监听
            GameEventCenter:dispatchEvent({ name = EnlistData.ENLIST_CRAD_EVENT, data = event })

            --数据更新监听
            GameEventCenter:dispatchEvent({ name = EnlistData.ENLIST_CRAD_TIME, data = event })

            
            self:clearEnlistData()--清空主数据
            for k, v in pairs(tmp) do
            	local cardInfo = {}
            	cardInfo.m_id = v.id
                cardInfo.m_mark = v.slot
                self.enlistDatas[#self.enlistDatas + 1] = cardInfo
            end
            --更新标志
            self:setEnlistDataBZ()
            listener(event)
        else
            listener(event)
        end
        return true
    end
    local type = self.m_CardType
    local num = self.m_CardNum
    NetWork:addNetWorkListener({ 9, 4 }, onSendGetCard)
    NetWork:sendToServer({ idx = { 9, 4 }, btype = self.m_CardType, stype = self.m_CardNum  })

    --self._controller_t:openChildView("app.ui.popViews.EnlistTwoPopView", { data = num , self._type, isRemove = false })
end

--清空主数据
function EnlistData:ClearEnlistData()
    self.enlistDatas = {}
end

--获取主数据
function EnlistData:getEnlistData()
    return self.enlistDatas
end

return EnlistData