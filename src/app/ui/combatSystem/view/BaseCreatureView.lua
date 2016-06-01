
local BaseCreatureView = class("BaseCreatureView", cc.Node)

local CreatureModel = require("app.ui.combatSystem.model.CreatureModel")
local CombatViewController = require("app.ui.combatSystem.CombatViewController")

local CombatConfigs = require("app.common.ConfigHandler")
local ResManager = require("app.common.ResManager")

BaseCreatureView.animaTables = 
{
    [CreatureModel.stateType.S_MOVE] = 
    {
            [0] = { "walk_rightup_anim", false, false },
            [1] = { "walk_up_anim", false, false},
            [2] = { "walk_rightup_anim", true, false},
            [3] = { "walk_right_anim", true, false },
            [4] = { "walk_rightdown_anim", true, false },
            [5] = { "walk_down_anim", false, false},
            [6] = { "walk_rightdown_anim", false, false},
            [7] = { "walk_right_anim", false, false},
    },
    [CreatureModel.stateType.S_ATTACK] = 
    {
            [0] = { "attack_rightup_anim", false, false },
            [1] = { "attack_up_anim", false, false},
            [2] = { "attack_rightup_anim", true, false},
            [3] = { "attack_right_anim", true, false },
            [4] = { "attack_rightdown_anim", true, false },
            [5] = { "attack_down_anim", false, false},
            [6] = { "attack_rightdown_anim", false, false},
            [7] = { "attack_right_anim", false, false},
    },
    [CreatureModel.stateType.S_VICTORY] = 
    {
            [0] = { "victory_down_anim", false, false },
            [1] = { "victory_down_anim", false, false},
            [2] = { "victory_down_anim", false, false},
            [3] = { "victory_down_anim", false, false },
            [4] = { "victory_down_anim", false, false },
            [5] = { "victory_down_anim", false, false},
            [6] = { "victory_down_anim", false, false},
            [7] = { "victory_down_anim", false, false},
    },
    [CreatureModel.stateType.S_IDLE] = 
    {
            [0] = { "idle_rightup_anim", false, false },
            [1] = { "idle_rightup_anim", false, false},
            [2] = { "idle_rightup_anim", true, false},
            [3] = { "idle_rightup_anim", true, false },
            [4] = { "idle_rightdown_anim", true, false },
            [5] = { "idle_rightdown_anim", true, false},
            [6] = { "idle_rightdown_anim", false, false},
            [7] = { "idle_rightup_anim", false, false},
    },
    [CreatureModel.stateType.S_DYING] = 
    {
            [0] = { "die_rightup_anim", false, false },
            [1] = { "die_rightup_anim", false, false},
            [2] = { "die_rightup_anim", true, false},
            [3] = { "die_right_anim", true, false },
            [4] = { "die_rightdown_anim", true, false },
            [5] = { "die_rightdown_anim", false, false},
            [6] = { "die_rightdown_anim", false, false},
            [7] = { "die_right_anim", false, false},
    },
}
    


function BaseCreatureView:ctor(controller, model)
    
    assert(model, "creature model error : model is nil")
    
    self.model = model
    self.controller = controller
    
    self:initDisplayNode()

    --添加伤害显示widget
    self.hurtDisNode = require("app.ui.common.ActionQueueWidget").new()
    self:addChild(self.hurtDisNode)
    
    --获取动画node
    self.animaNode = Functions.createSprite()
    self.animaNode:setLocalZOrder(-1)
    self:addChild(self.animaNode)
    
    --绑定相关功能
    self:bindFunc_()
    
    
    --初始化动画数据
    local resPath = nil
    if self.model.m_viewType <= 2 then --英雄
        self.heroAnimas = ConfigHandler:loadHeroAnimaInfo(self.model.m_resId)
        self.animaNode:setScale(2)
    else   --小兵
        self.heroAnimas = ConfigHandler:loadSoldierAnimaInfo(self.model.m_resId)
    end
    
    self.m_deadState = false
    
    --初始化相关数据
    self.effectLists = {}
    
    --初始化状态
    self.animaState = CreatureModel.stateType.S_IDLE
    
    --初始化方向
    if self.model.m_frdly then  
        self.idir = 0
    else
        self.idir = 4
    end

    self.initScale = self:getScale()
    
end

function BaseCreatureView:initDisplayNode()

    --根据model 视图类型，加载不同的node，
    self.displayNode_ = Factory:createHeroNode(self.model.m_viewType)
    self:addChild(self.displayNode_)

    --根据不同阵营，初始化相关ui
    if not self.model.m_frdly then
        local hp = self.displayNode_:getChildByName("hp_panel"):getChildByName("hp")
        Functions.loadImageWithWidget(hp, "cs/ui_res/CombatUI/combat_xiaohpred.png")
        local name = self.displayNode_:getChildByName("name")
        Functions.initWidgetWithColor({ color = display.COLOR_RED, widgets = { name }})
    else
--        local hp = self.displayNode_:getChildByName("hp_panel"):getChildByName("hp")
        local name = self.displayNode_:getChildByName("name")
        Functions.initWidgetWithColor({ color = display.COLOR_GREEN, widgets = { name }})
    end

    --fightNumber
    self.displayNode_:getChildByName("fightNumber"):setString(self.model.m_fightNumber)

    self:setScale(0.7)   
end

function BaseCreatureView:playAnimaOfZX(backCall)
    
end

function BaseCreatureView:bindFunc_()

    --绑定坐标
    self.oldPos = { x = self.model.eventAttr.m_pos.x, y = self.model.eventAttr.m_pos.y }
    self.controller:coordinateSystem(self.oldPos)  --坐标转换
    self:setPosition(self.oldPos)
    self:setLocalZOrder( 2000 - self.oldPos.y )
    local onPosChange = function(event)
        if self.m_deadState then return end
        if self.animaState == CreatureModel.stateType.S_IDLE then return end

        local pos = { x = event.data.x, y = event.data.y }
        self.controller:coordinateSystem(pos)
        self:setPosition(pos)
        self:setLocalZOrder( 2000 - pos.y )
    end
    Functions.bindUiWithModelAttr(self, self.model, "m_pos", onPosChange)

    --绑定hp
    self.hpView = self.displayNode_:getChildByName("hp_panel"):getChildByName("hp")
    self.hpView:setPercent(self.model.eventAttr.m_hp/self.model.m_raw_hp*100)
    self.hp = self.displayNode_:getChildByName("hp_panel")
    local onHpChange = function(event)
        self.hpView:setPercent(event.data/self.model.m_raw_hp*100)
        if event.data == 0 then
            self:heroDeathFunc_()
        end
    end
    Functions.bindUiWithModelAttr(self.hpView, self.model, "m_hp", onHpChange)

    --绑定状态
    local onStateChange = function(event)
        --死亡，不更新状态
        if self.m_deadState then return end
        self:stateHandler_(event.data)
    end
    Functions.bindUiWithModelAttr(self, self.model, "m_state", onStateChange)

    --绑定方向
    local onDireChange = function(event)
        if self.m_deadState then return end
        self:direChangeHandler_(event.data)
    end
    Functions.bindUiWithModelAttr(self, self.model, "m_dire", onDireChange)

    --初始化名称
    self.nameView = self.displayNode_:getChildByName("name")
    if self.nameView then   --小兵不带名字node
        self.nameView:setString(self.model.m_viewName)
    end

    --绑定死亡事件
    Functions.bindEventListener(self, self.model, CreatureModel.HERO_DEAD_EVENT, handler(self, self.heroDeathFunc_))

    --绑定释放技能事件
    Functions.bindEventListener(self, self.model, CreatureModel.SKILL_ATTACK_EVENT, handler(self, self.onSkillAttack))
    --绑定播放技能特效事件
    Functions.bindEventListener(self, self.model, CreatureModel.SKILL_EFFECT_START_EVENT, handler(self, self.onSkillEffectStart))
    --绑定停止技能特效事件
    Functions.bindEventListener(self, self.model, CreatureModel.SKILL_EFFECT_END_EVENT, handler(self, self.onSkillEffectEnd))
    --绑定技能hp改变事件
    Functions.bindEventListener(self, self.model, CreatureModel.SPELL_HP_CHANGED_EVENT, handler(self, self.onSpellHpChanged))
    --绑定伤害事件
    Functions.bindEventListener(self, self.model, CreatureModel.ON_HURT_EVENT, handler(self, self.onHurt))
    --绑定普通攻击事件
    Functions.bindEventListener(self, self.model, CreatureModel.ON_ATTACK_START_EVENT, handler(self, self.onAttackStart ))
    
end

function BaseCreatureView:heroDeathFunc_()
    if self.m_deadState then return end
    self.m_deadState = true
    self.animaNode:stopAllActions()
    local onDeadAnimaFinish = function()
        local action = cc.FadeOut:create(1)
        Functions.playActionWithBackCall(self.animaNode, action, function()
            self.controller:removeCombatView(self) 
        end)
    end
    Functions.playActionWithBackCall(self.animaNode, self.heroAnimas[BaseCreatureView.animaTables[CreatureModel.stateType.S_DYING][self.idir][1]], onDeadAnimaFinish)
end

function BaseCreatureView:stateHandler_(state)
    if self.state ~= state then
        self.state = state
        if self.state == CreatureModel.stateType.S_MOVE then
            if self.state ~= self.animaState then
                self.animaState = self.state
            end
        elseif self.state == CreatureModel.stateType.S_ATTACK then
            if self.state ~= self.animaState then
                self.animaState = self.state
            end
        elseif self.state == CreatureModel.stateType.S_VICTORY then
            if self.state ~= self.animaState then
                self.animaState = self.state
            end
        elseif self.state == CreatureModel.stateType.S_IDLE then
            if self.state ~= self.animaState then
                self.animaState = self.state
            end
        end
    end
    
end

function BaseCreatureView:onSkillAttack()

    self.controller:skillPause(self)
    
    local onMoveFinsih = function()
        print("move is finish")        
                
        self.zorder_hc = self:getLocalZOrder()
        self:setLocalZOrder(CombatViewController.Skill_Creature_Zorder)
        self:setScale(self.initScale + 0.4)
        
        --添加技能释放特效
        local aniSprite = Functions.createSprite({ scale = 4 })
        self:addChild(aniSprite)

        --播放通用技能音效
        Audio.playSound("sound/ui_mp3/skill.wav")
        Functions.playActionWithBackCall(aniSprite, "Ani_baoqi", function()
            aniSprite:removeSelf()
        end)
        
        self.animaNode:stopAllActions()
        local animaName = BaseCreatureView.animaTables[CreatureModel.stateType.S_ATTACK][self.idir][1]
        Functions.playActionWithBackCall(self.animaNode, self.heroAnimas[animaName], function()
            self:updateAnimas()
            self:setScale(self.initScale)
            self:onSkillBeginAnimFinish()
        end)
        
    end
    self.controller:moveCenterOfHero(self, onMoveFinsih)
end

function BaseCreatureView:onSkillBeginAnimFinish()
    
    --继续游戏
    self.controller:skillResume(self)
    
    --播放英雄吼叫
    Audio.playSound(self.model.heroSound)
    
    local skillAnimaName = self.model.skillAnimaName
    if skillAnimaName and skillAnimaName ~= "0"  then
        --添加技能播放精灵
        local sprite = Functions.createSprite({ scale = 2 })
        sprite:setPositionX(self:getPositionX())
        sprite:setPositionY(self:getPositionY())
        sprite:setLocalZOrder(self.controller.Skill_Creature_Zorder+1)
        self:getParent():addChild(sprite)
        
        Functions.playActionWithBackCall(sprite, skillAnimaName, function()
            sprite:removeSelf()
            self:setLocalZOrder(self.zorder_hc)
        end)
    else
        self:setLocalZOrder(self.zorder_hc)
    end
end

function BaseCreatureView:onSkillEffectStart(event)
    if self.effectLists[event.data.id] == nil then
       
        local effectData = { count = 1, msgIds =  { event.data.msgId } }
        self.effectLists[event.data.id] = effectData
        
        --获取技能特效动画
        local effectAnimaName = ConfigHandler:getSkillResOfId(event.data.id)
        local effectScale     = ConfigHandler:getSkillEffScaleOfId(event.data.id)
        if not effectScale then effectScale = 1 end

        if effectAnimaName then
            local sprite = Functions.createSprite({ scale = effectScale })
            self:addChild(sprite)
            if event.data.isLoop == 1 then
                self.effectLists[event.data.id]["targetSp"] = sprite
                Functions.playAnimaOfUI(sprite, effectAnimaName, 0, false)
            else
                Functions.playActionWithBackCall(sprite, effectAnimaName, function()
                    sprite:removeSelf()
                    self.effectLists[event.data.id] = nil
                end)
            end

            --判断是否冰冻技能
            local buffType = ConfigHandler:getSkillBuffTypeOfId(event.data.id)
            if buffType == 5 then
                -- self:pause()
                self:skillAnimaPause()
            end
        end

        --获取技能buff文字
        local buffNames = ConfigHandler:getSkillBuffName(event.data.id)
        if buffNames then
            for i=1, #buffNames do
                local lab = Functions.createSprite({ spriteName = buffNames[i] ,pos = { x = Functions.getPosOfIndex(i, #buffNames, 80, 0), y = 30 }})
                self:addChild(lab)
                transition.execute(lab, UIActionTool:createHpBaojiAction(), { onComplete = function()
                    lab:removeSelf()
                end})
            end
        end
        
        --获取技能音效
        local sound = ConfigHandler:getSkillSoundName(event.data.id)
        if sound then
            Audio.playSoundWithCount(sound)
            -- Audio.playSound(sound)
        end
       
    else
        local effcetData = self.effectLists[event.data.id]
        local msgIds     = effcetData.msgIds

        if not table.hasValue(msgIds, event.data.msgId) then
            msgIds[#msgIds+1] = event.data.msgId
            self.effectLists[event.data.id].count = self.effectLists[event.data.id].count + 1
        end
    end
end

function BaseCreatureView:onSkillEffectEnd(event)
    
    local effectData = self.effectLists[event.data.id]
    effectData.deleteMsgIds = effectData.deleteMsgIds or {}
    local model = self.model
    if effectData and table.hasValue(effectData.msgIds, event.data.msgId) then

        if  not table.hasValue(effectData.deleteMsgIds, event.data.msgId) then
            effectData.deleteMsgIds[#effectData.deleteMsgIds+1] = event.data.msgId
            effectData.count = effectData.count - 1
            
            if effectData.count == 0  then
                if effectData.targetSp ~= nil then
                    effectData.targetSp:removeSelf()
                end
    
                --判断是否冰冻技能
                local buffType = ConfigHandler:getSkillBuffTypeOfId(event.data.id)
                if buffType == 5 then
                    -- self:resume()
                    self:skillAnimaResume()
                end
    
                self.effectLists[event.data.id] = nil
            end
        end
    else
        assert(false, " skillEffect end error : not effect data skill id " .. event.data.id)
    end
       
end

function BaseCreatureView:onSpellHpChanged(event)

    local val = math.floor(event.data.val)
    local level = event.data.level

    local hpLab = nil
    if val > 0 then
        self:addUpHpLab(val)
    elseif val < 0 then
        self:addDownHpLab(val, level)
    end

end

function BaseCreatureView:onHurt(event)
    local sender = event.data.sender
    local val    = math.floor(event.data.val)
    local level  = event.data.level

    local temp = self.displayNode_:getChildByName("hptp")
    
    local lab = self:getHpLab(val, level)
    Functions.copyParam(temp, lab)
    
    self.hurtDisNode:pushActionNode({ target = lab, createFunc = handler(self, self.getDownHpAction), data = level }, true)

    if level > 0 then
        local animationName = nil
        if sender.m_viewType == CreatureModel.viewType.lord or sender.m_viewType == CreatureModel.viewType.lieutenant then
            animationName = "Ani_herohit"
        elseif sender.m_viewType == CreatureModel.viewType.infantry then
            animationName = "Ani_bubinhit" 
        elseif sender.m_viewType == CreatureModel.viewType.cavalry then
            animationName = "Ani_qibinghit"
        elseif sender.m_viewType == CreatureModel.viewType.archer then
            animationName = "Ani_gongbinghit"
        end

        --添加受伤特效
        local aniSprite = Functions.createSprite()
        self:addChild(aniSprite)
        Functions.playActionWithBackCall(aniSprite, animationName, function()
            aniSprite:removeSelf()
        end)

    end

end

function BaseCreatureView:onAttackStart(event)
    
    local ycAttackCall = function()
        local model = self.model
        if self.model.m_atk_range > 150 then
            local tar = CombatCenter:getAttackTarOfId(self.model.m_fightNumber)
            if tar then
                self:shooting(tar)
            end
        end

        self:updateAnimas()
    end
    
    self.animaNode:stopAllActions()
    local animaName = BaseCreatureView.animaTables[CreatureModel.stateType.S_ATTACK][self.idir][1]
    Functions.playActionWithBackCall(self.animaNode, self.heroAnimas[animaName], ycAttackCall)

end

function BaseCreatureView:shooting(tar)

    if self.model.m_viewType == CreatureModel.viewType.archer then
        local number = tonumber(self.model.m_pid)%10
        if number > 3 then
            number = 3
        end
        for i=1, number do
            local bullet = self:getBulletView()
            local startPoint = clone(self.model.eventAttr.m_pos)

            startPoint = { x = Functions.getPosOfIndex(i, number, 10, startPoint.x), y = startPoint.y}
            self.controller:coordinateSystem(startPoint)

            local endPoint = clone(tar.eventAttr.m_pos)
            endPoint = { x = Functions.getPosOfIndex(i, number, 10, endPoint.x), y = endPoint.y }
            self.controller:coordinateSystem(endPoint)

            bullet:excute({ startPoint = startPoint, endPoint = endPoint })
            self.controller:addBulletView(bullet)
        end
    else
        local bullet = self:getBulletView()
        local startPoint = clone(self.model.eventAttr.m_pos)
        self.controller:coordinateSystem(startPoint)

        local endPoint = clone(tar.eventAttr.m_pos)
        self.controller:coordinateSystem(endPoint)

        bullet:excute({ startPoint = startPoint, endPoint = endPoint })
        self.controller:addBulletView(bullet)
    end
end

function BaseCreatureView:getBulletView()
    
    local bulletView = nil
    if self.model.m_viewType == CreatureModel.viewType.archer then
        bulletView = Factory:createBullet("Arrows")
    else
        bulletView = Factory:createBullet("Fire")
    end
    
    bulletView:setLocalZOrder(self.controller.Bullet_Zorder)
    return bulletView
end

function BaseCreatureView:updateMoveAnima()
    --初始化状态
    self.animaState = CreatureModel.stateType.S_MOVE
    self:updateAnimas()
end


function BaseCreatureView:direChangeHandler_(dire)
    
    local idir = math.atan2(dire.y, dire.x)
    
    if idir >= -math.pi and idir < -math.pi*7/8 then
        idir = 4
    elseif idir >= -math.pi*7/8 and idir < -math.pi*5/8 then
        idir = 5
    elseif idir >= -math.pi*5/8 and idir < -math.pi*3/8 then
        idir = 6
    elseif idir >= -math.pi*3/8 and idir < -math.pi/8 then
        idir = 7
    elseif idir >= -math.pi/8 and idir < 0 then
        idir = 0
    elseif idir >= 0 and idir < math.pi/8 then
        idir = 0
    elseif idir >= math.pi/8 and idir < math.pi*3/8 then
        idir = 1
    elseif idir >= math.pi*3/8 and idir < math.pi*5/8 then
        idir = 2
    elseif idir >= math.pi*5/8 and idir < math.pi*7/8 then 
        idir = 3
    elseif idir >= math.pi*7/8 and idir <= math.pi then
        idir = 4
    end
    
    if self.idir ~= idir then
        
        self.idir = idir
        self:updateAnimas()
    end
    
end

function BaseCreatureView:updateAnimas()
    
    if not self._isPause and not self._isSkillAnimaPause then
        self.animaNode:setFlippedX(BaseCreatureView.animaTables[self.animaState][self.idir][2])
        self.animaNode:setFlippedY(BaseCreatureView.animaTables[self.animaState][self.idir][3])
        
        local animaName = self:getCurrentAnimaName()
        if animaName ~= "null" then
            self.animaNode:stopAllActions()
            Functions.playActionWithBackCall(self.animaNode, animaName, function()
                self:updateAnimas()
            end)
        end
    end
end

function BaseCreatureView:luaPause()
    self._isPause = true
    Functions.pauseNode(self)
end

function BaseCreatureView:luaResume()
    self._isPause = false
    Functions.resumeNode(self)
end

function BaseCreatureView:skillAnimaPause()
    self._isSkillAnimaPause = true
    Functions.pauseNode(self.animaNode)
end

function BaseCreatureView:skillAnimaResume()
    self._isSkillAnimaPause = false
    Functions.resumeNode(self.animaNode)
end

function BaseCreatureView:getCurrentAnimaName()
    local animaName = BaseCreatureView.animaTables[self.animaState][self.idir][1]
    return self.heroAnimas[animaName]
end

function BaseCreatureView:addUpHpLab(val)
    local temp = self.displayNode_:getChildByName("hptp")

    local lab = Functions.createBMFont({ scale = temp:getScale(), filePath ="fonts/jiaxue.fnt", pos = { x = temp:getPositionX(), y = temp:getPositionY() },
        text = "+" .. tostring(val) })

    self:addChild(lab)
        
    transition.execute(lab, UIActionTool:createHpBaojiAction(), { onComplete = function()
        lab:removeSelf()
    end})
end

function BaseCreatureView:addDownHpLab(val, level)

    local temp = self.displayNode_:getChildByName("hptp")
    
    local lab = self:getHpLab(val, level)
    Functions.copyParam(temp, lab)

    transition.execute(lab, self:getDownHpAction(level), { onComplete = function()
            lab:removeSelf()
        end})

    self:addChild(lab)
end

function BaseCreatureView:getHpLab(val, level)

    local fntFile = nil

    local hpToString = function(val)
        if val > 0 then
            val = "+" .. tostring(val)
        else
            val = tostring(val)
        end
        return val
    end

    if level > 0 then
        fntFile = "fonts/baoji.fnt"
    else
        if val > 0 then
            fntFile = "fonts/jiaxue.fnt"
        else
            fntFile = "fonts/gongji.fnt"
        end
    end

    local lab = Functions.createBMFont({ filePath = fntFile, text = hpToString(val) })

    return lab

end

function BaseCreatureView:getDownHpAction(level)

    local playAction = nil
    if level == CombatCenter.HurtType.BaseAttack then
        playAction = UIActionTool:createHpPTAction()
    elseif level == CombatCenter.HurtType.BaoJi1 then
        playAction = UIActionTool:createHpBaojiAction() 
    end
    
    return playAction
end



return BaseCreatureView