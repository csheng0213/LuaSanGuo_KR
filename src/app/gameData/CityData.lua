local BaseModel = require("app.baseMVC.BaseModel")

local CityData = class("CityData", BaseModel)

CityData.debug = false

CityData.UPDATE_TASK = "UPDATE_TASK"

--存放做任务的卡片（mark=,type=）mark－卡片标记，type-任务类型
--CityData.cardTaskOne = { mark = 0, type = 0 }
--CityData.cardTaskTwo = {mark = 0, type = 0}
--CityData.cardTaskThree = {mark = 0, type = 0}

--存放正在做和已经做过任务的武将
CityData.taskOldCard = {}

--主城标志
CityData.eventAttr.cityDataBZ = 0

--CurLv         建筑等级
--sloting       正在任务的武将
--InitTime      开始任务的时间
--NeedExp       建筑升级经验
--oldslot1      已经做完任务的武将
--oldslot2      已经做完任务的武将
--state         建筑目前状态(0代表没做任务，1代表正在做任务，2代表可以领奖励)
--count         任务剩余次数            


function CityData:init()
    self.super.init(self)
    self.jianZhuinfo = {}
    self.taskHoreInfo = {}
    --建筑信息
    local onInfo = function(event)
        --先清空数据
        self.jianZhuinfo = {}
        self.jianZhuinfo = event.data
        
        --先清空任务卡数据
        CityData.taskOldCard = {}
        local dataCard = {}
        dataCard = event.data
        for k, v in pairs(dataCard) do
            if dataCard[k].sloting > 0 then
                CityData.taskOldCard[#CityData.taskOldCard + 1] = dataCard[k].sloting
            end
            
            for j, v in pairs(dataCard[k].oldSlot) do
                if v > 0 then
                    CityData.taskOldCard[#CityData.taskOldCard + 1] = v
                end
            end
        end
        self:setCityDataBZ()
    end
    NetWork:addNetWorkListener({ 2, 21 }, onInfo)
    
    self:Acceleration()
    
    local onInfHore = function(event)
        --先清空数据
        self.taskHoreInfo = {}
        --先清空任务卡数据
        CityData.taskHoreInfo = {}
        local dataCard = {}
        dataCard = event.data
        for k, v in pairs(dataCard) do
            CityData.taskHoreInfo[#CityData.taskHoreInfo + 1] = v
        end
    end
    NetWork:addNetWorkListener({ 2, 22 }, onInfHore)
end

--加速完成（以及时间走完都是这个接口）
function CityData:Acceleration()
    local onAcceleration = function(event)
        if event.stype == 1 then
            Functions.setAdbrixTag("retension","mgt_castle_mission_reward_buy", PlayerData.eventAttr.m_level )
        end
--        Functions.setAdbrixTag("retension","mgt_castle_mission_complete")
        local data = self:getArchitectureInfo()
        PlayerData.eventAttr.m_gold = event.gold

        --改变做完任务的建筑状态
        data[event.stIdx].state = event.state
        data[event.stIdx].InitTime = 0
        self:setCityDataBZ()
        --数据更新监听
        GameEventCenter:dispatchEvent({ name = CityData.UPDATE_TASK, data = event })
    end
    NetWork:addNetWorkListener({ 24, 5 }, onAcceleration)
end

--刷新主城标志
function CityData:setCityDataBZ()
    local data = CityData:getArchitectureInfo()
    for k,v in pairs(data) do
        if v.state == 2 then
            CityData.eventAttr.cityDataBZ = 1
            return CityData.eventAttr.cityDataBZ
        end
    end
    CityData.eventAttr.cityDataBZ = 0
    return CityData.eventAttr.cityDataBZ
end


--获取正在做任务的武将
function CityData:getTaskHoreInfo()
    return self.taskHoreInfo
end

--获取建筑信息
function CityData:getArchitectureInfo()
    return self.jianZhuinfo
end

--获取正在做和已经做过任务的武将
function CityData:getTaskOldCard()
    return CityData.taskOldCard
end

return CityData