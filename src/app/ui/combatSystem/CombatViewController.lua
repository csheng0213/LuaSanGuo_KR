--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local CombatViewController = class("CombatViewController", BaseViewController)

local Functions = require("app.common.Functions")

CombatViewController.debug = true
CombatViewController.modulePath = ...
CombatViewController.studioSpriteFrames = {"CombatUI","CombatUI_Text" }
--@auto code head end

local CombatCenter = require("app.ui.combatSystem.model.CombatCenter")
local CreatureModel = require("app.ui.combatSystem.model.CreatureModel")

CombatViewController.fightAngle = math.pi/6

CombatViewController.Skill_Creature_Zorder = 2100
CombatViewController.Skill_Color_Zorder = 2000
CombatViewController.Bullet_Zorder = 1999

CombatViewController.Combat_Min_Scale = 0.65
CombatViewController.Combat_Max_Scale = 1

CombatViewController.Touch_Move_Min = 5

--combat Time
local scheduler = require("app.common.scheduler")

--@Pre loading
CombatViewController.spriteFrameNames = 
    {
        "playerHeadRes","headPilistRes"
    }

CombatViewController.animaNames = 
    {
        "Ani_baoqi", "Ani_herohit", "Ani_bubinhit", "Ani_qibinghit", "Ani_gongbinghit", "Ani_fireball", "Ani_fireballB","Ani_skillRelease"
    }
    

--@auto code uiInit
--add spriteFrames
if #CombatViewController.studioSpriteFrames > 0 then
    CombatViewController.spriteFrameNames = CombatViewController.spriteFrameNames or {}
    table.insertto(CombatViewController.spriteFrameNames, CombatViewController.studioSpriteFrames)
end
function CombatViewController:onDidLoadView()

    --output list
    self._main_t = self.view_t.csbNode:getChildByName("main")
	self._combatPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("combatPanel")
	self._combatBg_t = self.view_t.csbNode:getChildByName("main"):getChildByName("combatPanel"):getChildByName("combatBg")
	self._colorPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("combatPanel"):getChildByName("colorPanel")
	self._time_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_1"):getChildByName("time")
	self._control_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("control_panel")
	self._right_down_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("control_panel"):getChildByName("right_down_panel")
	self._video_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("video_panel")
	self._left_top_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("left_top_panel")
	self._right_top_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("right_top_panel")
	self._fbinfo_Panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("right_top_panel"):getChildByName("fbinfo_Panel")
	self._fbInfo_t = self.view_t.csbNode:getChildByName("main"):getChildByName("right_top_panel"):getChildByName("fbinfo_Panel"):getChildByName("fbInfo")
	self._shield_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("shield_panel")
	
    --label list
    
    --button list
    self._handleFightBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("control_panel"):getChildByName("right_panel"):getChildByName("handleFightBt")
	self._handleFightBt_t:onTouch(Functions.createClickListener(handler(self, self.onHandlefightbtClick), ""))

	self._autoFightBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("control_panel"):getChildByName("right_panel"):getChildByName("autoFightBt")
	self._autoFightBt_t:onTouch(Functions.createClickListener(handler(self, self.onAutofightbtClick), ""))

	self._speed2Bt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("control_panel"):getChildByName("right_panel"):getChildByName("speed2Bt")
	self._speed2Bt_t:onTouch(Functions.createClickListener(handler(self, self.onSpeed2btClick), ""))

	self._speed1Bt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("control_panel"):getChildByName("right_panel"):getChildByName("speed1Bt")
	self._speed1Bt_t:onTouch(Functions.createClickListener(handler(self, self.onSpeed1btClick), ""))

	self._combatSkipBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("video_panel"):getChildByName("combatSkipBt")
	self._combatSkipBt_t:onTouch(Functions.createClickListener(handler(self, self.onCombatskipbtClick), ""))

	self._resumeBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("left_down_panel"):getChildByName("resumeBt")
	self._resumeBt_t:onTouch(Functions.createClickListener(handler(self, self.onResumebtClick), ""))

	self._pauseBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("left_down_panel"):getChildByName("pauseBt")
	self._pauseBt_t:onTouch(Functions.createClickListener(handler(self, self.onPausebtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Resumebt btFunc
function CombatViewController:onResumebtClick()
    Functions.printInfo(self.debug,"Resumebt button is click!")

    if self.isPause then
        self._pauseBt_t:setVisible(true)
        self._resumeBt_t:setVisible(false)
        cc.Director:getInstance():resume()
        self.isPause = false
    end
end
--@auto code Resumebt btFunc end

--@auto code Pausebt btFunc
function CombatViewController:onPausebtClick()
    Functions.printInfo(self.debug,"Pausebt button is click!")
    
    if not self.isPause then
        self._pauseBt_t:setVisible(false)
        self._resumeBt_t:setVisible(true)
        cc.Director:getInstance():pause()
        self.isPause = true
    end
end
--@auto code Pausebt btFunc end

--@auto code Autofightbt btFunc
function CombatViewController:onAutofightbtClick()
    Functions.printInfo(self.debug,"Autofightbt button is click!")
    if not self.isPause then  --暂停不允许点击自动
        self:setHeroAuto(true)
    end
end
--@auto code Autofightbt btFunc end

--@auto code Speed2bt btFunc
function CombatViewController:onSpeed2btClick()
    Functions.printInfo(self.debug,"Speed2bt button is click!")
    cc.Director:getInstance():getScheduler():setTimeScale(1)
    self:setAddSpeed(false)
end
--@auto code Speed2bt btFunc end

--@auto code Speed1bt btFunc
function CombatViewController:onSpeed1btClick()
    Functions.printInfo(self.debug,"Speed1bt button is click!")

    if PlayerData.eventAttr.m_level >= g_csBaseCfg.addSpeedLevel then
        cc.Director:getInstance():getScheduler():setTimeScale(2)
        self:setAddSpeed(true)
    else
        PromptManager:openTipPrompt(LanguageConfig.ui_CombatView_tip_3)
    end
end
--@auto code Speed1bt btFunc end

--@auto code Handlefightbt btFunc
function CombatViewController:onHandlefightbtClick()
    Functions.printInfo(self.debug,"Handlefightbt button is click!")
    if not self.isPause then  --暂停不允许点击自动
        self:setHeroAuto(false)
    end
end
--@auto code Handlefightbt btFunc end

--@auto code Combatskipbt btFunc
function CombatViewController:onCombatskipbtClick()
    Functions.printInfo(self.debug,"Combatskipbt button is click!")

    if self.combatInfo.combatType == CombatCenter.CombatType.RB_PVPHistoryData then
        CombatCenter:combatForceEnd()
        self:quitCombat()
    elseif self.combatInfo.combatType == CombatCenter.CombatType.RB_Guide then
        CombatCenter:combatForceEnd()
    end
end
--@auto code Combatskipbt btFunc end

--@auto button backcall end


--@auto code view display func
function CombatViewController:onCreate()
    Functions.printInfo(self.debug_b," CombatViewController controller create!")
    
    self.viewInfos = {}
    self.bulletViews = {}
end

function CombatViewController:onReceiveParentCtlData(data)
    self.combatInfo = data
end

function CombatViewController:onReceivePushData(data)
    self.combatInfo = data
end

function CombatViewController:onReceivePopData(data)
    if data and data.jumpData.isUpdate then
        --布阵返回，获取本方攻击战斗信息,更新战前界面
        EmbattleData:getEmbattleInfos(EmbattleData.EmbattleTypeEnum.attack, function(data)
            if self.curChildView then
                self.heroCombatInfo = CombatCenter:getCombatHeroInfos(data)
                self.curChildView:updateHeroInfo(CombatCenter:getCombatBeforeHeroInfos(data))
            end
        end)
    end
end

function CombatViewController:openBgMusic()
    Audio.playMusic("sound/combat.mp3", true)
end

function CombatViewController:onDisplayView()
	Functions.printInfo(self.debug_b," CombatViewController view enter display!")
	
    --战斗加速
    -- self._speed1Bt_t:setVisible(true)
    
    --绑定自动按钮动画
    -- local aniSprite1 = Functions.createSprite()
    -- self._handleFightBt_t:addChild(aniSprite1)
    -- aniSprite1:setPosition({ x = self._handleFightBt_t:getSize().width/2, y = self._handleFightBt_t:getSize().height/2 })
    -- Functions.playAnimaOfUI(aniSprite1, "autoFight_plist")

    -- local aniSprite2 = Functions.createSprite()
    -- self._autoFightBt_t:addChild(aniSprite2)
    -- aniSprite2:setPosition({ x = self._autoFightBt_t:getSize().width/2, y = self._autoFightBt_t:getSize().height/2 })
    -- Functions.playAnimaOfUI(aniSprite2, "autoFight_plist")

    --初始化时间
    Functions.initLabelOfString(self._time_t, "0")
    self.combatTimeOut = false

    --战斗地图下移
    self._combatPanel_t:setPosition({ x = self._combatPanel_t:getPositionX() + 80, y = self._combatPanel_t:getPositionY() - 50})
	--初始化黑色遮挡层
    self._colorPanel_t:setLocalZOrder(CombatViewController.Skill_Color_Zorder)
    self:setColorLayer(false)

    --自动调整控制按钮坐标
    Functions.autoFixChildPos(self._control_panel_t)
    Functions.autoFixChildPos(self._video_panel_t)

    --绑定滑动监听
    self._combatPanel_t:onTouch(handler(self, self.onScrollCombat))

    --初始化战场偏移
    local centerPos = { x = CombatCenter.MapMaxSize.width/2, y = CombatCenter.MapMaxSize.height/2 }

    centerPos.x = centerPos.x + centerPos.y * math.cos(math.pi*2/3)
    centerPos.y = centerPos.y * math.sin(math.pi*2/3)
    
    local angle = Functions.getAngle(centerPos) + CombatViewController.fightAngle
    local dist  = Functions.getDistance({ x = 0, y = 0 }, centerPos) 
    
    centerPos.x = dist * math.cos(angle)
    centerPos.y = dist * math.sin(angle)
    
    local size  = self._combatPanel_t:getContentSize()

    self.combatMapOffset = {
        x = size.width/2 - centerPos.x,
        y = size.height/2 - centerPos.y
    }
    
    self:zoomCombatMap(0.8)

    --初始化自动战斗
    self.heroAutoFight = false
    self.enemyAutoFight = true

    --初始化技能控制器
    self.spellControllers = {}

    --初始化战斗地图
    self:initCombatMap()

    local combatTypeFuncs = 
    {
        [CombatCenter.CombatType.RB_PVE]            = handler(self, self.onFbPveCombat),
        [CombatCenter.CombatType.RB_ElitePVE]       = handler(self, self.onEliteFbPveCombat),
        [CombatCenter.CombatType.RB_Tandui]         = handler(self, self.onTanduiFbCombat),
        [CombatCenter.CombatType.RB_HeroTrial]      = handler(self, self.onHeroTrialCombat),
        [CombatCenter.CombatType.RB_BloodyBattle]   = handler(self, self.onBloodyBattle),
        [CombatCenter.CombatType.RB_PVPPlayerData]  = handler(self, self.onPVPPlayerData),
        [CombatCenter.CombatType.RB_PVPHistoryData] = handler(self, self.onPVPHistoryData),
        [CombatCenter.CombatType.RB_GVG]            = handler(self, self.onGVGCombat)
    }
    
    if self.combatInfo.combatType == CombatCenter.CombatType.RB_Guide then
        self:onGuideFunc()
    else
        --获取本方攻击战斗信息    
        EmbattleData:getEmbattleInfos(EmbattleData.EmbattleTypeEnum.attack, function(data)
           combatTypeFuncs[self.combatInfo.combatType](data)
        end)
    end

    --新手引导
    if PlayerData.eventAttr.m_guideId == 5 then  --第一站，隐藏自动战斗
        self._autoFightBt_t:setVisible(false)
        self._speed1Bt_t:setVisible(false)
    else
        self:setHeroAuto(BiographyData.isOpenAutoFight) --自动战斗
        self:setAddSpeed(BiographyData.isAddSpeed) --设置战斗加速
    end

end
--@auto code view display func end

--@public func
function CombatViewController:initCombatMap()

    if self.combatInfo.combatType == CombatCenter.CombatType.RB_PVE then
        local map = ConfigHandler:getMapOfID(self.combatInfo.majorHurdles)
        Functions.loadImageWithSprite(self._combatBg_t, map)
    elseif self.combatInfo.combatType == CombatCenter.CombatType.RB_ElitePVE then
        local map = ConfigHandler:getMapOfID(self.combatInfo.majorHurdles)
        local mapstr = string.sub(map,1, 4) .. "jymap/" .. string.sub(map,5, #map)
        Functions.loadImageWithSprite(self._combatBg_t, mapstr)
    elseif self.combatInfo.combatType == CombatCenter.CombatType.RB_Tandui then
        local map = ConfigHandler:getMapOfID(self.combatInfo.majorHurdles)
        Functions.loadImageWithSprite(self._combatBg_t, map)
    elseif self.combatInfo.combatType == CombatCenter.CombatType.RB_HeroTrial then
        self._pauseBt_t:setVisible(false)
        Functions.loadImageWithSprite(self._combatBg_t, g_Combat_Maps["HeroTrial"])
    elseif self.combatInfo.combatType == CombatCenter.CombatType.RB_BloodyBattle then
        self._pauseBt_t:setVisible(false)
        Functions.loadImageWithSprite(self._combatBg_t, g_Combat_Maps["BloodyBattle"][self.combatInfo.majorHurdles])
    elseif self.combatInfo.combatType == CombatCenter.CombatType.RB_PVPPlayerData then
        self._pauseBt_t:setVisible(false)
        Functions.loadImageWithSprite(self._combatBg_t, g_Combat_Maps["PVPPlayerData"])
    elseif self.combatInfo.combatType == CombatCenter.CombatType.RB_PVPHistoryData then
        self._pauseBt_t:setVisible(false)
        Functions.loadImageWithSprite(self._combatBg_t, g_Combat_Maps["PVPPlayerData"])
    elseif self.combatInfo.combatType == CombatCenter.CombatType.RB_GVG then
        self._pauseBt_t:setVisible(false)
        Functions.loadImageWithSprite(self._combatBg_t, g_Combat_Maps["GVG"])
    else
        Functions.loadImageWithSprite(self._combatBg_t, "map/cbj1.jpg")
    end

end

function CombatViewController:onGuideFunc()

    self._pauseBt_t:setVisible(false)
    --sdk
    Functions.setAdbrixTag("firstTimeExperience","loading_1_complete")
    
    --sdk
    Functions.setAdbrixTag("firstTimeExperience","tutorial_combat_try")

    self.heroAutoFight = true
    self.enemyAutoFight = true

    self._control_panel_t:setVisible(false)

    self.heroCombatBeforInfo, self.heroCombatInfo = CombatCenter:getFbCombatInfosOfId(7, 20000)
    self.enemyCombatBeforInfo, self.enemyCombatInfo = CombatCenter:getFbCombatInfosOfId(7, 20001)
    
    self.heroCombatBeforInfo.headId = 1
    self.heroCombatBeforInfo.level  = 99
    self.heroCombatBeforInfo.name   = LanguageConfig.ui_CombatView_shu

    self.enemyCombatBeforInfo.headId = 1
    self.enemyCombatBeforInfo.level  = 99
    self.enemyCombatBeforInfo.name   = LanguageConfig.ui_CombatView_wu

    self:combatResLoad()
end

function CombatViewController:onFbPveCombat(data, combatType)
    
    self.isFirstFight = BiographyData:isFirstOfGk(self.combatInfo.littleLevels)
    
    --获取本方战斗信息
    self.heroCombatBeforInfo = CombatCenter:getCombatBeforeHeroInfos(data)
    self.heroCombatInfo = CombatCenter:getCombatHeroInfos(data)
    
    self.enemyCombatBeforInfo, self.enemyCombatInfo = CombatCenter:getFbCombatInfosOfId(self.combatInfo.majorHurdles, self.combatInfo.littleLevels, nil, combatType)
    
    --副本信息显示
    self._fbinfo_Panel_t:setVisible(true)
    self._fbinfo_Panel_t:getChildByName("fbInfo"):setString(self.enemyCombatBeforInfo.fbName)

    local onFightCall= function()
        local onPveFightRequetReturn = function(event)
            CombatCenter:setRand(event.seed)
            self:combatResLoad()
        end
            
        NetWork:addNetWorkListener({ 1, 1 }, Functions.createNetworkListener(onPveFightRequetReturn, true, _, handler(self, self.quitCombat) ))
        
        local temp = self.combatInfo.littleLevels % 10
        if temp == 0 then
            temp = 10 
        end
        NetWork:sendToServer({ idx = { 1, 1}, btype = self.combatInfo.combatType, data = { lpassid = self.combatInfo.majorHurdles, spassid = temp }})    
    end

    local onPveBegin = function()
        BiographyData:excuteFightSpeak(self.combatInfo.littleLevels, BiographyData.DialogueType.Begin, onFightCall)
    end
    
    self:openChildView("app.ui.popViews.CombatBeforePopView", { isRemove = false, data = { heroInfo = self.heroCombatBeforInfo,
        enemyInfo = self.enemyCombatBeforInfo , fightCall = onPveBegin } })
          
end

function CombatViewController:recoverySpeed()
    cc.Director:getInstance():getScheduler():setTimeScale(1)
end

function CombatViewController:onEliteFbPveCombat(data)
	self:onFbPveCombat(data, CombatCenter.CombatType.RB_ElitePVE)
end

function CombatViewController:onTanduiFbCombat(data)
    --获取本方战斗信息
    self.heroCombatBeforInfo = CombatCenter:getCombatBeforeHeroInfos(data)
    self.heroCombatInfo = CombatCenter:getCombatHeroInfos(data)
    
    self.enemyCombatBeforInfo, self.enemyCombatInfo = CombatCenter:getFbCombatInfosOfId(self.combatInfo.majorHurdles, self.combatInfo.littleLevels, nil, CombatCenter.CombatType.RB_Tandui)
    
    local onFightCall= function()
        local onPveFightRequetReturn = function(event)
            CombatCenter:setRand(event.seed)
            local preHps = event.bloody
            
            self.enemyCombatBeforInfo, self.enemyCombatInfo = 
            CombatCenter:getFbCombatInfosOfId(self.combatInfo.majorHurdles, self.combatInfo.littleLevels, preHps, CombatCenter.CombatType.RB_Tandui)

            self:combatResLoad()
        end
            
        NetWork:addNetWorkListener({ 1, 1 }, Functions.createNetworkListener(onPveFightRequetReturn, true, _, handler(self, self.quitCombat)) )
        
        local temp = self.combatInfo.littleLevels % 10;
        if temp == 0 then
            temp = 10
        end
        NetWork:sendToServer({ idx = { 1, 1}, btype = self.combatInfo.combatType, data = { lpassid = self.combatInfo.majorHurdles, spassid = temp }})    
        
    end
    
    self:openChildView("app.ui.popViews.CombatBeforePopView", { isRemove = false, data = { heroInfo = self.heroCombatBeforInfo,
        enemyInfo = self.enemyCombatBeforInfo , fightCall = onFightCall } })
end
function CombatViewController:onHeroTrialCombat(data)
    --获取本方战斗信息
    self.heroCombatBeforInfo = CombatCenter:getCombatBeforeHeroInfos(data)
    self.enemyCombatBeforInfo = CombatCenter:getHeroTrialInfos(self.combatInfo.majorHurdles, self.combatInfo.littleLevels, self.combatInfo.enemyHeroIDs)
    
    local onFightCall= function()

        local onHeroTrialBegin = function(event)
            PlayerData:setPlayerPower(event.energy)
            CombatCenter:setRand(event.data.seed)
            self.heroCombatInfo        = CombatCenter:getCombatHeroInfos(event.data.sform)
            self.enemyCombatInfo       = CombatCenter:getCombatHeroInfos(event.data.tform)


            --为试炼敌人添加难度增益
            for k,v in pairs(self.enemyCombatInfo.peopleInfos) do
                if v.type ~= "soldier" or (v.type == "soldier" and event.data.diff <= 100)then
                    v.gainValue = event.data.diff
                end 
            end
            self:combatResLoad()
        end
        NetWork:addNetWorkListener({ 1, 1 }, Functions.createNetworkListener(onHeroTrialBegin, true, _, handler(self, self.quitCombat) ))
        NetWork:sendToServer({ idx = { 1, 1}, btype = self.combatInfo.combatType,
            data = { trail_type = self.combatInfo.majorHurdles, level = self.combatInfo.littleLevels }})    

    end
    
    self:openChildView("app.ui.popViews.CombatBeforePopView", { isRemove = false, data = { heroInfo = self.heroCombatBeforInfo,
        enemyInfo = self.enemyCombatBeforInfo , fightCall = onFightCall } })

end

function CombatViewController:onBloodyBattle(data)
    --获取本方战斗信息
    self.heroCombatBeforInfo = CombatCenter:getCombatBeforeHeroInfos(data)
    
    --获取敌方血战数据
    local onBloodyBattleDataReturn = function(data)
        self.enemyCombatBeforInfo = data.enemyCombatBeforInfo
        self:combatBeginRequire()
    end
    
    CombatCenter:getBloodyBattleData(self.combatInfo.majorHurdles, self.combatInfo.littleLevels, onBloodyBattleDataReturn)
    
end

function CombatViewController:onPVPPlayerData(data)

    --获取本方战斗信息
    self.heroCombatBeforInfo = CombatCenter:getCombatBeforeHeroInfos(data)

    --获取敌方pvp战斗数据
    self.enemyCombatBeforInfo        = {}
    self.enemyCombatBeforInfo.level  = self.combatInfo.playerData.level
    self.enemyCombatBeforInfo.headId = self.combatInfo.playerData.imgid
    self.enemyCombatBeforInfo.power  = self.combatInfo.playerData.fight
    self.enemyCombatBeforInfo.name   = self.combatInfo.playerData.name

    --显示战前状态
    local onFightCall= function()

            local onPVPPlayerBegin = function(event)
                
                --修改天梯挑战次数
                TianTiData.eventAttr.m_tianTiCount = TianTiData.eventAttr.m_tianTiCount - 1

                CombatCenter:setRand(event.seed)
                self.heroCombatInfo  = CombatCenter:getCombatHeroInfos(event.sform)
                self.enemyCombatInfo = CombatCenter:getCombatHeroInfos(event.tform)

                self:combatResLoad()
            end
            NetWork:addNetWorkListener({ 1, 1 }, Functions.createNetworkListener(onPVPPlayerBegin, true, _, handler(self, self.quitCombat)))
            NetWork:sendToServer({ idx = { 1, 1}, btype = self.combatInfo.combatType,
            data = { uid = self.combatInfo.playerData.id  }})    

        end

    self:openChildView("app.ui.popViews.CombatBeforePopView", { isRemove = false, data = { heroInfo = self.heroCombatBeforInfo,
        enemyInfo = self.enemyCombatBeforInfo , fightCall = onFightCall } })
    
end

function CombatViewController:combatBeginRequire()
	local onFightCall= function()

            local onHeroTrialBegin = function(event)
                CombatCenter:setRand(event.seed)
                self.heroCombatInfo  = CombatCenter:getCombatHeroInfos(event.sform)
                self.enemyCombatInfo = CombatCenter:getCombatHeroInfos(event.tform)

                --如果血站跳过，则直接跳过战斗，返回战斗结果
                if self.combatInfo.isPassFlag then
                    -- self:jumpCombatFunc()
                    scheduler.performWithDelayGlobal(function()
                        self:fightOver(CombatCenter.FightResult.WIN)
                    end, 0.2)
                else
                    self:combatResLoad()
                end
            end
            NetWork:addNetWorkListener({ 1, 1 }, Functions.createNetworkListener(onHeroTrialBegin, true) )
            NetWork:sendToServer({ idx = { 1, 1}, btype = self.combatInfo.combatType,
                data = { diff = self.combatInfo.majorHurdles  }})    

        end

        self:openChildView("app.ui.popViews.CombatBeforePopView", { isRemove = false, data = { heroInfo = self.heroCombatBeforInfo,
            enemyInfo = self.enemyCombatBeforInfo , fightCall = onFightCall } })
end

function CombatViewController:onPVPHistoryData(data)
    
    self._control_panel_t:setVisible(false) --隐藏控制层
    
    if self.combatInfo.playerData.passive == 0 then
        --获取本方战斗信息
        self.heroCombatBeforInfo = CombatCenter:getCombatBeforeHeroInfos(data)

        --获取敌方pvp战斗数据
        self.enemyCombatBeforInfo        = {}
        self.enemyCombatBeforInfo.level  = self.combatInfo.playerData.lvl
        self.enemyCombatBeforInfo.headId = self.combatInfo.playerData.pic
        self.enemyCombatBeforInfo.power  = self.combatInfo.playerData.power
        self.enemyCombatBeforInfo.name   = self.combatInfo.playerData.name
    else
        --获取本方战斗信息
        self.enemyCombatBeforInfo = CombatCenter:getCombatBeforeHeroInfos(data)

        --获取敌方pvp战斗数据
        self.heroCombatBeforInfo        = {}
        self.heroCombatBeforInfo.level  = self.combatInfo.playerData.lvl
        self.heroCombatBeforInfo.headId = self.combatInfo.playerData.pic
        self.heroCombatBeforInfo.power  = self.combatInfo.playerData.power
        self.heroCombatBeforInfo.name   = self.combatInfo.playerData.name
    end
    
    local onPVPHistoryDataBegin = function(event)
                                CombatCenter:setRand(event.data.seed)
                                CombatCenter:setReload()
                                
                                --添加事件
                                CombatCenter:addAiEvent(event.data.evt_list)
                                
                                self.heroCombatInfo  = CombatCenter:getCombatHeroInfos(event.data.sform)
                                self.enemyCombatInfo = CombatCenter:getCombatHeroInfos(event.data.tform)

                                self:combatResLoad()
                            end

    NetWork:addNetWorkListener({ 1, 1 }, Functions.createNetworkListener(onPVPHistoryDataBegin, true, _, handler(self, self.quitCombat)))
    NetWork:sendToServer({ idx = { 1, 1}, btype = self.combatInfo.combatType,
    data = { idx = self.combatInfo.playerData.index  }})
end

--公会战斗
function CombatViewController:onGVGCombat(data)
    
    --获取本方战斗信息
    self.heroCombatBeforInfo = CombatCenter:getCombatBeforeHeroInfos(data)

    --获取敌方pvp战斗数据
    self.enemyCombatBeforInfo        = {}
    self.enemyCombatBeforInfo.level  = self.combatInfo.playerData.level
    self.enemyCombatBeforInfo.headId = self.combatInfo.playerData.headId
    self.enemyCombatBeforInfo.power  = self.combatInfo.playerData.power
    self.enemyCombatBeforInfo.name   = self.combatInfo.playerData.name
    
    local onGVGBegin = function(event)
        
        --修改天梯挑战次数
        CombatCenter:setRand(event.data.seed)
        self.heroCombatInfo  = CombatCenter:getGVGCombatHeroInfos(event.data.sform)
        self.enemyCombatInfo = CombatCenter:getGVGCombatHeroInfos(event.data.tform)

        self:combatResLoad()
    end
    NetWork:addNetWorkListener({ 1, 1 }, Functions.createNetworkListener(onGVGBegin, true, "ret", handler(self, self.quitCombat)))
    NetWork:sendToServer({ idx = { 1, 1}, btype = self.combatInfo.combatType,
    data = { big = self.combatInfo.big, small = self.combatInfo.small }})

end


-- function CombatViewController:jumpCombatFunc()

--     CombatCenter:init(self)
--     CombatCenter:initCombat(self.heroCombatInfo, self.enemyCombatInfo, self.combatInfo.combatType)

--     --设置自动战斗
--     CombatCenter:setHeroAuto(self.heroAutoFight)
--     CombatCenter:setEnemyAuto(self.enemyAutoFight)

--     CombatCenter:jumpCombatStart()
-- end

function CombatViewController:combatResLoad()

    PromptManager:openLoadingPrompt("",true)
    CombatCenter:init(self)
    
    CombatCenter:initCombat(self.heroCombatInfo, self.enemyCombatInfo, self.combatInfo.combatType)

    --设置自动战斗
    CombatCenter:setHeroAuto(self.heroAutoFight)
    CombatCenter:setEnemyAuto(self.enemyAutoFight)

    --加载动画资源
    self.heroInfos = CombatCenter:getFightHeroInfo()
    local models = CombatCenter:getCombatCreatures()

    self:loadCombatRes(self.heroInfos, models, handler(self, self.startFight))
    
end

function CombatViewController:startFight()

    --绑定视图
    local models = CombatCenter:getCombatCreatures()
    models_temp = clone(models)

    Functions.tableSeqFunc(models_temp, function(model, endCallBack) --单模型加载回调函数
            self:addCombatView_(model)
            endCallBack()
        end, function() --所有模型加载完成函数
        
            --初始化ui
            self:initCombatUI()
            self:updateViewAnima()

            PromptManager:closeLoadingPrompt()
            --新手引导
            if PlayerData.eventAttr.m_guideId == 7 and self.combatInfo.littleLevels == 2 then
                    transition.execute(self.view_t, cc.DelayTime:create(1), {
                       onComplete = function()
                            self.isLogicPause = true
                            PromptManager:openNewGuide(self._autoFightBt_t, LanguageConfig.ui_CombatView_2, function()
                               self.isLogicPause = false
                               CombatCenter:combatStart()
                               self:updateViewMoveAnima()
                            end)
                       end
                    })
            else
                transition.execute(self.view_t, cc.DelayTime:create(1), {
                       onComplete = function()
                           CombatCenter:combatStart()
                           self:updateViewMoveAnima()
                           
                            if self.combatInfo.combatType == CombatCenter.CombatType.RB_Guide or
                            self.combatInfo.combatType == CombatCenter.CombatType.RB_Guide then
                                self._video_panel_t:setVisible(true)
                            end

                            if BiographyData.isAddSpeed then
                                cc.Director:getInstance():getScheduler():setTimeScale(2)
                            else
                                cc.Director:getInstance():getScheduler():setTimeScale(1)
                            end
                       end
                    })
            end

        end)

end

function CombatViewController:initCombatUI()
	
	--初始化英雄组件
	for i=1, 3 do
        local heroCom = self._right_down_panel_t:getChildByName("combatHead" .. tostring(i))
        local model = self.heroInfos.heroInfo.heros[i] 
        if model then
            self:initCombatHeroCom_(heroCom, model)
            heroCom:setVisible(true)
            self.spellControllers[#self.spellControllers+1] = Factory:createSpellCtl({ view = heroCom, model = model, parentCtl = self })
        end
	end

    local onSpellAttack = function()
        for k,v in ipairs(self.spellControllers) do
            v:setCommonCDState(false)
        end
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, CreatureModel.SI_FANG_SPELL_EVENT, onSpellAttack)
	
	--初始化本方显示
    self:initCombatDisHeroCom_(self._left_top_panel_t, self.heroInfos.heroInfo, self.heroCombatBeforInfo)
	
	--初始化敌方显示
	self:initCombatDisHeroCom_(self._right_top_panel_t, self.heroInfos.enemyInfo, self.enemyCombatBeforInfo)
	
    self.timeSprite = Functions.createSprite()
    self.view_t:addChild(self.timeSprite)

	--初始化时间
    self.curTime = g_Combat_Time
    Functions.initLabelOfString(self._time_t, g_Combat_Time)
    
    local timeChange = function()

        local time = math.floor(CombatCenter.FrameTimeCount/60)
        local curTime = g_Combat_Time - time
        if self.curTime ~= curTime then
            self.curTime = curTime
            Functions.initLabelOfString(self._time_t, self.curTime)
        end

        if self.curTime <= 0 then
            self.combatTimeOut = true
            self:forceQuitCombat()
        end 
    end
    Functions.bindEventListener(self.timeSprite, GameEventCenter, CombatCenter.GAME_UPDATE, timeChange)


end

function CombatViewController:timeOutCreatureState()
    
end

function CombatViewController:setHeroAuto(isAuto)
    self._autoFightBt_t:setVisible(not isAuto)
    self._handleFightBt_t:setVisible(isAuto)
    self.heroAutoFight = isAuto
    CombatCenter:setHeroAuto(self.heroAutoFight)
    BiographyData.isOpenAutoFight = isAuto
end

function CombatViewController:setAddSpeed(isAddSpeed)
    self._speed1Bt_t:setVisible(not isAddSpeed)
    self._speed2Bt_t:setVisible(isAddSpeed)
    self.isAddSpeed = isAddSpeed
    BiographyData.isAddSpeed = isAddSpeed
end

 

function CombatViewController:initCombatDisHeroCom_(comView, combatHeros, combatInfo)
	
	local name = comView:getChildByName("name_panel"):getChildByName("heroName")
    name:setString(combatInfo.name)
	
    local level = comView:getChildByName("heroLevel"):getChildByName("level")
    level:setString(combatInfo.level)
    
    --绑定血条
    local hp = comView:getChildByName("hp_panel"):getChildByName("hp")
    local hp_text = comView:getChildByName("hp_panel"):getChildByName("hp_text")
    
    --获取总血量
    local allHp = 0
    local heros = combatHeros.heros
    for i=1, #heros do
        allHp = allHp + heros[i].m_raw_hp
    end
    
    --添加监听
    for k, v in pairs(heros) do
        local onHpChange = function(event)
            
            local curHp = 0
            for i=1, #heros do
                curHp = curHp + heros[i].eventAttr.m_hp
            end
            
            curHp = math.floor(curHp)
            allHp = math.floor(allHp)
            hp:setPercent(curHp/allHp*100)
            hp_text:setString(tostring(curHp) .. "/" .. tostring(allHp))
        end
        onHpChange()
        Functions.bindUiWithModelAttr(hp, v, "m_hp", onHpChange)
    end
    
    --初始化显示头像
    local heroHead = comView:getChildByName("heroHeadImage")
    Functions.loadImageWithWidget(heroHead, Functions.getDisHeadImagePathOfId(combatInfo.headId))
    heroHead:setVisible(true)
    
end

function CombatViewController:initCombatHeroCom_(comView, model)
	
	--初始化英雄头像
	local heroHead = comView:getChildByName("headCom")
    Functions.initHeadComOfId(heroHead, model.m_pid, model.m_class)
    Functions.getHeroHead(heroHead, { id = model.m_pid , class = model.m_class})
    
    --初始化技能名称
    local skillName = comView:getChildByName("skillName")
    skillName:setString(model.m_spells.skillDatas[1].m_skillName)

    --初始化英雄名称
    local heroName = comView:getChildByName("heroName")

    local bigClass,minClass = Functions.formatHeroClass(model.m_class)
    heroName:setString(ConfigHandler:getHeroNameOfId(model.m_pid, bigClass))

	--绑定血条
	local hp = comView:getChildByName("hp")
    local onHpChange = function(event)
        if model.m_raw_hp < event.data then  --防止血量超过上限，进度条无显示
            model.m_raw_hp = event.data
        end
        hp:setPercent(event.data/model.m_raw_hp*100)
        if event.data == 0 then 
            print("hero is death!")
        end
    end
	Functions.bindUiWithModelAttr(hp, model, "m_hp", onHpChange)
	
end

function CombatViewController:onScrollCombat(event)

    if not self.isPause then       --暂停时不允许滑动
        if event.name == "began" then

            local touchPos = event.target:getTouchBeganPosition()
            self.curScrollPos_ = { x = touchPos.x, y = touchPos.y }
            
        elseif event.name == "moved" then
            
            local touchPos = event.target:getTouchMovePosition()
            
            local diffX = touchPos.x - self.curScrollPos_.x 
            local diffY = touchPos.y - self.curScrollPos_.y

            if math.abs(diffX) > CombatViewController.Touch_Move_Min or math.abs(diffY) > CombatViewController.Touch_Move_Min then

                local newX = self._combatPanel_t:getPositionX() + diffX
                local newY = self._combatPanel_t:getPositionY() + diffY
                self:moveCombatPanel({ x = newX, y = newY })

                self.curScrollPos_ = { x = touchPos.x, y = touchPos.y } --设置当前纪录触摸值
            end
        end
    end
end

function CombatViewController:moveCombatPanel(pos)

    local minX, maxX, minY, maxY = self:getCombatPanelCoordLimit()
    if pos.x >= minX and pos.x <= maxX then
        self._combatPanel_t:setPositionX(pos.x)
    end

    if pos.y >= minY and pos.y <= maxY then
        self._combatPanel_t:setPositionY(pos.y)
    end

end


function CombatViewController:quitCombat()

    local quitFunc_ = function()
        self:clearFightRes()
        GameCtlManager:pop(self, { data = { result = self.combatResult, combatType = self.combatInfo.combatType } })
    end

    if self.combatInfo.combatType == CombatCenter.CombatType.RB_PVE and self.combatResult == CombatCenter.FightResult.WIN
     and self.isFirstFight and self.combatInfo.littleLevels%10 == 0 then
        GameCtlManager:push("app.ui.imagePlayerSystem.ImagePlayerViewController",{ data = { jumpData = { levelId = ConfigHandler:getChapterOfID(self.combatInfo.majorHurdles), callBack = quitFunc_ } }})
    else
        quitFunc_()
    end
end

function CombatViewController:forceQuitCombat()
    CombatCenter:forceShutdown()
end

--hero view move center 
function CombatViewController:moveCenterOfHero(heroView, moveEndCall)

    local oldPos = { x = heroView:getPositionX(), y = heroView:getPositionY() }
    oldPos = heroView:getParent():convertToWorldSpace(oldPos)
    
    local movePos = { x = display.cx - oldPos.x, y = display.cy - oldPos.y }
    
    local cmbp_x = self._combatPanel_t:getPositionX()
    local cmbp_y = self._combatPanel_t:getPositionY()
    
    local minX, maxX, minY, maxY = self:getCombatPanelCoordLimit()
    
    --x轴限制
    if movePos.x > 0 then
        if (cmbp_x + movePos.x) > maxX then
            movePos.x = maxX - cmbp_x
        end
    else
        if (cmbp_x + movePos.x) < minX then
            movePos.x = minX - cmbp_x 
        end
    end
    
    --y轴限制
    if movePos.y > 0 then
        if (cmbp_y + movePos.y) > maxY then
            movePos.y = maxY - cmbp_y
        end
    else
        if (cmbp_y + movePos.y) < minY then
            movePos.y = minY - cmbp_y
        end
    end
    
    self._combatPanel_t:moveBy({  x = movePos.x,
                                  y = movePos.y,
                                  time = 0.3,
                                  onComplete = moveEndCall
                              })
    
end

function CombatViewController:getCombatPanelCoordLimit()
    
    local size = self._combatPanel_t:getContentSize()
    local offsetX = size.width/2*self.curScale - display.cx
    local offsetY = size.height/2*self.curScale - display.cy
    local minX = display.cx - offsetX
    local maxX = display.cx + offsetX
    local minY = display.cy - offsetY
    local maxY = display.cy + offsetY
    
    return minX, maxX, minY, maxY
end

--逻辑暂停
function CombatViewController:logicPause()

    self.isLogicPause = true
    CombatCenter:combatPause()
    for _,v in pairs(self.viewInfos) do
        if not v.isDeath then
            v.target:luaPause()
        end
    end

end

--逻辑继续
function CombatViewController:logicResume()

    self.isLogicPause = false
    CombatCenter:combatResume()
    for _,v in pairs(self.viewInfos) do
        if not v.isDeath then
            v.target:luaResume()
        end
    end

end

--技能释放暂停
function CombatViewController:skillPause(heroView)
    
    --打开黑色遮挡
    self:setColorLayer(true)
    
	CombatCenter:combatPause()
	for _,v in pairs(self.viewInfos) do
        if not v.isDeath and v.target ~= heroView then
            v.target:luaPause()
        end
	end
end

--技能释放，继续
function CombatViewController:skillResume(heroView)

    --关闭黑色遮挡
    self:setColorLayer(false)

	CombatCenter:combatResume()
	for _,v in pairs(self.viewInfos) do
	   if not v.isDeath and v.target ~= heroView then
            v.target:luaResume()
	   end
	end
end

--打开技能释放，黑色遮挡
function CombatViewController:setColorLayer(isShow)
	self._colorPanel_t:setVisible(isShow)
    self._shield_panel_t:setVisible(isShow)
    -- self._colorPanel_t:setEnabled(isShow)
end

--战斗开始，统一更新视图动画
function CombatViewController:updateViewAnima()
	for i=1, #self.viewInfos do
	   self.viewInfos[i].target:updateAnimas()
	end
end

function CombatViewController:updateViewMoveAnima()
    for i=1, #self.viewInfos do
       self.viewInfos[i].target:updateMoveAnima()
    end
end

--移除战斗视图
function CombatViewController:removeCombatView(view)
   for i=1, #self.viewInfos do
        if self.viewInfos[i].target == view then
            self.viewInfos[i].isDeath = true
            view:removeSelf()
        end
   end
end

--添加战斗视图
function CombatViewController:addCombatView_(model)

    local view = Factory:createCreatureView(self, model)

    assert(view, "无法给模型绑定视图")
    self.viewInfos[#self.viewInfos + 1] = { target = view, isDeath = false }

    self._combatPanel_t:addChild(self.viewInfos[#self.viewInfos].target)
end

--添加远程攻击子弹
function CombatViewController:addBulletView(bullet)
    self.bulletViews[#self.bulletViews+1] = bullet
    self._combatPanel_t:addChild(bullet)
    bullet:setController(self)
end

--移除子弹
function CombatViewController:removeBullet(bullet)
	bullet:removeSelf()
    table.removeOfValue(self.bulletViews, bullet)
end

--加载技能资源
function CombatViewController:loadCombatRes(heroInfo, models, backCall)
    assert(heroInfo.heroInfo and heroInfo.heroInfo.heros, "not hero data!")
    assert(heroInfo.enemyInfo and heroInfo.enemyInfo.heros, "not hero data!")
    
    --收集战场技能特效
	self.skillAnimaNames = {}
    local heros = {}
    table.insertto(heros, heroInfo.heroInfo.heros)
    table.insertto(heros, heroInfo.enemyInfo.heros)
    
    --根据战斗英雄，添加技能特效
    for k,v in pairs(heros) do
        local animaName = v.skillAnimaName
        if animaName and #animaName > 0 and animaName ~= "0" and not table.hasValue(self.skillAnimaNames, animaName) then
            self.skillAnimaNames[#self.skillAnimaNames + 1] = animaName
        end
        
        local skillDatas = v.m_spells.skillDatas
        for k, v in pairs(skillDatas) do
            local animaName = v.m_SkillRes
            if not table.hasValue(self.skillAnimaNames, animaName) then
                self.skillAnimaNames[#self.skillAnimaNames + 1] = animaName
            end
        end
	end

    --加载收集模型资源
    for k, v in pairs(models) do
        local temp = v.m_resId
        if not table.hasValue(self.skillAnimaNames, temp) then
            self.skillAnimaNames[#self.skillAnimaNames + 1] = temp
        end
    end
	
	--加载技能特效动画资源
	if #self.skillAnimaNames > 0 then
	   local onAnimaLoad = function(data)
	       if data == 1 then
	           backCall()
	       end
	   end
	   ResManager:loadAnimations(self.skillAnimaNames, onAnimaLoad)
	else
	   backCall()
	end

end

--移除技能特效资源
function CombatViewController:clearFightRes()

    for k, v in pairs(self.viewInfos) do
        if not v.isDeath then
            v.target:removeSelf()
        end
    end

	if self.skillAnimaNames and #self.skillAnimaNames > 0 then
	   ResManager:removeAnimations(self.skillAnimaNames)
    end
end

function CombatViewController:stopTimer()
    if self.timeSprite then
        self.timeSprite:removeFromParent() --移除时间监听
    end
end

--战斗结束
function CombatViewController:fightOver(result)

    self:recoverySpeed() --恢复正常时间流速
    TimerManager:sendServerTimeRequest() --同步服务器时间

    if self.combatInfo.combatType == CombatCenter.CombatType.RB_PVPHistoryData then --战斗录像,直接退出，不显示战斗结果
        self:quitCombat()
    -- elseif self.combatInfo.combatType == CombatCenter.CombatType.RB_GVG then
        
    else 
         --显示战斗结果回调
        local onFightOverCall = function()
            self.combatResult = result

            local  isJump = nil
            if self.combatInfo.isPassFlag then
                isJump = 1
            else
                isJump = 0
            end

            if self.combatInfo.combatType ~= CombatCenter.CombatType.RB_GVG then
                self:openChildView("app.ui.popViews.CombatOverPopView",
                                     { isRemove = false, data = { result = result, combatType = self.combatInfo.combatType ,
                                      combatInfo = self.combatInfo, isJump = isJump }} )
            else
                self:openChildView("app.ui.popViews.GvgOverPopView",
                                     { isRemove = false, data = { result = result, combatType = self.combatInfo.combatType ,
                                      combatInfo = self.combatInfo }})
            end
        end

        if self.combatInfo.combatType == CombatCenter.CombatType.RB_PVE then
            if result == CombatCenter.FightResult.WIN then
                BiographyData:excuteFightSpeak(self.combatInfo.littleLevels, BiographyData.DialogueType.Ended, onFightOverCall)                  --pve 播放战斗结束对话
            else
                onFightOverCall()
            end
        else
            onFightOverCall()  --其他战斗，直接显示战斗结果
        end

    end

end

--首战引导
function CombatViewController:firstCombatGuide()

    --sdk
    Functions.setAdbrixTag("firstTimeExperience","tutorial_combat_complete")
    Functions.setAdbrixTag("firstTimeExperience","cartoon_1_1_try")
    --清除战斗资源
    self:clearFightRes()
    -- PromptManager:openDialoguePrompt(20000, function()
            GameCtlManager:push("app.ui.imagePlayerSystem.ImagePlayerViewController",{ data = { jumpData = { levelId = 2, callBack = function()
                
                --sdk
                Functions.setAdbrixTag("firstTimeExperience","cartoon_1_3_complete")

                GameCtlManager:goTo("app.ui.newPlayerSystem.NewPlayerViewController")
            end } }})
    -- end)
end

function CombatViewController:zoomCombatMap(scale)
    self.curScale = scale
    self._combatPanel_t:setScale(scale)
end

function CombatViewController:coordinateSystem(pos)

    --斜45度处理
    pos.x = pos.x + pos.y * math.cos(math.pi*2/3)
    pos.y = pos.y * math.sin(math.pi*2/3)

    local angle = Functions.getAngle(pos) + CombatViewController.fightAngle
    local dist = Functions.getDistance({ x = 0, y = 0 }, pos) 

    pos.x = dist * math.cos(angle)
    pos.y = dist * math.sin(angle)

    pos.x = pos.x + self.combatMapOffset.x
    pos.y = pos.y + self.combatMapOffset.y

end


return CombatViewController