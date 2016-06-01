--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local MinFbSelectViewController = class("MinFbSelectViewController", BaseViewController)

local Functions = require("app.common.Functions")

MinFbSelectViewController.debug = true
MinFbSelectViewController.modulePath = ...
MinFbSelectViewController.studioSpriteFrames = {"MinFbSelectUI","CBO_taskNewBg","FbSelectUI","CBO_infor" }
--@auto code head end

--@Pre loading
MinFbSelectViewController.spriteFrameNames = 
    {
        "headPilistRes","FbSelectUIMap1","FbSelectUIMap2"
    }

MinFbSelectViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #MinFbSelectViewController.studioSpriteFrames > 0 then
    MinFbSelectViewController.spriteFrameNames = MinFbSelectViewController.spriteFrameNames or {}
    table.insertto(MinFbSelectViewController.spriteFrameNames, MinFbSelectViewController.studioSpriteFrames)
end
function MinFbSelectViewController:onDidLoadView()

    --output list
    self._bg_t = self.view_t.csbNode:getChildByName("main"):getChildByName("bg")
	self._reward_info_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info")
	self._gkjl_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info"):getChildByName("gkjl_panel")
	self._coin_jl_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info"):getChildByName("gkjl_panel"):getChildByName("coin_jl_text")
	self._exp_jl_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info"):getChildByName("gkjl_panel"):getChildByName("exp_jl_text")
	self._wuhun_jl_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info"):getChildByName("gkjl_panel"):getChildByName("wuhun_jl_text")
	self._neet_power_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info"):getChildByName("gkjl_panel"):getChildByName("neet_power_text")
	self._shaod_star_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info"):getChildByName("gkjl_panel"):getChildByName("shaod_star_panel")
	self._goods_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info"):getChildByName("goods_panel")
	self._goods1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info"):getChildByName("goods_panel"):getChildByName("goods1")
	self._goods_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info"):getChildByName("goods_panel"):getChildByName("goods")
	self._gkPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("gkPanel")
	self._tabs_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("tabs")
	self._tab3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("tabs"):getChildByName("tab3")
	self._tab2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("tabs"):getChildByName("tab2")
	self._jyPoint_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("tabs"):getChildByName("tab2"):getChildByName("jyPoint")
	self._jituiText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("leftTopPanel"):getChildByName("power_panel"):getChildByName("jituiText")
	self._gkName_t = self.view_t.csbNode:getChildByName("main"):getChildByName("leftTopPanel"):getChildByName("gkName")
	self._gkIndexText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("leftTopPanel"):getChildByName("gkIndexText")
	self._box1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("rightTopPanel"):getChildByName("box1")
	self._box2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("rightTopPanel"):getChildByName("box2")
	self._gk_neet_star1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("rightTopPanel"):getChildByName("gk_neet_star1")
	self._gk_neet_star2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("rightTopPanel"):getChildByName("gk_neet_star2")
	self._jy_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("jy_panel")
	self._td_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("td_panel")
	
    --label list
    
    --button list
    self._shaodangBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info"):getChildByName("shaodangBt")
	self._shaodangBt_t:onTouch(Functions.createClickListener(handler(self, self.onShaodangbtClick), ""))

	self._fightBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("panel"):getChildByName("reward_info"):getChildByName("fightBt")
	self._fightBt_t:onTouch(Functions.createClickListener(handler(self, self.onFightbtClick), ""))

	self._backBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("leftTopPanel"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), ""))

	self._addPowerBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("leftTopPanel"):getChildByName("power_panel"):getChildByName("addPowerBt")
	self._addPowerBt_t:onTouch(Functions.createClickListener(handler(self, self.onAddpowerbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt btFunc
function MinFbSelectViewController:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    BiographyData.eventAttr.curFbType = CombatCenter.CombatType.RB_PVE
    GameCtlManager:pop(self)    
end
--@auto code Backbt btFunc end

--@auto code Addpowerbt btFunc
function MinFbSelectViewController:onAddpowerbtClick()
    Functions.printInfo(self.debug,"Addpowerbt button is click!")

    Functions.setAdbrixTag("retension","energy_inter")
    Functions.buyPowerHandler(self)
end
--@auto code Addpowerbt btFunc end

--@auto code Shaodangbt btFunc
function MinFbSelectViewController:onShaodangbtClick()
    Functions.printInfo(self.debug,"Shaodangbt button is click!")
    
    --检查限制
    if self:fightBeginRuleCheck_() then
        --等级条件限制
        if PlayerData.eventAttr.m_level < g_csOpen.SweepingOpen.level then
            PromptManager:openTipPrompt(LanguageConfig["language_9_60"])
            return
        end

        local neetPower = BiographyData:getCruFbNeedPower()

        if PlayerData.eventAttr.m_energy < neetPower then
            PromptManager:openTipPrompt(LanguageConfig["language_6_22"])
            return
        end

        local gkInfo    = BiographyData:getCurFbInfo()[BiographyData.eventAttr.curSelectIndex]
        local maxGkNum  = gkInfo.maxPass - gkInfo.limit
        if maxGkNum > BiographyData:getCruFbLimit() then
            maxGkNum = BiographyData:getCruFbLimit()
        end
        self:openChildView("app.ui.popViews.SweepPopView", { isRemove = false, name = "SweepPopView",data = { totalNum = g_maxSweepOfDay, levelNum = maxGkNum, levelPower = neetPower }})
    end

end
--@auto code Shaodangbt btFunc end

--@auto code Fightbt btFunc
function MinFbSelectViewController:onFightbtClick()
    Functions.printInfo(self.debug,"Fightbt button is click!")
    
    -- 团队副本，不需要检查次数和体力相关限制
    if BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_Tandui then

        --服务器时间更新监听
        local onFightBegin = function(event)
            GameCtlManager:push("app.ui.combatSystem.CombatViewController",
                                            { data = {  combatType = BiographyData.eventAttr.curFbType,
                                                        majorHurdles = BiographyData.eventAttr.curSelectFbId,
                                                        littleLevels = self.curLittleLevel
                                                    }
                                             })
        end
        NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onFightBegin, true, "ret"))
        local msg = { idx = { 7, 1 }, reqtype = 37, data = { lidx = BiographyData.eventAttr.curSelectFbId - 6,
         sidx = self.curLittleLevel - (BiographyData.eventAttr.curSelectFbId - 1)*10 }  }
        NetWork:sendToServer(msg)
    else
        --检查限制
        if self:fightBeginRuleCheck_() then
            GameCtlManager:push("app.ui.combatSystem.CombatViewController",
                                            { data = {  combatType = BiographyData.eventAttr.curFbType,
                                                        majorHurdles = BiographyData.eventAttr.curSelectFbId,
                                                        littleLevels = self.curLittleLevel
                                                    }
                                             })
        end
    end
    
end
--@auto code Fightbt btFunc end

--@auto button backcall end


--@auto code view display func
function MinFbSelectViewController:onCreate()
    Functions.printInfo(self.debug_b," MinFbSelectViewController controller create!")
end

function MinFbSelectViewController:openBgMusic()
    Audio.playMusic("sound/combat.mp3", true)
end

function MinFbSelectViewController:onDisplayView()
	Functions.printInfo(self.debug_b," MinFbSelectViewController view enter display!")
	
    DebugDelayTime("MinFbSelectViewController---1")
    self.isGuideState = false

    -- self._backBt_t:ignoreContentAdaptWithSize(false)
    -- self._backBt_t:setSize({ width = 100, height = 100})


    --初始化bg
    local map = string.format("cs/ui_res/FbSelectUI/map%d.png", math.ceil(BiographyData.eventAttr.curSelectFbId/6))
    Functions.loadImageWithSprite(self._bg_t, map)

    --绑定体力监听
    Functions.bindMGSDisplay({ powerObj = self._jituiText_t })

    --绑定奖励获取监听
    local onAwardReceivefinish = function(event)
        if event.awardType == BiographyData.AWARD_TYPE.SmallType then
            self:awardBoxHandler_(self._box1_t)
        else
            self:awardBoxHandler_(self._box2_t)
        end
    end
    
    Functions.bindEventListener(self.view_t, GameEventCenter, BiographyData.FB_RECEIVE_AWARD_SUCCESS_EVENT,
     onAwardReceivefinish)

    --初始化副本掉落物显示相关参数
    self.awardItemDistance = self._goods1_t:getPositionX() - self._goods_t:getPositionX()
    self.awardFirstPos = { x = self._goods_t:getPositionX(), y = self._goods_t:getPositionY() }
    self.awardItemScale = self._goods_t:getScale()

    --绑定刷新奖励数据按钮监听
    Functions.bindEventListener(self.view_t, GameEventCenter, BiographyData.FB_RECEIVE_AWARD_SUCCESS_EVENT,
        handler(self, self.refresFbAwardClickUI))

    Functions.bindEventListener(self.view_t, GameEventCenter , BiographyData.FB_DATA_UPDATA_EVENT,
        handler(self, self.refresFbAwardClickUI))

    self:refresFbAwardClickUI()

    --刷新顶部视图
    self:refreshTopViewInfo()

    --刷新标签页按钮
    self:refreshTabButton()

    --绑定小关卡切换监听
    Functions.bindUiWithModelAttr(self.view_t, BiographyData, "curSelectIndex", handler(self, self.refreshGkSelect))

    --刷新界面显示的所有FB相关信息
    self:refreshGkButton()
    Functions.bindEventListener(self.view_t, GameEventCenter, BiographyData.FB_DATA_UPDATA_EVENT, handler(self, self.refreshGkButton))
    
    --刷新关卡次数和限制
    Functions.bindEventListener(self.view_t, GameEventCenter, BiographyData.FB_STAR_LIMIT_RESET_EVENT, handler(self, self.refreshMinGkDis_))
    
    DebugDelayTime("MinFbSelectViewController--- ")
end
--@auto code view display func end

--接受pop数据
function MinFbSelectViewController:onReceivePopData(data)

    if PlayerData.eventAttr.m_guideId == 105 then
        self.isGuideState = true
    end

    if data.result == CombatCenter.FightResult.WIN then

         --刷新标签页按钮 解决普通副本通关，刷新精英tab点击监听
        if not self.curJyState and BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then

            -- if BiographyData.eventAttr.curPassLittelLevel%10 == 0 and
            --  (BiographyData.eventAttr.curPassLittelLevel - BiographyData.eventAttr.curPassEliteLittelLevel)  == 10 then
            --     PromptManager:openTipPrompt(LanguageConfig.ui_MinFbSelectView_2)
            -- end

            if BiographyData.eventAttr.curPassLittelLevel%10 == 0 then
                PromptManager:openTipPrompt(LanguageConfig.ui_MinFbSelectView_2)
            end

            if BiographyData.eventAttr.curPassLittelLevel == 10 then
                Functions.handGuideOfFeild("isGuideJyGk", 1002)
            end
        end
        
        self:refreshTabButton()

        if BiographyData.eventAttr.curFbType ~= CombatCenter.CombatType.RB_Tandui then
            self:refreshGkButton() --普通，精英副本，刷新关卡显示
        else
            self:onClickTuanDui() --团队副本胜利，刷新关卡展示
        end

    end

end

--刷新顶部显示栏
function MinFbSelectViewController:refreshTopViewInfo()

    --初始化副本名称 
    local textIndex = string.format(LanguageConfig.ui_CombatView_GkIndex, BiographyData.eventAttr.curSelectFbId)
    self._gkIndexText_t:setString(textIndex)
    self._gkName_t:setString(ConfigHandler:getCheckPointNameOfID(BiographyData.eventAttr.curSelectFbId))

    local fbAwards = BiographyData:getCurFbAwardData()
    --初始化星级条件
    Functions.initLabelOfString(self._gk_neet_star1_t, fbAwards[1].neetStarCount, self._gk_neet_star2_t , fbAwards[2].neetStarCount)

end

-------------------奖励------------------------------
--刷新奖励点击按钮监听
function MinFbSelectViewController:refresFbAwardClickUI()
    
    local fbAwards = BiographyData:getCurFbAwardData()
    
    --初始化按钮fb奖励按钮监听
    for i=1, 2 do
        local awardType = i - 1
        local onAwardClick = function()
            self:openChildView("app.ui.popViews.CombatAwardPopView", { data = { awardData = fbAwards[i], awardType = awardType } })
        end
        
        self["_box" .. tostring(i) .. "_t"]:getChildByName("bt"):onTouch(Functions.createClickListener(onAwardClick))
    end
    
    --刷新宝箱状态
    self:reFreshAwardBoxState(fbAwards[1], self._box1_t)
    self:reFreshAwardBoxState(fbAwards[2], self._box2_t)
end

function MinFbSelectViewController:reFreshAwardBoxState(state, box)

    local bg = box:getChildByName("box_bg")
    local isGetView = box:getChildByName("isGet")
	if state.isReceive == 1 then
        bg:stopAllActions()
        bg:setVisible(false)
        isGetView:setVisible(true)
	else
        isGetView:setVisible(false)
        
        if state.curStarCount >= state.neetStarCount then
            local bg = box:getChildByName("box_bg")
            bg:setVisible(true)
            Functions.playActionWithBackCall(bg, UIActionTool:createBlinkAction(0.5))
        end
        
	end
end

function MinFbSelectViewController:awardBoxHandler_(box)
    local bg = box:getChildByName("box_bg")
    local isGetView = box:getChildByName("isGet")
    bg:stopAllActions()
    bg:setVisible(false)
    isGetView:setVisible(true)
end

----------------------------关卡信息-------------------------
function MinFbSelectViewController:disGKBoardHandler_(target, isOpen)
    if isOpen then
        if not target:isVisible() then
            target:setVisible(true) 
            target:fadeIn({ time = 0.3 })
        end
    else
        if target:isVisible() then
            target:fadeOut({ time = 0.5 , onComplete = function()
                    target:setVisible(false)
                end})
        end
    end
end

--初始化界面显示，绑定精英选项卡切换
function MinFbSelectViewController:refreshTabButton()
	
    --显示团队标签
    if BiographyData.eventAttr.curSelectFbId > 6 then
        self._tab3_t:setVisible(true)
    else
        self._tab3_t:setVisible(false)
    end

    --初始化标签切换
    local onTabClick = function(data)
        if data == "tab1" then

            if BiographyData.eventAttr.curFbType ~= CombatCenter.CombatType.RB_PVE then
                BiographyData.isAutoUpdateGk = true
                BiographyData.eventAttr.curFbType = CombatCenter.CombatType.RB_PVE
                self:refreshGkButton()                                                                                                           
            end

            self:disGKBoardHandler_(self._jy_panel_t, false)
            self:disGKBoardHandler_(self._td_panel_t, false)
        elseif data == "tab2" then
            
            if BiographyData.eventAttr.curFbType ~= CombatCenter.CombatType.RB_ElitePVE then
                BiographyData.isAutoUpdateGk = true
                BiographyData.eventAttr.curFbType = CombatCenter.CombatType.RB_ElitePVE
                self:refreshGkButton()
            end

            self:disGKBoardHandler_(self._jy_panel_t, true)
            self:disGKBoardHandler_(self._td_panel_t, false)
        elseif data == "tab3" then
            if BiographyData.eventAttr.curFbType ~= CombatCenter.CombatType.RB_Tandui then
                BiographyData.isAutoUpdateGk = true
                BiographyData.eventAttr.curFbType = CombatCenter.CombatType.RB_Tandui
                self:refreshGkButton()
            end

            self:disGKBoardHandler_(self._jy_panel_t, false)
            self:disGKBoardHandler_(self._td_panel_t, true)
        end
    end

    local onDisTab2Click = function(data)
        PromptManager:openTipPrompt(LanguageConfig.language_MinFb_1)
    end

    local onDisTab3Click = function(data)
        PromptManager:openTipPrompt(LanguageConfig.language_MinFb_2)
    end

    local onDisTab3Click1 = function(data)
        PromptManager:openTipPrompt(LanguageConfig["language_task_13"])
    end

    local disTabDatas = {}
    local tabState = BiographyData:getCurFbState()
    if not tabState.isOpen_jy then
        disTabDatas[#disTabDatas+1] = { name = "tab2", listener = onDisTab2Click }
        self.curJyState = false
    else
        self.curJyState = true
    end

    --刷新精英是否打通的标志
    local isFinish = BiographyData:getEliteFbFinishOfFbId(BiographyData.eventAttr.curSelectFbId)
    if isFinish or not self.curJyState then
        self._jyPoint_t:setVisible(false)
    else
        self._jyPoint_t:setVisible(true)
    end
    
    if UnionData:isHaveTong() then
        local isOff = UnionData:isTeamFBOff(BiographyData.eventAttr.curSelectFbId)
        if not isOff or not BiographyData:checkCurTuiduiFbState(BiographyData.eventAttr.curSelectFbId) then
            disTabDatas[#disTabDatas+1] = { name = "tab3", listener = onDisTab3Click }
        end
    else
        disTabDatas[#disTabDatas+1] = { name = "tab3", listener = onDisTab3Click1 }
    end
    
    if BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then
        Functions.initTabComWithSimple({ widget = self._tabs_t, listener = onTabClick, firstName = "tab1", disTabDatas = disTabDatas })
    elseif BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_ElitePVE then
        Functions.initTabComWithSimple({ widget = self._tabs_t, listener = onTabClick, firstName = "tab2", disTabDatas = disTabDatas })
    else
        Functions.initTabComWithSimple({ widget = self._tabs_t, listener = onTabClick, firstName = "tab3", disTabDatas = disTabDatas })
    end

    --获得精英点击标签
    self._jyTab_t = self._tabs_t:getChildByName("tab2")
end


--根据选择的小关卡，刷新关卡数据显示
function MinFbSelectViewController:refreshGkSelect()
	
    --刷新小关卡显示
	for i=1, 10 do
	   
        --设置选中关卡的标志
        local selectView = self._gkPanel_t:getChildByName("gk" .. tostring(i)):getChildByName("1")
              
        if i == BiographyData.eventAttr.curSelectIndex then
            selectView:setVisible(true)
        else 
            selectView:setVisible(false)
        end  
         
	end
	
	--刷新小关卡底部数据
    self:refresGKinfo_(BiographyData.eventAttr.curSelectIndex + (BiographyData.eventAttr.curSelectFbId - 1)*10)
	
end

--刷新界面显示的所有FB相关信息
function MinFbSelectViewController:refreshGkButton()

    if BiographyData.eventAttr.curFbType ~= CombatCenter.CombatType.RB_Tandui then
        --获取关卡最大开启关卡
        local fbMaxGkNumber = BiographyData:getCurFbMaxGkNumber()

        --根据当前副本，设置最大选择的FB关卡
        if BiographyData.isAutoUpdateGk then
            BiographyData.eventAttr.curSelectIndex = fbMaxGkNumber
        end

        --手动刷新小关卡奖励显示，防止当精英普通切换时，选择索引相等时，属性监听无效
        self:refreshGkSelect()


        --绑定关卡点击监听
        for i=1, 10 do
            local bt = nil
            if i <= fbMaxGkNumber then
                local onGkClick = function()
                    if i ~= BiographyData.eventAttr.curSelectIndex then
                        BiographyData.eventAttr.curSelectIndex = i

                        if not self.isGuideState then  -- 引导状态，不能清除自动选关标志
                            if fbMaxGkNumber == i then  --当选中当前未通关关卡时，开启自动选关标志
                                BiographyData.isAutoUpdateGk = true
                            else
                                BiographyData.isAutoUpdateGk = false
                            end
                        end

                    end
                end
        
                bt = self._gkPanel_t:getChildByName("gk" .. tostring(i)):getChildByName("bt")
                bt:onTouch(Functions.createClickListener(onGkClick))

            else
                local onGkClick = function()
                   PromptManager:openTipPrompt(LanguageConfig.language_MinFb_3) 
                end
                bt = self._gkPanel_t:getChildByName("gk" .. tostring(i)):getChildByName("bt")
                bt:onTouch(Functions.createClickListener(onGkClick))
            end

            if i == 4 then
                self._gkBt4_t = bt
            end

        end
        self:refreshMinGkDis_()
    else
        self:onClickTuanDui()
    end
end

--刷新所有小关卡的星级，挑战次数
function MinFbSelectViewController:refreshMinGkDis_()
	
	local minGkInfos = BiographyData:getCurFbInfo()

	--刷新面板里面的小关卡显示
	for i=1, 10 do
        local gkView = self._gkPanel_t:getChildByName("gk" .. tostring(i))
        local lock = gkView:getChildByName("lock")
        local infoPanel = gkView:getChildByName("gkInfoPanel")
        local ytg_panel = gkView:getChildByName("ytg_panel")
        local stars = infoPanel:getChildByName("stars")
        
        ytg_panel:setVisible(false)
        if minGkInfos[i] then
            infoPanel:setVisible(true)
            infoPanel:getChildByName("gkName"):setString(minGkInfos[i].name):setVisible(true)
            infoPanel:getChildByName("gkRule"):setString(minGkInfos[i].limit .. "/" .. minGkInfos[i].maxPass):setVisible(true)
            
            self:updateStarDis_(stars, minGkInfos[i].star)
            lock:setVisible(false)
        
        else
            lock:setVisible(true)
        end
	end
	
end

--小关卡数据刷新
function MinFbSelectViewController:refresGKinfo_(littleLevel)
    
    self.curLittleLevel = littleLevel
    
    self._gkjl_panel_t:setVisible(true)

    local awardData = BiographyData:getCurGkAwardData()
	Functions.initLabelOfString(   
        self._coin_jl_text_t, awardData.coin,
        self._exp_jl_text_t, awardData.exp,
        self._wuhun_jl_text_t, awardData.wuhun,
        self._neet_power_text_t, BiographyData:getCruFbNeedPower()
        )
    
    --初始化掉落物
    local datas = ConfigHandler:getFbAwardData(littleLevel)

    local items = {}
    for i=1, #datas/5 do
        if BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then
            if datas[(i-1)*5 + 5] == 1 then
                local item = {}
                for j=1, 4 do
                    item[#item+1] = datas[(i-1)*5 + j] 
                end
                items[#items+1] = item
            end
        elseif BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_ElitePVE then
            if datas[(i-1)*5 + 5] == 2 then
                local item = {}
                for j=1, 4 do
                    item[#item+1] = datas[(i-1)*5 + j] 
                end
                items[#items+1] = item
            end 
        end
    end

    --添加道具显示
    self:displayAwardItem_(items)

    --初始化扫荡
    local minGkInfos = BiographyData:getCurFbInfo()
    local gkInfo = minGkInfos[BiographyData.eventAttr.curSelectIndex]
    
    Functions.loadImageWithSprite(self._shaodangBt_t:getChildByTag(1),"commonUI/res/cs/MinFbSelectUI/saodang.png")
    self._shaodangBt_t:setVisible(true)
    self._shaodangBt_t:onTouch(Functions.createClickListener(handler(self, self.onShaodangbtClick), ""))

    if gkInfo.star == 3 and PlayerData.eventAttr.m_level >= g_csOpen.SweepingOpen.level then
        Functions.setEnabledBt(self._shaodangBt_t, true)
        self._shaod_star_panel_t:setVisible(false)
    else
        Functions.setEnabledBt(self._shaodangBt_t, false)
        self._shaod_star_panel_t:setVisible(true)
        Functions.updateStarDis(self._shaod_star_panel_t, gkInfo.star, 3)
    end
    
end

function MinFbSelectViewController:displayAwardItem_(items)

    Functions.clearAllChildren(self._goods_panel_t)
    local count = 5
    if #items < 5 then
        count = #items
    end
    for i=1, count do
        local disNode = Functions.createPartNode({ nodeId = items[i][1], nodeType = items[i][2] })

        local onPartInfos = function()
            PromptManager:openInfPrompt({type = items[i][2],id = items[i][1], target = disNode })
        end        
        
        local model = disNode:getChildByName("model")
        Functions.setEnabledWidget(model, true)
        model:onTouch(Functions.createClickListener(onPartInfos, "zoom"))

        if disNode ~= nil then

            local pos = { x = self.awardFirstPos.x + self.awardItemDistance*(i-1), y = self.awardFirstPos.y }
            disNode:setScale(self.awardItemScale)
            disNode:setPosition(pos)

            self._goods_panel_t:addChild(disNode)
        end
    end
    
end

function MinFbSelectViewController:updateStarDis_(starView, count)
    
    starView:setVisible(true)
	if count == 1 then
        starView:getChildByName("star1"):setVisible(false)
        starView:getChildByName("star2"):setVisible(true)
        starView:getChildByName("star3"):setVisible(false)
    elseif count == 2 then
        starView:getChildByName("star1"):setVisible(true)
        starView:getChildByName("star2"):setVisible(false)
        starView:getChildByName("star3"):setVisible(true)
    elseif count == 3 then
        starView:getChildByName("star1"):setVisible(true)
        starView:getChildByName("star2"):setVisible(true)
        starView:getChildByName("star3"):setVisible(true)
    else
        starView:getChildByName("star1"):setVisible(false)
        starView:getChildByName("star2"):setVisible(false)
        starView:getChildByName("star3"):setVisible(false)

    end
end

function MinFbSelectViewController:fightBeginRuleCheck_()

    --检查次数限制
    local minGkInfos = BiographyData:getCurFbInfo()
    local data = minGkInfos[BiographyData.eventAttr.curSelectIndex]

    --精英关卡重置函数
    local bugResetGkFunc = function()

        if PlayerData.eventAttr.m_gold >= g_VipCgf.ConsumePassPrice[PlayerData.eventAttr.m_passResetCount+1] then
            local baseMsg = { idx = { 1, 6 }, lpassid = BiographyData.eventAttr.curSelectFbId, spassid = BiographyData.eventAttr.curSelectIndex }
             
            local onServerRutrun = function(event)
                BiographyData:resetFbLimit(BiographyData.eventAttr.curFbType, BiographyData.eventAttr.curSelectFbId, BiographyData.eventAttr.curSelectIndex)
            
                PlayerData.eventAttr.m_passResetCount = PlayerData.eventAttr.m_passResetCount  + 1
                 --重置精英关卡成功
                Functions.setAdbrixTag("retension","dungeon_reset_buy_" .. tostring(PlayerData.eventAttr.m_passResetCount), tostring(PlayerData.eventAttr.m_level))
                
                PlayerData.eventAttr.m_gold =  event.gold
                PromptManager:openTipPrompt(LanguageConfig["resetJYgk_3"])
            end

            NetWork:addNetWorkListener({ 1, 6}, Functions.createNetworkListener(onServerRutrun, true, "ret"))
            NetWork:sendToServer(baseMsg)
        else
            self:openChildView("app.ui.popViews.PayPopView",{isRemove = false})
        end
    end

    local openVipView = function()
        self:openChildView("app.ui.popViews.VipPopView", { isRemove = false })
    end
    
    if data.limit == data.maxPass and BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_ElitePVE then

        if PlayerData.eventAttr.m_passResetCount < g_VipCgf.ResetCount[VipData.eventAttr.m_vipLevel] then

            local titilStr = string.format(LanguageConfig["resetJYgk_1"], g_VipCgf.ConsumePassPrice[PlayerData.eventAttr.m_passResetCount+1])
            NoticeManager:openTips(self, { title = titilStr, handler = bugResetGkFunc })

        elseif PlayerData.eventAttr.m_passResetCount == g_VipCgf.ResetCount[VipData.eventAttr.m_vipLevel] then

            local titilStr = string.format(LanguageConfig["resetJYgk_2"], PlayerData.eventAttr.m_passResetCount)
            NoticeManager:openTips(self, { title = titilStr, handler = openVipView, affirmBtText = "commonUI/res/common/vipTeqaun.png" })

        else
            assert(false, "玩家重置精英副本数据错误！")
        end


        return false
    end

    --检查体力是否满足条件
    if PlayerData.eventAttr.m_energy < BiographyData:getCruFbNeedPower() then
        PromptManager:openTipPrompt(LanguageConfig["language_6_22"])
        return false
    end

    --检查背包是否已满
    if #PropData.propInf.m_itemBag >= PlayerData.eventAttr.m_curBagSize then
        PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(65))
        return false
    end

    --检查武将是否已满
    if #HeroCardData:getAllHeroData() >= HeroCardData:getBagBaseSize() then
        PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(66))
        return false
    end

    --检查等级是否达到开启等级
    local openLevel = ConfigHandler:getFbLimitLevel(BiographyData.eventAttr.curSelectFbId, BiographyData.eventAttr.curSelectIndex)
    if PlayerData.eventAttr.m_level < openLevel[1] then
        local tip = string.format(LanguageConfig["ui_MinFbSelectView_1"],openLevel[1])
        PromptManager:openTipPrompt(tip)
        return false
    end
    
    return true
    
end

--团队副本点击
function MinFbSelectViewController:onClickTuanDui()

    local tuanduiDataHandler = function(data)

        --隐藏奖励经验，元宝...
        self._gkjl_panel_t:setVisible(false)

        --修改bt文字，注册点击函数
        local onZhanLiPin = function(data)
            self:openChildView("app.ui.popViews.TdFBAwardPopView", { data = data })
        end
        Functions.loadImageWithSprite(self._shaodangBt_t:getChildByTag(1),"commonUI/res/cs/MinFbSelectUI/zhanlipin.png")
        self._shaodangBt_t:onTouch(Functions.createClickListener(function()
                onZhanLiPin({ lidx = BiographyData.eventAttr.curSelectFbId - 6 })
            end))
        Functions.setEnabledBt(self._shaodangBt_t, true)

        local curIndex = #data
        local isFight = false
        for k,v in ipairs(data) do
            local gkView = self._gkPanel_t:getChildByName("gk" .. tostring(k))

            local lock = gkView:getChildByName("lock")
            local gkInfoPanel = gkView:getChildByName("gkInfoPanel")
            
            local minGkInfos = BiographyData:getCurFbInfo()
            gkInfoPanel:getChildByName("gkName"):setString(minGkInfos[k].name)
            
            local ytg_panel = gkView:getChildByName("ytg_panel")
            local bt = gkView:getChildByName("bt")
            local selectView = gkView:getChildByName("1")
            if v.locked == 1 then
                if v.passed == 1 then
                    local onGkClick = function()
                       PromptManager:openTipPrompt(LanguageConfig.language_MinFb_4)
                    end
                    bt:onTouch(Functions.createClickListener(onGkClick)) 
                    lock:setVisible(false)
                    ytg_panel:setVisible(true)
                else
                    local onGkClick = function()
                       PromptManager:openTipPrompt(LanguageConfig.language_MinFb_5) 
                    end
                    bt:onTouch(Functions.createClickListener(onGkClick))

                    lock:setVisible(true)
                    ytg_panel:setVisible(false)
                end
                selectView:setVisible(false)
            else
                bt:onTouch(function()end)
                selectView:setVisible(true)
                lock:setVisible(false)
                ytg_panel:setVisible(false)
                gkInfoPanel:setVisible(true)
                gkInfoPanel:getChildByName("stars"):setVisible(false)
                gkInfoPanel:getChildByName("gkRule"):setVisible(false)

                curIndex = k
                isFight = true
            end
        end

        local littleLevel = (BiographyData.eventAttr.curSelectFbId - 1)*10 + curIndex
        self:refreshTuanDuiInfos_(littleLevel, isFight)
    end
    BiographyData:getTuanDuiData(tuanduiDataHandler)  

end

function MinFbSelectViewController:refreshTuanDuiInfos_(littleLevel, isFight)
    self.curLittleLevel = littleLevel

    --初始化掉落物
    local datas = ConfigHandler:getTdFbAwardData(littleLevel)

    local items = {}
    for i=1, #datas/4 do
        local item = {}
        for j=1, 4 do
            item[#item+1] = datas[(i-1)*4 + j] 
        end
        items[#items+1] = item
    end

    --添加道具显示
    self:displayAwardItem_(items)

    --使能战斗按钮
    Functions.setEnabledBt(self._fightBt_t, isFight)
end















return MinFbSelectViewController