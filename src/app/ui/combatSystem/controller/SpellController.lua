local SpellController = class("SpellController")

local CreatureModel = require("app.ui.combatSystem.model.CreatureModel")

function SpellController:ctor(param)

	assert( type(param.view) == "userdata" and type(param.model) == "table", "param is error")
	self.view  = param.view
	self.model = param.model
	self.parentCtl = param.parentCtl

	self.isStartCombat = false
	self.isSpellEnable = false
	self.isCommonSpell = false

	self.isDeath = false
	self.isParentPause = false

	--初始化相关ui
	self:initUI()

end

function SpellController:initUI()

	--初始化技能按钮
    local sprite = Functions.createSprite()
    Functions.initHeroHeadSprite(sprite, self.model.m_pid)
    
    local cdTime = cc.ProgressTimer:create(sprite) 

    local model = self.view:getChildByName("headCom"):getChildByName("model")
    local colorBg = model:getChildByName("headColor")

    model:getChildByName("star"):setLocalZOrder(1)
    local head = model:getChildByName("head")
    local size = head:getContentSize()
    colorBg:setContentSize(size)
    colorBg:setVisible(true)
    
    cdTime:setPosition(head:getPositionX(), head:getPositionY())
    model:addChild(cdTime)

    --初始化动画节点
    self.animaNode = self.view:getChildByName("animaNode")
    Functions.playAnimaOfUI(self.animaNode:getChildByName("animaSprite"), "Ani_skillRelease")

    --bt
	self.spellbt = self.view:getChildByName("bt")
    self.spellbt:onTouch(Functions.createClickListener(function()
    		if self.isStartCombat and self.isCommonSpell and self.isSpellEnable and not self.parentCtl.isPause 
    			and self.model.eventAttr.m_state ~= CreatureModel.stateType.S_FREEZING then

    			if self.isParentPause then
    				self.parentCtl:logicResume()
    			end

    			self:setSpellCDState(false)
    			cdTime:setPercentage(0)
    			CombatCenter:raiseEvent({ raiser = self.model.m_fightNumber , etype = CombatCenter.AIEventType.EVT_SPELL }) 
            	GameEventCenter:dispatchEvent({ name = CreatureModel.SI_FANG_SPELL_EVENT })
            end
        end))

    --绑定死亡事件
	local onHeroDeath = function()
		Functions.setGraySprite(head, true)
		colorBg:setVisible(false)
		cdTime:setVisible(false)
		self.animaNode:setVisible(false)
        self.isDeath = true
	end
	Functions.bindEventListener(self.view, self.model, CreatureModel.HERO_DEAD_EVENT, onHeroDeath)

	--绑定技能cd
	local onStartCombatCD = function(event)
		
		if self.isDeath then return end

		cdTime:setPercentage(event.data)
		if event.data == 100 then
		  	self:setStartSpellCDState(true)
		else
			self:setStartSpellCDState(false)
		end
	end
	Functions.bindUiWithModelAttr(self.view, self.model, "m_startCombatCD", onStartCombatCD)

	local onCommonSpellCD = function(event)

		if self.isDeath then return end

		if self.isStartCombat and self.isSpellEnable then
			cdTime:setPercentage(event.data)
		end
        if event.data == 100 then
            self:setCommonCDState(true)
        else
        	self:setCommonCDState(false)
        end
	end
	Functions.bindUiWithModelAttr(self.view, self.model, "m_commonSpellCD", onCommonSpellCD)

	local onSpellCD = function(event)

		if self.isDeath then return end

		if self.isStartCombat then
			cdTime:setPercentage(event.data)
		end
        if event.data == 100 then
        	self:setSpellCDState(true)
       	else
       		self:setSpellCDState(false)
        end
	end
	Functions.bindUiWithModelAttr(self.view, self.model, "m_spellCD", onSpellCD)

end

function SpellController:setCommonCDState(isFinish)
	self.isCommonSpell = isFinish
	self:updateAnima()
end

function SpellController:setSpellCDState(isFinish)
	self.isSpellEnable = isFinish
	self:updateAnima()
end

function SpellController:setStartSpellCDState(isFinish)
	self.isStartCombat = isFinish
	self:updateAnima()
end

function SpellController:updateAnima()
	if self:isSpellReady() then
		self.animaNode:setVisible(true)
		--新手引导
	    if PlayerData.eventAttr.m_guideId == 5 and not GuideManager.isSpellGuide then
	    	self.isParentPause = true
	    	GuideManager.isSpellGuide = true
	    	PromptManager:openNewGuide(self.spellbt, LanguageConfig.ui_CombatView_1)
	    	self.parentCtl:logicPause()
	    end
	else
		self.animaNode:setVisible(false)
	end
end

function SpellController:isSpellReady()
	return self.isStartCombat and self.isCommonSpell and self.isSpellEnable
end



return SpellController