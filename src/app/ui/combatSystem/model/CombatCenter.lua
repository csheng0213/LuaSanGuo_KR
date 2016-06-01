local CombatCenter = {}

local ConfigHandler = require("app.common.ConfigHandler")
local CreatureFactory = require("app.ui.combatSystem.model.CreatureFactory")

local CreatureModel = require("app.ui.combatSystem.model.CreatureModel")
local scheduler = require("app.common.scheduler")

CombatCenter.debug = false

CombatCenter.CombatType = {
    RB_Down = 0,
    RB_PVPPlayerList = 1, -- pvp
    RB_PVPPlayerData = 2,
    RB_PVPHistory = 3, --zhanbao
    RB_PVPHistoryData = 4, --pvp history data

    RB_PVE = 5, -- pve
    RB_ElitePVE = 6, 
    RB_BloodyBattle = 7, --xuezhan
    RB_HeroTrial = 8,
    RB_Tandui = 9, -- tuandui 
    RB_Guide = 10 ,

    RB_GVG = 11
}

CombatCenter.HurtType =
{
    BaseAttack = 0,
    BaoJi1     = 1,
    BaoJi2     = 2
}

CombatCenter.AIEventType = 
{
    EVT_BEGIN   = 0,
    EVT_TIME_OUT = 1,
    EVT_HERO_ALL_DIE = 2,
    EVT_SPELL = 3,
    EVT_AUTO_SPELL = 4,
    EVT_END = 5
}

CombatCenter.BattleFieldWidth  = 9
CombatCenter.BattleFieldLength = 16

CombatCenter.CellSize = 67
CombatCenter.BATTLE_FPS = 60

CombatCenter.BATTLE_FIELD_WIDTH_IN_TILE  = 20
CombatCenter.BATTLE_FIELD_HEIGHT_IN_TILE = 9
CombatCenter.BATTLE_SCENE_SIZE_WIDTH     = 1704
CombatCenter.BATTLE_SCENE_SIZE_HEIGHT    = 960
CombatCenter.BATTLE_TILE_SIZE            = 64

CombatCenter.PVE_COMBAT_COMMON_ENEMY_CD = 600
CombatCenter.PVE_COMBAT_COMMON_HERO_CD = 480

CombatCenter.PVP_COMBAT_COMMON_ENEMY_CD = 600
CombatCenter.PVP_COMBAT_COMMON_HERO_CD = 596

CombatCenter.FrameTimeCount = 0

CombatCenter.MapMaxSize = {
    width = CombatCenter.BattleFieldLength*CombatCenter.CellSize ,
    height = CombatCenter.BattleFieldWidth*CombatCenter.CellSize
}

--combat event enum
CombatCenter.CallBackEvent = {
    ON_ATTACK_START         = 1,
    ON_HURT                 = 2,
    ON_SPELL_HP_CHANGED     = 3,
    ON_DEAD                 = 4,
    ON_SPELL_TARGET_CHANGED = 5,
    ON_EFFECT_START         = 6,
    ON_EFFECT_END           = 7,
    ON_GAMEOVER             = 8,
    ON_CREATURE_UPDATE      = 9
}

CombatCenter.FightResult =
{
    WIN   = 1,
    FAILE = 0.
}

--event
CombatCenter.GAME_UPDATE = "GAME_UPDATE"



function CombatCenter:init(controller)
    
    cc.exports.CombatMsgHandler = self.combatMsgHandler_
    
    self.fightModelIndex        = 0
    self.fightCreatures         = {}
    self.m_lead_enemy           = 0
    self.isPause                = false
    CombatCenter.FrameTimeCount = 0
    
    self.combatHeroInfos        = {}
    self.combatEnemyInfos       = {}

    self.controller = controller
    
    InitCombatCenter()
    
    self.updateHandler = nil
    local onCombatViewQuit = function()
        scheduler.unscheduleGlobal(self.updateHandler)
    end
    Functions.addCleanFuncWithNode(self.controller._main_t, onCombatViewQuit)
    
end
---------------ai------------------
function CombatCenter:setRand(seed)
    -- 设置引擎随机因子
    AiSetRand(seed)
end

function CombatCenter:setReload()
    AiSetReload()
end

function CombatCenter:addAiEvent(eventList)
    local data = {}
    data.elist = eventList
    data.elistLen = #eventList
    AiAddEventList(data)
end

function CombatCenter:forceShutdown()
    AiForceShutDown()
end

function CombatCenter:isFinish()
    return AiIsFinish()
end

function CombatCenter:raiseEvent(event)
    AiRaiseEvent(event)
end

--@pulice
--获取攻击目标
function CombatCenter:getAttackTarOfId(id)
    local tarFightId = GetAttackTarOfFightId(id)
    return self.fightCreatures[tarFightId]
end

function CombatCenter:getCombatHeroInfos(heroInfos)

    assert(heroInfos.MainHero[1],"返回参数错误: MainHero is nil ")
    local heroCombatInfos       = {}
    
    heroCombatInfos.peopleInfos = {}
    --添加主英雄
    self:addHeroDataHandler_(heroCombatInfos.peopleInfos, heroInfos.MainHero[1], "hero")
    heroCombatInfos.peopleInfos[#heroCombatInfos.peopleInfos].solderNumLevel = heroInfos.solderNumLevel

    --添加副将
    local index = 0
    for k, v in pairs(heroInfos.ViceHeros) do
        index = index + 1
        self:addHeroDataHandler_(heroCombatInfos.peopleInfos, v, "Commander" .. tostring(index))
    end
    
    --添加偏将
    heroCombatInfos.partHeros = {}
    for k, v in pairs(heroInfos.PartHero) do
        self:addHeroDataHandler_(heroCombatInfos.partHeros, v)
    end
    
    heroCombatInfos.equipInfos = heroInfos.equipInfos

    --添加小兵
    for i=1, #heroInfos.Soldiers do
        self:addSoldierDataHandler_(heroCombatInfos.peopleInfos, heroInfos.Soldiers[i], "soldier")
    end
    
    return heroCombatInfos
end

function CombatCenter:getGVGCombatHeroInfos(heroInfos)
    assert(heroInfos.MainHero[1],"返回参数错误: MainHero is nil ")
    

    local heroAddHandler = function(param, heroType, isFrdly)
        --计算坐标
        local pointX, pointY
        
        pointX = self:createPosOfTmxX(param.x * CombatCenter.CellSize)
        pointY = self:createPosOfTmxX(param.y * CombatCenter.CellSize)
        
        local isDeath = nil
        if param.curHp then
            isDeath = param.curHp <= 0 
        else
            isDeath = false
        end

        return {
            id       = param.id,
            type     = heroType,
            x        = pointX,
            y        = pointY,
            level    = param.level,
            class    = param.class,
            curHp    = param.curHp,
            attackEx = param.attack,
            hpEx     = param.hp,
            fasEx    = param.mp,
            fafEx    = param.soldier,
            isDeath  = isDeath,
        }
    end

    local heroCombatInfos       = {}
    heroCombatInfos.peopleInfos = {}
    --添加主英雄
    heroCombatInfos.peopleInfos[#heroCombatInfos.peopleInfos + 1] = heroAddHandler(heroInfos.MainHero[1], "hero")

    --添加副将
    local index = 0
    for k, v in pairs(heroInfos.ViceHeros) do
        index = index + 1
        heroCombatInfos.peopleInfos[#heroCombatInfos.peopleInfos + 1] = heroAddHandler(v, "Commander" .. tostring(index))
    end
    
    --添加偏将
    heroCombatInfos.partHeros = {}
    for k, v in pairs(heroInfos.PartHero) do
        heroCombatInfos.peopleInfos[#heroCombatInfos.peopleInfos + 1] = heroAddHandler(v)
    end
    
    heroCombatInfos.equipInfos = heroInfos.equipInfos

    -- --团队战斗，暂时不添加小兵
    -- for i=1, #heroInfos.Soldiers do
    --     self:addSoldierDataHandler_(heroCombatInfos.peopleInfos, heroInfos.Soldiers[i], "soldier")
    -- end
    
    return heroCombatInfos
end

function CombatCenter:getOverEnemyHps()
    local hps = {}
    for k, v in ipairs(self.combatEnemyInfos.heros) do
        hps[k] = v.eventAttr.m_hp
    end
    return hps
end

function CombatCenter:getCombatBeforeHeroInfos(heroInfos)
    --添加本方英雄数据
    assert(heroInfos.MainHero[1],"返回参数错误: MainHero is nil ")

    heroBeforeInfos           = {}
    heroBeforeInfos.name      = PlayerData.eventAttr.m_name
    heroBeforeInfos.level     = PlayerData.eventAttr.m_level
    heroBeforeInfos.headId    = PlayerData.eventAttr.m_imgID
    heroBeforeInfos.heros     = {}
    heroBeforeInfos.power     = 0

    --添加装备信息
    local equipInfos = heroInfos.equipInfos or {}

    --添加主英雄
    heroBeforeInfos.heros[#heroBeforeInfos.heros+1] = heroInfos.MainHero[1].id
    heroBeforeInfos.power = heroBeforeInfos.power + cs_GetCardFightValue({ heroInfo = heroInfos.MainHero[1],
                        partHeros = heroInfos.PartHero, equipInfos = equipInfos[1]})
    
    --添加副将
    for k, v in pairs(heroInfos.ViceHeros) do
        heroBeforeInfos.heros[#heroBeforeInfos.heros+1] = v.id
        heroBeforeInfos.power = heroBeforeInfos.power + cs_GetCardFightValue({ heroInfo = v,
                        partHeros = heroInfos.PartHero, equipInfos = equipInfos[k+1]})
    end

    return heroBeforeInfos
end


function CombatCenter:getFbCombatInfosOfId( majorHurdles, littleLevels, preHps, combatType)

    combatType = combatType or CombatCenter.CombatType.RB_PVE
    --添加副本英雄数据
    local fbInfos          = ConfigHandler:loadFBInfo(littleLevels)
    local fbInfo           = fbInfos.fbInfo
    
    local enemyCombatInfos = {}
    local enemyBeforeInfos = {}
    
    enemyBeforeInfos.heros = {}
    enemyBeforeInfos.power = 0
    
    --初始化副本战场数据
    enemyBeforeInfos.fbName  = ConfigHandler:getCheckPointNameOfID(majorHurdles) .. " " .. fbInfo["小关卡标题"]
    enemyBeforeInfos.level  = PlayerData.eventAttr.m_level
    enemyBeforeInfos.headId = littleLevels
    if littleLevels < 1 then
        enemyBeforeInfos.headId = 1
    elseif littleLevels > 8 then
        enemyBeforeInfos.headId = 8
    end

    enemyCombatInfos.partHeros = {}
    --初始化fb敌人数据
    enemyCombatInfos.peopleInfos = ConfigHandler:loadZxInfoOfAllName(ConfigHandler:getHeroZxResNameOfId(fbInfo["主将ID"]))


    for i=1, #enemyCombatInfos.peopleInfos do

        if enemyCombatInfos.peopleInfos[i].type == "hero" then
            
            enemyCombatInfos.peopleInfos[i].id = fbInfo["主将ID"] or 0
            enemyCombatInfos.peopleInfos[i].level = fbInfo["主将等级"]
            enemyCombatInfos.peopleInfos[i].class = fbInfo["主将阶级"]
            enemyCombatInfos.peopleInfos[i].solderNumLevel = fbInfo["士兵数量等级"]

            local class = Functions.formatHeroClass(enemyCombatInfos.peopleInfos[i].class)
            enemyBeforeInfos.name = ConfigHandler:getHeroNameOfId(enemyCombatInfos.peopleInfos[i].id,
             class)
            if preHps then
                if preHps[1] > 0 then
                    enemyCombatInfos.peopleInfos[i].preHp = preHps[1]
                else
                    enemyCombatInfos.peopleInfos[i].isDeath = true
                end
            end
            
            enemyBeforeInfos.heros[#enemyBeforeInfos.heros+1] = enemyCombatInfos.peopleInfos[i].id
            enemyBeforeInfos.power = enemyBeforeInfos.power + Functions.getNPCFightValue({ id = enemyCombatInfos.peopleInfos[i].id,
                level = enemyCombatInfos.peopleInfos[i].level , class = enemyCombatInfos.peopleInfos[i].class,combatType = combatType })
                
        elseif enemyCombatInfos.peopleInfos[i].type == "Commander1" then
            
            enemyCombatInfos.peopleInfos[i].id = fbInfo["副将1ID"] or 0 
            enemyCombatInfos.peopleInfos[i].level = fbInfo["副将1等级"]
            enemyCombatInfos.peopleInfos[i].class = fbInfo["副将1阶级"]
            if preHps then
                if preHps[2] > 0 then
                    enemyCombatInfos.peopleInfos[i].preHp = preHps[2]
                else
                    enemyCombatInfos.peopleInfos[i].isDeath = true
                end
            end
            
            enemyBeforeInfos.heros[#enemyBeforeInfos.heros+1] = enemyCombatInfos.peopleInfos[i].id
            enemyBeforeInfos.power = enemyBeforeInfos.power + Functions.getNPCFightValue({ id = enemyCombatInfos.peopleInfos[i].id,
                level = enemyCombatInfos.peopleInfos[i].level ,class = enemyCombatInfos.peopleInfos[i].class, combatType = combatType })
                
        elseif enemyCombatInfos.peopleInfos[i].type == "Commander2" then
            
            enemyCombatInfos.peopleInfos[i].id = fbInfo["副将2ID"] or 0
            enemyCombatInfos.peopleInfos[i].level = fbInfo["副将2等级"]
            enemyCombatInfos.peopleInfos[i].class = fbInfo["副将2阶级"] 
            if preHps then
                if preHps[3] > 0 then
                    enemyCombatInfos.peopleInfos[i].preHp = preHps[3]
                else
                    enemyCombatInfos.peopleInfos[i].isDeath = true
                end
            end
            
            enemyBeforeInfos.heros[#enemyBeforeInfos.heros+1] = enemyCombatInfos.peopleInfos[i].id
            enemyBeforeInfos.power = enemyBeforeInfos.power + Functions.getNPCFightValue({ id = enemyCombatInfos.peopleInfos[i].id,
                level = enemyCombatInfos.peopleInfos[i].level ,class = enemyCombatInfos.peopleInfos[i].class, combatType = combatType })
                
        elseif enemyCombatInfos.peopleInfos[i].type == "soldier" then
            local type = tonumber(enemyCombatInfos.peopleInfos[i].name)
            if type == 1 then 
                enemyCombatInfos.peopleInfos[i].id    = fbInfo["步兵1ID"] or 0
                enemyCombatInfos.peopleInfos[i].level = fbInfo["步兵1等级"]
            elseif type == 2 then
                enemyCombatInfos.peopleInfos[i].id    = fbInfo["骑兵2ID"] or 0
                enemyCombatInfos.peopleInfos[i].level = fbInfo["骑兵2等级"]
            elseif type == 3 then
                enemyCombatInfos.peopleInfos[i].id    = fbInfo["弓兵3ID"] or 0
                enemyCombatInfos.peopleInfos[i].level = fbInfo["弓兵3等级"]
            end
        end
        enemyCombatInfos.peopleInfos[i].x = self:createPosOfTmxX(tonumber(enemyCombatInfos.peopleInfos[i].x))
        enemyCombatInfos.peopleInfos[i].y = self:createPosOfTmxY(tonumber(enemyCombatInfos.peopleInfos[i].y))
    end
    
    return enemyBeforeInfos, enemyCombatInfos
end

function CombatCenter:getHeroTrialInfos(majorHurdles, littleLevels, enemyIds)

    local enemyBeforeInfos  = {}
    enemyBeforeInfos.level  = PlayerData.eventAttr.m_level
    enemyBeforeInfos.headId = 1
    
    enemyBeforeInfos.heros  = {}
    enemyBeforeInfos.power  = 0

    local heroTrialData = ConfigHandler:getTrialHeroConfigOfLevel(PlayerData.eventAttr.m_level)
    
    enemyBeforeInfos.heros[#enemyBeforeInfos.heros+1] = enemyIds[1]
    enemyBeforeInfos.power = enemyBeforeInfos.power + Functions.getNPCFightValue({ id = enemyBeforeInfos.heros[#enemyBeforeInfos.heros],
        level = heroTrialData["主将等级"], class = heroTrialData["主将阶级"] })

    for i=1, 2 do
        enemyBeforeInfos.heros[#enemyBeforeInfos.heros+1] = enemyIds[i+1]
        enemyBeforeInfos.power = enemyBeforeInfos.power + Functions.getNPCFightValue({ id = enemyBeforeInfos.heros[#enemyBeforeInfos.heros],
            level = heroTrialData["副将" ..  tostring(i) .. "等级"], class = heroTrialData["副将" ..  tostring(i) .. "阶级"] })
    end

    --设置挑战名字
    if majorHurdles == 1 then 
        enemyBeforeInfos.name = LanguageConfig["language_Teach29"]
    elseif majorHurdles == 2 then
        enemyBeforeInfos.name = LanguageConfig["language_Teach30"]
    elseif majorHurdles == 3 then
        enemyBeforeInfos.name = LanguageConfig["language_Teach31"]
    end

    --根据难度算战斗力
    if littleLevels == 1 then
        enemyBeforeInfos.power = math.floor(enemyBeforeInfos.power*( 1 - 0.3))
    elseif littleLevels == 2 then
    elseif littleLevels == 3 then
        enemyBeforeInfos.power = math.floor(enemyBeforeInfos.power*( 1 + 0.3))
    end
    
    return enemyBeforeInfos
end

function CombatCenter:getBloodyBattleData(majorHurdles, littleLevels, backCall)
	local onBloodyDataRequire = function(event)
	
        local enemyBeforeInfos  = {}
        enemyBeforeInfos.level  = littleLevels
        enemyBeforeInfos.headId = 1
        enemyBeforeInfos.name   = string.format(LanguageConfig["language_Teach34"], littleLevels)
        
        enemyBeforeInfos.heros = {}
        enemyBeforeInfos.power = 0
        for i=1, 3 do
            enemyBeforeInfos.heros[#enemyBeforeInfos.heros + 1] = event.data[i].id
            enemyBeforeInfos.power = enemyBeforeInfos.power + math.floor(Functions.getNPCFightValue({ id = event.data[i].id,
                level = event.data[i].level, class = event.data[i].class })*event.data.add)
        end
        backCall({ enemyCombatBeforInfo = enemyBeforeInfos })
		return true
	end
    NetWork:addNetWorkListener({16,2}, Functions.createNetworkListener(onBloodyDataRequire,true,"ret"))
    NetWork:sendToServer({ idx = { 16, 2} , diff = majorHurdles })
end

--获取战斗英雄数据
function CombatCenter:getFightHeroInfo()
    return { heroInfo = self.combatHeroInfos, enemyInfo = self.combatEnemyInfos }
end

--fight相关
function CombatCenter:initCombat(heroCombatInfos, enemyCombatInfos, combatType)

    self:initCombatOfInfo_(heroCombatInfos, true, combatType)
    self:initCombatOfInfo_(enemyCombatInfos, false, combatType)
    self.curCombatType = combatType
    if combatType == CombatCenter.CombatType.RB_PVPPlayerData or combatType == CombatCenter.
        CombatType.RB_PVPHistoryData then
        AiSetFSBSCD(CombatCenter.PVP_COMBAT_COMMON_HERO_CD)
        AiSetESBSCD(CombatCenter.PVP_COMBAT_COMMON_ENEMY_CD)
    else
        AiSetFSBSCD(CombatCenter.PVE_COMBAT_COMMON_HERO_CD)
        AiSetESBSCD(CombatCenter.PVE_COMBAT_COMMON_ENEMY_CD)
    end
    self:initCombatAutoConfig_()

    --设置cd时间
end

function CombatCenter:setEnemyAuto(isAuto)
	SetEnemyAutoFight(isAuto)
end

function CombatCenter:setHeroAuto(isAuto)
	SetSelfAutoFight(isAuto)
end

function CombatCenter:addHeroDataHandler_(heroDatas, param, heroType, isFrdly)
    
    --计算坐标
    local pointX, pointY
    
    pointX = self:createPosOfTmxX(param.x * CombatCenter.CellSize)
    pointY = self:createPosOfTmxX(param.y * CombatCenter.CellSize)
    
    --添加参数
	heroDatas[#heroDatas+1] = 
	{
        id       = param.id,
        type     = heroType,
        x        = pointX,
        y        = pointY,
        level    = param.level,
        class    = param.class,
        attackEx = param.attack,
        hpEx     = param.hp,
        fasEx    = param.mp,
        fafEx    = param.soldier
	}
	
end

function CombatCenter:addSoldierDataHandler_(heroDatas, param, heroType, isFrdly)

    --计算坐标
    local pointX, pointY

    pointX = self:createPosOfTmxX(param.x * CombatCenter.CellSize)
    pointY = self:createPosOfTmxX(param.y * CombatCenter.CellSize)

    --添加参数
    heroDatas[#heroDatas+1] = 
        {
            id = param.id,
            type = heroType,
            x = pointX,
            y = pointY,
            level = param.level
        }

end

--@param : creatureInfo = { { name, type, x, y, level }...} 
function CombatCenter:initCombatOfInfo_(creatureInfos, isFrdly, combatType)
    
    local beforeInfo = {}
    
    beforeInfo.heros = {}
    local m_lead_enemy = 0
    --初始化英雄
    
    local peopleInfos = creatureInfos.peopleInfos
    local partHeros   = creatureInfos.partHeros
    local equipInfos  = creatureInfos.equipInfos
    local leadCount   = 1
    local heroZxID = 0
    for i=1, #peopleInfos do
        local heroId = tonumber(peopleInfos[i].id)
        if heroId > 0 then
            local creature = nil
            if peopleInfos[i].type == "hero" then
                
                --获取阵型id
                heroZxID = ConfigHandler:getHeroZxIdOfId(peopleInfos[i].id)

                if not peopleInfos[i].isDeath then

                    local equipInfo = nil
                    if equipInfos then
                        equipInfo = equipInfos[1]
                    end
                    creature = CreatureFactory:createHero(peopleInfos[i], partHeros, equipInfo, isFrdly,
                        CreatureModel.viewType.lord, self:createPos({ x = peopleInfos[i].x, y = peopleInfos[i].y }, 0, isFrdly), combatType, heroZxID)

                    if combatType == CombatCenter.CombatType.RB_PVPHistoryData or 
                        combatType == CombatCenter.CombatType.RB_PVPPlayerData then
                        leadCount = 4
                    elseif combatType == CombatCenter.CombatType.RB_PVE or 
                        combatType == CombatCenter.CombatType.RB_ElitePVE or 
                        combatType == CombatCenter.CombatType.RB_Tandui or
                        combatType == CombatCenter.CombatType.RB_Guide then
                        if isFrdly then
                            leadCount = Functions.getSoldierCountOfLevel(PlayerData.eventAttr.m_level)
                        else
                            leadCount = Functions.getSoldierCountOfLevel(peopleInfos[i].solderNumLevel)
                        end
                    else
                        if isFrdly then
                            leadCount = Functions.getSoldierCountOfLevel(PlayerData.eventAttr.m_level)
                        else
                            leadCount = Functions.getSoldierCountOfLevel(peopleInfos[i].level)
                        end
                    end
                    
                    beforeInfo.heros[#beforeInfo.heros + 1] = creature
                end
            elseif peopleInfos[i].type == "Commander1" then

                local equipInfo = nil
                if equipInfos then
                    equipInfo = equipInfos[2]
                end
                if not peopleInfos[i].isDeath then
                    creature = CreatureFactory:createHero(peopleInfos[i], partHeros, equipInfo, isFrdly,
                        CreatureModel.viewType.lieutenant, self:createPos({ x = peopleInfos[i].x, y = peopleInfos[i].y }, 0, isFrdly), combatType, heroZxID)
                    
                    beforeInfo.heros[#beforeInfo.heros + 1] = creature
                end
                
            elseif peopleInfos[i].type == "Commander2" then
                
                local equipInfo = nil
                if equipInfos then
                    equipInfo = equipInfos[3]
                end
                
                if not peopleInfos[i].isDeath then
                    creature = CreatureFactory:createHero(peopleInfos[i], partHeros, equipInfo, isFrdly,
                        CreatureModel.viewType.lieutenant, self:createPos({ x = peopleInfos[i].x, y = peopleInfos[i].y }, 0, isFrdly), combatType, heroZxID)
                    
                    beforeInfo.heros[#beforeInfo.heros + 1] = creature
                end
            end
    
            if creature then
                m_lead_enemy = creature.m_num + m_lead_enemy
                self:addCreature(creature)
            end
        end
    end

    --初始化战场小兵

    local creatures = nil
    if not isFrdly then
        m_lead_enemy = m_lead_enemy*2
    end

    for i=1, #peopleInfos do
        if peopleInfos[i].type == "soldier" then
            creatures = CreatureFactory:createSoldiers(tonumber(peopleInfos[i].id), peopleInfos[i].level, isFrdly,
                { x = peopleInfos[i].x, y = peopleInfos[i].y }, leadCount, m_lead_enemy, handler(self, self.createPos), combatType, heroZxID, peopleInfos[i].gainValue )
        end

        self:addCreatures(creatures)
    end
    
    if isFrdly then
        self.combatHeroInfos = beforeInfo
    else
        self.combatEnemyInfos = beforeInfo
    end
    
end

function CombatCenter:initCombatAutoConfig_()
    assert(self.combatHeroInfos and self.combatHeroInfos.heros,"not hero data!")
    assert(self.combatEnemyInfos and self.combatEnemyInfos.heros,"not hero data!")
    
    local addAutoFightCon = function(heros, isFrdly)
        local lieutenantCount = 1
        for i=1, #heros do
            if heros[i].m_viewType == CreatureModel.viewType.lord then
                self:addAutoConfigOfHeroId(isFrdly, CreatureModel.AutoFightType.AFH_MAIN_HERO, heros[i].m_pid)
            elseif heros[i].m_viewType == CreatureModel.viewType.lieutenant then
                self:addAutoConfigOfHeroId(isFrdly, CreatureModel.AutoFightType.AFH_MAIN_HERO + lieutenantCount, heros[i].m_pid)
                lieutenantCount = lieutenantCount + 1
            end
        end
    end

    addAutoFightCon(self.combatHeroInfos.heros, true)
    addAutoFightCon(self.combatEnemyInfos.heros, false)
    
end

function CombatCenter:addAutoConfigOfHeroId(isFly, fightIndex, heroId)
    local autoSkillCon = clone(AutoFightConfig[1])
    if autoSkillCon then
        autoSkillCon.skillConLen = #autoSkillCon
        for i=1, #autoSkillCon do
            autoSkillCon[i].skillCfgLen = #autoSkillCon[i]
        end
        
        local autoConfig = { isFly = isFly, index = fightIndex, id = heroId, data = autoSkillCon }
        AddAutoFightCon(autoConfig)
    end
end

--@--public
function CombatCenter:getCombatCreatures()
	return self.fightCreatures
end

function CombatCenter:getAiEventList()
    local data = GetAIEventList()
    return data["elist"]
end

function CombatCenter:getAiCreatureList()
    local data = GetAICreatureList()
    return data["clist"]
end

function CombatCenter:getHeroHpList()
    local data = AiGetHpList()
    return data
end

function CombatCenter:addCreature(creature)
    assert(creature,"addCreature error : creature is null")
    
    self.fightModelIndex = self.fightModelIndex + 1
    creature:setFightNumber(self.fightModelIndex)
    self.fightCreatures[self.fightModelIndex] = creature
    AddCreatureToAIengin(creature)
    
end


function CombatCenter:addCreatures(creatures)
    if creatures then
        for i=1, #creatures do
            self:addCreature(creatures[i])
        end
    end
end

function CombatCenter:combatStart()

    Audio.playSound("sound/ui_mp3/daping.mp3", false)
    StartCombatCenter()
    self.updateHandler = scheduler.scheduleUpdateGlobal(handler(self, self.updateAI))
end

function CombatCenter:jumpCombatStart()
    
end

function CombatCenter:updateAI()
    if not self.isPause then
        if not self:isFinish() then
            if self.controller.isAddSpeed then
                CombatCenter.FrameTimeCount = CombatCenter.FrameTimeCount + 2
                UpdateCombatCenter()
                UpdateCombatCenter()
                GameEventCenter:dispatchEvent({ name = CombatCenter.GAME_UPDATE })
            else
                CombatCenter.FrameTimeCount = CombatCenter.FrameTimeCount + 1
                UpdateCombatCenter()
                GameEventCenter:dispatchEvent({ name = CombatCenter.GAME_UPDATE })
            end
        else
            self:gameOver_()
        end
	end
end

function CombatCenter:combatPause()
    AiPause()
    self.isPause = true
end

function CombatCenter:combatResume()
    AiResume()
    self.isPause = false
end

function CombatCenter:combatForceEnd(result)
    
    self.isPause = true
    self:forceShutdown()
    self:gameOver_()

end

function CombatCenter:createPosOfTmxX(x)
    return x + CombatCenter.CellSize/2
end

function CombatCenter:createPosOfTmxY(y)
    return CombatCenter.MapMaxSize.height - y - CombatCenter.CellSize/2
end

function CombatCenter:createPos(pos, count, campType)

    if count == 0 then  
        --英雄
        return self:createPosOfCamp(pos, campType)
    else
        --小兵
        local srcPos = self:createPosOfCamp(pos, campType)
        return self:createChildPos(srcPos,count)
    end 
   
end

function CombatCenter:createPosOfCamp(pos, campType)
    
    local point = {}
    if campType then
        point.x = pos.x
        point.y = pos.y
    else
        point.x = CombatCenter.MapMaxSize.width - pos.x
        point.y = pos.y
    end
    return point
    
end

function CombatCenter:createChildPos(pos, count)
	
	local points = {}
	if count == 1 then
		points[#points+1] = pos
    elseif count == 2 then
        points[#points+1] = { x = pos.x, y = pos.y + CombatCenter.CellSize/4 }    
        points[#points+1] = { x = pos.x, y = pos.y - CombatCenter.CellSize/4 }
    elseif count == 3 then
        points[#points+1] = { x = pos.x + CombatCenter.CellSize/4, y = pos.y + CombatCenter.CellSize/4 }    
        points[#points+1] = { x = pos.x + CombatCenter.CellSize/4, y = pos.y - CombatCenter.CellSize/4 }
        points[#points+1] = { x = pos.x - CombatCenter.CellSize/4, y = pos.y + CombatCenter.CellSize/4 }
    elseif count == 4 then
        points[#points+1] = { x = pos.x + CombatCenter.CellSize/4, y = pos.y + CombatCenter.CellSize/4 }    
        points[#points+1] = { x = pos.x + CombatCenter.CellSize/4, y = pos.y - CombatCenter.CellSize/4 }
        points[#points+1] = { x = pos.x - CombatCenter.CellSize/4, y = pos.y + CombatCenter.CellSize/4 }
        points[#points+1] = { x = pos.x - CombatCenter.CellSize/4, y = pos.y - CombatCenter.CellSize/4 }
	end
	
    return points
end

function CombatCenter:createPosOfCoor(pos, count, campType)

end

function CombatCenter:getFightResult()

    if self.controller.combatTimeOut then
        if self.curCombatType == CombatCenter.CombatType.RB_Tandui then
            if self.combatEnemyInfos.heros[1].eventAttr.m_state ~= CreatureModel.stateType.S_DYING then
                return CombatCenter.FightResult.FAILE
            else
                return CombatCenter.FightResult.WIN
            end
        else
            return CombatCenter.FightResult.FAILE
        end
    else
        if self.curCombatType == CombatCenter.CombatType.RB_Tandui then
            if self.combatEnemyInfos.heros[1].eventAttr.m_state ~= CreatureModel.stateType.S_DYING then
                return CombatCenter.FightResult.FAILE
            else
                return CombatCenter.FightResult.WIN
            end
        else
            for k, v in pairs(self.combatEnemyInfos.heros) do
                if v.eventAttr.m_state ~= CreatureModel.stateType.S_DYING then
                    return CombatCenter.FightResult.FAILE
                end
            end
        end
    end

    return CombatCenter.FightResult.WIN
end



--@--private
function CombatCenter.combatMsgHandler_(...)
      
    local param = { ... }
    local combatHandler = function()
        CombatCenter.MsgHandlerFuncs[param[1]](param)
    end
    
    Functions.debugCall(combatHandler)
    
end

function CombatCenter:onHeroAttackStart_(param)
    Functions.printInfo(self.debug, "hero attack start call")
    
    local heroId, level = param[2], param[3]
    --更新战斗creatrue数据
    self.fightCreatures[heroId]:onAttackStart_(level)
end
  
function CombatCenter:onHeroHurt_(param)
    Functions.printInfo(self.debug, "hero hurt call")
    
    local heroId, sender, val, level = param[2], param[3], param[4], param[5]
    --更新战斗creatrue数据
    self.fightCreatures[heroId]:onHurt_(self.fightCreatures[sender], val, level)
end

function CombatCenter:onHeroSpellHpChanged_(param)
    Functions.printInfo(self.debug, "hero spell hp change call")
    
    local heroId, val, level = param[2], param[3], param[4]
    --更新战斗creatrue数据
    self.fightCreatures[heroId]:onSpellHpChanged_(val, level)
end

function CombatCenter:onHeroDead_(param)
    Functions.printInfo(self.debug, "hero dead call")
    
    local heroId = param[2]
    self.fightCreatures[heroId]:onDead_()
end

function CombatCenter:onHeroTargetChanged_(param)
    Functions.printInfo(self.debug, "hero target changed call")
    
    local heroId = param[2]
    self.fightCreatures[heroId]:onSpellTargetChanged_()
end

function CombatCenter:onHeroEffectStart_(param)
    Functions.printInfo(self.debug, "hero effect start call")
    
    local heroId  = param[2]
    local skillId = param[3]
    local isLoop  = param[4]
    local msgId   = param[5]
    self.fightCreatures[heroId]:onEffectStart_(skillId, isLoop, msgId)
end

function CombatCenter:onHeroEffectEnd_(param)
    Functions.printInfo(self.debug, "hero effect start call")
    
    local heroId  = param[2]
    local skillId = param[3]
    local msgId   = param[4]
    self.fightCreatures[heroId]:onEffectEnd_(skillId, msgId)
end

function CombatCenter:gameOver_(param)
    Functions.printInfo(self.debug, "hero game over call")
    
    if self.curCombatType == CombatCenter.CombatType.RB_Guide then
        if self.updateHandler then
            scheduler.unscheduleGlobal(self.updateHandler)
        end
        self.controller:stopTimer()
        self.controller:firstCombatGuide()
    else
        if self.updateHandler then
            scheduler.unscheduleGlobal(self.updateHandler)
        end

        if not self.controller.combatTimeOut then   --如果不是战斗时间用完结束
            self.updateHandler = scheduler.scheduleUpdateGlobal(UpdateCombatCenter)

            self.controller:stopTimer()
            transition.execute(self.controller.view_t, cc.DelayTime:create(3), {
                onComplete = function()
                    if self.updateHandler then
                        scheduler.unscheduleGlobal(self.updateHandler)
                    end
                    self.controller:fightOver(self:getFightResult())
                end
            })
        else  --时间消耗完结束
            for k, v in pairs(self.fightCreatures) do
                v.eventAttr.m_state = CreatureModel.stateType.S_IDLE
            end

            transition.execute(self.controller.view_t, cc.DelayTime:create(1), {
                onComplete = function()
                    self.controller:fightOver(self:getFightResult())
                end
               })
        end
    end
end


function CombatCenter:onCreatureUpdate_(param)
    Functions.printInfo(self.debug, "hero creature update call")
    
    local heroId, posX, posY, direX, direY, heroHp, heroHpMax, heroAtk, heroFaf, heroFas, heroState, startCombatCD, commonSpellCD, spellCD
     = param[2], param[3], param[4], param[5], param[6], param[7], param[8], param[9], param[10], param[11], param[12], param[13], param[14], param[15]

    
    --更新战斗creatrue数据
    self.fightCreatures[heroId].eventAttr.m_hp = heroHp

    self.fightCreatures[heroId].eventAttr.m_hp_max = heroHpMax

    self.fightCreatures[heroId].eventAttr.m_atk = heroAtk

    self.fightCreatures[heroId].eventAttr.m_faf = heroFaf

    self.fightCreatures[heroId].eventAttr.m_fas = heroFas
    
    local pos = { x = posX, y = posY }
    self.fightCreatures[heroId].eventAttr.m_pos = pos
    
    local dire = { x = direX, y = direY }
    self.fightCreatures[heroId].eventAttr.m_dire = dire
    
    self.fightCreatures[heroId].eventAttr.m_state = heroState

    self.fightCreatures[heroId].eventAttr.m_startCombatCD = startCombatCD or 0
    self.fightCreatures[heroId].eventAttr.m_commonSpellCD = commonSpellCD or 0
    self.fightCreatures[heroId].eventAttr.m_spellCD = spellCD or 0

end


CombatCenter.MsgHandlerFuncs = 
{ 
    [CombatCenter.CallBackEvent.ON_ATTACK_START] = handler(CombatCenter, CombatCenter.onHeroAttackStart_),
    [CombatCenter.CallBackEvent.ON_HURT] = handler(CombatCenter, CombatCenter.onHeroHurt_),
    [CombatCenter.CallBackEvent.ON_SPELL_HP_CHANGED] = handler(CombatCenter, CombatCenter.onHeroSpellHpChanged_),
    [CombatCenter.CallBackEvent.ON_DEAD] = handler(CombatCenter, CombatCenter.onHeroDead_),
    [CombatCenter.CallBackEvent.ON_SPELL_TARGET_CHANGED] = handler(CombatCenter, CombatCenter.onHeroTargetChanged_),
    [CombatCenter.CallBackEvent.ON_EFFECT_START] = handler(CombatCenter, CombatCenter.onHeroEffectStart_),
    [CombatCenter.CallBackEvent.ON_EFFECT_END] = handler(CombatCenter, CombatCenter.onHeroEffectEnd_),
    [CombatCenter.CallBackEvent.ON_CREATURE_UPDATE] = handler(CombatCenter, CombatCenter.onCreatureUpdate_)
}


return CombatCenter