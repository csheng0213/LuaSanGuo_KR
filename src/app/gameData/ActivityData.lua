local BaseModel = require("app.baseMVC.BaseModel")

local ActivityData = class("ActivityData", BaseModel)

ActivityData.debug = false
ActivityData.eventAttr = {}
ActivityData.eventAttr.rank = 0 --当前玩家积分排名
ActivityData.eventAttr.score = 0  --当前玩家积分
ActivityData.eventAttr.cdTime = 0  --免费抽卡cd时间
ActivityData.eventAttr.rankPlayer = {}  --所有玩家排名数据
ActivityData.eventAttr.count = 0  --玩家当前抽卡次数
ActivityData.eventAttr.gold = 0  --元宝抽消耗
ActivityData.eventAttr.freeTakeHeroFlag = 0
ActivityData.eventAttr.activityHeroTime = 0   --限时神将活动剩余时间
ActivityData.eventAttr.freeHeroRemainTime = 0  --免费抽剩余时间
ActivityData.eventAttr.isEnableActivityHero = 0 --限时神将获得是否开启 1开启
ActivityData.xsHero = {}
ActivityData.xsHero.rank = 0 --当前玩家积分排名
ActivityData.xsHero.score = 0  --当前玩家积分
ActivityData.xsHero.startTime = {} --活动开始时间
ActivityData.xsHero.endTime = {} --活动结束时间
ActivityData.xsHero.rankPlayer = {}  --所有玩家排名数据
ActivityData.xsHero.cdTime = 0  --免费抽卡cd时间
ActivityData.xsHero.count = 0  --玩家当前抽卡次数
ActivityData.xsHero.rankDescribe = {} --描述配置
ActivityData.xsHero.tips = "" --提示
ActivityData.xsHero.gold = 0  --元宝抽消耗
ActivityData.xsHero.showHero = {} --展示的卡牌
ActivityData.xsHero.CritNum = 10 --必得六星抽卡的次数
ActivityData.xsHero.CD = 0 --免费抽卡的cd时间

--测试数据
ActivityData.xsHero.isEnableHero = {}
ActivityData.xsHero.showHero = {}

--在线领奖
ActivityData.eventAttr.m_onlineIndex = 0
ActivityData.eventAttr.remainTime = 0
ActivityData.eventAttr.m_onlinePrizeState = 0

ActivityData.onlineReward = {}
ActivityData.onlineReward.m_dailyonlinetime = 0 --刚建号初始数据在线总时间为0
ActivityData.onlineReward.m_onlinePrizeState = 0 --领取状态
ActivityData.onlineReward.m_onlineIndex = 0 --领取的阶段
ActivityData.onlineReward.remainTime = 0 --本次距离上次领奖时
ActivityData.onlineReward.Rewards = {} --奖品配置

ActivityData.VIPBZ = false          --VIP标志
ActivityData.VIPJiHua = {}          --VIP成长基金
ActivityData.VIPJiHuaItem = {}
ActivityData.VIPJiHuaBuy = 0        --VIP成长基金是否购买(0-未购买，1-已购买)

ActivityData.EveryDayBZ = false     --每日充值标志
ActivityData.EveryDay = {}          --每日充值(0不可领取 1 可领取 2 已经领取过了)
ActivityData.EveryDayItem = {}      --每日充值道具
ActivityData.EveryDayGold = 0       --今日已充钱数

ActivityData.MoneyBZ = false        --充值标志
ActivityData.MoneyHuoDong = {}      --充值活动(0不可领取 1 可领取 2 已经领取过了)
ActivityData.MoneyHuoDongItem = {}
ActivityData.MoneyHuoDongNum = 0    --已充钱数

ActivityData.XiaoFeiBZ = false      --消费标志
ActivityData.XiaoFei = {}           --累积消费(0不可领取 1 可领取 2 已经领取过了)
ActivityData.XiaoFeiItem = {}
ActivityData.XiaoFeiNum = 0         --累积消费数

ActivityData.TianTiRank = {}        --天梯排名分段
--ActivityData.TianTiScore = {}     --天梯积分
--ActivityData.TianTiItem = {}      --天梯道具

--StartTime = {day, hour, min, month, sec，year}
ActivityData.StartTime = {}         --活动开始时间
ActivityData.EndTime = {}           --活动结束时间
ActivityData.StrText = {}           --活动介绍



--福利标志
ActivityData.eventAttr.fuLiDataBZ = 0

function ActivityData:init()
    self.super.init(self)
    local onActivityInit = function(event)
        local data = event.data
        for k, v in pairs(data) do
            self.xsHero[k] = v
        end 
        --测试数据
--        ActivityData.xsHero.isEnableHero = {true,true,true,true,false}
--        ActivityData.xsHero.showHero={[1]={[0]=120,[1]=121,[2]=122},
--                                      [2]={[0]=123,[1]=124,[2]=125},
--                                      [3]={[0]=124,[1]=121,[2]=122},
--                                      [4]={[0]=125,[1]=121,[2]=122},
--                                      [5]={[0]=127,[1]=121,[2]=122},}  
                                                        


        ActivityData.eventAttr.gold = ActivityData.xsHero.gold
        ActivityData.eventAttr.rank = ActivityData.xsHero.rank 
        ActivityData.eventAttr.score =ActivityData.xsHero.score 
        ActivityData.eventAttr.cdTime = ActivityData.xsHero.cdTime 
        ActivityData.eventAttr.isEnableActivityHero = ActivityData.xsHero.isEnableActivityHero
        if ActivityData.eventAttr.cdTime == 0 then
            ActivityData.eventAttr.freeTakeHeroFlag = 1
        else
            ActivityData.eventAttr.freeTakeHeroFlag = 0
        end
        ActivityData.eventAttr.rankPlayer = ActivityData.xsHero.rankPlayer 
        ActivityData.eventAttr.count = ActivityData.xsHero.CritNum - ActivityData.xsHero.count 
        --活动时间
        -- local isEnableActivityHero = Functions.checkTime(TimerManager:getCurrentSecond(),ActivityData.xsHero.startTime,ActivityData.xsHero.endTime)
        if ActivityData.eventAttr.isEnableActivityHero == 1 then 
            ActivityData.eventAttr.activityHeroTime = ActivityData.xsHero.endTime_s - TimerManager:getCurrentSecond()
            local listener = function( )               
                if ActivityData.eventAttr.cdTime > 0 then
                    ActivityData.eventAttr.freeHeroRemainTime = ActivityData.xsHero.CD - (TimerManager:getCurrentSecond() - ActivityData.eventAttr.cdTime)
                    if ActivityData.eventAttr.freeHeroRemainTime > 0 then
                        ActivityData.eventAttr.freeHeroRemainTime = ActivityData.eventAttr.freeHeroRemainTime - 1
                        ActivityData.eventAttr.freeTakeHeroFlag = 0
                    else
                        ActivityData.eventAttr.freeTakeHeroFlag = 1
                        ActivityData.eventAttr.cdTime = 0
                        ActivityData.eventAttr.freeHeroRemainTime = 0
                    end
                else
                    ActivityData.eventAttr.freeTakeHeroFlag = 1
                end
                if ActivityData.eventAttr.activityHeroTime >= 1 then
                    ActivityData.eventAttr.activityHeroTime = ActivityData.eventAttr.activityHeroTime - 1 
                else
                    ActivityData.eventAttr.activityHeroTime = 0
                    ActivityData.eventAttr.freeTakeHeroFlag = 0
                    ActivityData.eventAttr.isEnableActivityHero = 0
                end
            end
            GameEventCenter:addEventListener(TimerManager.SECOND_CHANGE_EVENT, listener)
        else
            ActivityData.eventAttr.freeTakeHeroFlag = 0
            ActivityData.eventAttr.activityHeroTime = 0
        end
    end
    NetWork:addNetWorkListener({ 2, 24 }, onActivityInit)

    local onActivityInit2 = function(event)
        local data = event.data
        for k, v in pairs(data) do
            self.onlineReward[k] = v
        end  
        ActivityData.eventAttr.m_onlineIndex = ActivityData.onlineReward.m_onlineIndex
        ActivityData.eventAttr.remainTime = ActivityData.onlineReward.remainTime
        ActivityData.eventAttr.m_onlinePrizeState = ActivityData.onlineReward.m_onlinePrizeState
        --在线领奖时间
        local listener = function( )
            if ActivityData.eventAttr.remainTime >= 0 and ActivityData.eventAttr.m_onlinePrizeState == 0 then
                ActivityData.eventAttr.remainTime = ActivityData.eventAttr.remainTime - 1 
                if ActivityData.eventAttr.remainTime < 0 then
                    ActivityData.eventAttr.m_onlinePrizeState = 1
                    ActivityData.eventAttr.remainTime = 0
                end     
            else
                ActivityData.eventAttr.remainTime = 0    
            end
        end
        GameEventCenter:addEventListener(TimerManager.SECOND_CHANGE_EVENT, listener)
    end
    NetWork:addNetWorkListener({ 2, 23 }, onActivityInit2)
    
    local onBZ = function(event)
    
        --每日充值
        if event.active == "everyPay" and event.isHave then
        	self.EveryDayBZ = true
        elseif event.active == "everyPay" and not event.isHave then 
            self.EveryDayBZ = false
        end
        --充值活动 
        if event.active == "totalPay" and event.isHave then
            self.MoneyBZ = true
        elseif event.active == "totalPay" and not event.isHave then 
            self.MoneyBZ = false
        end
        --总消费 
        if event.active == "allConsume" and event.isHave then
            self.XiaoFeiBZ = true
        elseif event.active == "allConsume" and not event.isHave then
            self.XiaoFeiBZ = false
        end
        --成长计划
        if event.active == "growUp" and event.isHave then
            self.VIPBZ = true
        elseif event.active == "growUp" and not event.isHave then 
            self.VIPBZ = false
        end
        
        if self.EveryDayBZ or self.MoneyBZ or self.XiaoFeiBZ or self.VIPBZ then
            ActivityData.eventAttr.fuLiDataBZ = 1
        else
            ActivityData.eventAttr.fuLiDataBZ = 0
        end
        
        
    end
    NetWork:addNetWorkListener({ 20, 30 }, onBZ)
end
--发送抽抽卡请求
function ActivityData:RequestTakeCard(type,xsHeroType,handler)
    --监听服务器数据
    local onServerRequest = function (event)
        HeroCardData:addCard({slot = event.tmp[1].slot,id = event.tmp[1].id}) 
        PlayerData.eventAttr.m_gold = event.gold
        ActivityData.eventAttr.score = event.score
        ActivityData.eventAttr.rank = event.rank         
        ActivityData.eventAttr.rankPlayer = event.rankPlayer
        ActivityData.eventAttr.count = ActivityData.xsHero.CritNum - event.count 
        TimerManager:setCurrentSecond(event.currentTime)
        if type == 1 then 
            ActivityData.eventAttr.cdTime = event.initTime
            ActivityData.eventAttr.freeHeroRemainTime = ActivityData.xsHero.CD - (TimerManager:getCurrentSecond() - ActivityData.eventAttr.cdTime)
        end
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({26,1}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {26, 1}, stype = type,xsHeroType = xsHeroType}
    NetWork:sendToServer(msg)
end
--同步在线领奖接口
function ActivityData:requireOnline(handler)
    --监听服务器数据
    local onServerRequest = function (event)
        local data = event.data
        for k, v in pairs(data) do
            self.onlineReward[k] = v
        end  
        ActivityData.eventAttr.m_onlineIndex = ActivityData.onlineReward.m_onlineIndex
        ActivityData.eventAttr.remainTime = ActivityData.onlineReward.remainTime
        ActivityData.eventAttr.m_onlinePrizeState = ActivityData.onlineReward.m_onlinePrizeState
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({20,5}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {20, 5}}
    NetWork:sendToServer(msg)
end
--发送首充领奖请求
function ActivityData:RequestFirstPayReward(handler)
    --监听服务器数据
    local onServerRequest = function (event)
        PlayerData.eventAttr.m_money = event.data.money
        PlayerData.eventAttr.m_gold = event.data.gold
        PlayerData.eventAttr.m_soul = event.data.soul
        PlayerData.eventAttr.m_hunjing = event.data.hunjing
        PlayerData.eventAttr.m_vipFirstFlag = 0   --vip首充标示：是否有奖可领 1/0
        for k,v in pairs(event.data.items) do
            Functions:addItemResources(v)
        end

        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({25,6}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {25, 6}}
    NetWork:sendToServer(msg)
end
--发送在线领奖请求
function ActivityData:RequestOnlineReward(handler)
    --监听服务器数据
    local onServerRequest = function (event)
        PlayerData.eventAttr.m_money = event.data.money
        PlayerData.eventAttr.m_gold = event.data.gold
        PlayerData.eventAttr.m_soul = event.data.soul
        PlayerData.eventAttr.m_hunjing = event.data.hunjing
        ActivityData.eventAttr.remainTime = event.remainTime
        ActivityData.eventAttr.m_onlinePrizeState = event.m_onlinePrizeState
        for k,v in pairs(event.data.items) do
            Functions:addItemResources(v)
        end
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({20,4}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {20, 4}}
    NetWork:sendToServer(msg)
end


--发送VIP成长基金
function ActivityData:sendJiHua()
    --监听服务器数据
    local onServerRequest = function (event)
    
        local group = event.data
        ActivityData.StrText[#ActivityData.StrText + 1] = event.description         --活动介绍

        ActivityData.VIPJiHuaItem = {}
        for k, v in pairs(group) do
            ActivityData.VIPJiHuaItem[#ActivityData.VIPJiHuaItem + 1] = v
        end
        
        local data = event.state
        ActivityData.VIPJiHua = {}
        for k, v in pairs(data) do
            ActivityData.VIPJiHua[#ActivityData.VIPJiHua + 1] = v
        end
        self.VIPJiHuaBuy = event.growUpFlag
    end
    NetWork:addNetWorkListener({25,5}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {25, 5}}
    NetWork:sendToServer(msg)
end

--发送每日充值
function ActivityData:sendEveryDay(onData)
    --监听服务器数据
    local onServerRequest = function (event)
        local data = event.state
        local group = event.data.group
        
        ActivityData.StartTime[#ActivityData.StartTime + 1] = event.data.startTime       --活动开始时间
        ActivityData.EndTime[#ActivityData.EndTime + 1] = event.data.endTime       --活动结束时间
        
        ActivityData.StrText[#ActivityData.StrText + 1] = event.description         --活动介绍

        ActivityData.EveryDayItem = {}
        for k, v in pairs(group) do
            ActivityData.EveryDayItem[#ActivityData.EveryDayItem + 1] = v
        end
        
        ActivityData.EveryDay = {}
        for k, v in pairs(data) do
            ActivityData.EveryDay[#ActivityData.EveryDay + 1] = v
        end
        ActivityData.EveryDayGold = event.everyAllPay
        onData()
    end
    NetWork:addNetWorkListener({20,15}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {20, 15}}
    NetWork:sendToServer(msg)
end

--发送充值活动
function ActivityData:sendNumHuoDong()
    --监听服务器数据
    local onServerRequest = function (event)
    
        local group = event.data.group

        ActivityData.MoneyHuoDongItem = {}
        for k, v in pairs(group) do
            ActivityData.MoneyHuoDongItem[#ActivityData.MoneyHuoDongItem + 1] = v
        end
        
        local data = event.state
        ActivityData.StartTime[#ActivityData.StartTime + 1] = event.data.startTime       --活动开始时间
        ActivityData.EndTime[#ActivityData.EndTime + 1] = event.data.endTime       --活动结束时间
        
        ActivityData.StrText[#ActivityData.StrText + 1] = event.description         --活动介绍
        
        ActivityData.MoneyHuoDong = {}
        for k, v in pairs(data) do
            ActivityData.MoneyHuoDong[#ActivityData.MoneyHuoDong + 1] = v
        end
        ActivityData.MoneyHuoDongNum = event.MoneyHuoDongNum
    end
    NetWork:addNetWorkListener({20,8}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {20, 8}}
    NetWork:sendToServer(msg)
end

--发送累积消费
function ActivityData:sendXiaoFei()
    --监听服务器数据
    local onServerRequest = function (event)
    
        local group = event.data.group

        ActivityData.XiaoFeiItem = {}
        for k, v in pairs(group) do
            ActivityData.XiaoFeiItem[#ActivityData.XiaoFeiItem + 1] = v
        end
        
        local data = event.state
        ActivityData.StartTime[#ActivityData.StartTime + 1] = event.data.startTime      --活动开始时间
        ActivityData.EndTime[#ActivityData.EndTime + 1] = event.data.endTime            --活动结束时间
        
        ActivityData.StrText[#ActivityData.StrText + 1] = event.description             --活动介绍
        
        ActivityData.XiaoFei = {}
        for k, v in pairs(data) do
            ActivityData.XiaoFei[#ActivityData.XiaoFei + 1] = v
        end
        ActivityData.XiaoFeiNum = event.allConsume
    end
    NetWork:addNetWorkListener({20,20}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {20, 20}}
    NetWork:sendToServer(msg)
end

--发送天梯数据
function ActivityData:sendTianTi()
    --监听服务器数据
    local onServerRequest = function (event)
        local data = event.data
        ActivityData.StartTime[#ActivityData.StartTime + 1] = event.data.startTime      --活动开始时间
        ActivityData.EndTime[#ActivityData.EndTime + 1] = event.data.endTime            --活动结束时间
        ActivityData.StrText[#ActivityData.StrText + 1] = event.description             --活动介绍
        
        ActivityData.TianTiRank = {}
        for k, v in pairs(data.group) do
            ActivityData.TianTiRank[#ActivityData.TianTiRank + 1] = v
        end
    end
    NetWork:addNetWorkListener({20,25}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {20, 25}}
    NetWork:sendToServer(msg)
end


----VIP成长基金标志
--function ActivityData:getVIPBZ()
--    local data = ActivityData.VIPJiHua
--    local BZ = true
--    for k, v in pairs(data) do
--        if v == 1 then
--        	ActivityData.VIPBZ = true
--            BZ = false
--        	break
--        end
--    end
--    if BZ then
--        ActivityData.VIPBZ = false
--    end
--    return  ActivityData.VIPBZ
--end
--
----每日充值标志
--function ActivityData:getEveryDayBZ()
--    local data = ActivityData.EveryDay
--    local BZ = true
--    for k, v in pairs(data) do
--        if v == 1 then
--            ActivityData.EveryDayBZ = true
--            BZ = false
--            break
--        end
--    end
--    if BZ then
--        ActivityData.EveryDayBZ = false
--    end
--    return  ActivityData.EveryDayBZ
--end
--
----累积充值标志
--function ActivityData:getMoneyBZ()
--    local data = ActivityData.MoneyHuoDong
--    local BZ = true
--    for k, v in pairs(data) do
--        if v == 1 then
--            ActivityData.MoneyBZ = true
--            BZ = false
--            break
--        end
--    end
--    if BZ then
--        ActivityData.MoneyBZ = false
--    end
--    return  ActivityData.MoneyBZ
--end
--
----消费标志
--function ActivityData:getXiaoFeiBZ()
--    local data = ActivityData.XiaoFei
--    local BZ = true
--    for k, v in pairs(data) do
--        if v == 1 then
--            ActivityData.XiaoFeiBZ = true
--            BZ = false
--            break
--        end
--    end
--    if BZ then
--        ActivityData.XiaoFeiBZ = false
--    end
--    return  ActivityData.XiaoFeiBZ
--end

--获取每日充值
function ActivityData:getEveryDay()
    return self.EveryDay
end

--获取每日充值道具
function ActivityData:getEveryDayItem()
    return self.EveryDayItem
end

--获取累积消费
function ActivityData:getXiaoFei()
    return self.XiaoFei
end

--获取累积消费道具
function ActivityData:getXiaoFeiItem()
    return self.XiaoFeiItem
end

--获取充值活动
function ActivityData:getMoneyHuoDong()
    return self.MoneyHuoDong
end

--获取充值活动道具
function ActivityData:getMoneyHuoDongItem()
    return self.MoneyHuoDongItem
end

--获取天梯数据
function ActivityData:getTianTiRank()
    return self.TianTiRank
end

--获取VIP成长基金
function ActivityData:getJiHua()
    return self.VIPJiHua
end

--获取VIP成长基金道具
function ActivityData:getJiHuaItem()
    return self.VIPJiHuaItem
end

--获取活动开始时间
function ActivityData:getStartTime()
    return self.StartTime
end

--获取活动结束时间
function ActivityData:getEndTime()
    return self.EndTime
end

--获取活动结束时间
function ActivityData:getStrText()
    return self.StrText
end


return ActivityData