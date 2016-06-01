--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local XueZhanViewController = class("XueZhanViewController", BaseViewController)

local Functions = require("app.common.Functions")

XueZhanViewController.debug = true
XueZhanViewController.modulePath = ...
XueZhanViewController.studioSpriteFrames = {"XUEZHANUI","CB_blackbg","XueZhanUI","CBO_unionBg" }
--@auto code head end

--@Pre loading
XueZhanViewController.spriteFrameNames = 
    {
        "playerHeadRes"
    }

XueZhanViewController.animaNames = 
    {
        "An_easy","An_diff","An_lianYu"
    }


--@auto code uiInit
--add spriteFrames
if #XueZhanViewController.studioSpriteFrames > 0 then
    XueZhanViewController.spriteFrameNames = XueZhanViewController.spriteFrameNames or {}
    table.insertto(XueZhanViewController.spriteFrameNames, XueZhanViewController.studioSpriteFrames)
end
function XueZhanViewController:onDidLoadView()

    --output list
    self._topNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("topNode")
	self._an_easy_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Sprite1"):getChildByName("an_easy")
	self._an_diff_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Sprite2"):getChildByName("an_diff")
	self._an_lianYu_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Sprite_27"):getChildByName("an_lianYu")
	self._attack_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Image_127"):getChildByName("attack")
	self._life_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Image_127"):getChildByName("life")
	self._chouMou_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Image_127"):getChildByName("chouMou")
	self._attack_0_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Image_127"):getChildByName("attack_0")
	self._attack_0_0_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Image_127"):getChildByName("attack_0_0")
	self._life_0_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Image_127"):getChildByName("life_0")
	self._life_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Image_127"):getChildByName("life_1")
	self._chouMou_0_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Image_127"):getChildByName("chouMou_0")
	self._chouMou_0_0_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Image_127"):getChildByName("chouMou_0_0")
	self._gk_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("guanKa"):getChildByName("gk")
	self._hero_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("hero")
	self._head_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("hero"):getChildByName("head")
	self._jb_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("jb")
	self._name_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("name")
	self._level_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("level")
	self._starCnt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("starCnt")
	self._star_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("star")
	self._zj_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("zj")
	self._ciShu_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("ciShu")
	self._ciSh_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("ciShu"):getChildByName("ciSh_1")
	self._ciSh_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("ciShu"):getChildByName("ciSh_2")
	self._ciSh_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("ciShu"):getChildByName("ciSh_3")
	self._ciSh_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("ciShu"):getChildByName("ciSh_4")
	self._ciSh_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("ciShu"):getChildByName("ciSh_5")
	self._ciSh_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("ciShu"):getChildByName("ciSh_6")
	self._ciSh_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("ciShu"):getChildByName("ciSh_7")
	self._ciSh_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("ciShu"):getChildByName("ciSh_8")
	self._paiMing_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("paiMing")
	self._passPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("passPanel")
	
    --label list
    
    --button list
    self._backBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), ""))

	self._helpBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("helpBt")
	self._helpBt_t:onTouch(Functions.createClickListener(handler(self, self.onHelpbtClick), ""))

	self._easyPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Sprite1"):getChildByName("easyPanel")
	self._easyPanel_t:onTouch(Functions.createClickListener(handler(self, self.onEasypanelClick), ""))

	self._diffPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Sprite2"):getChildByName("diffPanel")
	self._diffPanel_t:onTouch(Functions.createClickListener(handler(self, self.onDiffpanelClick), ""))

	self._lianYuPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("Sprite_27"):getChildByName("lianYuPanel")
	self._lianYuPanel_t:onTouch(Functions.createClickListener(handler(self, self.onLianyupanelClick), ""))

	self._tiaoZhanBt1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("tiaoZhanBt1")
	self._tiaoZhanBt1_t:onTouch(Functions.createClickListener(handler(self, self.onTiaozhanbt1Click), "zoom"))

	self._tiaoZhanBt1_0_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("tiaoZhanBt1_0")
	self._tiaoZhanBt1_0_t:onTouch(Functions.createClickListener(handler(self, self.onTiaozhanbt1_0Click), "zoom"))

	self._tiaoZhanBt1_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg11"):getChildByName("tiaoZhanBt1_1")
	self._tiaoZhanBt1_1_t:onTouch(Functions.createClickListener(handler(self, self.onTiaozhanbt1_1Click), "zoom"))

	self._rankingBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroInf"):getChildByName("rankingBt")
	self._rankingBt_t:onTouch(Functions.createClickListener(handler(self, self.onRankingbtClick), "zoom"))

	self._passBox_t = self.view_t.csbNode:getChildByName("main"):getChildByName("passPanel"):getChildByName("passBox")
	self._passBox_t:onTouch(Functions.createClickListener(handler(self, self.onPassboxClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt btFunc
function XueZhanViewController:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    GameCtlManager:pop(self)
end
--@auto code Backbt btFunc end

--@auto code Helpbt btFunc
function XueZhanViewController:onHelpbtClick()
    Functions.printInfo(self.debug,"Helpbt button is click!")
    NoticeManager:openNotice(self, {type = NoticeManager.XUEZHAN_INFO})
end
--@auto code Helpbt btFunc end

--@auto code Tiaozhanbt1 btFunc
function XueZhanViewController:onTiaozhanbt1Click()
    Functions.printInfo(self.debug,"Tiaozhanbt1 button is click!")  
    if self:checkXueZhanTime() then 
        if XueZhanData.xueZhanData.m_xzlyPass <= g_VipCgf.xueZhanLevels then
            if XueZhanData.xueZhanData.m_xzlyCount < g_VipCgf.xzlyAllCount[VipData.eventAttr.m_vipLevel] then
                GameCtlManager:push("app.ui.combatSystem.CombatViewController", { data = { combatType = CombatCenter.CombatType.RB_BloodyBattle,
                    majorHurdles = 1, littleLevels = XueZhanData.xueZhanData.m_xzlyPass,isPassFlag = self.passFlag } })
            else
                PromptManager:openTipPrompt(LanguageConfig.language_2_23) 
            end
        else
            PromptManager:openTipPrompt(LanguageConfig.language_Teach35) 
        end
    else
        PromptManager:openTipPrompt(LanguageConfig.language_6_25) 
    end
end
--@auto code Tiaozhanbt1 btFunc end

--@auto code Tiaozhanbt1_0 btFunc
function XueZhanViewController:onTiaozhanbt1_0Click()
    Functions.printInfo(self.debug,"Tiaozhanbt1_0 button is click!")
    if self:checkXueZhanTime() then 
        if XueZhanData.xueZhanData.m_xzlyPass <= g_VipCgf.xueZhanLevels then
            if XueZhanData.xueZhanData.m_xzlyCount < g_VipCgf.xzlyAllCount[VipData.eventAttr.m_vipLevel] then
                GameCtlManager:push("app.ui.combatSystem.CombatViewController", { data = { combatType = CombatCenter.CombatType.RB_BloodyBattle,
                    majorHurdles = 2, littleLevels = XueZhanData.xueZhanData.m_xzlyPass ,isPassFlag = self.passFlag} })
            else
                PromptManager:openTipPrompt(LanguageConfig.language_2_23) 
            end
        else
             PromptManager:openTipPrompt(LanguageConfig.language_Teach35) 
        end
    else
       PromptManager:openTipPrompt(LanguageConfig.language_6_25) 
    end  
end
--@auto code Tiaozhanbt1_0 btFunc end

--@auto code Tiaozhanbt1_1 btFunc
function XueZhanViewController:onTiaozhanbt1_1Click()
    Functions.printInfo(self.debug,"Tiaozhanbt1_1 button is click!")
    if self:checkXueZhanTime() then 
        if XueZhanData.xueZhanData.m_xzlyPass <= g_VipCgf.xueZhanLevels then
            if XueZhanData.xueZhanData.m_xzlyCount < g_VipCgf.xzlyAllCount[VipData.eventAttr.m_vipLevel] then
                GameCtlManager:push("app.ui.combatSystem.CombatViewController", { data = { combatType = CombatCenter.CombatType.RB_BloodyBattle,
                    majorHurdles = 3, littleLevels = XueZhanData.xueZhanData.m_xzlyPass ,isPassFlag = self.passFlag} })
            else
                PromptManager:openTipPrompt(LanguageConfig.language_2_23) 
            end
        else
            PromptManager:openTipPrompt(LanguageConfig.language_Teach35) 
        end
    else
        PromptManager:openTipPrompt(LanguageConfig.language_6_25) 
    end 
end
--@auto code Tiaozhanbt1_1 btFunc end

--@auto code Tiaozhanbt1_2 btFunc
function XueZhanViewController:onTiaozhanbt1_2Click()
    Functions.printInfo(self.debug,"Tiaozhanbt1_2 button is clicbk!")
end
--@auto code Tiaozhanbt1_2 btFunc end

--@auto code Rankingbt btFunc
function XueZhanViewController:onRankingbtClick()
    Functions.printInfo(self.debug,"Rankingbt button is click!")
    GameCtlManager:push("app.ui.rankingSystem.RankingViewController")
end
--@auto code Rankingbt btFunc end

--@auto code Passbox btFunc
function XueZhanViewController:onPassboxClick()
    Functions.printInfo(self.debug,"Passbox button is click!")
    if self._passBox_t:isSelected() then
        self.passFlag = false
        print(self.passFlag)
    else
        self.passFlag = true
        print(self.passFlag)
    end
end
--@auto code Passbox btFunc end

--@auto code Easypanel btFunc
function XueZhanViewController:onEasypanelClick()
    Functions.printInfo(self.debug,"Easypanel button is click!")
    if XueZhanData.xueZhanData.m_xzlyPass > g_VipCgf.xueZhanLevels then
        NoticeManager:openXueZhanTips(GameCtlManager.currentController_t, {type = 1,data = {currentLevel =  g_VipCgf.xueZhanLevels}})
    else
        NoticeManager:openXueZhanTips(GameCtlManager.currentController_t, {type = 1,data = {currentLevel = XueZhanData.xueZhanData.m_xzlyPass}})
    end
end
--@auto code Easypanel btFunc end

--@auto code Diffpanel btFunc
function XueZhanViewController:onDiffpanelClick()
    Functions.printInfo(self.debug,"Diffpanel button is click!")
    if XueZhanData.xueZhanData.m_xzlyPass > g_VipCgf.xueZhanLevels then
        NoticeManager:openXueZhanTips(GameCtlManager.currentController_t, {type = 2,data = {currentLevel =  g_VipCgf.xueZhanLevels}})
    else
        NoticeManager:openXueZhanTips(GameCtlManager.currentController_t, {type = 2,data = {currentLevel = XueZhanData.xueZhanData.m_xzlyPass}})
    end
end
--@auto code Diffpanel btFunc end

--@auto code Lianyupanel btFunc
function XueZhanViewController:onLianyupanelClick()
    Functions.printInfo(self.debug,"Lianyupanel button is click!")
    if XueZhanData.xueZhanData.m_xzlyPass > g_VipCgf.xueZhanLevels then
        NoticeManager:openXueZhanTips(GameCtlManager.currentController_t, {type = 3,data = {currentLevel =  g_VipCgf.xueZhanLevels}})
    else
        NoticeManager:openXueZhanTips(GameCtlManager.currentController_t, {type = 3,data = {currentLevel = XueZhanData.xueZhanData.m_xzlyPass}})
    end
end
--@auto code Lianyupanel btFunc end

--@auto button backcall end


--@auto code view display func
function XueZhanViewController:onCreate()
    Functions.printInfo(self.debug_b," XueZhanViewController controller create!")
end

function XueZhanViewController:onChangeView( )
-- body
end
function XueZhanViewController:openBgMusic()
    Audio.playMusic("sound/combat.mp3", true)
end
function XueZhanViewController:onDisplayView()
    Functions.printInfo(self.debug_b," XueZhanViewController view enter display!")
    Functions.setAdbrixTag("retension","blood_inter")
    Functions.setPopupKey("blood_fight")
    local temp1,temp2= Functions.formatHeroClass(18)

    --初始化动画
    self:initUiAnima_()

    self:initUiDisplay_()

    XueZhanData:loadXueZhanData(handler(self,self.refrashInf))

end

--@auto code view display func end
function XueZhanViewController:initUiDisplay_()
    self._attack_0_t:setString(LanguageConfig.language_sevenStar_5 .. " +")
    self._life_0_t:setString(LanguageConfig.language_sevenStar_6 .. " +")
    self._chouMou_0_t:setString(LanguageConfig.language_sevenStar_7 .. " +")
    --钱币显示
    -- Functions.bindMGSDisplay({moneyObj = self._coinText_t,goldObj = self._goldText_t,soulObj = self._soulText_t})
    Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})
    --角色等级
    self._level_t:setString(tostring(PlayerData.eventAttr.m_level))       
    Functions.bindUiWithModelAttr(self._level_t, PlayerData, "m_level")
    --角色名字
    self._name_t:setString(tostring(PlayerData.eventAttr.m_name))
    Functions.bindUiWithModelAttr(self._name_t, PlayerData, "m_name")
    --角色头像
    local headImg = Functions.getDisHeadFImagePathOfId(PlayerData.eventAttr.m_imgID)
    Functions.loadImageWithWidget(self._head_t,headImg)
    Functions.bindUiWithModelAttr(self._attack_t, XueZhanData, "m_xzAttack")
    Functions.bindUiWithModelAttr(self._life_t, XueZhanData, "m_xzHp")
    Functions.bindUiWithModelAttr(self._chouMou_t, XueZhanData, "m_xzMp")
    Functions.bindUiWithModelAttr(self._starCnt_t, XueZhanData, "m_xzlyStar")
    if self._passBox_t:isSelected() and self._passPanel_t:isVisible() then
        self.passFlag = false
    else
        self.passFlag = true
    end
end
function XueZhanViewController:initUiAnima_()

    --简单
    Functions.playAnimaOfUI(self._an_easy_t, "An_easy", 0.001)
    --困难
    Functions.playAnimaOfUI(self._an_diff_t, "An_diff", 0.001)
    --炼狱
    Functions.playAnimaOfUI(self._an_lianYu_t, "An_lianYu", 0.001)


end
function XueZhanViewController:checkXueZhanTime()
    local currentTime = TimerManager:getCurrentSecond() 
    -- local dt = os.date('*t', nowTime)
    -- dt.hour, dt.min, dt.sec = 10, 0, 0
    -- local startTime = clone(dt)
    -- dt.hour, dt.min, dt.sec = 23, 59, 59
    -- local endTime = clone(dt)
    return self:checkTime(currentTime,XueZhanData.eventAttr.startTime,XueZhanData.eventAttr.endTime)
end
function XueZhanViewController:checkTime(currentTime,startTime,endTime)
    if currentTime >= startTime and currentTime <= endTime then
        return true
    else
        return false
    end
end
function XueZhanViewController:refrashInf()

    self._paiMing_t:setString(tostring(XueZhanData.xueZhanData.m_xzlyRank)) --排名
    self._zj_t:setString(tostring(XueZhanData.xueZhanData.m_xzlyPassBest)) --最佳战绩
    if XueZhanData.xueZhanData.m_xzlyPass > g_VipCgf.xueZhanLevels then 
        self._gk_t:setString(tostring(g_VipCgf.xueZhanLevels))      --当前关卡 
    else
        self._gk_t:setString(tostring(XueZhanData.xueZhanData.m_xzlyPass))      --当前关卡 
    end

    self._starCnt_t:setString(tostring(XueZhanData.eventAttr.m_xzlyStar)) --剩余星数



    self._attack_t:setString(tostring(XueZhanData.eventAttr.m_xzAttack)) --攻击加成
    self._life_t:setString(tostring(XueZhanData.eventAttr.m_xzHp) )     --生命加成
    self._chouMou_t:setString(tostring(XueZhanData.eventAttr.m_xzMp))--筹谋加成

    for i=1,g_VipCgf.xzlyAllCount[VipData.eventAttr.m_vipLevel] do
        self._ciShu_t:getChildByTag(i):setVisible(true)
    end

    for i=1,g_VipCgf.xzlyAllCount[VipData.eventAttr.m_vipLevel] do                                                    --挑战次数
        local challengBox  = self._ciShu_t:getChildByTag(i)
        if i <= g_VipCgf.xzlyAllCount[VipData.eventAttr.m_vipLevel] - XueZhanData.xueZhanData.m_xzlyCount then
            challengBox:getChildByName("heart"):setVisible(true)
        else
            challengBox:getChildByName("heart"):setVisible(false)
        end
    end
    self._jb_t:setString(Functions.getPlayerRank(XueZhanData.xueZhanData.m_xzlyRank)) --角色级别

    if XueZhanData.xueZhanData.m_xzGetBuff == 0 or XueZhanData.xueZhanData.m_xzlyPass > XueZhanData.xueZhanData.m_xzGetBuff then
        self._passPanel_t:setVisible(false)
        self.passFlag = false
    else
        self._passPanel_t:setVisible(true)
        if self._passBox_t:isSelected() then 
            self.passFlag = true
        else
            self.passFlag = false
        end
    end
    if XueZhanData.xueZhanData.m_xzlyPass ~= 1 and (XueZhanData.xueZhanData.m_xzlyPass -1) % 5 == 0 and XueZhanData.xueZhanData.buffFlag == 1 then
        self:openChildView("app.ui.popViews.XueZhanAttrPopView",{isRemove = false})
    end

    self:showView()
end

--接受pop数据
function XueZhanViewController:onReceivePopData(data)
    XueZhanData:loadXueZhanData(handler(self,self.refrashInf))
end
return XueZhanViewController