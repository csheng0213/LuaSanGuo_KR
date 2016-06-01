local SpellPiece = class("SpellPiece")

local CombatCenter = require("app.ui.combatSystem.model.CombatCenter")
SpellPiece.debug = true

function SpellPiece:ctor()
    self.skillDatas = {}
    self.m_SkillLen = 0
    
    self.passiveSkillDatas = {}
    self.m_passiveSkillLen = 0
    
    self.soldierSkillDatas = {}
    self.m_soldierSkillLen = 0

    self.otherSkillDatas = {}
    self.m_otherSkillLen = 0
end

function SpellPiece:addSkillData(skillId)
    
    local skillInfos = ConfigHandler:getSkillInfos(skillId)
    if skillInfos then
    	local skillData = self:initSkillData_(skillInfos)
    	self.skillDatas[#self.skillDatas + 1 ] = skillData
        
        self.m_SkillLen = #self.skillDatas
    end
end

function SpellPiece:addPassiveSkillData(skillId)

    local passiveSkillInfo = ConfigHandler:getPassiveSkillId(skillId)
    if passiveSkillInfo then
        local passiveSkillData = self:initPassiveSkillData_(passiveSkillInfo)
        self.passiveSkillDatas[#self.passiveSkillDatas + 1 ] = passiveSkillData 
        
        self.m_passiveSkillLen = #self.passiveSkillDatas
    end
end

function SpellPiece:addOtherSkill(skillData)
    local otherSkillData = {}
    otherSkillData.id = skillData.id
    otherSkillData.effect = skillData.effect
    otherSkillData.state = skillData.state
    otherSkillData.val_pct = skillData.val_pct

    self.otherSkillDatas[#self.otherSkillDatas + 1] = otherSkillData
    self.m_otherSkillLen = #self.otherSkillDatas
end

function SpellPiece:addSoldierSkill(skillInfo)
    local soldierSkillData = {}
    soldierSkillData.id = skillInfo.id
    soldierSkillData.range = skillInfo.range
    soldierSkillData.effect = skillInfo.effect
    soldierSkillData.state = skillInfo.state
    soldierSkillData.val_pct = skillInfo.val_pct
    soldierSkillData.interval = skillInfo.interval
    soldierSkillData.total_time = skillInfo.total_time
    
    self.soldierSkillDatas[#self.soldierSkillDatas + 1] = soldierSkillData
    
    self.m_soldierSkillLen = #self.soldierSkillDatas
end

function SpellPiece:initSkillData_(skillInfo)
	
	local skillData = {}
	skillData.m_skillId = skillInfo["ID"]
    skillData.m_skillName = skillInfo["技能名字"]
    skillData.m_SkillDescribe = skillInfo["技能描述"]
    skillData.m_SkillCd = skillInfo["CD时间"] * CombatCenter.BATTLE_FPS
    skillData.m_SkillRes = skillInfo["技能片特效"]
    skillData.m_SkillScall = skillInfo["技能片缩放比例"]
    skillData.m_SkillRange = skillInfo["技能范围"]
    skillData.m_SkillPos = skillInfo["技能基准点"]
    skillData.m_SkillFrdly = skillInfo["阵营选择"]
    skillData.m_SkillRadius = skillInfo["半径"]
    skillData.m_SkillAngle = skillInfo["角度"]
    skillData.m_SkillHeight = skillInfo["高度"]
    skillData.m_SkillWidth = skillInfo["宽度"]
    skillData.m_SkillBackdis = skillInfo["身后距离"]
    skillData.m_SkillCond = skillInfo["值条件(条件)"]
    skillData.m_SkillPCond = skillInfo["百分比条件(条件)"]
    skillData.m_SkillProb = skillInfo["几率(条件)"]
    skillData.m_SkillVal = skillInfo["值(条件)"]
    skillData.m_Skillval_pct = skillInfo["百分比(条件)"]
    skillData.m_SkillDelay = skillInfo["延迟时间"]
    if not skillData.m_SkillDelay or skillData.m_SkillDelay <= 0 then
        skillData.m_SkillDelay = 1
    end
    skillData.m_SkillInterval = skillInfo["间隔时间"]
    skillData.m_SkillTotal_time = skillInfo["总时间"]
    skillData.m_SkillEffect = skillInfo["效果选择"]
    skillData.m_SkillSpc = skillInfo["作用属性"]
    skillData.m_SkillState = skillInfo["效果状态"]
    skillData.m_SkillEffectVal_pct = skillInfo["百分比"]
    skillData.m_SkillBaseDamage = skillInfo["基础伤害"]
    skillData.m_SkillDamageType = skillInfo["技能伤害类型"]
    skillData.m_SkillDelayType = skillInfo["延时类型"]
    skillData.m_SkillEDescribe = skillInfo["效果描述"]
    skillData.m_SkillSound = skillInfo["技能声效"]
    skillData.m_param1 = skillInfo["参数1"]
    skillData.m_param2 = skillInfo["参数2"]
    skillData.m_param3 = skillInfo["参数3"]
    skillData.m_param4 = skillInfo["参数4"]
    return skillData
end

function SpellPiece:initPassiveSkillData_(skillInfo)
    local passiveSkillData = {}
    passiveSkillData.m_id = skillInfo["id"]
    passiveSkillData.m_name = skillInfo["name"]
    passiveSkillData.m_describe = skillInfo["describe"]
    passiveSkillData.m_spellRange = skillInfo["range"]
    passiveSkillData.m_addHp = skillInfo["hpPercent"]
    passiveSkillData.m_addAttack = skillInfo["attackPercent"]
    passiveSkillData.m_addFas = skillInfo["fasPercent"]
    passiveSkillData.m_addFaf = skillInfo["fafPercent"]
    passiveSkillData.m_skillFrdly = skillInfo["skillFrdly"]

    return passiveSkillData
end




return SpellPiece