local BaseModel = require("app.baseMVC.BaseModel")
local EmbattleData = class("EmbattleData", BaseModel)

EmbattleData.debug = false

EmbattleData.EmbattleInf = {}
EmbattleData.Itype = 1
EmbattleData.MainHeroMark = 0
EmbattleData.ViceHero1Mark = 0
EmbattleData.ViceHero2Mark = 0
EmbattleData.PartHeroMark = {0,0,0,0,0,0}

EmbattleData.MainHeroMarkBak = 0
EmbattleData.ViceHero1MarkBak  = 0
EmbattleData.ViceHero2MarkBak  = 0
EmbattleData.PartHeroMarkBak  = {0,0,0,0,0,0}

EmbattleData.MainHeroPos = {x = 0,y = 0}
EmbattleData.ViceHero1Pos = {x = 0,y = 0}
EmbattleData.ViceHero2Pos = {x = 0,y = 0}

EmbattleData.EmbattleInf.MainHero = {}   --主将
EmbattleData.EmbattleInf.PartHero = {}   --偏将
EmbattleData.EmbattleInf.Soldiers  = {}   --士兵
EmbattleData.EmbattleInf.SoldiersBak  = {}   --士兵
EmbattleData.EmbattleInf.ViceHeros = {}  --
EmbattleData.soldierId = {}
EmbattleData.eventAttr.zhanLi = 0
EmbattleData.eventAttr.daiBing = 0
EmbattleData.eventAttr.infantryNum = 0
EmbattleData.eventAttr.cavalryNum = 0
EmbattleData.eventAttr.archerNum = 0

EmbattleData.EmbattleTypeEnum =
{
    attack = 1,
    defense = 2
}


function EmbattleData:init()
    self.super.init(self)
    --注册网络监听，游戏开始初始化数据
    --游戏布阵数据初始化命令：idx ＝ { 1, 3 }
end
--加载服务器布阵信息
function EmbattleData:loadEmbattleData(embattleType,hander)

    local onEmbattleInit = function(event)
        local data = event.Formation
        self.Itype = event.Itype
        for k, v in pairs(data) do
            self.EmbattleInf[k] = v
        end
        -- local jasonStr  = json.encode(self.EmbattleInf)
        -- print(jasonStr)
        self.EmbattleInf.SoldiersBak  = clone(EmbattleData.EmbattleInf.Soldiers) 
        self.soldierId = event.soldierid
        if hander ~= nil then
           hander()
        end
    end
    NetWork:addNetWorkListener({ 1, 3}, Functions.createNetworkListener(onEmbattleInit, true, "ret"))

    local msg = {idx = {1, 3},rtype = 2 ,data = { ltype = embattleType }}
    NetWork:sendToServer(msg)
end
function EmbattleData:cleanAllEmbattleData()
    self.EmbattleInf = {}
    self.Itype = 1
    self.MainHeroMark = 0
    self.ViceHero1Mark = 0
    self.ViceHero2Mark = 0
    self.PartHeroMark = {0,0,0,0,0,0}

    self.MainHeroMarkBak = 0
    self.ViceHero1MarkBak  = 0
    self.ViceHero2MarkBak  = 0
    self.PartHeroMarkBak  = {0,0,0,0,0,0}
    self.MainHeroPos = {x = 0,y = 0}
    self.ViceHero1Pos = {x = 0,y = 0}
    self.ViceHero2Pos = {x = 0,y = 0}

    self.EmbattleInf.MainHero = {}   --主将
    self.EmbattleInf.PartHero = {}   --偏将
    self.EmbattleInf.Soldiers  = {}   --士兵
    self.EmbattleInf.SoldiersBak  = {}   --士兵
    self.EmbattleInf.ViceHeros = {}  --

    EmbattleData.eventAttr.zhanLi = 0
    EmbattleData.eventAttr.chouMou = 0
    EmbattleData.eventAttr.daiBing = 0

    EmbattleData.eventAttr.infantryNum = 0
    EmbattleData.eventAttr.cavalryNum = 0
    EmbattleData.eventAttr.archerNum = 0
end
--得到阵型信息
function EmbattleData:cleanEmbattleBasecInf()
    EmbattleData.eventAttr.infantryNum = 0
    EmbattleData.eventAttr.cavalryNum = 0
    EmbattleData.eventAttr.archerNum = 0
end

--@embattle:attack攻击阵型  defense防御阵型
function EmbattleData:getEmbattleInfos(embattleType,hander)
    local onEmbattleInit = function(event)
        hander(event.Formation)
    end
    NetWork:addNetWorkListener({ 1, 3}, Functions.createNetworkListener(onEmbattleInit, true, "ret"))
    local msg = {idx = {1, 3},rtype = 2 ,data = { ltype = embattleType }}
    NetWork:sendToServer(msg)
end

--根据武将位置获取响应的武将mark 
function EmbattleData:getHeroMarkOfPos(embattleType,pos)
    self:initHeroMark(embattleType)
    if pos == 1 then 
        return  self.MainHeroMark
    elseif pos == 2 then
        return  self.ViceHero1Mark
    elseif pos == 3 then
        return  self.ViceHero2Mark
    end
end
--更新属性信息
function EmbattleData:updateAtrrInf(embattleType)
    local inf = {embattleType = embattleType, mainHeroMark=self.MainHeroMark,viceHeroMarks={self.ViceHero1Mark,self.ViceHero2Mark},partHeroMarks=self.PartHeroMark}
    local zhanLi = Functions.getFinalFightAttrs(inf)
    local daiBing = Functions.getFinalSoldiersNum({mainHeroMark=self.MainHeroMark,viceHeroMarks={self.ViceHero1Mark,self.ViceHero2Mark}})
    self.eventAttr.zhanLi = zhanLi
    self.eventAttr.daiBing = daiBing

end
--初始化布阵英雄在背包中的mark
function EmbattleData:initHeroMark(embattleModel)

    if self.EmbattleInf.MainHero[1] ~= nil then
        local heroInf = HeroCardData:getHeroMark(self.EmbattleInf.MainHero[1].id,1,embattleModel)
        if heroInf ~= nil then
            self.MainHeroMark = heroInf.m_mark
            self.MainHeroMarkBak = heroInf.m_mark
        end
    end
    if self.EmbattleInf.ViceHeros[1] ~= nil then
        local heroInf = HeroCardData:getHeroMark(self.EmbattleInf.ViceHeros[1].id,2,embattleModel)
        if heroInf ~= nil then
            self.ViceHero1Mark = heroInf.m_mark
            self.ViceHero1MarkBak = heroInf.m_mark
        end
    end
    if self.EmbattleInf.ViceHeros[2] ~= nil then
        local heroInf = HeroCardData:getHeroMark(self.EmbattleInf.ViceHeros[2].id,3,embattleModel)
        if heroInf ~= nil then
            self.ViceHero2Mark = heroInf.m_mark
            self.ViceHero2MarkBak = heroInf.m_mark
        end
    end
    for k,v in pairs(self.EmbattleInf.PartHero) do
        if self.EmbattleInf.PartHero[k] ~= nil then
            local heroInf = HeroCardData:getHeroMark(self.EmbattleInf.PartHero[k].id,k+3,embattleModel)
            if heroInf ~= nil then
                self.PartHeroMark[k] = heroInf.m_mark
                self.PartHeroMarkBak[k] = heroInf.m_mark
            end
        end
    end
    -- body
end
--更新所有上阵英雄的上阵状态
function EmbattleData:saveAllHeroState(embattleType)
    self:saveHeroState("MainHeroMark","MainHeroMarkBak",embattleType)
    self:saveHeroState("ViceHero1Mark","ViceHero1MarkBak",embattleType)
    self:saveHeroState("ViceHero2Mark","ViceHero2MarkBak",embattleType)
    for i = 1,6 do
        self:saveHeroState("PartHeroMark","PartHeroMarkBak",embattleType,i)
    end
end
--恢复所有上阵英雄的上阵状态
function EmbattleData:regainAllHeroState(embattleType)
    self:regainHeroState("MainHeroMark","MainHeroMarkBak",embattleType)
    self:regainHeroState("ViceHero1Mark","ViceHero1MarkBak",embattleType)
    self:regainHeroState("ViceHero2Mark","ViceHero2MarkBak",embattleType)
    for i = 1,6 do
        self:regainHeroState("PartHeroMark","PartHeroMarkBak",embattleType,i)
    end
end
--判断上阵信息是否有改动
function EmbattleData:isHaveUpdate()
    if self.MainHeroMark ~= self.MainHeroMarkBak then
        return true
    end
    if self.ViceHero1Mark ~= self.ViceHero1MarkBak then
        return true
    end
    if self.ViceHero2Mark ~= self.ViceHero2MarkBak then
        return true
    end
    for i=1,6 do
        if self.PartHeroMark[i] ~= self.PartHeroMarkBak[i] then
            return true
        end
    end
    if #self.EmbattleInf.SoldiersBak ~= #self.EmbattleInf.Soldiers then 
        return true
    else
        local cnt = 0
        for i=1,#self.EmbattleInf.SoldiersBak do 
            for j = 1,#self.EmbattleInf.Soldiers do 
                if self.EmbattleInf.SoldiersBak[i].id == self.EmbattleInf.Soldiers[j].id and self.EmbattleInf.SoldiersBak[i].x == self.EmbattleInf.Soldiers[j].x and self.EmbattleInf.SoldiersBak[i].y == self.EmbattleInf.Soldiers[j].y then
                    cnt = cnt + 1 
                    break
                end
            end 
        end
        if cnt ~= #self.EmbattleInf.SoldiersBak then 
            return true
        end
    end

    return false
end
--根据英雄mark设置英雄上阵状态
function  EmbattleData:saveHeroState(newMark,oldMark,embattleType,i)
    if i == nil then
        if EmbattleData[oldMark] ~= EmbattleData[newMark] then
            local oldHeroInf =  HeroCardData:searchHeroOfMark(EmbattleData[oldMark])
            local newHeroInf =  HeroCardData:searchHeroOfMark(EmbattleData[newMark])
            if embattleType == 1 then
               if oldHeroInf ~= nil  then 
                   oldHeroInf.m_atkFormFlag = oldHeroInf.m_atkFormFlagTemp
               end
                if newHeroInf ~= nil then
                    newHeroInf.m_atkFormFlag = newHeroInf.m_atkFormFlagTemp 
                end
            elseif  embattleType == 2 then
                if oldHeroInf ~= nil then
                    oldHeroInf.m_defFormFlag = 0
                    oldHeroInf.m_defFormFlagTemp = 0 
                end
                if newHeroInf ~= nil then 
                    newHeroInf.m_defFormFlag = newHeroInf.m_defFormFlagTemp 
                end
            end  
        end
        EmbattleData[oldMark] = EmbattleData[newMark]
    else
        if EmbattleData[oldMark][i] ~= EmbattleData[newMark][i]  then
            local oldHeroInf =  HeroCardData:searchHeroOfMark(EmbattleData[oldMark][i])
            local newHeroInf =  HeroCardData:searchHeroOfMark(EmbattleData[newMark][i])
            if embattleType == 1 then
                if oldHeroInf ~= nil then 
                   oldHeroInf.m_atkFormFlag = oldHeroInf.m_atkFormFlagTemp
                end
                if newHeroInf ~= nil then
                    newHeroInf.m_atkFormFlag = newHeroInf.m_atkFormFlagTemp 
                end
            elseif  embattleType == 2  then
                if oldHeroInf ~= nil  then
                    oldHeroInf.m_defFormFlag = 0
                    oldHeroInf.m_defFormFlagTemp = 0 
                end
                if newHeroInf ~= nil then 
                    newHeroInf.m_defFormFlag = newHeroInf.m_defFormFlagTemp 
                end
            end  
        end
        EmbattleData[oldMark][i] = EmbattleData[newMark][i]
    end   
end
--恢复英雄上阵状态
function  EmbattleData:regainHeroState(newMark,oldMark,embattleType,i)
    if i == nil then
        if EmbattleData[oldMark] ~= EmbattleData[newMark] then
            local oldHeroInf =  HeroCardData:searchHeroOfMark(EmbattleData[oldMark])
            local newHeroInf =  HeroCardData:searchHeroOfMark(EmbattleData[newMark])
            if embattleType == 1 then
                if newHeroInf ~= nil then
                    -- newHeroInf.m_atkFormFlag = 0
                    -- newHeroInf.m_atkFormFlagTemp = 0 
                    newHeroInf.m_atkFormFlagTemp = newHeroInf.m_atkFormFlag
                end
                if oldHeroInf ~= nil then
                    oldHeroInf.m_atkFormFlagTemp = oldHeroInf.m_atkFormFlag
                end
            elseif  embattleType == 2 then
                if newHeroInf ~= nil then
                    newHeroInf.m_atkFormFlagTemp = newHeroInf.m_atkFormFlag
                end
                if oldHeroInf ~= nil then
                    oldHeroInf.m_defFormFlagTemp = oldHeroInf.m_defFormFlag
                end
            end 
        end
        EmbattleData[newMark] = EmbattleData[oldMark]
    else
        if EmbattleData[oldMark][i] ~= EmbattleData[newMark][i] then
            local oldHeroInf =  HeroCardData:searchHeroOfMark(EmbattleData[oldMark][i])
            local newHeroInf =  HeroCardData:searchHeroOfMark(EmbattleData[newMark][i])
            if embattleType == 1 then
               if newHeroInf ~= nil then
                   newHeroInf.m_atkFormFlagTemp = newHeroInf.m_atkFormFlag
               end
                if oldHeroInf ~= nil then
                    oldHeroInf.m_atkFormFlagTemp = oldHeroInf.m_atkFormFlag
                end
            elseif  embattleType == 2 then
                if newHeroInf ~= nil then
                    newHeroInf.m_defFormFlag = 0
                    newHeroInf.m_defFormFlagTemp = 0 
                end
                if oldHeroInf ~= nil then
                    oldHeroInf.m_defFormFlagTemp = oldHeroInf.m_defFormFlag
                end
            end 
        end
        EmbattleData[newMark][i] = EmbattleData[oldMark][i]
    end
end
--根据英雄位置返回英雄mark
function EmbattleData:getHeroMarkOfType(heroPos)
    if heroPos == 0 then
        return self.MainHeroMark
    elseif heroPos == 1 then
        return self.ViceHero1Mark
    elseif heroPos == 2 then
        return self.ViceHero2Mark
    end
end
--判断某个上阵武将是否有缘分偏将
function EmbattleData:isHaveFateHero(heroMark,partHeroMarks,fateType)
    local heroId = HeroCardData:getHeroID(heroMark)
    for k,v in partHeroMarks do
        local partHeroId = HeroCardData:getHeroID(v)
        if fateType == 1 then
            if ConfigHandler:getFateHero1IdOfId(heroId) == partHeroId then
                return true
            end
        elseif fateType == 2 then
            if ConfigHandler:getFateHero2IdOfId(heroId) == partHeroId then
                return true
            end
        end
    end
    return false
end
return EmbattleData