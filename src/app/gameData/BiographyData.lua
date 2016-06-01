local BaseModel = require("app.baseMVC.BaseModel")
local BiographyData = class("BiographyData", BaseModel)


BiographyData.debug = false

BiographyData.FB_RECEIVE_AWARD_SUCCESS_EVENT = "FB_RECEIVE_AWARD_SUCCESS_EVENT"
BiographyData.FB_DATA_UPDATA_EVENT = "FB_DATA_UPDATA_EVENT"
BiographyData.FB_STAR_LIMIT_RESET_EVENT = "FB_STAR_LIMIT_RESET_EVENT"

BiographyData.AWARD_TYPE = 
{
    SmallType = 0,
    BigType = 1
}

BiographyData.DialogueType = 
{
    Begin = 0,
    Ended = 1
}

BiographyData.eventAttr = {}
BiographyData.eventAttr.curFbType = CombatCenter.CombatType.RB_PVE

BiographyData.eventAttr.curPassFbId = 0
BiographyData.eventAttr.curPassLittelLevel = 0

BiographyData.eventAttr.curPassEliteFbId = 0
BiographyData.eventAttr.curPassEliteLittelLevel = 0

BiographyData.eventAttr.curSelectFbId = 0
BiographyData.eventAttr.curSelectIndex = 0

BiographyData.eventAttr.curAllStarCount = 0

BiographyData.MAX_FB_ID = g_pveMAX_FB_ID

function BiographyData:init()
    
    self.super.init(self)
    --注册网络监听，游戏开始初始化数据
    --游戏战斗数据初始化命令：idx ＝ { 2, 5 }
    
    local onBiographyDataInit = function(event)

        --接受精英关卡通关信息
        self.elitePassInfos = self:serverDataHandler_(event.data.elitePassInfo)
        
        --接受普通关卡数据
        self.passInfos = self:serverDataHandler_(event.data.m_passInfo)
        --接受通关奖励数据
        self.passStarAwards = {}
        for i=1, #event.data.m_passStarAward do
            local passStarInfo = {}
            passStarInfo.m_normal = event.data.m_passStarAward[i].m_normal
            passStarInfo.m_elite = event.data.m_passStarAward[i].m_elite
            self.passStarAwards[#self.passStarAwards + 1] = passStarInfo
        end
        
        self:updateFbData()
        self:updateEliteFbData()

    end 
    
    NetWork:addNetWorkListener({ 2, 5 }, onBiographyDataInit)

    
    BiographyData.isAutoUpdateGk = true
    BiographyData.isOpenAutoFight = false
    BiographyData.isAddSpeed = false
end

--@public

--检查指定关卡是否打开
--@param: param : { fbType = , fbId = , gkId = }
--@ fbType 副本类型，分精英和普通 普通:CombatCenter.CombatType.RB_PVE 精英:CombatCenter.CombatType.RB_ElitePVE
--@ fbId 大关卡编号
--@ gkId 小关卡编号
function BiographyData:checkFbState(param)
    assert( param and param.fbId and param.gkId and param.fbType, "输入参数错误")

    local littleId = (param.fbId - 1) * 10 + param.gkId
    if param.fbType == CombatCenter.CombatType.RB_PVE then
        if littleId <= BiographyData.eventAttr.curPassLittelLevel then
            return true
        else
            return false
        end
    elseif param.fbType == CombatCenter.CombatType.RB_ElitePVE then
        if littleId <= BiographyData.eventAttr.curPassEliteLittelLevel then
            return true
        else
            return false
        end
    end
end

--获取当前精英是否通关
function BiographyData:getEliteFbFinishOfFbId(fbId)
    local info = self.elitePassInfos[fbId]
    for k,v in pairs(info) do
        if v.star == 0 then
            return false
        end
    end
    return true
end

function BiographyData:checkCurTuiduiFbState(fbId)
    return self:checkFbState({ fbType = CombatCenter.CombatType.RB_ElitePVE, fbId = fbId, gkId = 10 })
end

function BiographyData:getCurFbLevelId()
    return (BiographyData.eventAttr.curSelectFbId - 1)*10 + BiographyData.eventAttr.curSelectIndex
end

--根据副本id获取副本相关信息
--@param id :副本id
--@return { allStars : 所有星数, percent : 副本进度 }
function BiographyData:getFbDisInfoOfId(id)

    local fbInfo = {}

    --计算总星数
    local passDatas = self.passInfos[id]
    local elitePassDatas = self.elitePassInfos[id]
    
    local datas = {}
    Functions.insertTable(datas, passDatas)
    Functions.insertTable(datas, elitePassDatas)

    fbInfo.allStars = 0
    for i=1, #datas do
        fbInfo.allStars = fbInfo.allStars + datas[i].star
    end

    --计算当前副本进行百分百
    fbInfo.percent = 0
    if BiographyData.eventAttr.curPassFbId > id then
        fbInfo.percent = fbInfo.percent + 10 
    elseif BiographyData.eventAttr.curPassFbId == id then
        fbInfo.percent = fbInfo.percent + (BiographyData.eventAttr.curPassLittelLevel - (BiographyData.eventAttr.curPassFbId - 1)*10 )
    end

     if BiographyData.eventAttr.curPassEliteFbId > id then
        fbInfo.percent = fbInfo.percent + 10 
    elseif BiographyData.eventAttr.curPassEliteFbId == id then
        fbInfo.percent = fbInfo.percent + (BiographyData.eventAttr.curPassEliteLittelLevel - (BiographyData.eventAttr.curPassEliteFbId - 1)*10 )
    end

    fbInfo.percent = math.floor(fbInfo.percent/20*100)

    return fbInfo
end

--更新普通关卡数据
function BiographyData:updateFbData()
    BiographyData.eventAttr.curPassLittelLevel, BiographyData.eventAttr.curPassFbId =
        self:getFbInfosHandler_(self.passInfos)

    GameEventCenter:dispatchEvent({ name = BiographyData.FB_DATA_UPDATA_EVENT })
end

--更新精英关卡数据
function BiographyData:updateEliteFbData()
    BiographyData.eventAttr.curPassEliteLittelLevel, BiographyData.eventAttr.curPassEliteFbId =
         self:getFbInfosHandler_(self.elitePassInfos)

    GameEventCenter:dispatchEvent({ name = BiographyData.FB_DATA_UPDATA_EVENT })
end

--设置普通关卡，通关星数
--@param: fbId 大关卡id， littleLevelId 小关卡id, starNum 通关星数
function BiographyData:setFbPassStar(fbId, littleLevelId, starNum)
    
    local i = littleLevelId - (fbId - 1)*10
    if self.passInfos[fbId][i].star < starNum then
        self.passInfos[fbId][i].star = starNum
        self:updateFbData()
    end
    
    if littleLevelId == BiographyData:getCurOpenGkNumber() then
        self:updateFbData()
    else
        GameEventCenter:dispatchEvent({ name = BiographyData.FB_STAR_LIMIT_RESET_EVENT, data = { isAutoSelectGk = true }})
    end

end

--更新关卡挑战次数
function BiographyData:updateFbLimit(fbType, fbId, littleLevelId)
    self:updateFbLimitHandler(fbType, fbId, littleLevelId, 1)
end

--重置关卡挑战次数
function BiographyData:resetFbLimit(fbType, fbId, gkIndex)

    if fbType == CombatCenter.CombatType.RB_PVE then
        self.passInfos[fbId][gkIndex].limit = 0
         GameEventCenter:dispatchEvent({ name = BiographyData.FB_STAR_LIMIT_RESET_EVENT, data = { isAutoSelectGk = true }})
    elseif fbType == CombatCenter.CombatType.RB_ElitePVE then
        self.elitePassInfos[fbId][gkIndex].limit = 0
        GameEventCenter:dispatchEvent({ name = BiographyData.FB_STAR_LIMIT_RESET_EVENT, data = { isAutoSelectGk = true }})
    end
end

--更新关卡挑战次数
function BiographyData:updateFbLimitHandler(fbType, fbId, littleLevelId, count)

    local i = littleLevelId - (fbId - 1)*10
    if fbType == CombatCenter.CombatType.RB_PVE then
        self.passInfos[fbId][i].limit = self.passInfos[fbId][i].limit + count
        GameEventCenter:dispatchEvent({ name = BiographyData.FB_STAR_LIMIT_RESET_EVENT, data = { isAutoSelectGk = true }})
    elseif fbType == CombatCenter.CombatType.RB_ElitePVE then
        self.elitePassInfos[fbId][i].limit = self.elitePassInfos[fbId][i].limit + count
        GameEventCenter:dispatchEvent({ name = BiographyData.FB_STAR_LIMIT_RESET_EVENT, data = { isAutoSelectGk = true }})
    end
end

--设置精英关卡，通关星数
function BiographyData:setEliteFbPassStar(fbId, littleLevelId, starNum)

    local i = littleLevelId - (fbId - 1)*10
    if self.elitePassInfos[fbId][i].star < starNum then
        self.elitePassInfos[fbId][i].star = starNum
        self:updateFbData()
    end

    if littleLevelId == BiographyData:getCurOpenGkNumber() then
        self:updateEliteFbData()
    else
        GameEventCenter:dispatchEvent({ name = BiographyData.FB_STAR_LIMIT_RESET_EVENT, data = { isAutoSelectGk = true }})
    end

end

function BiographyData:getTuanDuiData(backCall)
	local onTuanDuiData = function(event)
        backCall(event.data.lvl)
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onTuanDuiData, true, "ret"))
    NetWork:sendToServer({ idx = { 7, 1} , reqtype = 31, data = { lidx = BiographyData.eventAttr.curSelectFbId - 6 }})
end

function BiographyData:getTaunDuiAward(backCall)
    local onTuanDuiData = function(event)

        local tdAwardItems = {}
        for k, v in ipairs(event.data.list) do 
            tdAwardItems[#tdAwardItems+1] = Factory:createTdFbAwardItem(v)
            if k == event.data.reqinfo.idx then
                tdAwardItems[#tdAwardItems].eventAttr.isApply = true 
            end
        end

        backCall({ list = tdAwardItems, reqinfo = event.data.reqinfo })
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onTuanDuiData, true, "ret"))
    NetWork:sendToServer({ idx = { 7, 1} , reqtype = 28, data = { lidx = BiographyData.eventAttr.curSelectFbId - 6 }})
end

function BiographyData:applyTDAward(backCall, index)
    local onApplyResult = function(event)
        local tdAwardItems = {}
        for k, v in ipairs(event.data.list) do 
            tdAwardItems[#tdAwardItems+1] = Factory:createTdFbAwardItem(v)
            if k == event.data.reqinfo.idx then
                tdAwardItems[#tdAwardItems].eventAttr.isApply = true 
            end
        end

        backCall({ list = tdAwardItems, reqinfo = event.data.reqinfo })
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onApplyResult, true, "ret"))
    NetWork:sendToServer({ idx = { 7, 1} , reqtype = 29, data = { lidx = BiographyData.eventAttr.curSelectFbId - 6, idx = index }})
end

--设置奖励获取
function BiographyData:setReceiveAward(id, awardType)
    if awardType == BiographyData.AWARD_TYPE.SmallType then
        self.passStarAwards[id].m_normal = 1
    elseif awardType == BiographyData.AWARD_TYPE.BigType then
        self.passStarAwards[id].m_elite = 1
    end
end

--获取当前精英关卡，普通关卡状态
function BiographyData:getCurFbState()
    local stats = {}
    if BiographyData.eventAttr.curSelectFbId <= BiographyData.eventAttr.curPassEliteFbId and 
    (BiographyData.eventAttr.curPassLittelLevel - (BiographyData.eventAttr.curSelectFbId - 1)*10) >=10 then
        stats.isOpen_jy = true
    else
        stats.isOpen_jy = false
    end

    if BiographyData.eventAttr.curSelectFbId > BiographyData.eventAttr.curPassFbId then
        stats.isOpen_pt = false
    else
        stats.isOpen_pt = true
    end

    return stats
end

--获取当前，精英关卡，团队关卡开启状态,任务系统调用
--@result : { isOpen_jy :精英副本是否打开, isOpen_td: 团队副本是否打开 }
function BiographyData:getFbOpenState()
    
    local stats = {}
    if BiographyData.eventAttr.curPassLittelLevel >= 10 then
        stats.isOpen_jy = true
    else
        stats.isOpen_jy = false
    end

    if UnionData:isHaveTong() and BiographyData.eventAttr.curPassEliteLittelLevel >= 60 then
        stats.isOpen_td = true 
    else
        stats.isOpen_td = false 
    end

    return stats
end

function BiographyData:getCurFBPageIndex()
    return math.floor((self:getCurFbIndex() - 1)/10)
end

function BiographyData:getCurFbIndex()
    if self.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then
        return BiographyData.eventAttr.curPassFbId
    else
        return BiographyData.eventAttr.curPassEliteFbId
    end
end

function BiographyData:getCurLittleLevels()
    if self.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then
        return BiographyData.eventAttr.curPassLittelLevel
    else
        return BiographyData.eventAttr.curPassEliteLittelLevel
    end
end

function BiographyData:getFbInfoOfId(id)

    local tempInfos = {}
    local oldInfos = self.passInfos[id]
    for i=1, #oldInfos do
        local littleId = (id - 1)*10 + i
        if littleId <= self:getCurOpenGkNumber() then
            local passInfo = {}
            passInfo.maxPass = ConfigHandler:getFbMaxCountOfId(littleId)
            passInfo.name = ConfigHandler:getFbNameOfId(littleId)
            passInfo.star = oldInfos[i].star
            passInfo.limit = oldInfos[i].limit
            tempInfos[i] = passInfo
        end
    end

    return tempInfos 
end

function BiographyData:getEliteFbInfoOfId(id)

    local tempInfos = {}
    local oldInfos = self.elitePassInfos[id]
    for i=1, #oldInfos do
        local littleId = (id - 1)*10 + i
        if littleId <= self:getCurOpenGkNumber() then
            local passInfo = {}
            passInfo.maxPass = g_pveEliteLimit
            passInfo.name = ConfigHandler:getFbNameOfId(littleId)
            passInfo.star = oldInfos[i].star
            passInfo.limit = oldInfos[i].limit
            tempInfos[i] = passInfo
        end
    end

    return tempInfos 
end

--获取当前副本体力限制
function BiographyData:getCruFbNeedPower()

    if BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then
        return ConfigHandler:getFbDrainPowerOfId(self:getCurFbLevelId())
    elseif BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_ElitePVE then
        return ConfigHandler:getFbDrainPowerOfId(self:getCurFbLevelId())*g_PveSweepEliteRate
    end

end
--获取当前副本次数
function BiographyData:getCruFbLimit()

    if BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then
        return g_maxSweepOfTime
    elseif BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_ElitePVE then
        return g_maxSweepOfTimeElite
    end

end

--获取当前副本关卡奖励数据
function BiographyData:getCurGkAwardData()

    local awardData = {}
    if BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then

        awardData.coin = ConfigHandler:getFbCoinOfId(self:getCurFbLevelId())
        awardData.exp = g_roleLevelExp[PlayerData.eventAttr.m_level]
        awardData.wuhun = ConfigHandler:getFbSoulOfId(self:getCurFbLevelId())

    elseif BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_ElitePVE then

        awardData.coin = ConfigHandler:getFbCoinOfId(self:getCurFbLevelId())*g_PveSweepEliteRate
        awardData.exp = g_roleLevelExp[PlayerData.eventAttr.m_level]*g_PveSweepEliteRate
        awardData.wuhun = ConfigHandler:getFbSoulOfId(self:getCurFbLevelId())*g_PveSweepEliteRate
    end

    return awardData
    
end


function BiographyData:getCurFbInfo()
    
    local passInfos = nil
    if self.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then
        passInfos = self:getFbInfoOfId(self.eventAttr.curSelectFbId)
    elseif self.eventAttr.curFbType == CombatCenter.CombatType.RB_ElitePVE then
        passInfos = self:getEliteFbInfoOfId(self.eventAttr.curSelectFbId)
    else
        passInfos = self:getFbInfoOfId(self.eventAttr.curSelectFbId)
    end
    
    return passInfos
end

--获取当前打开的最大小关卡数
function BiographyData:getCurOpenGkNumber()

    if self.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then
        return self.eventAttr.curPassLittelLevel + 1
    else
        return self.eventAttr.curPassEliteLittelLevel + 1
    end
    
end

--获取当前fb开启的最大小关卡id
function BiographyData:getCurFbMaxGkNumber()
    local temp = BiographyData:getCurOpenGkNumber() - (BiographyData.eventAttr.curSelectFbId - 1)*10
    if temp > 10 then
        return 10 
    else
        return temp
    end
end

--获取当前选中副本所有星星数
function BiographyData:getCurFbAllStars()
    local passDatas = self.passInfos[self.eventAttr.curSelectFbId]
    local elitePassDatas = self.elitePassInfos[self.eventAttr.curSelectFbId]
    
    local datas = {}
    Functions.insertTable(datas, passDatas)
    Functions.insertTable(datas, elitePassDatas)

    local allStars = 0
    for i=1, #datas do
        allStars = allStars + datas[i].star
    end

    return allStars
end

--获取当前FB星级奖励数据
function BiographyData:getCurFbAwardData()
    
	local awardDatas = {}
	for i=1, 2 do
	   local awardData = {}
        awardData.neetStarCount = g_PassStarAward[self.eventAttr.curSelectFbId][i][1]
        awardData.award = g_PassStarAward[self.eventAttr.curSelectFbId][i][2]
        awardData.curStarCount = self:getCurFbAllStars()
        if i == 1 then
            awardData.isReceive = self.passStarAwards[self.eventAttr.curSelectFbId].m_normal 
        else
            awardData.isReceive = self.passStarAwards[self.eventAttr.curSelectFbId].m_elite
        end
        
        awardDatas[#awardDatas+1] = awardData
	end
	
	return awardDatas
end

--领取奖励
function BiographyData:receiveAwared(fbId, awardType, gold, listener)
	
    local onReceiveFinish = function(event)
        self:setReceiveAward(fbId, awardType)
        if awardType == 0 then  --普通获得金币
            PlayerData.eventAttr.m_money = PlayerData.eventAttr.m_money + event.gold
        else
            PlayerData.eventAttr.m_gold = PlayerData.eventAttr.m_gold + event.gold
        end
        
        if event.hunjing and event.hunjing > 0 then
            PlayerData.eventAttr.m_soul = PlayerData.eventAttr.m_soul + event.hunjing       
        else
            Functions.addItemsToData(Functions.rewardDataHandler(event.item))
        end

        Audio.playSound("sound/ui_mp3/getrewards.mp3", false)
        listener()
        GameEventCenter:dispatchEvent({ name = BiographyData.FB_RECEIVE_AWARD_SUCCESS_EVENT, awardType = awardType })
    end
    NetWork:addNetWorkListener({ 4, 4 }, Functions.createNetworkListener(onReceiveFinish, true, "ret"))
    NetWork:sendToServer({ idx = { 4, 4 }, lidx = fbId, elite = awardType })
    
end

function BiographyData:serverDataHandler_(data)

    local passInfos = {}
    for i=1, #data do
        passInfos[i] = {}
        for j=1, #data[i].m_passStar do

            local passInfo = {}
            passInfo.limit = data[i].m_passStar[j].limit
            passInfo.star  = data[i].m_passStar[j].star

            passInfos[i][j] = passInfo
        end
    end

    return passInfos
end

function BiographyData:getFbInfosHandler_(datas)
    
    for i=1, #datas do
        fbid = i
        local passStars = datas[i]
        for j=1, #passStars do
            
            if passStars[j].star == 0 then
                return (i - 1)*10 + j - 1, i
            end
        end
    end
    return #datas * 10, #datas
end

function BiographyData:isFirstOfFbBegin(FbId)
    if BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE and FbId == BiographyData.eventAttr.curPassFbId and BiographyData:getCurOpenGkNumber()%10 == 1 then
        return true
    else
        return false
    end
end

function BiographyData:isFirstOfFbEnd(FbId)
    if BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE and FbId == BiographyData.eventAttr.curPassFbId and BiographyData:getCurOpenGkNumber()%10 == 0 then
        return true
    else
        return false
    end
end

function BiographyData:isFirstOfGk(gkId)
    
    if (gkId - 1) ~= BiographyData.eventAttr.curPassLittelLevel then
        return false
    else
        return true
    end
end

function BiographyData:getSweepData(sweepNum, callBack)

    local onSweepReturn = function(data)
        PlayerData:setPlayerPower(data.energy)

        local old_level = PlayerData.eventAttr.m_level
        for k, v in ipairs(data.result) do

            --添加资源
            PlayerData.eventAttr.m_money = PlayerData.eventAttr.m_money + v.reward.money
            PlayerData.eventAttr.m_soul = PlayerData.eventAttr.m_soul + v.reward.soul
            PlayerData.eventAttr.m_level = PlayerData.eventAttr.m_level + v.addlevel

            --添加道具
            Functions.addItemsToData(Functions.rewardDataHandler(v.reward.item))
        end
        data.levelChange = { old = old_level, new = PlayerData.eventAttr.m_level }
        
        PlayerData.eventAttr.m_exp = data.exps
        --更新关卡挑战次数
        BiographyData:updateFbLimitHandler(BiographyData.eventAttr.curFbType, BiographyData.eventAttr.curSelectFbId,
         self:getCurFbLevelId(), sweepNum)

        callBack(data)
    end
    NetWork:addNetWorkListener({ 1, 2}, Functions.createNetworkListener(onSweepReturn))

    local btype = 0
    if BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then
        btype = 4 
    else
        btype = 5
    end
    local msg = {idx = {1, 2}, btype = btype , data = { lpassid = BiographyData.eventAttr.curSelectFbId,
    spassid = BiographyData.eventAttr.curSelectIndex, times = sweepNum } }
    
    NetWork:sendToServer(msg)

end

function BiographyData:excuteFightSpeak(gkId, dialogueType, callback)
    
    if self:isFirstOfGk(gkId) then
        local dialogueIds = ConfigHandler:getGkDialogueOfId(gkId)
        for k, v in ipairs(dialogueIds) do
            if v > 0 and ConfigHandler:getTalkPosOfId(v) == dialogueType then
                PromptManager:openDialoguePrompt(v, callback)
                return
            end
        end
        callback()
    else
        callback()
    end
    
end


return BiographyData