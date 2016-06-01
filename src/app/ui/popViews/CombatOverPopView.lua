--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local CombatOverPopView = class("CombatOverPopView", BasePopView)

local Functions = require("app.common.Functions")

CombatOverPopView.csbResPath = "cs/csb"
CombatOverPopView.debug = true
CombatOverPopView.studioSpriteFrames = {"CombatOverPopUI","CombatOverUI" }
--@auto code head end

local CombatCenter = require("app.ui.combatSystem.model.CombatCenter")

CombatOverPopView.spriteFrameNames = 
    {   
    }

--@auto code uiInit
--add spriteFrames
if #CombatOverPopView.studioSpriteFrames > 0 then
    CombatOverPopView.spriteFrameNames = CombatOverPopView.spriteFrameNames or {}
    table.insertto(CombatOverPopView.spriteFrameNames, CombatOverPopView.studioSpriteFrames)
end
function CombatOverPopView:onInitUI()

    --output list
    self._fightFailPanel_t = self.csbNode:getChildByName("fightFailPanel")
	self._fail_npc_t = self.csbNode:getChildByName("fightFailPanel"):getChildByName("fail_npc")
	self._failAwardPanel_t = self.csbNode:getChildByName("fightFailPanel"):getChildByName("failAwardPanel")
	self._fightWinPanel_t = self.csbNode:getChildByName("fightWinPanel")
	self._stars_panel_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("stars_panel")
	self._result_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result")
	self._success_npc_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("success_npc")
	self._award_panel1_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1")
	self._pve_panel_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("pve_panel")
	self._expLoadingBar_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("pve_panel"):getChildByName("expLoadingBar")
	self._expText_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("pve_panel"):getChildByName("expText")
	self._wuhunText_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("pve_panel"):getChildByName("wuhunText")
	self._coinText_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("pve_panel"):getChildByName("coinText")
	self._bloody_panel_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("bloody_panel")
	self._text_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("bloody_panel"):getChildByName("node1"):getChildByName("text")
	self._text_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("bloody_panel"):getChildByName("node2"):getChildByName("text")
	self._text_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("bloody_panel"):getChildByName("node3"):getChildByName("text")
	self._tianti_panel_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("tianti_panel")
	self._score_text_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("tianti_panel"):getChildByName("score_text")
	self._tuandui_panel_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("tuandui_panel")
	self._tuandui_text_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel1"):getChildByName("tuandui_panel"):getChildByName("tuandui_text")
	self._award_panel2_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel2")
	self._foods_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("award_panel2"):getChildByName("foods")
	self._shilian_panel_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("shilian_panel")
	self._zhangong_bg_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("shilian_panel"):getChildByName("zhangong_bg")
	self._zgText_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("shilian_panel"):getChildByName("zhangong_bg"):getChildByName("zgText")
	self._fightInvalidPanel_t = self.csbNode:getChildByName("fightInvalidPanel")
	self._errorCode_t = self.csbNode:getChildByName("fightInvalidPanel"):getChildByName("errorCode")
	
    --label list
    
    --button list
    self._faileSureBt_t = self.csbNode:getChildByName("fightFailPanel"):getChildByName("faileSureBt")
	self._faileSureBt_t:onTouch(Functions.createClickListener(handler(self, self.onFailesurebtClick), ""))

	self._heroUpBt_t = self.csbNode:getChildByName("fightFailPanel"):getChildByName("heroUpBt")
	self._heroUpBt_t:onTouch(Functions.createClickListener(handler(self, self.onHeroupbtClick), "zoom"))

	self._soldierUpBt_t = self.csbNode:getChildByName("fightFailPanel"):getChildByName("soldierUpBt")
	self._soldierUpBt_t:onTouch(Functions.createClickListener(handler(self, self.onSoldierupbtClick), "zoom"))

	self._winSureBt_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("winSureBt")
	self._winSureBt_t:onTouch(Functions.createClickListener(handler(self, self.onWinsurebtClick), ""))

	self._invalidSureBt_t = self.csbNode:getChildByName("fightInvalidPanel"):getChildByName("invalidSureBt")
	self._invalidSureBt_t:onTouch(Functions.createClickListener(handler(self, self.onInvalidsurebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Heroupbt btFunc
function CombatOverPopView:onHeroupbtClick()
    Functions.printInfo(self.debug,"Heroupbt button is click!")
    GameCtlManager:push("app.ui.enhanceSystem.EnhanceViewController")
end
--@auto code Heroupbt btFunc end

--@auto code Soldierupbt btFunc
function CombatOverPopView:onSoldierupbtClick()
    Functions.printInfo(self.debug,"Soldierupbt button is click!")
    GameCtlManager:push("app.ui.enhanceSystem.EnhanceViewController")
end
--@auto code Soldierupbt btFunc end

--@auto code Failesurebt btFunc
function CombatOverPopView:onFailesurebtClick()
    Functions.printInfo(self.debug,"Failesurebt button is click!")
    
    self:quitCombat()
end
--@auto code Failesurebt btFunc end

--@auto code Winsurebt btFunc
function CombatOverPopView:onWinsurebtClick()
    Functions.printInfo(self.debug,"Winsurebt button is click!")
    
    if self.addLevel and self.addLevel > 0 then
        local oldLevel = PlayerData.eventAttr.m_level
        PlayerData.eventAttr.m_level = PlayerData.eventAttr.m_level + self.addLevel
        
        local controller = self._controller_t
        self._controller_t:openChildView("app.ui.popViews.LevelUpPopView", { isRemove = false, data = { oldLevel = oldLevel,
         newLevel = PlayerData.eventAttr.m_level, upLevelAward = self.upLevelAward, callBack = function()
                    controller:quitCombat()
                end}})
        self:close()
    else
        self:quitCombat()
    end
end
--@auto code Winsurebt btFunc end

--@auto code Invalidsurebt btFunc
function CombatOverPopView:onInvalidsurebtClick()
    Functions.printInfo(self.debug,"Invalidsurebt button is click!")
    self:quitCombat()
end
--@auto code Invalidsurebt btFunc end

--@auto button backcall end


--@auto code output func
function CombatOverPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function CombatOverPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	
    self._fightWinPanel_t:setVisible(false)
    self._fightFailPanel_t:setVisible(false)
    self._fightInvalidPanel_t:setVisible(false)
    self._pve_panel_t:setVisible(false)
    self._bloody_panel_t:setVisible(false)
    self._tianti_panel_t:setVisible(false)
    self._tuandui_panel_t:setVisible(false)
    self._award_panel2_t:setVisible(false)
    self._shilian_panel_t:setVisible(false)

    --游戏结束音效
    local scheduler = require("app.common.scheduler")
    if data.result == CombatCenter.FightResult.WIN then
        scheduler.performWithDelayGlobal(function()
            Audio.playSound("sound/game_win.mp3")
        end, 0.4)

        if PlayerData.eventAttr.m_guideId == 5 or PlayerData.eventAttr.m_guideId == 7 or PlayerData.eventAttr.m_guideId == 8 or PlayerData.eventAttr.m_guideId == 12 then  --手动完成新手引导
            GuideManager:finishGuide()
        end
    else
        scheduler.performWithDelayGlobal(function()
            Audio.playSound("sound/game_lose.mp3")
        end, 0.4)
    end

    self.currentType  = data.combatType
    self.combatResult = data.result
    self.combatInfo = data.combatInfo
	
    local elist   = CombatCenter:getAiEventList()
    local clist   = CombatCenter:getAiCreatureList()
    local baseMsg = { idx = { 1, 2 }, data = { res = data.result, elist = elist, clist = clist } }

	if data.combatType == CombatCenter.CombatType.RB_PVE then
		baseMsg.btype = 1
	elseif data.combatType == CombatCenter.CombatType.RB_ElitePVE then
        baseMsg.btype = 3
    elseif data.combatType == CombatCenter.CombatType.RB_Tandui then
        baseMsg.btype = 9
        local hps = CombatCenter:getHeroHpList()
        for i=4, 6 do
            baseMsg.data["hero" .. tostring(i-3)] = hps[i]
        end
    elseif data.combatType == CombatCenter.CombatType.RB_HeroTrial then
        baseMsg.btype = 8
    elseif data.combatType == CombatCenter.CombatType.RB_BloodyBattle then
        baseMsg.data.isJump = data.isJump
        baseMsg.btype = 7

        --血战应用分析
        Functions.setAdbrixTag("retension","blood_try_" .. tostring(XueZhanData.xueZhanData.m_xzlyCount+1), PlayerData.eventAttr.m_level)

    elseif data.combatType == CombatCenter.CombatType.RB_PVPPlayerData then
        baseMsg.btype = 2
        baseMsg.data.euid  = self.combatInfo.playerData.id
    elseif data.combatType == CombatCenter.CombatType.RB_GVG then
        baseMsg.btype = 11
        local hps = CombatCenter:getHeroHpList()
        for i=1, 6 do
            baseMsg.data["hero" .. tostring(i)] = hps[i]
        end

        baseMsg.data.big = self.combatInfo.big
        baseMsg.data.small = self.combatInfo.small
	end 
    
    NetWork:addNetWorkListener({ 1, 2}, handler(self, self.onServerResponse))
    NetWork:sendToServer(baseMsg)
    
end

function CombatOverPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function CombatOverPopView:onServerResponse(event)
  
    self:displayCombatResult_(event)
    return true
end


function CombatOverPopView:onFbPveOverFunc(data)
    self:onFbResultHandler(data)

    --更新关卡通关星数
    BiographyData:setFbPassStar(self.combatInfo.majorHurdles, self.combatInfo.littleLevels, data.star)
    BiographyData:updateFbLimit(self.combatInfo.combatType, self.combatInfo.majorHurdles, self.combatInfo.littleLevels)

end

function CombatOverPopView:onEliteFbOverFunc(data)
    self:onFbResultHandler(data)

    --更新关卡通关星数
    BiographyData:setEliteFbPassStar(self.combatInfo.majorHurdles, self.combatInfo.littleLevels, data.star)
    BiographyData:updateFbLimit(self.combatInfo.combatType, self.combatInfo.majorHurdles, self.combatInfo.littleLevels)

end

function CombatOverPopView:onFbResultHandler(data)

    --数据初始化
    PlayerData:addPlayerAtrs({ money = data.reward.money, soul = data.reward.soul})
    self.addLevel = data.addlevel
    self.upLevelAward = data.allgoods

    --ui显示
    self:fbDataDis_(data)

end

function CombatOverPopView:onTuanduiFunc(data)
    --ui显示
    local onPlayStarAnimaFinish = function()

        self._result_t:setVisible(true)
        self._tuandui_panel_t:setVisible(true)
        self._award_panel1_t:setVisible(true)
        
        --绑定fb获得数据显示
        Functions.initLabelOfString(    
            self._tuandui_text_t, "+" .. tostring(math.floor(data.reward.money))
        )

        --初始化掉落物
        self:showRewardFoods(data.reward.item, false)
        
    end
    self:playStarAnima_(data.star, onPlayStarAnimaFinish)
end

function CombatOverPopView:tuanduiFailFunc(data)
    self._failAwardPanel_t:setVisible(true)
    --数据初始化
    PlayerData.eventAttr.m_money = PlayerData.eventAttr.m_money + data.reward.money
    
    --绑定fb获得数据显示
    Functions.initLabelOfString(    
        self._failAwardPanel_t:getChildByName("coinText"), "+" .. tostring(math.floor(data.reward.money))
    )
end

function CombatOverPopView:onHeroTrialFunc(event)
    
    local onPlayStarAnimaFinish = function()

        self._result_t:setVisible(true)
    	self._shilian_panel_t:setVisible(true)

    	
        local heroTrialData = HeroShiLianData:getShiLianInfo()
        local addZhanGong   = event.data.progress - heroTrialData[self._controller_t.combatInfo.majorHurdles].progress
        Functions.initLabelOfString(self._zgText_t, "+" .. addZhanGong)

    end
    self:playStarAnima_(event.star, onPlayStarAnimaFinish)
end

function CombatOverPopView:onBloodyBattleFunc(data)

    local onPlayStarAnimaFinish = function()

        self._result_t:setVisible(true)
        self._award_panel1_t:setVisible(true)
        self._bloody_panel_t:setVisible(true)
        self._award_panel2_t:setVisible(true)

        --绑定fb获得数据显示
        for i=1, 3 do
            local child = self._bloody_panel_t:getChildByName("node" .. tostring(i))
            if data.reward.base[i] then

                child:setVisible(true)
                local text = child:getChildByName("text")
                local image = child:getChildByName("image")
                Functions.initLabelOfString(text, "+" .. tostring(data.reward.base[i][3]))
                Functions.loadImageWithSprite(image, "commonUI/res/image/" .. ResImageTable[data.reward.base[i][1]] .. ".png")

                PropData:addProp({m_id = data.reward.base[i][1], m_count = data.reward.base[i][3]})
            else
                child:setVisible(false)
            end
        end

        if #data.reward.extra > 0 then
            self:showRewardFoods(data.reward.extra)
        end

    end
    self:playStarAnima_(data.star, onPlayStarAnimaFinish)

end

function CombatOverPopView:onPVPlayerDataFunc(data)
    
    TianTiData.eventAttr.m_tianTiScore = data.score
    TianTiData.eventAttr.m_tianTiRank = data.nrank
         
    local onPlayStarAnimaFinish = function()
        
        self._result_t:setVisible(true)
        self._award_panel1_t:setVisible(true)
        self._tianti_panel_t:setVisible(true)

        --绑定fb获得数据显示
        Functions.initLabelOfString(    
            self._score_text_t, "+" .. tostring(data.diffscore)
        )

         UIActionTool:playPopAction({ target = self._result_t, beginScale = 0.2, endScale = 1,
     maxScale = 1.8, time = 0.1 })
    end
    self:playStarAnima_(data.star, onPlayStarAnimaFinish)

end

function CombatOverPopView:onGVGFunc(data)
    self._result_t:setVisible(true)
    self._award_panel1_t:setVisible(true)
    self._bloody_panel_t:setVisible(true)
    self._award_panel2_t:setVisible(true)
    print("gvg return success!")
end

function CombatOverPopView:fbDataDis_(data)

    --同步经验
    local oldExp = PlayerData.eventAttr.m_exp
    PlayerData.eventAttr.m_exp = data.exps 

    local onPlayStarAnimaFinish = function()

        self._result_t:setVisible(true)
        self._pve_panel_t:setVisible(true)
        self._award_panel1_t:setVisible(true)
        self._award_panel2_t:setVisible(true)
        
        --绑定fb获得数据显示
        Functions.initLabelOfString(    
            self._coinText_t, "+" .. tostring(data.reward.money),
            self._wuhunText_t, "+" .. tostring(data.reward.soul)
        )

        --经验增长
        local tempExp = 0
        local loopAdd = math.floor(data.reward.exps*0.06)

        self._expLoadingBar_t:setPercent(oldExp/g_roleUplevelExp[PlayerData.eventAttr.m_level]*100)
        self._expText_t:setString(tostring(oldExp) .. "/" .. tostring(g_roleUplevelExp[PlayerData.eventAttr.m_level]))
        local scheduler = require("app.common.scheduler")
        scheduler.performWithDelayGlobal(function()
            local expUpdateAction = UIActionTool:createLoopFunc(0.06,function()
                tempExp = tempExp + loopAdd
                if tempExp > data.reward.exps then
                    tempExp = data.reward.exps
                end
                local currentExp = oldExp + tempExp
                if currentExp > g_roleUplevelExp[PlayerData.eventAttr.m_level] then
                    currentExp = g_roleUplevelExp[PlayerData.eventAttr.m_level]
                end
                if tempExp < data.reward.exps and currentExp < g_roleUplevelExp[PlayerData.eventAttr.m_level] then
                    self._expLoadingBar_t:setPercent(currentExp/g_roleUplevelExp[PlayerData.eventAttr.m_level]*100)
                    self._expText_t:setString(tostring(currentExp) .. "/" .. tostring(g_roleUplevelExp[PlayerData.eventAttr.m_level]))
                    return false
                else
                    self._expLoadingBar_t:setPercent(currentExp/g_roleUplevelExp[PlayerData.eventAttr.m_level]*100)
                    self._expText_t:setString(tostring(currentExp) .. "/" .. tostring(g_roleUplevelExp[PlayerData.eventAttr.m_level]))
                    return true
                end
            end)
            transition.execute(self._expText_t, expUpdateAction)
        end, 0.5)

        --初始化掉落物
        self:showRewardFoods(data.reward.item)

        UIActionTool:playPopAction({ target = self._result_t, beginScale = 0.2, endScale = 1,
     maxScale = 1.3, time = 0.1 })

        --扫荡引导
        if PlayerData.eventAttr.m_guideId == 13 then
            scheduler.performWithDelayGlobal(function()
                PromptManager:openNewGuide(self._winSureBt_t, LanguageConfig.Guide_OpenTip_sd)
            end, 0.9)
        end
    end
    self:playStarAnima_(data.star, onPlayStarAnimaFinish)
end

function CombatOverPopView:showRewardFoods(datas, isAddItems)

    local items = Functions.rewardDataHandler(datas)
    self:showItems_(items, isAddItems)
end

function CombatOverPopView:showItems_(items, isAddItems)

    if isAddItems == nil then isAddItems = true end

    --添加获得的掉落物到背包系统
    if isAddItems then
        Functions.addItemsToData(items)
    end

    --战斗结束界面，掉落物文本设置为白色
    Functions.initDropAward(self._foods_t, items)

end


function CombatOverPopView:playStarAnima_(starNum, backCall)
    Functions.updateStarDis(self._stars_panel_t, starNum, 3)
    
    self._result_t:setVisible(false)
    UIActionTool:playPopAction({ target = self._stars_panel_t, beginScale = 0.2, endScale = 1,
     maxScale = 1.8, time = 0.1, onComplete = backCall })
end

function CombatOverPopView:displayCombatResult_(event)
    local ResultFuncs = 
    {
        [CombatCenter.CombatType.RB_PVE]           = handler(self, self.onFbPveOverFunc),
        [CombatCenter.CombatType.RB_ElitePVE]      = handler(self, self.onEliteFbOverFunc),
        [CombatCenter.CombatType.RB_Tandui]        = handler(self, self.onTuanduiFunc),
        [CombatCenter.CombatType.RB_HeroTrial]     = handler(self, self.onHeroTrialFunc),
        [CombatCenter.CombatType.RB_BloodyBattle]  = handler(self, self.onBloodyBattleFunc),
        [CombatCenter.CombatType.RB_PVPPlayerData] = handler(self, self.onPVPlayerDataFunc),
        [CombatCenter.CombatType.RB_GVG]           = handler(self, self.onGVGFunc),
        
    }
    
    --同步体力
    if self.currentType == CombatCenter.CombatType.RB_PVE or self.currentType == CombatCenter.CombatType.RB_ElitePVE
    or  self.currentType == CombatCenter.CombatType.RB_HeroTrial then --血战不需要消耗体力
        PlayerData:setPlayerPower(event.energy)
    end

    if self.combatResult == 1 then
    
        if self.currentType == CombatCenter.CombatType.RB_PVPPlayerData and event.err ~= 1 then
            self._fightFailPanel_t:setVisible(false)
            self._fightInvalidPanel_t:setVisible(true)
            self._errorCode_t:setString(LanguageConfig.ui_CombatView_invalid)
        else
            --初始化npc
            Functions.loadImageWithSprite(self._success_npc_t, "npc/NPC_zgl_combatSuccess.png")

            self:setCombatResultDis(true) 
            ResultFuncs[self.currentType](event) 
        end
    else
        --初始化npc
        Functions.loadImageWithSprite(self._fail_npc_t, "npc/NPC_zgl_combatFail.png")
        
        self:setCombatResultDis(false)

        if self.currentType == CombatCenter.CombatType.RB_Tandui then
            self._heroUpBt_t:setVisible(false)
            self._soldierUpBt_t:setVisible(false)

            self:tuanduiFailFunc(event)
        else
            self._heroUpBt_t:setVisible(true)
            self._soldierUpBt_t:setVisible(true)
        end
    end
        
end

function CombatOverPopView:setCombatResultDis(isWin)
    if isWin then
        self._fightFailPanel_t:setVisible(false)
        self._fightWinPanel_t:setVisible(true)
    else
        self._fightFailPanel_t:setVisible(true)
        self._fightWinPanel_t:setVisible(false)
    end
end

function CombatOverPopView:quitCombat()
    local controller = self._controller_t
    self:close()
    controller:quitCombat() 
end

return CombatOverPopView