local BaseModel = require("app.baseMVC.BaseModel")

local GuildBattleData = class("GuildBattleData", BaseModel)

GuildBattleData.debug = false
GuildBattleData.BID_RANK_CHANGE = "BID_RANK_CHANGE"
GuildBattleData.OCCUPY_PRIZE = "OCCUPY_PRIZE"
--倒计时
GuildBattleData.COUNTDOWN = "COUNTDOWN"
--小城改变信息
GuildBattleData.BUILDING_INFO = "BUILDING_INFO"
--资源改变信息
GuildBattleData.RESOURCE_INFO = "RESOURCE_INFO"
--竟价排行界面
GuildBattleData.BID_RANK_INFO = "BID_RANK_INFO"
--公会战结果
GuildBattleData.BID_BATTLE_RESULT = "BID_BATTLE_RESULT"
--大城状态改变
GuildBattleData.BATTLE_STATE = "BATTLE_STATE"
GuildBattleData.eventAttr.allTime = 0
GuildBattleData.eventAttr.Time = 0
GuildBattleData.eventAttr.bidTime = 0
GuildBattleData.eventAttr.planTime = 0

--复活倒计时
--GuildBattleData.eventAttr.DownTime = 0


function GuildBattleData:init()
    self.super.init(self)
    
    local onRankInfo = function(event)

        --self.bidInfo = {}
        local data = GuildBattleData:getBidInfo()
         local ppp = self.bidInfo
        data.bidList = event.data.bidList
        --数据更新广播
        GameEventCenter:dispatchEvent({ name = GuildBattleData.BID_RANK_CHANGE})
    end
    NetWork:addNetWorkListener({28, 2}, onRankInfo)
    
    --复活倒计时
    local onTime = function(event)
        self.CountdownTime = 0
        self.CountdownTime = event.time
        TimerManager:setCurrentSecond(event.st)
--        GuildBattleData.eventAttr.DownTime = self.CountdownTime - TimerManager:getCurrentSecond()
--        local listener = function( )
--            if GuildBattleData.eventAttr.Time <= 0 then 
--                GuildBattleData.eventAttr.DownTime = GuildBattleData.eventAttr.DownTime - 1
--            end
--        end
--        GameEventCenter:removeEventListenersByEvent(TimerManager.SECOND_CHANGE_EVENT)
--        GameEventCenter:addEventListener(TimerManager.SECOND_CHANGE_EVENT, listener)
        
        --倒计时广播
        GameEventCenter:dispatchEvent({ name = GuildBattleData.COUNTDOWN})
    end
    NetWork:addNetWorkListener({28, 7}, onTime)
    
    --小城改变后的数据
    local onCityInfo = function(event)
        self.GuildBuildingInfo[event.data.index] = event.data
        --小城改变信息广播
        GameEventCenter:dispatchEvent({ name = GuildBattleData.BUILDING_INFO})
    end
    NetWork:addNetWorkListener({28, 8}, onCityInfo)
    
    --小城打仗时强制退出，服务器返回状态
    local onCityInfo = function(event)
        
        self.GuildBuildingInfo[event.index].state = event.state
        --小城改变信息广播
        GameEventCenter:dispatchEvent({ name = GuildBattleData.BUILDING_INFO})
    end
    NetWork:addNetWorkListener({28, 15}, onCityInfo)
    
    --资源改变信息
    local onResource = function(event)
        --资源改变信息
        GuildBattleData:getAttdata().plusCrystal = event.data.redInfo.plusCrystal
        GuildBattleData:getDefdata().plusCrystal = event.data.greedInfo.plusCrystal
        
        --资源改变信息广播
        GameEventCenter:dispatchEvent({ name = GuildBattleData.RESOURCE_INFO})
    end
    NetWork:addNetWorkListener({28, 9}, onResource)
    
    --公会战结果
    local onBattleResult = function(event)
        self.BattleResult = {}
        self.BattleResult = event.data
        --公会战结果广播
        GameEventCenter:dispatchEvent({ name = GuildBattleData.BID_BATTLE_RESULT})
    end
    NetWork:addNetWorkListener({28, 16}, onBattleResult)
    
    --大城更改状态
    local onBattleState = function(event)
        local data = GuildBattleData:getBuildingInfo()
         data[event.index].state = event.state
        --公会战结果广播
        GameEventCenter:dispatchEvent({ name = GuildBattleData.BATTLE_STATE})
    end
    NetWork:addNetWorkListener({28, 18}, onBattleState)
    
end


--isOpen        建筑未开放(true,false)
--ownName       占领的公会名
--own           占领的公会id
--state         （0是普通，1是竞价，2是战斗准备，3战斗)
--rewardState   占领奖品（0 不能领 1可以领 2领过了）
--Rate          奖励是否会有翻倍（它的值带表会有几倍）
--公会战建筑信息
function GuildBattleData:sendBuildingInfo(listener)

    local onInfo = function(event)
        --先清空数据
        self.buildingInfo = {}
        self.buildingInfo = event.data
        self.buildingPrize = event.reward

        --GameCtlManager:push("app.ui.guildBattleSystem.GuildBattleViewController")
        listener()
    end
    NetWork:addNetWorkListener({28, 1}, Functions.createNetworkListener(onInfo, true, "ret"))
    local msg = {idx = {28, 1}}
    NetWork:sendToServer(msg)
end

--id                --城池id
--isChairMan        --是否是某公会会长
--startbidTime      --竞标开始时间
--endBidTime        --竞标结束时间
--endPlanTime       --准备战斗结束时间
--endfightTime      --公会战斗结束时间
--allActif          --公会资金
--bidBasePrice      --城堡竞价底价 
--bidList           --竞价列表
--state             --状态 0普通 1竞标 2战斗准备 3战斗
--preInfo           --公会战结果数据

--公会战结果数据
--win(胜方) lose（输方）
--id                公会id
--name              公会名
--pic               公会图标
--竞价排行接口
--function GuildBattleData:sendBidRank(id, listener)
--    local onInfo = function(event)
--        --先清空数据
--        self.bidInfo = {}
--        self.bidInfo = event.data
--        --小城改变信息广播
--        GameEventCenter:dispatchEvent({ name = GuildBattleData.BUILDING_INFO})
--        listener()
--    end
--    NetWork:addNetWorkListener({28, 2}, Functions.createNetworkListener(onInfo, true, "ret"))
--    local msg = {idx = {28, 2}, city = id}
--    NetWork:sendToServer(msg)
--end

--竞价钱数
function GuildBattleData:sendBidMoney(id, num)
    local onInfo = function(event)
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_GuildBattle_2)

        --listener()
    end
    NetWork:addNetWorkListener({28, 3}, Functions.createNetworkListener(onInfo, true, "ret"))
    local msg = {idx = {28, 3},id = id, num = num}
    NetWork:sendToServer(msg)
end

--攻方（att）和守方（def）的数据
--guild             公会ID（黄巾军ID为-1）
--guildName         公会名字
--joinnum           公会人数
--plusCrystal       资源数量
--cityNum           占领小城的数量

--小城数据
--progress          小城进度条
--cast              小城现在属于谁(0 黄巾军，1红方，2绿方)
--state             小城现在的状态（0未战斗，1正在战斗）
--id                玩家id
--smallname         据点名字

--playerData        玩家数据表名
--name              小城占领者的名字
--level             小城占领者的等级
--headid            小城占领者的头像id
--power             小城占领者的战斗力

--Maxcrystal        攻城战资源最大值
--endfightTime      攻城倒计时
--攻城数据
function GuildBattleData:sendAttackGuildBuilding(id, listener)
    local onInfo = function(event)
        --先清空数据
        self.GuildBuildingInfo = {}
        self.attdata = {}
        self.defdata = {}
        self.endfightTime = 0
        self.attdata = event.data.att
        self.defdata = event.data.def
        self.GuildBuildingInfo = event.data.small
        self.endfightTime = event.data.endfightTime
        self.Maxcrystal = event.data.Maxcrystal
        listener()
    end
    NetWork:addNetWorkListener({28, 4}, Functions.createNetworkListener(onInfo, true, "ret"))
    local msg = {idx = {28, 4}, id = id }
    NetWork:sendToServer(msg)
end

--离开据点界面
function GuildBattleData:sendLeaveBuilding(id, listener)
    local onInfo = function(event)
        listener()
    end
    NetWork:addNetWorkListener({28, 5}, Functions.createNetworkListener(onInfo, true, "ret"))
    local msg = {idx = {28, 5}, id = id }
    NetWork:sendToServer(msg)
end

--离开城池界面(服务器不返回消息)
function GuildBattleData:sendCloseBuilding(id)
    local onInfo = function(event)
    end
    NetWork:addNetWorkListener({28, 10}, Functions.createNetworkListener(onInfo, true, "ret"))
    local msg = {idx = {28, 10}, id = id }
    NetWork:sendToServer(msg)
end

--进入城池界面(成功后服务器会推送 28-2 接口)
function GuildBattleData:sendIntoBuilding(id)
    local onInfo = function(event)
        self.bidInfo = {}
        self.bidInfo = event.data
        TimerManager:setCurrentSecond(event.st)
        --数据更新广播
        GameEventCenter:dispatchEvent({ name = GuildBattleData.BID_RANK_INFO})

--        GuildBattleData.eventAttr.planTime = self.bidInfo.endPlanTime - self.bidInfo.endBidTime
        local listener = function()   

            if self.bidInfo.startbidTime - TimerManager:getCurrentSecond() >= 0 then
                GuildBattleData:getBidInfo().state = 0 
                if self.bidInfo.startbidTime - TimerManager:getCurrentSecond() == 0 then
                    GuildBattleData:getBidInfo().state = 1
                end
                GuildBattleData.eventAttr.allTime = self.bidInfo.startbidTime - TimerManager:getCurrentSecond()
            elseif self.bidInfo.endBidTime - TimerManager:getCurrentSecond() >= 0 then
                GuildBattleData:getBidInfo().state = 1
                if self.bidInfo.endBidTime - TimerManager:getCurrentSecond() == 0 then
                    GuildBattleData:getBidInfo().state = 2
                end
                GuildBattleData.eventAttr.allTime = self.bidInfo.endBidTime - TimerManager:getCurrentSecond()
            elseif self.bidInfo.endPlanTime - TimerManager:getCurrentSecond() >= 0 then
                GuildBattleData:getBidInfo().state = 2
                if self.bidInfo.endPlanTime - TimerManager:getCurrentSecond() == 0 then
                    GuildBattleData:getBidInfo().state = 3
                end
                GuildBattleData.eventAttr.allTime = self.bidInfo.endPlanTime - TimerManager:getCurrentSecond()
            else
                GuildBattleData:getBidInfo().state = 3
                GuildBattleData.eventAttr.allTime = 0
            end

        end
        GameEventCenter:removeEventListenersByEvent(TimerManager.SECOND_CHANGE_EVENT)
        GameEventCenter:addEventListener(TimerManager.SECOND_CHANGE_EVENT, listener)
    end
   
    
    
    NetWork:addNetWorkListener({28, 11}, Functions.createNetworkListener(onInfo, true, "ret"))
    local msg = {idx = {28, 11}, id = id }
    NetWork:sendToServer(msg)
end

--领取奖励
function GuildBattleData:sendGetPrize(id, listener)
    local onInfo = function(event)
        --奖励道具
        local msg = event.goods
        for k,v in pairs(msg) do
            local id = v.id
            local type = v.type
            local count = v.count
            local slot = v.slot

            Functions:addItemResources( {id = id, type = type, count = count, slot = slot} )
        end
        
        local datas = GuildBattleData:getBuildingInfo()
        datas[id].rewardState = event.rewardState
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_activity_1)
        --领取占领奖励广播
        GameEventCenter:dispatchEvent({ name = GuildBattleData.OCCUPY_PRIZE})
        listener()
    end
    NetWork:addNetWorkListener({28, 12}, Functions.createNetworkListener(onInfo, true, "ret"))
    local msg = {idx = {28, 12}, id = id }
    NetWork:sendToServer(msg)
end

--是否能够攻城
function GuildBattleData:sendAttackRequest(big, small)
    local onInfo = function(event)
        local bigInfo = event.playerData--GuildBattleData:getGuildBuildingInfo()[big].playerData
        --先清空数据
        GameCtlManager:push("app.ui.combatSystem.CombatViewController",
            { data = {  combatType = CombatCenter.CombatType.RB_GVG,
                big = big,
                small = small,
                playerData = bigInfo
--                {
--                    level  = 11,
--                    headId = 1,
--                    power  = 12342,
--                    name   = "sdf"
--                }
            }
            })
    end
    NetWork:addNetWorkListener({28, 6}, Functions.createNetworkListener(onInfo, true, "ret"))
    local msg = {idx = {28, 6}, big = big ,small = small}
    NetWork:sendToServer(msg)
end

--复活
function GuildBattleData:sendFuHuoInfo(bigId, listener)
    local onInfo = function(event)
        --先清空数据
        self.fuHuoInfo = event.data
--        self.CountdownTime = 0
--        GuildBattleData.eventAttr.DownTime = 0
        listener()
    end
    NetWork:addNetWorkListener({28, 13}, Functions.createNetworkListener(onInfo, true, "ret"))
    local msg = {idx = {28, 13}, id = bigId}
    NetWork:sendToServer(msg)
end

--复活后剩余元宝
function GuildBattleData:sendFuHuo(bigId, listener)
    local onInfo = function(event)
        --先清空数据
        PlayerData.eventAttr.m_gold = event.gold
        self.CountdownTime = 0
        listener()
    end
    NetWork:addNetWorkListener({28, 14}, Functions.createNetworkListener(onInfo, true, "ret"))
    local msg = {idx = {28, 14}, id = bigId}
    NetWork:sendToServer(msg)
end

--离开大城
function GuildBattleData:sendLeave()
    local onLeave = function(event)
    end
    NetWork:addNetWorkListener({28, 17}, Functions.createNetworkListener(onLeave, true, "ret"))
    local msg = {idx = {28, 17}}
    NetWork:sendToServer(msg)
end


--城池奖励
function GuildBattleData:getBuildingPrize()
    return self.buildingPrize
end

--复活倒计时
function GuildBattleData:getCountdownTime()
    return self.CountdownTime
end

--复活信息
function GuildBattleData:getfuHuoInfo()
    return self.fuHuoInfo
end

--攻城战斗倒计时
function GuildBattleData:getEndFightTime()
    return self.endfightTime
end

--攻城资源最大值
function GuildBattleData:getMaxcrystal()
    return self.Maxcrystal
end


--小城数据
function GuildBattleData:getGuildBuildingInfo()
    return self.GuildBuildingInfo
end

--攻方数据
function GuildBattleData:getAttdata()
    return self.attdata
end

--守方数据
function GuildBattleData:getDefdata()
    return self.defdata
end

--获取竞价排行信息
function GuildBattleData:getBidInfo()
    return self.bidInfo
end

--获取建筑信息
function GuildBattleData:getBuildingInfo()
    return self.buildingInfo
end

--公会战结果
function GuildBattleData:getBattleResult()
    return self.BattleResult
end

--获取正在做和已经做过任务的武将
function GuildBattleData:getTaskOldCard()

end

return GuildBattleData