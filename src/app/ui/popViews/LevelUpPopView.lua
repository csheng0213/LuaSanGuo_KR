--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local LevelUpPopView = class("LevelUpPopView", BasePopView)

local Functions = require("app.common.Functions")

LevelUpPopView.csbResPath = "cs/csb"
LevelUpPopView.debug = true
LevelUpPopView.studioSpriteFrames = {"CBO_uplevelPanel","MainUI","LevelUpPopUI" }
--@auto code head end

--@Pre loading
LevelUpPopView.spriteFrameNames = 
    {
    }

LevelUpPopView.animaNames = 
    {
        "Ani_levelup"
    }

local scheduler = require("app.common.scheduler")

--@auto code uiInit
--add spriteFrames
if #LevelUpPopView.studioSpriteFrames > 0 then
    LevelUpPopView.spriteFrameNames = LevelUpPopView.spriteFrameNames or {}
    table.insertto(LevelUpPopView.spriteFrameNames, LevelUpPopView.studioSpriteFrames)
end
function LevelUpPopView:onInitUI()

    --output list
    self._tips1_1_d_t = self.csbNode:getChildByName("tips1_1_d")
	self._uplevel_pnc_t = self.csbNode:getChildByName("uplevel_pnc")
	self._tips1_1_t = self.csbNode:getChildByName("tips1_1")
	self._level_text_t = self.csbNode:getChildByName("tips1_1"):getChildByName("level_text")
	self._upLevelText_t = self.csbNode:getChildByName("tips1_1"):getChildByName("upLevelText")
	self._foods_t = self.csbNode:getChildByName("tips1_1"):getChildByName("foods")
	self._notItem_text_t = self.csbNode:getChildByName("tips1_1"):getChildByName("foods"):getChildByName("notItem_text")
	self._animaNode_t = self.csbNode:getChildByName("animaNode")
	
    --label list
    
    --button list
    self._surt_bt_t = self.csbNode:getChildByName("tips1_1"):getChildByName("surt_bt")
	self._surt_bt_t:onTouch(Functions.createClickListener(handler(self, self.onSurt_btClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Surt_bt btFunc
function LevelUpPopView:onSurt_btClick()
    Functions.printInfo(self.debug,"Surt_bt button is click!")
    
    local controller = self._controller_t
    local tempCall = self.endCallBack
    self:close()

    if PlayerData.eventAttr.m_guideStageId and g_guideConfig.guideStage[PlayerData.eventAttr.m_guideStageId] and PlayerData.eventAttr.m_guideStageId ~= 1 then
        GameCtlManager:goTo("app.ui.mainSystem.MainViewController")
    else
        if tempCall then
            tempCall()
        end
    end
    
end
--@auto code Surt_bt btFunc end

--@auto button backcall end


--@auto code output func
function LevelUpPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function LevelUpPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
    
    --初始化npc
    Functions.loadImageWithSprite(self._uplevel_pnc_t, "npc/NPC_zf_uplevel.png")

    self.endCallBack = data.callBack
	Functions.initLabelOfString(self._level_text_t, data.oldLevel,self._upLevelText_t, data.newLevel)

    self._tips1_1_t:setVisible(false)
    self._tips1_1_d_t:setVisible(false)
    self._uplevel_pnc_t:setVisible(false)
	local onAnimaFinish = function()
        self._tips1_1_t:setVisible(true)
        self._tips1_1_d_t:setVisible(true)
        self._uplevel_pnc_t:setVisible(true)

        if PlayerData.eventAttr.m_energy == g_csBaseCfg.MaxBaseEnergy then
            PromptManager:openTipPrompt(LanguageConfig["ui_LevelUpView_1"])
        end
	end

    --显示升级奖励
    local items = Functions.rewardDataHandler(data.upLevelAward)
    Functions.addItemsToData(items)
    Functions.initDropAward(self._foods_t, items, cc.c3b(93,36,15))

    --播放升级声音
    Functions.playSound("masterlevelup.mp3")
	local anima = Functions.createSprite({ copyNode = self._animaNode_t })    
	self._animaNode_t:getParent():addChild(anima)

    if G_CurrentLanguage == "hr" then
        anima:setScale(2)
    else
        anima:setScale(1.5)
    end
    Functions.playActionWithBackCall(anima, "Ani_levelup", onAnimaFinish)

    local onReturnMain = function()
    end

    if PlayerData.eventAttr.m_guideStageId and g_guideConfig.guideStage[PlayerData.eventAttr.m_guideStageId]
     and PlayerData.eventAttr.m_guideStageId ~= 1 then
        scheduler.performWithDelayGlobal(function()
                            PromptManager:openNewGuide(self._surt_bt_t, g_uplevelConfig[PlayerData.eventAttr.m_level], onReturnMain, true)
                         end, 1.5)
    end
                    
end

function LevelUpPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return LevelUpPopView