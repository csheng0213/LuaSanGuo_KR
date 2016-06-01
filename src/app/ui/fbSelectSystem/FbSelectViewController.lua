--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local FbSelectViewController = class("FbSelectViewController", BaseViewController)

local Functions = require("app.common.Functions")

FbSelectViewController.debug = true
FbSelectViewController.modulePath = ...
FbSelectViewController.studioSpriteFrames = {"FbSelectUIMap2","FbSelectUIMap1","FbSelectUI_Text" }
--@auto code head end

local scheduler = require("app.common.scheduler")
--@Pre loading
FbSelectViewController.spriteFrameNames = 
    {
        "FbSelectUI"
    }

FbSelectViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #FbSelectViewController.studioSpriteFrames > 0 then
    FbSelectViewController.spriteFrameNames = FbSelectViewController.spriteFrameNames or {}
    table.insertto(FbSelectViewController.spriteFrameNames, FbSelectViewController.studioSpriteFrames)
end
function FbSelectViewController:onDidLoadView()

    --output list
    self._PageView_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("PageView_1")
	self._fbPanel1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("PageView_1"):getChildByName("fbPanel1")
	self._gk1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("PageView_1"):getChildByName("fbPanel1"):getChildByName("gk1")
	self._fbPanel2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("PageView_1"):getChildByName("fbPanel2")
	self._fbPanel3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("PageView_1"):getChildByName("fbPanel3")
	self._fbPanel4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("PageView_1"):getChildByName("fbPanel4")
	self._TopResNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("TopResNode")
	
    --label list
    
    --button list
    self._backBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), ""))

	self._leftMoveBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("leftMoveBt")
	self._leftMoveBt_t:onTouch(Functions.createClickListener(handler(self, self.onLeftmovebtClick), ""))

	self._rightMoveBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("rightMoveBt")
	self._rightMoveBt_t:onTouch(Functions.createClickListener(handler(self, self.onRightmovebtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt btFunc
function FbSelectViewController:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    
    GameCtlManager:goTo("app.ui.mainSystem.MainViewController")
end
--@auto code Backbt btFunc end

--@auto code Leftmovebt btFunc
function FbSelectViewController:onLeftmovebtClick()
    Functions.printInfo(self.debug,"Leftmovebt button is click!")

    local index = self._PageView_1_t:getCurPageIndex()
    if index > 0 then
        self._PageView_1_t:scrollToPage(index-1)
    end

end
--@auto code Leftmovebt btFunc end

--@auto code Rightmovebt btFunc
function FbSelectViewController:onRightmovebtClick()
    Functions.printInfo(self.debug,"Rightmovebt button is click!")

    local pages = self._PageView_1_t:getPages()
    local index = self._PageView_1_t:getCurPageIndex()
    if index < #pages-1 then
        self._PageView_1_t:scrollToPage(index+1)
    elseif index == #pages-1 then
        PromptManager:openTipPrompt(LanguageConfig["cs_FbSelect_1"])
    end
end
--@auto code Rightmovebt btFunc end

--@auto button backcall end


--@auto code view display func
function FbSelectViewController:onCreate()
    Functions.printInfo(self.debug_b," FbSelectViewController controller create!")
end

function FbSelectViewController:openBgMusic()
    Audio.playMusic("sound/combat.mp3", true)
end

function FbSelectViewController:onDisplayView()
	Functions.printInfo(self.debug_b," FbSelectViewController view enter display!")
    Functions.setPopupKey("fighting")
    --初始化数据
    BiographyData.eventAttr.curFbType = CombatCenter.CombatType.RB_PVE

    BiographyData.eventAttr.curSelectFbId = BiographyData.eventAttr.curPassFbId
    BiographyData.eventAttr.curSelectLittelLevel = BiographyData.eventAttr.curPassLittelLevel
    BiographyData.isAutoUpdateGk = true

    --初始化ui
    self:initUi()

    --第一关按钮
    self._firstGk1_t = self._gk1_t:getChildByName("bt")
end
--@auto code view display func end

function FbSelectViewController:initUi()
	
	self:refreshDisplay()

    Functions.bindUiWithModelAttr(self.view_t, BiographyData, "curPassFbId", handler(self, self.refreshDisplay))
    Functions.bindUiWithModelAttr(self.view_t, BiographyData, "curPassEliteFbId", handler(self, self.refreshDisplay))


    
	--绑定全局数据
    -- Functions.bindMGSDisplay({ moneyObj = self._coinText_t, soulObj = self._wuhunText_t, powerObj = self._jituiText_t })
    Functions.initResNodeUI(self._TopResNode_t,{ "jinbi", "soul", "jitui" })
    self._TopResNode_t:getChildByName("panel"):getChildByName("colorBg"):setVisible(true)

    --初始化左右移动按钮动作
    local actionR = cc.Sequence:create(cc.MoveBy:create(0.5, { x = 10, y = 0 }), cc.MoveBy:create(0.5, { x = -10, y = 0}))
    self._rightMoveBt_t:runAction(cc.RepeatForever:create(actionR))
    
    local actionL = cc.Sequence:create(cc.MoveBy:create(0.5, { x = -10, y = 0 }), cc.MoveBy:create(0.5, { x = 10, y = 0}))
    self._leftMoveBt_t:runAction(cc.RepeatForever:create(actionL))
    
    -- 绑定pageview 
    local onIndexChange = function(event)
        if event.index == 0 then
            self._rightMoveBt_t:setVisible(true)
            self._leftMoveBt_t:setVisible(false)
        else
            self._leftMoveBt_t:setVisible(true)
        end
    end
    Functions.bindPageViewListener(self._PageView_1_t, onIndexChange)
    self._PageView_1_t:setCustomScrollThreshold(20)
  	
    Functions.bindUiWithModelAttr(self.view_t, BiographyData, "curPassFbId", handler(self, self.updateFBpages))
    --副本大关卡刷新
    self:updateFBpages()
end

function FbSelectViewController:updateFBpages()

    local maxIndex = math.floor((BiographyData.MAX_FB_ID - 1)/6)
    local curIndex = math.floor((BiographyData.eventAttr.curPassFbId - 1)/6)
    
    scheduler.performWithDelayGlobal(function()
        self._PageView_1_t:scrollToPage(curIndex)
    end,0.1)

    if curIndex == 0 then
    
        self._rightMoveBt_t:setVisible(false)
        self._leftMoveBt_t:setVisible(false)
        
    else
    
        self._rightMoveBt_t:setVisible(true)
        self._leftMoveBt_t:setVisible(true)
        
    end
end

function FbSelectViewController:refreshDisplay()

    local fbPanels = self._PageView_1_t:getChildren()
    for i=1, #fbPanels do
        local panelName = "fbPanel" .. tostring(i)
        self:initFbPanel(self._PageView_1_t:getChildByName(panelName), i)
    end
    BiographyData.isAutoUpdateGk = true
end

function FbSelectViewController:fbHandler_(fbId)
    if BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_ElitePVE then
        if fbId > BiographyData.eventAttr.curPassEliteFbId then
            BiographyData.eventAttr.curFbType = CombatCenter.CombatType.RB_PVE
            BiographyData.eventAttr.curSelectFbId = fbId
        end
    else
        BiographyData.eventAttr.curSelectFbId = fbId
    end
end

function FbSelectViewController:initFbPanel(gkPanel, count)
	local gks = gkPanel:getChildren()
	local gkLen = #gks - 1
	for i=1, gkLen do
	
        local gk = gkPanel:getChildByName("gk" .. i)
        local FbId = i + (count -  1)*gkLen
        
        local gkName = ConfigHandler:getCheckPointNameOfID(FbId)
        local gkNameView = gk:getChildByName("titleBg"):getChildByName("titleName")
        gkNameView:setString(gkName)
        
        local fbInfoNode = gk:getChildByName("fbInfoPanel")
        local gkButton = gk:getChildByName("bt")
        if FbId <= BiographyData:getCurFbIndex() and FbId <= BiographyData.MAX_FB_ID then  --暂开16关
            gkButton:onTouch(Functions.createClickListener(function()
                --打开关卡选择界面
                self:fbHandler_(FbId)   --处理精英关卡可能没开放的情况
                DebugHoldTime("MinFbSelectViewController--- ")
                DebugHoldTime("MinFbSelectViewController---1")
                GameCtlManager:push("app.ui.minFbSelectSystem.MinFbSelectViewController")
            end, "zoom"))
            Functions.setEnabledBt(gkButton, true)
            
            local starText = gk:getChildByName("fbInfoPanel"):getChildByName("textPanel"):getChildByName("starText")
            local percent = gk:getChildByName("fbInfoPanel"):getChildByName("fbpercent")

            local info = BiographyData:getFbDisInfoOfId(FbId)
            starText:setString(info.allStars .. "/60")
            percent:setPercent(info.percent)

            fbInfoNode:setVisible(true)
        else
            Functions.setEnabledBt(gkButton, false)
            fbInfoNode:setVisible(false)
        end

	end

end

function FbSelectViewController:onReceivePopData(data)
    self:refreshDisplay()
end

return FbSelectViewController