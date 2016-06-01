local BaseModel = require("app.baseMVC.BaseModel")

local CreatureModel = class("CreatureModel", BaseModel)

--
CreatureModel.SI_FANG_SPELL_EVENT = "SI_FANG_SPELL_EVENT"

CreatureModel.debug = false
--事件属性
CreatureModel.eventAttr          = {}
CreatureModel.eventAttr.m_hp     = 0 
CreatureModel.eventAttr.m_hp_max = 0
CreatureModel.eventAttr.m_atk    = 0 
CreatureModel.eventAttr.m_fas    = 0 
CreatureModel.eventAttr.m_faf    = 0 

CreatureModel.eventAttr.m_pos           = nil
CreatureModel.eventAttr.m_dire          = nil
CreatureModel.eventAttr.m_state         = nil
CreatureModel.eventAttr.m_startCombatCD = 0
CreatureModel.eventAttr.m_commonSpellCD = 0
CreatureModel.eventAttr.m_spellCD       = 0

--事件名称
CreatureModel.HERO_DEAD_EVENT = "HERO_DEAD_EVENT"
CreatureModel.SKILL_ATTACK_EVENT = "SKILL_ATTACK_EVENT"
CreatureModel.SKILL_EFFECT_START_EVENT = "SKILL_EFFECT_START_EVENT"
CreatureModel.SKILL_EFFECT_END_EVENT = "SKILL_EFFECT_END_EVENT"
CreatureModel.SPELL_HP_CHANGED_EVENT = "SPELL_HP_CHANGED_EVENT"
CreatureModel.ON_HURT_EVENT = "ON_HURT_EVENT"
CreatureModel.ON_ATTACK_START_EVENT = "ON_ATTACK_START_EVENT"

CreatureModel.campType = {
    hero = true,
    enemy = false
}

CreatureModel.stateType = {
    S_NONE = 1,
    S_ALIVE = 2,
    S_ATTACK = 3,
    S_FREEZING = 4,
    S_IDLE = 5,
    S_VICTORY = 6,
    S_DYING = 7,
    S_MOVE = 8,
    S_SPELLING = 9
}

CreatureModel.viewType = {
    lord = 1,
    lieutenant = 2,
    infantry = 3,
    cavalry = 4,
    archer = 5
}

CreatureModel.AutoFightType = 
{
    AFH_NONE = 0,
    AFH_MAIN_HERO = 1,
    AFH_VICE_HERO1 = 2,
    AFH_VICE_HERO2 = 3,
}
        
--@params : { heroId, campType, viewType, dire, pos, veiwName, resId, hp,
--    mp, atk, num, round, atk_spd, atk_range, vis_field, mv_spd, cnotion, spells, passiveSkills } 
function CreatureModel:ctor(params)

	--attribut
    self.m_pid                     = params.heroId
    self.m_class                   = params.class
    self.m_frdly                   = params.campType
    self.m_viewType                = params.viewType
    self.m_dire                    = params.dire
    self.eventAttr.m_dire = params.dire
    self.m_pos                     = params.pos
    self.eventAttr.m_pos  = params.pos
    self.m_viewName                = params.veiwName
    self.m_resId                   = params.resId
    
    self.m_hp                      = params.hp
    self.eventAttr.m_hp            = params.hp
    self.m_hp_max                  = params.hp
    self.m_raw_hp                  = params.hp
    self.m_raw_hp_max              = params.hp
    
    self.m_atk                     = params.atk
    self.m_raw_atk                 = params.atk
    
    self.m_fas                     = params.fas
    self.m_fas_max                 = params.fas
    self.m_raw_fas                 = params.fas
    self.m_raw_fas_max             = params.fas
    
    self.m_faf                     = params.faf
    self.m_faf_max                 = params.faf
    self.m_raw_faf                 = params.faf
    self.m_raw_faf_max             = params.faf
    
    self.m_baoj                    = params.baoj
    self.m_raw_baoj                = params.baoj
    
    self.m_baos                    = params.baos
    self.m_raw_baos                = params.baos
    
    self.m_wuli                    = params.wuli or 0
    self.m_zhili                   = params.zhili or 0
    self.m_tongyu                  = params.tongyu or 0
    
    self.m_num                     = params.num
    self.m_round                   = params.round
    
    self.m_atk_spd                 = params.atk_spd
    self.m_raw_atk_spd             = params.atk_spd
    
    self.m_atk_range               = params.atk_range
    self.m_raw_atk_range           = params.atk_range
    
    self.m_vis_field               = params.vis_field
    self.m_raw_vis_field           = params.vis_field
    
    self.m_mv_spd                  = params.mv_spd
    self.m_raw_mv_spd              = params.mv_spd

    self.m_zxId                    = params.zxId
    self.m_enemyZxId               = params.enemyZxId
    
    self.m_cnotion                 = params.cnotion
    
    self.skillAnimaName            = params.skillAnimaName
    self.heroSound                 = params.heroSound

    --初始化技能
    if params.spells then
        if not self.m_spells then 
            self.m_spells = require("app.ui.combatSystem.model.SpellPiece").new()
        end
        
        for k,v in pairs(params.spells) do
            self.m_spells:addSkillData(v)
        end
    end
    
    if params.passiveSkills then
        if not self.m_spells then 
            self.m_spells = require("app.ui.combatSystem.model.SpellPiece").new()
        end
        
        for k,v in pairs(params.passiveSkills) do
            self.m_spells:addPassiveSkillData(v)
        end
    end
    
    if params.soldierSkills then
        if not self.m_spells then 
            self.m_spells = require("app.ui.combatSystem.model.SpellPiece").new()
        end

        for i=1, #params.soldierSkills do
            self.m_spells:addSoldierSkill(params.soldierSkills[i])
        end
    end

    if params.otherSkills then
        if not self.m_spells then 
            self.m_spells = require("app.ui.combatSystem.model.SpellPiece").new()
        end

        for i=1, #params.otherSkills do
            self.m_spells:addOtherSkill(params.otherSkills[i])
        end
    end
    
	--func
	self.onAttackStart = handler(self, self.onAttackStart_)
	self.onHurt = handler(self, self.onHurt_)
    self.onSpellHpChanged = handler(self, self.onSpellHpChanged_)
    self.onDead = handler(self, self.onDead_)
    self.onSpellTargetChanged = handler(self, self.onSpellTargetChanged_)
    self.onEffectStart = handler(self, self.onEffectStart_)
    self.onEffectEnd = handler(self, self.onEffectEnd_)
    
    --parent init
    self:init()
    
end

function CreatureModel:init()
    self.super.init(self)
end

function CreatureModel:setFightNumber(value)
    self.m_fightNumber = value
end

function CreatureModel:setHp(hp)
    self.m_hp                      = hp
    self.eventAttr.m_hp            = hp
    self.m_hp_max                  = hp
    self.m_raw_hp                  = hp
    self.m_raw_hp_max              = hp
end

function CreatureModel:getHp()
    return self.m_raw_hp
end

function CreatureModel:setAttack(attack)
    self.m_atk                     = attack
    self.m_raw_atk                 = attack
end

function CreatureModel:getAttack()
    return self.m_raw_atk
end

function CreatureModel:setFas(fas)
    self.m_fas                     = fas
    self.m_fas_max                 = fas
    self.m_raw_fas                 = fas
    self.m_raw_fas_max             = fas
end

function CreatureModel:getFas()
    return self.m_raw_fas
end

function CreatureModel:setFaf(faf)
    self.m_faf                     = faf
    self.m_faf_max                 = faf
    self.m_raw_faf                 = faf
    self.m_raw_faf_max             = faf
end

function CreatureModel:getFaf()
    return self.m_raw_faf
end

function CreatureModel:setMvSpd(mv_spd)
    self.m_mv_spd                  = mv_spd
    self.m_raw_mv_spd              = mv_spd
end

function CreatureModel:getMvSpd()
    return self.m_raw_mv_spd
end

function CreatureModel:updateAttrExOfZx(combatType, zxId, campType)

    if combatType ~= CombatCenter.CombatType.RB_GVG then
        local zxType  = ConfigHandler:getZxEffectType(zxId)
        local zxValue = ConfigHandler:getZxEffectValue(zxId)

        local _, doubleBuffName = Functions.getTianTiBuffZX()
        local isDouble =  doubleBuffName == "language_" .. ConfigHandler:getZxNameOfId(zxId)
        if campType and combatType == CombatCenter.CombatType.RB_PVPPlayerData and isDouble then
            zxValue = zxValue * 2
        end

        if zxType == 1 then
            self:setHp(self:getHp()*(1+zxValue))
        elseif zxType == 2 then
            self:setAttack(self:getAttack()*(1+zxValue))
        elseif zxType == 3 then
            self:setFas(self:getFas()*(1+zxValue))
        elseif zxType == 4 then
            self:setFaf(self:getFaf()*(1+zxValue))
        elseif zxType == 5 then
            self:setMvSpd(self:getMvSpd()*(1+zxValue))
        elseif zxType == 6 then
            self:setHp(self:getHp()*(1+zxValue))
            self:setAttack(self:getAttack()*(1+zxValue))
            self:setFas(self:getFas()*(1+zxValue))
            self:setFaf(self:getFaf()*(1+zxValue))
        end
    end
end

--c++回调
function CreatureModel:onAttackStart_(level)
	Functions.printInfo(self.debug, "onAttackStart_ is call")

    self:dispatchEvent({ name = CreatureModel.ON_ATTACK_START_EVENT , data = { level = level }})
end

function CreatureModel:onHurt_(sender, val, level)
	Functions.printInfo(self.debug, "onHurt_ is call")

    self:dispatchEvent({ name = CreatureModel.ON_HURT_EVENT, data = { sender = sender, val = val, level = level }})
end

function CreatureModel:onSpellHpChanged_(val, level)
	Functions.printInfo(self.debug, "onSpellHpChanged is call")

    self:dispatchEvent({ name = CreatureModel.SPELL_HP_CHANGED_EVENT, data = { val = val, level = level } })
end

function CreatureModel:onDead_()
	Functions.printInfo(self.debug, "onDead_ is call")
	
    self:dispatchEvent({ name =  CreatureModel.HERO_DEAD_EVENT })
end

function CreatureModel:onSpellTargetChanged_()
	Functions.printInfo(self.debug, "onSpellTargetChanged_ is call")
	
    local CombatCenter = require("app.ui.combatSystem.model.CombatCenter")
	if CombatCenter.FrameTimeCount >  20 then
        self:dispatchEvent({ name =  CreatureModel.SKILL_ATTACK_EVENT })
    end
    
end

function CreatureModel:onEffectStart_(skillId, isLoop, msgId)
	Functions.printInfo(self.debug, "onEffectStart_ is call")
	
    local CombatCenter = require("app.ui.combatSystem.model.CombatCenter")
    if CombatCenter.FrameTimeCount >  20 then
        self:dispatchEvent({ name =  CreatureModel.SKILL_EFFECT_START_EVENT, data = { id = skillId, isLoop = isLoop, msgId = msgId }})
    end
end

function CreatureModel:onEffectEnd_(skillId, msgId)
	Functions.printInfo(self.debug, "onEffectEnd is call")
	
    local CombatCenter = require("app.ui.combatSystem.model.CombatCenter")
    if CombatCenter.FrameTimeCount >  20 then
        self:dispatchEvent({ name =  CreatureModel.SKILL_EFFECT_END_EVENT, data = { id = skillId , msgId = msgId} })
    end
end




return CreatureModel
