--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local EmbattleViewController = class("EmbattleViewController", BaseViewController)

local Functions = require("app.common.Functions")

EmbattleViewController.debug = true
EmbattleViewController.modulePath = ...
EmbattleViewController.studioSpriteFrames = {"CB_battleBack","EmbattleUI_Text","EmbattleUI" }
--@auto code head end
local scheduler = require("app.common.scheduler")
--@Pre loading
EmbattleViewController.spriteFrameNames =
    {
        "sodiersRes","headPilistRes"
    }

EmbattleViewController.animaNames =
    {
        "An_footNote"
    }
local JumpType = 
    {
        EmbattleToSelectHero = 0,
        PartHeroToSelectHero = 1,
        EmbattleToPartHero = 2
    }
    
--@auto code uiInit
--add spriteFrames
if #EmbattleViewController.studioSpriteFrames > 0 then
    EmbattleViewController.spriteFrameNames = EmbattleViewController.spriteFrameNames or {}
    table.insertto(EmbattleViewController.spriteFrameNames, EmbattleViewController.studioSpriteFrames)
end
function EmbattleViewController:onDidLoadView()

    --output list
    self._mainHero_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_32"):getChildByName("mainHero")
	self._viceHero1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_32"):getChildByName("viceHero1")
	self._viceHero2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_32"):getChildByName("viceHero2")
	self._table_t = self.view_t.csbNode:getChildByName("main"):getChildByName("table")
	self._gridPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("gridPanel")
	self._gird_2_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("gridPanel"):getChildByName("gird_2_4")
	self._gird_3_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("gridPanel"):getChildByName("gird_3_3")
	self._gird_3_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("gridPanel"):getChildByName("gird_3_5")
	self._gird_4_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("gridPanel"):getChildByName("gird_4_2")
	self._gird_4_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("gridPanel"):getChildByName("gird_4_5")
	self._gird_5_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("gridPanel"):getChildByName("gird_5_1")
	self._gird_5_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("gridPanel"):getChildByName("gird_5_7")
	self._gird_6_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("gridPanel"):getChildByName("gird_6_8")
	self._gird_6_0_t = self.view_t.csbNode:getChildByName("main"):getChildByName("gridPanel"):getChildByName("gird_6_0")
	self._infView_t = self.view_t.csbNode:getChildByName("main"):getChildByName("infView")
	self._zhanLi_t = self.view_t.csbNode:getChildByName("main"):getChildByName("infView"):getChildByName("zhanLi")
	self._daiBing_t = self.view_t.csbNode:getChildByName("main"):getChildByName("infView"):getChildByName("daiBing")
	self._infantry_t = self.view_t.csbNode:getChildByName("main"):getChildByName("infView"):getChildByName("infantry")
	self._archer_t = self.view_t.csbNode:getChildByName("main"):getChildByName("infView"):getChildByName("archer")
	self._cavarly_t = self.view_t.csbNode:getChildByName("main"):getChildByName("infView"):getChildByName("cavarly")
	self._zhanLiChangText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("zhanLiChangText")
	self._zhanLiAn_t = self.view_t.csbNode:getChildByName("main"):getChildByName("zhanLiAn")
	
    --label list
    
    --button list
    self._soldier1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel23"):getChildByName("soldier1")
	self._soldier1_t:onTouch(Functions.createClickListener(handler(self, self.onSoldier1Click), ""))

	self._soldier2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel23"):getChildByName("soldier2")
	self._soldier2_t:onTouch(Functions.createClickListener(handler(self, self.onSoldier2Click), ""))

	self._soldier3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel23"):getChildByName("soldier3")
	self._soldier3_t:onTouch(Functions.createClickListener(handler(self, self.onSoldier3Click), ""))

	self._pianJiangBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel23"):getChildByName("pianJiangBt")
	self._pianJiangBt_t:onTouch(Functions.createClickListener(handler(self, self.onPianjiangbtClick), ""))

	self._cheJunBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel23"):getChildByName("cheJunBt")
	self._cheJunBt_t:onTouch(Functions.createClickListener(handler(self, self.onChejunbtClick), ""))

	self._saveBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel23"):getChildByName("saveBt")
	self._saveBt_t:onTouch(Functions.createClickListener(handler(self, self.onSavebtClick), ""))

	self._onKeyBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel23"):getChildByName("onKeyBt")
	self._onKeyBt_t:onTouch(Functions.createClickListener(handler(self, self.onOnkeybtClick), ""))

	self._backBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_3"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), ""))

	self._helpBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_3"):getChildByName("helpBt")
	self._helpBt_t:onTouch(Functions.createClickListener(handler(self, self.onHelpbtClick), ""))

	self._infBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("infView"):getChildByName("infBt")
	self._infBt_t:onTouch(Functions.createClickListener(handler(self, self.onInfbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt btFunc
function EmbattleViewController:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    if EmbattleData:isHaveUpdate() then
        local handler = function ( )

            self:saveEmbattleInf(function()
--                scheduler.performWithDelayGlobal(function()
                        GameCtlManager:pop(self,{data = {jumpData = {isUpdate = self.isUpdate,embattleType = self.Itype}}})
--                    end, 0)
            end)       

        end
        local handler1 = function ( )
            EmbattleData:regainAllHeroState(self.Itype)
            -- self:removeAllModelRes()
            GameCtlManager:pop(self,{data = {jumpData = {isUpdate = self.isUpdate,embattleType = self.Itype}}})
        end
        NoticeManager:openTips(self, {title = LanguageConfig.language_embattle_1,handler = handler,handler1 = handler1})
    else
        EmbattleData:regainAllHeroState(self.Itype)
        -- self:removeAllModelRes()
        GameCtlManager:pop(self,{data = {jumpData = {isUpdate = self.isUpdate,embattleType = self.Itype}}})
    end
end
--@auto code Backbt btFunc end

--@auto code Helpbt btFunc
function EmbattleViewController:onHelpbtClick()
    Functions.printInfo(self.debug,"Helpbt button is click!")
    NoticeManager:openNotice(self, {type = NoticeManager.EMBATTLE_INFO})
end
--@auto code Helpbt btFunc end

--@auto code Attactbt btFunc
function EmbattleViewController:onAttactbtClick()
    Functions.printInfo(self.debug,"Attactbt button is click!")
end
--@auto code Attactbt btFunc end

--@auto code Defentbt btFunc
function EmbattleViewController:onDefentbtClick()
    Functions.printInfo(self.debug,"Defentbt button is click!")
end
--@auto code Defentbt btFunc end

--@auto code Pianjiangbt btFunc
function EmbattleViewController:onPianjiangbtClick()
    Functions.printInfo(self.debug,"Pianjiangbt button is click!")
    -- GameCtlManager:goTo("app.ui.partHeroSystem.PartHeroViewController")
    GameCtlManager:push("app.ui.partHeroSystem.PartHeroViewController",{data = {jumpType = JumpType.EmbattleToPartHero,jumpData = {embattleType = self.Itype}}})
end
--@auto code Pianjiangbt btFunc end

--@auto code Onkeybt btFunc
function EmbattleViewController:onOnkeybtClick()
    Functions.printInfo(self.debug,"Onkeybt button is click!")
  
    if EmbattleData.EmbattleInf.MainHero[1] ~= nil then
        PromptManager:openShieldLayer()
        EmbattleData:cleanEmbattleBasecInf()
        self:setZxMapOfHeroId(EmbattleData.EmbattleInf.MainHero[1].id,1)
    else 
        PromptManager:openTipPrompt(LanguageConfig.language_embattle_2)
    end
end
--@auto code Onkeybt btFunc end

--@auto code Savebt btFunc
function EmbattleViewController:onSavebtClick()
    Functions.printInfo(self.debug,"Savebt button is click!")
    Functions.playSound("saveformation.mp3") 
    self:saveEmbattleInf()
end
--@auto code Savebt btFunc end

--@auto code Chejunbt btFunc
function EmbattleViewController:onChejunbtClick()
    Functions.printInfo(self.debug,"Chejunbt button is click!")
    EmbattleData.EmbattleInf.Soldiers = {}
    EmbattleData:cleanEmbattleBasecInf()
    self:cleanZxMap(1)
end
--@auto code Chejunbt btFunc end

--@auto code Infbt btFunc
function EmbattleViewController:onInfbtClick()
    Functions.printInfo(self.debug,"Infbt button is click!")
    self:showInfAction()
end
--@auto code Infbt btFunc end

--@auto code Mainhero btFunc
function EmbattleViewController:onMainheroClick()
    Functions.printInfo(self.debug,"Mainhero button is click!")

    -- self:openChildController("app.ui.selectHeroSystem.SelectHeroViewController",{heroType = 0, mainHeroId = self.EmbattleInf.MainHero[1].id ,viceHero1Id = self.EmbattleInf.ViceHeros[1].id,viceHero2Id = self.EmbattleInf.ViceHeros[2].id})
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data = {jumpType = JumpType.EmbattleToSelectHero,jumpData = {embattleType = self.Itype, heroType = 0}}})
end
--@auto code Mainhero btFunc end

--@auto code Vicehero1 btFunc
function EmbattleViewController:onVicehero1Click()
    Functions.printInfo(self.debug,"Vicehero1 button is click!")
    -- self:openChildController("app.ui.selectHeroSystem.SelectHeroViewController",{heroType = 1, mainHeroId = self.EmbattleInf.MainHero[1].id ,viceHero1Id= self.EmbattleInf.ViceHeros[1].id,viceHero2Id= self.EmbattleInf.ViceHeros[2].id})
    if EmbattleData.EmbattleInf.MainHero[1] ~= nil and EmbattleData.EmbattleInf.MainHero[1].id > 0 then
        GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data = {jumpType = JumpType.EmbattleToSelectHero,jumpData = {embattleType = self.Itype, heroType = 1}}})
    else
        PromptManager:openTipPrompt(LanguageConfig.language_embattle_3)
    end
end
--@auto code Vicehero1 btFunc endId

--@auto code Vicehero2 btFunc
function EmbattleViewController:onVicehero2Click()
    Functions.printInfo(self.debug,"Vicehero2 button is click!")
    -- self:openChildController("app.ui.selectHeroSystem.SelectHeroViewController",{heroType = 2,mainHeroId = self.EmbattleInf.MainHero[1].id ,viceHero1Id = self.EmbattleInf.ViceHeros[1].id,viceHero2Id = self.EmbattleInf.ViceHeros[2].id})
    if EmbattleData.EmbattleInf.MainHero[1] ~= nil and EmbattleData.EmbattleInf.MainHero[1].id > 0 then
        GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data = {jumpType = JumpType.EmbattleToSelectHero,jumpData = {embattleType = self.Itype, heroType = 2}}})
    else
        PromptManager:openTipPrompt(LanguageConfig.language_embattle_3)
    end
end
--@auto code Vicehero2 btFunc end

--@auto code Soldier1 btFunc
function EmbattleViewController:onSoldier1Click()
    Functions.printInfo(self.debug,"Soldier1 button is click!")
    self:selectSoldier(1)
end
--@auto code Soldier1 btFunc end

--@auto code Soldier2 btFunc
function EmbattleViewController:onSoldier2Click()
    Functions.printInfo(self.debug,"Soldier2 button is click!")
    self:selectSoldier(2)
end
--@auto code Soldier2 btFunc end

--@auto code Soldier3 btFunc
function EmbattleViewController:onSoldier3Click()
    Functions.printInfo(self.debug,"Soldier3 button is click!")
    self:selectSoldier(3)
end
--@auto code Soldier3 btFunc end

--@auto button backcall end


--@auto code view display func
function EmbattleViewController:onCreate()
    Functions.printInfo(self.debug_b," EmbattleViewController controller create!")
end

function EmbattleViewController:onChangeView()
    -- body
end
function EmbattleViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
function EmbattleViewController:onDisplayView()
    Functions.printInfo(self.debug_b," EmbattleViewController view enter display!")
    
    Functions.setPopupKey("embattle")
    --新手引导相关
    self._mainHeroBt_t = self._mainHero_t:getChildByName("model")
    self._viceHero1Bt_t = self._viceHero1_t:getChildByName("model")
    self._viceHero2Bt_t = self._viceHero2_t:getChildByName("model")
    --新手引导相关
    self._mainHero_t:getChildByName("model"):onTouch(Functions.createClickListener(handler(self, self.onMainheroClick), ""))
    self._viceHero1_t:getChildByName("model"):onTouch(Functions.createClickListener(handler(self, self.onVicehero1Click), ""))
    self._viceHero2_t:getChildByName("model"):onTouch(Functions.createClickListener(handler(self, self.onVicehero2Click), ""))
    self._mainHero_t:getChildByName("model"):setTouchEnabled(true)
    self._viceHero1_t:getChildByName("model"):setTouchEnabled(true)
    self._viceHero2_t:getChildByName("model"):setTouchEnabled(true)
    --限制防御阵型
    if PlayerData.eventAttr.m_level < g_csOpen.TianTiOpen.level then
        self._table_t:getChildByName("tb2"):setVisible(false)
        self._table_t:getChildByName("tb1"):setPositionX(200)
        self._table_t:getChildByName("tb1"):setTouchEnabled(false)
    end 
    self.heroNode = {}   --用于记录创建的英雄节点
    self.heroModelRes = {}
    self.heroModelRes.main = nil
    self.heroModelRes.vice1 = nil
    self.heroModelRes.vice2 = nil
    self.selctedSoldierFlag = 1 -- 1 步兵，2，骑兵 ,3 步兵
    self.mainHeroHeadId = 0
    self.vice1HeroHeadId = 0
    self.vice2HeroHeadId = 0
    --士兵类型
    self.soldier1Type = 1101    
    self.soldier2Type = 2101
    self.soldier3Type = 3101
    --带兵数量
    self.leadSoldierCount = 1
    --士兵头像资源
    self.soldierHeadImg1 = "avatar_infantry1.png"
    self.soldierHeadImg2 = "avatar_cavalry1.png"
    self.soldierHeadImg3 = "avatar_archer1.png"
    --士兵模型资源
    self.soldierRes = {}
    self.soldierRes.soldier1 = nil
    self.soldierRes.soldier2 = nil
    self.soldierRes.soldier3 = nil
    --是否有保存布阵信息
    self.isUpdate = false
    self:bindEmbattleInf()
    --------------------------------------
    self:initZxMode(self.Itype)
    --self:updateEmbattle()

    Functions.addCleanFuncWithNode(self.view_t, handler(self,self.removeAllModelRes))

end
--@auto code view display func end

--移除所有模型资源
function EmbattleViewController:removeAllModelRes()
    local proRemoveHeroRes = {}
    for k,v in pairs(self.heroModelRes) do 
        proRemoveHeroRes[#proRemoveHeroRes+1] = v
    end
    for k,v in pairs(self.soldierRes) do
        proRemoveHeroRes[#proRemoveHeroRes+1] = v
    end
    ResManager:removeAnimations(proRemoveHeroRes)
end
--初始化布阵基本信息数据
function EmbattleViewController:bindEmbattleInf()
    EmbattleData:cleanEmbattleBasecInf()
    self._zhanLi_t:setString(tostring(EmbattleData.eventAttr.zhanLi))
    Functions.bindUiWithModelAttr(self._zhanLi_t, EmbattleData, "zhanLi")
    
    self._daiBing_t:setString(tostring(EmbattleData.eventAttr.daiBing))
    Functions.bindUiWithModelAttr(self._daiBing_t, EmbattleData, "daiBing")

    self._infantry_t:setString(tostring(EmbattleData.eventAttr.infantryNum))
    Functions.bindUiWithModelAttr(self._infantry_t, EmbattleData, "infantryNum")

    self._cavarly_t:setString(tostring(EmbattleData.eventAttr.cavalryNum))
    Functions.bindUiWithModelAttr(self._cavarly_t, EmbattleData, "cavalryNum")

    self._archer_t:setString(tostring(EmbattleData.eventAttr.archerNum))
    Functions.bindUiWithModelAttr(self._archer_t, EmbattleData, "archerNum")
end
--更新布阵信息
function EmbattleViewController:updateEmbattle()
    EmbattleData:cleanAllEmbattleData()
    EmbattleData:loadEmbattleData(self.Itype,handler(self,self.initDisplay))
end
--更新带兵数量
function EmbattleViewController:updateLeadSoldierCout()
    if EmbattleData.MainHeroMark ~= 0 then
        local heroInf = HeroCardData:searchHeroOfMark(EmbattleData.MainHeroMark)
        self.leadSoldierCount = Functions.getSoldierCountOfLevel(PlayerData.eventAttr.m_level)
    end
end
--选择需要布阵的士兵类型
function EmbattleViewController:selectSoldier(soldierType)
    if soldierType == 1 then
        self._soldier1_t:getChildByName("choose"):setVisible(true)
        self._soldier2_t:getChildByName("choose"):setVisible(false)
        self._soldier3_t:getChildByName("choose"):setVisible(false)
        self.selctedSoldierFlag = 1
    end
    if soldierType == 2  then
        self._soldier1_t:getChildByName("choose"):setVisible(false)
        self._soldier2_t:getChildByName("choose"):setVisible(true)
        self._soldier3_t:getChildByName("choose"):setVisible(false)
        self.selctedSoldierFlag = 2
    end
    if soldierType == 3 then
        self._soldier1_t:getChildByName("choose"):setVisible(false)
        self._soldier2_t:getChildByName("choose"):setVisible(false)
        self._soldier3_t:getChildByName("choose"):setVisible(true)
        self.selctedSoldierFlag = 3
    end
end
--显示布阵信息动画
function EmbattleViewController:showInfAction()
    local infBtStyleView = self._infBt_t:getChildByName("infBtStyleView")
    if self._infView_t:getPositionX() == 0 then
        transition.execute(self._infView_t, cc.MoveBy:create(0.5,cc.p(220, 0)),0)
        infBtStyleView:setFlippedX(true)
    else
        transition.execute(self._infView_t, cc.MoveBy:create(0.5,cc.p(-220, 0)),0)
        infBtStyleView:setFlippedX(false)
    end
end

--初始化布阵显示
function EmbattleViewController:initDisplay(isInitMark)
    PromptManager:openHttpLinkPrompt()
    --初始化布阵信息
    if isInitMark or isInitMark == nil then
        EmbattleData:initHeroMark(self.Itype)
        EmbattleData:updateAtrrInf(self.Itype)
    end
    self:updateLeadSoldierCout()
    self:cleanSoldierNum()
    if table.empty(self.soldierRes) then 
        self:updateSoldierHeadRes(EmbattleData.soldierId,function ()
            self:initZX(EmbattleData.EmbattleInf)
        end)
    else
        self:initZX(EmbattleData.EmbattleInf)
    end
    self:playZhanLiChangAnction()
end

function EmbattleViewController:playZhanLiChangAnction( )
    local tempZhanLi =EmbattleData.eventAttr.zhanLi 
    EmbattleData:updateAtrrInf(self.Itype)
    if tempZhanLi > EmbattleData.eventAttr.zhanLi then
        Functions.loadImageWithSprite(self._zhanLiAn_t,"tyj/dynamicUI_res/jiang.png")

        self._zhanLiChangText_t:setFntFile("fonts/gongji.fnt")
        self._zhanLiChangText_t:setText("-" .. tostring(tempZhanLi - EmbattleData.eventAttr.zhanLi))
        self._zhanLiChangText_t:setVisible(true)


        local fadeinUP = cc.FadeIn:create(0.1)--渐显
        local scaletoUP = cc.ScaleTo:create(0.2, 1) --缩放
        local MoveBy = cc.MoveBy:create(0.3, cc.p(0, -80))
        local fadeOutUP = cc.FadeOut:create(1)--渐隐
        local zhanLiTextPosY = self._zhanLiChangText_t:getPositionY()
        local seqUP = cc.Sequence:create(fadeinUP, MoveBy,cc.DelayTime:create(0.5),fadeOutUP,cc.CallFunc:create(function()
                self._zhanLiChangText_t:setPositionY(zhanLiTextPosY)
        end))
        self._zhanLiChangText_t:runAction(seqUP)

        self._zhanLiAn_t:setVisible(true)
        local fadeinUP1 = cc.FadeIn:create(0.1)--渐显
        local scaletoUP1 = cc.ScaleTo:create(0.2, 1) --缩放
        local MoveBy1 = cc.MoveBy:create(0.3, cc.p(0, -80))
        local fadeOutUP1 = cc.FadeOut:create(1)--渐隐
        local zhanLiAnPosY = self._zhanLiAn_t:getPositionY()
        local seqUP1 = cc.Sequence:create(fadeinUP1, MoveBy1,cc.DelayTime:create(0.5),fadeOutUP1,cc.CallFunc:create(function()
                self._zhanLiAn_t:setPositionY(zhanLiAnPosY)
        end))
        self._zhanLiAn_t:runAction(seqUP1)

    elseif tempZhanLi < EmbattleData.eventAttr.zhanLi then
        Functions.loadImageWithSprite(self._zhanLiAn_t,"tyj/dynamicUI_res/sheng.png")
        self._zhanLiChangText_t:setFntFile("fonts/jiaxue.fnt")
        self._zhanLiChangText_t:setText("+" .. tostring(EmbattleData.eventAttr.zhanLi - tempZhanLi))
        self._zhanLiChangText_t:setVisible(true)


        local fadeinUP = cc.FadeIn:create(0.1)--渐显
        local scaletoUP = cc.ScaleTo:create(0.2, 1) --缩放
        local MoveBy = cc.MoveBy:create(0.3, cc.p(0, 80))
        local fadeOutUP = cc.FadeOut:create(1)--渐隐
        local zhanLiTextPosY = self._zhanLiChangText_t:getPositionY()
        local seqUP = cc.Sequence:create(fadeinUP, MoveBy,cc.DelayTime:create(0.5),fadeOutUP,cc.CallFunc:create(function()
                self._zhanLiChangText_t:setPositionY(zhanLiTextPosY)
        end))
        self._zhanLiChangText_t:runAction(seqUP)

        self._zhanLiAn_t:setVisible(true)
        local fadeinUP1 = cc.FadeIn:create(0.1)--渐显
        local scaletoUP1 = cc.ScaleTo:create(0.2, 1) --缩放
        local MoveBy1 = cc.MoveBy:create(0.3, cc.p(0, 80))
        local fadeOutUP1 = cc.FadeOut:create(1)--渐隐
        local zhanLiAnPosY = self._zhanLiAn_t:getPositionY()
        local seqUP1 = cc.Sequence:create(fadeinUP1, MoveBy1,cc.DelayTime:create(0.5),fadeOutUP1,cc.CallFunc:create(function()
                self._zhanLiAn_t:setPositionY(zhanLiAnPosY)
        end))
        self._zhanLiAn_t:runAction(seqUP1)
    end
end
--初始化布阵模式，0 攻击模式  1防御模式
function EmbattleViewController:initZxMode(mode)

     --添加标签页监听
    local tabs = {}
    
    tabs[#tabs+1] =self._table_t:getChildByName("tb1")
    tabs[#tabs+1] =self._table_t:getChildByName("tb2")
    local tableListener = function(target)
        if target == "tb1" then
            EmbattleData:regainAllHeroState(self.Itype)
            self.Itype = 1            
            self:updateEmbattle()  
        elseif target == "tb2" then
           EmbattleData:regainAllHeroState(self.Itype)
           self.Itype = 2            
           self:updateEmbattle()
        end
    end
    if mode == 1 then
        Functions.initTabComWithSimple({widget = self._table_t ,listener = tableListener, firstName = "tb1"})
    elseif mode == 2 then
        Functions.initTabComWithSimple({widget = self._table_t ,listener = tableListener, firstName = "tb2"})
    end
end
--初始化英雄布阵信息
function EmbattleViewController:initZX(embattleInf)
    -- self:cleanAllHeroHead()
    self:selectSoldier(1)
    local showHeroModelHandler = function(  )
        if embattleInf.MainHero[1] ~= nil and embattleInf.MainHero[1].id ~= 0  then        
            self:setZxMapOfHeroId(embattleInf.MainHero[1]["id"])
            self:addHeroOfInf(embattleInf.MainHero[1], "main")
        else
            self:cleanZxMap(0)
        end
        if embattleInf.ViceHeros[1] ~= nil and embattleInf.ViceHeros[1].id ~= 0 then            
            self:addHeroOfInf(embattleInf.ViceHeros[1],"vice1")
        end
        if embattleInf.ViceHeros[2] ~= nil then
            self:addHeroOfInf(embattleInf.ViceHeros[2],"vice2")
        end
        PromptManager:closeHttpLinkPrompt()
        self:showView()
    end    
    self:loadHeroModelRes(embattleInf,showHeroModelHandler)
end

--根据阵型快速设置士兵阵型
function EmbattleViewController:setFastZxMap(zxData)
    EmbattleData.EmbattleInf.Soldiers = {}
    self:cleanZxMap(1)
    for i=1,#zxData do
        if zxData[i].type == "soldier" then   
            local x ,y = self:getZxCoord(zxData[i])
            local element =self:getMapElement(x,y)
            local touch = ccui.Widget:create()
            touch:setTouchEnabled(true)
            touch:setLocalZOrder(10)
            touch:setPosition(cc.p(element:getContentSize().width/2,element:getContentSize().height/2))
            touch:setContentSize(50,50)
            element:addChild(touch)   
            element:setVisible(true)
            local child = element:getChildByTag(x*10+y)
            if child ~= nil then
                element:removeChild(child)
            end
            local soldierT = cc.Sprite:create()
            local soldierType = 1
            if zxData[i].name == "1" then
                soldierType = self.soldier1Type  
                table.insert(EmbattleData.EmbattleInf.Soldiers,{id =self.soldier1Type ,x = x , y = y })
            elseif zxData[i].name == "2" then
                soldierType = self.soldier2Type  
                table.insert(EmbattleData.EmbattleInf.Soldiers,{id =self.soldier2Type  ,x = x , y = y }) 
            elseif zxData[i].name == "3" then   
                soldierType = self.soldier3Type 
                table.insert(EmbattleData.EmbattleInf.Soldiers,{id =self.soldier3Type  ,x = x , y = y }) 
            end
            if  self.leadSoldierCount == 1 then
                soldierT:setPosition(cc.p(element:getContentSize().width/2-3,element:getContentSize().height/2+20))
            else 
                soldierT:setPosition(cc.p(element:getContentSize().width/2-5,element:getContentSize().height/2+8))
            end
            soldierT:setScale(0.5)
            soldierT:setTag(x*10+y)
            element:addChild(soldierT)  
            self:playSoilderAnimation(soldierT,soldierType)
            self:cloneSoldierModel(soldierT,self.leadSoldierCount,soldierType)
            self:updateSoldierNum(soldierType ,self.leadSoldierCount)   
            local touchClick = function(event)
                local temp = element:getChildByTag(x*10+y)
                local soldierType = 1
                if temp == nil then
                    local soldier = cc.Sprite:create() 
                    if self.selctedSoldierFlag == 1 then
                        soldierType = self.soldier1Type
                        --数据操作
                        table.insert(EmbattleData.EmbattleInf.Soldiers,{id =self.soldier1Type ,x = x , y = y })
                    elseif self.selctedSoldierFlag == 2 then
                        soldierType = self.soldier2Type
                        table.insert(EmbattleData.EmbattleInf.Soldiers,{id =self.soldier2Type  ,x = x , y = y }) 
                    elseif self.selctedSoldierFlag == 3 then
                        soldierType = self.soldier3Type
                        table.insert(EmbattleData.EmbattleInf.Soldiers,{id =self.soldier3Type  ,x = x , y = y }) 
                    end   
                    if  self.leadSoldierCount == 1 then
                        soldier:setPosition(cc.p(element:getContentSize().width/2-3,element:getContentSize().height/2+20))
                    else 
                        soldier:setPosition(cc.p(element:getContentSize().width/2-5,element:getContentSize().height/2+8))
                    end
                    soldier:setScale(0.5)
                    soldier:setTag(x*10+y)
                    element:addChild(soldier)
                    self:playSoilderAnimation(soldier,soldierType)
                    self:cloneSoldierModel(soldier,self.leadSoldierCount,soldierType)
                    self:updateSoldierNum(soldierType ,self.leadSoldierCount)
                else
                    --数据操作
                    local pos = self:getSoldierTablePos(EmbattleData.EmbattleInf.Soldiers,x,y)
                    self:updateSoldierNum(EmbattleData.EmbattleInf.Soldiers[pos].id ,-self.leadSoldierCount)
                    table.remove(EmbattleData.EmbattleInf.Soldiers,pos)
                    element:removeChild(temp)
                end
            end
            touch:onTouch(Functions.createClickListener(touchClick, ""))
        end
        if i >= #zxData then 
            PromptManager:closeShieldLayer()
        end
    end
end

--根据阵型数据设置布阵地图
function EmbattleViewController:setZxMap(zxData)
    self:cleanZxMap(0)
    for i = 1 ,#zxData do
        local x ,y = self:getZxCoord(zxData[i])
        self:setHeroFoot(zxData[i])
        if zxData[i].type == "soldier" then    
            local element =self:getMapElement(x,y)
            local touch = ccui.Widget:create()
            touch:setTouchEnabled(true)
            touch:setLocalZOrder(10)
            touch:setPosition(cc.p(element:getContentSize().width/2,element:getContentSize().height/2))
            touch:setContentSize(50,50)
            self["_gird_" .. tostring(x) .. "_" .. tostring(y) .. "_t"] = touch
            element:addChild(touch) 
            local child = element:getChildByTag(x*10+y)
            if child ~= nil then
                element:removeChild(child)
            end
            element:setVisible(true)
            local child = element:getChildByTag(x*10+y)

            if child ~= nil then
                element:removeChild(child)
            end
            for j = 1, #EmbattleData.EmbattleInf.Soldiers do
                local soldier = EmbattleData.EmbattleInf.Soldiers[j]
                if soldier.x == x and soldier.y == y then
                    local soldierNode = cc.Sprite:create()
                    if  self.leadSoldierCount == 1 then
                        soldierNode:setPosition(cc.p(element:getContentSize().width/2-3,element:getContentSize().height/2+20))
                    else 
                        soldierNode:setPosition(cc.p(element:getContentSize().width/2-5,element:getContentSize().height/2+8))
                    end
                    soldierNode:setScale(0.5)
                    soldierNode:setTag(x*10+y)
                    element:addChild(soldierNode)
                    self:playSoilderAnimation(soldierNode,soldier.id)
                    self:cloneSoldierModel(soldierNode,self.leadSoldierCount,soldier.id)
                    self:updateSoldierNum(soldier.id ,self.leadSoldierCount)
                end 
            end
            local touchClick = function(event)
                local temp = element:getChildByTag(x*10+y)
                local soldierType = 1
                if temp == nil then
                    local soldier = cc.Sprite:create() 
                    if self.selctedSoldierFlag == 1 then
                        soldierType = self.soldier1Type
                        --数据操作
                        table.insert(EmbattleData.EmbattleInf.Soldiers,{id =self.soldier1Type ,x = x , y = y })
                    elseif self.selctedSoldierFlag == 2 then
                        soldierType = self.soldier2Type
                        table.insert(EmbattleData.EmbattleInf.Soldiers,{id =self.soldier2Type  ,x = x , y = y }) 
                    elseif self.selctedSoldierFlag == 3 then
                        soldierType = self.soldier3Type
                        table.insert(EmbattleData.EmbattleInf.Soldiers,{id =self.soldier3Type  ,x = x , y = y }) 
                    end 
                    if  self.leadSoldierCount == 1 then
                        soldier:setPosition(cc.p(element:getContentSize().width/2-3,element:getContentSize().height/2+20))
                    else 
                        soldier:setPosition(cc.p(element:getContentSize().width/2-5,element:getContentSize().height/2+8))
                    end
                    soldier:setScale(0.5)
                    soldier:setTag(x*10+y)
                    element:addChild(soldier)
                    self:playSoilderAnimation(soldier,soldierType)
                    self:cloneSoldierModel(soldier,self.leadSoldierCount,soldierType)
                    self:updateSoldierNum(soldierType ,self.leadSoldierCount)
                else
                    --数据操作
                    local pos = self:getSoldierTablePos(EmbattleData.EmbattleInf.Soldiers,x,y)
                    self:updateSoldierNum(EmbattleData.EmbattleInf.Soldiers[pos].id ,-self.leadSoldierCount)
                    table.remove(EmbattleData.EmbattleInf.Soldiers,pos)
                    element:removeChild(temp)
                end
            end
            touch:onTouch(Functions.createClickListener(touchClick, ""))
        end
    end
end

function EmbattleViewController:cloneSoldierModel(target,num,soldierType)
    for i = 2, num do
        local soldierModel = cc.Sprite:create() 
        if i == 2 then
            soldierModel:setPosition(cc.p(200,275))
        elseif i == 3 then 
            soldierModel:setPosition(cc.p(250,300))
        elseif i == 4 then 
            soldierModel:setPosition(cc.p(300,275))
        end
        soldierModel:setLocalZOrder(-1)
        target:addChild(soldierModel)
        self:playSoilderAnimation(soldierModel,soldierType)
    end
end
--更新士兵数量
function EmbattleViewController:updateSoldierNum(soldierType ,num)
    if soldierType >= self.soldier1Type and soldierType <  self.soldier2Type then
        if num < 0 then
            EmbattleData.eventAttr.infantryNum = EmbattleData.eventAttr.infantryNum - math.abs(num)
        else
            EmbattleData.eventAttr.infantryNum = EmbattleData.eventAttr.infantryNum + num
        end
        if EmbattleData.eventAttr.infantryNum < 0 then
            EmbattleData.eventAttr.infantryNum = 0
        end
    elseif soldierType >= self.soldier2Type and soldierType <  self.soldier3Type then
        if num < 0 then
            EmbattleData.eventAttr.cavalryNum = EmbattleData.eventAttr.cavalryNum - math.abs(num)
        else
            EmbattleData.eventAttr.cavalryNum = EmbattleData.eventAttr.cavalryNum + num
        end
        if EmbattleData.eventAttr.cavalryNum < 0 then
            EmbattleData.eventAttr.cavalryNum = 0
        end
    elseif soldierType >= self.soldier3Type then
        if num < 0 then
            EmbattleData.eventAttr.archerNum = EmbattleData.eventAttr.archerNum - math.abs(num)
        else
            EmbattleData.eventAttr.archerNum = EmbattleData.eventAttr.archerNum + num
        end
        if EmbattleData.eventAttr.archerNum < 0 then
            EmbattleData.eventAttr.archerNum = 0
        end
    end
end
function EmbattleViewController:cleanSoldierNum()
    EmbattleData.eventAttr.infantryNum = 0
    EmbattleData.eventAttr.cavalryNum = 0
    EmbattleData.eventAttr.archerNum = 0
end
--根据英雄所在的阵型位置数据设置英雄脚下光环
function EmbattleViewController:setHeroFoot( zxData ) 
    local x ,y = self:getZxCoord(zxData)
    if zxData.type == "hero" then
        if EmbattleData.EmbattleInf.MainHero[1] ~= nil then
            EmbattleData.EmbattleInf.MainHero[1].x = x 
            EmbattleData.EmbattleInf.MainHero[1].y = y
        end
        self:setFootOfTag(1000,x,y)
    end
    if zxData.type == "Commander1" then
        if EmbattleData.EmbattleInf.ViceHeros[1] ~= nil then
            EmbattleData.EmbattleInf.ViceHeros[1].x = x 
            EmbattleData.EmbattleInf.ViceHeros[1].y = y
        end
        self:setFootOfTag(2000,x,y)
    end
    if zxData.type == "Commander2" then
        if EmbattleData.EmbattleInf.ViceHeros[2] ~= nil then
            EmbattleData.EmbattleInf.ViceHeros[2].x = x 
            EmbattleData.EmbattleInf.ViceHeros[2].y = y
        end
        self:setFootOfTag(3000,x,y)
    end
end
--利用tag设置英雄脚下光环
function EmbattleViewController:setFootOfTag(tag ,x ,y )
    local element =self:getMapElement(x,y)
    local positionX = element:getPositionX()
    local positionY = element:getPositionY()
    local foot = cc.Sprite:create()
    foot:setTag(tag)
    foot:setScale(0.5)
    foot:setLocalZOrder(-1)
    foot:setPosition(cc.p(positionX,positionY))
    self._gridPanel_t:addChild(foot)
    Functions.playAnimaOfUI(foot, "An_footNote", 0)
end

--根据士兵的位置得到数据表中的位置
function EmbattleViewController:getSoldierTablePos(soldierTable,x,y)
    for i=1,#soldierTable do
        if soldierTable[i].x == x and soldierTable[i].y == y then
            return i 
        end
    end
end

--根据主英雄ID设置布阵
function EmbattleViewController:setZxMapOfHeroId(id,fast)
    local zxType = ConfigHandler:getHeroZxNameOfId(id)
    if zxType == LanguageConfig.language_heyizhen then
        if fast == nil then
            self:setZxMap(ConfigHandler:loadZxInfoOfName("heyizhen.tmx"))
        else
            self:setFastZxMap(ConfigHandler:loadFastZxInfoOfName("heyizhen.tmx"))
        end   
    elseif zxType == LanguageConfig.language_zhuixingzhen then
        if fast == nil then   
            self:setZxMap(ConfigHandler:loadZxInfoOfName("zhuixingzhen.tmx"))
        else
            self:setFastZxMap(ConfigHandler:loadFastZxInfoOfName("zhuixingzhen.tmx"))
        end      
    elseif zxType == LanguageConfig.language_gouxingzhen then
        if fast == nil then
            self:setZxMap(ConfigHandler:loadZxInfoOfName("gouxingzhen.tmx"))
        else
            self:setFastZxMap(ConfigHandler:loadFastZxInfoOfName("gouxingzhen.tmx"))
        end 
    elseif zxType == LanguageConfig.language_changshezhen then
        if fast == nil then
            self:setZxMap(ConfigHandler:loadZxInfoOfName("changshezhen.tmx"))
        else
            self:setFastZxMap(ConfigHandler:loadFastZxInfoOfName("changshezhen.tmx"))
        end 
    elseif zxType == LanguageConfig.language_yuanxingzhen then
        if fast == nil then
            self:setZxMap(ConfigHandler:loadZxInfoOfName("yuanxingzhen.tmx"))
        else
            self:setFastZxMap(ConfigHandler:loadFastZxInfoOfName("yuanxingzhen.tmx"))
        end   
    elseif zxType == LanguageConfig.language_yanxingzhen then
        if fast == nil then       
            self:setZxMap(ConfigHandler:loadZxInfoOfName("yanxingzhen.tmx"))
        else
            self:setFastZxMap(ConfigHandler:loadFastZxInfoOfName("yanxingzhen.tmx"))
        end 
    end
end
function EmbattleViewController:loadHeroModelRes(embattleInf,callback)
    local proLoadHeroRes = {}
    local proRemoveHeroRes= {}
    if embattleInf.MainHero[1] ~= nil and embattleInf.MainHero[1].id ~= 0  then
        if self.mainHeroHeadId ~= embattleInf.MainHero[1].id then
            self.mainHeroHeadId = embattleInf.MainHero[1].id 
            Functions.getHeroHead(self._mainHero_t,{mark = EmbattleData.MainHeroMark})
        end
        local heroAnimaName = Functions.getHeroAnimaOfid(embattleInf.MainHero[1].id)        
        if heroAnimaName.name ~= self.heroModelRes.main then
            if self.heroModelRes.main ~= nil then 
                proRemoveHeroRes[#proRemoveHeroRes+1] = self.heroModelRes.main
            end
            self.heroModelRes.main = heroAnimaName.name
            proLoadHeroRes[#proLoadHeroRes+1] = self.heroModelRes.main 
        end
    else
        self.mainHeroHeadId = 0 
        Functions.cleanHeroHead(self._mainHero_t)
    end
    if embattleInf.ViceHeros[1] ~= nil and embattleInf.ViceHeros[1].id ~= 0 then
        if self.vice1HeroHeadId ~= embattleInf.ViceHeros[1].id then
            self.vice1HeroHeadId = embattleInf.ViceHeros[1].id 
            Functions.getHeroHead(self._viceHero1_t,{mark = EmbattleData.ViceHero1Mark})
        end
        local heroAnimaName = Functions.getHeroAnimaOfid(embattleInf.ViceHeros[1].id)
        if heroAnimaName.name ~= self.heroModelRes.vice1 then
            if self.heroModelRes.vice1 ~= nil then 
                proRemoveHeroRes[#proRemoveHeroRes+1] = self.heroModelRes.vice1
            end
            self.heroModelRes.vice1 = heroAnimaName.name
            proLoadHeroRes[#proLoadHeroRes+1] = self.heroModelRes.vice1 
        end
    else
        self.vice1HeroHeadId = 0 
        Functions.cleanHeroHead(self._viceHero1_t)
    end

    if embattleInf.ViceHeros[2] ~= nil and embattleInf.ViceHeros[2].id ~= 0 then
        if self.vice2HeroHeadId ~= embattleInf.ViceHeros[2].id then
            self.vice2HeroHeadId = embattleInf.ViceHeros[2].id 
            Functions.getHeroHead(self._viceHero2_t,{mark = EmbattleData.ViceHero2Mark})
        end
        local heroAnimaName = Functions.getHeroAnimaOfid(embattleInf.ViceHeros[2].id)
        if heroAnimaName.name ~= self.heroModelRes.vice2 then
            if self.heroModelRes.vice2 ~= nil then 
                proRemoveHeroRes[#proRemoveHeroRes+1] = self.heroModelRes.vice2
            end
            self.heroModelRes.vice2 = heroAnimaName.name
            proLoadHeroRes[#proLoadHeroRes+1] = self.heroModelRes.vice2 
        end
    else
        self.vice2HeroHeadId = 0 
        Functions.cleanHeroHead(self._viceHero2_t)
    end
    ResManager:removeAnimations(proRemoveHeroRes)
    if #proLoadHeroRes > 0 then 
        local tempHandler = function (count )
            if count == 1 then 
                callback()
            end
        end
        ResManager:loadAnimations(proLoadHeroRes, tempHandler)
    else
        callback()
    end 

end
--根据英雄坐标添加英雄
function EmbattleViewController:addHeroOfInf(heroInf,heroType)
    local x = heroInf["x"]
    local y = heroInf["y"]
    local element = self:getMapElement(x,y)
    local positionX = element:getPositionX()
    local positionY = element:getPositionY()
    local heroAnimaName = Functions.getHeroAnimaOfid(heroInf.id)
    if heroType == "main" then
        self:showHeroModel(self.heroNode.main,10000,heroInf.id,EmbattleData.MainHeroMark,positionX,positionY)
    elseif heroType == "vice1" then 
        self:showHeroModel(self.heroNode.vice1,20000,heroInf.id,EmbattleData.ViceHero1Mark,positionX,positionY)
    elseif heroType == "vice2" then 
        self:showHeroModel(self.heroNode.vice2,30000,heroInf.id,EmbattleData.ViceHero2Mark,positionX,positionY)
    end
    element:setVisible(false)
end
--显示英雄模型
function EmbattleViewController:showHeroModel(target,tag,heroId,heroMark,x,y)
    if target == nil then
        self:createHeroModel(target,tag,heroId,heroMark,x,y)
    else
        self:updateHeroModel(target,heroId,heroMark)
    end 
end
--根据英雄ID创建英雄模型
function EmbattleViewController:createHeroModel(target,tag,heroId,heroMark,x,y)
    
    local  hero = cc.Sprite:create()
    hero:setPosition(cc.p(x,y+15))
    hero:setTag(tag)
    hero:setScale(0.8)
    hero:setLocalZOrder(100)
    self._gridPanel_t:addChild(hero)

    target = hero
    self:playHeroAnimation(target,heroId)
    local nameNode = self:createHeroName(heroId,heroMark,cc.p(x,y+60),1.2)
    nameNode:setTag(tag+1)
    nameNode:setName("name")
    nameNode:setLocalZOrder(200)
    self._gridPanel_t:addChild(nameNode)
    -- body
end
--根据英雄ID创建一个英雄名字Label
function EmbattleViewController:createHeroName(heroId,heroMark,pos,scale)
    
    local heroClass = 1
    if heroMark > 0 then
        local tempClass = HeroCardData:searchHeroOfMark(heroMark).m_class
        heroClass = Functions.formatHeroClass(tempClass)  
    end 
    local heroName = ConfigHandler:getHeroNameOfId(heroId,heroClass)
    local colorValue = {
            -- cc.c3b(255,255,255), --白
            -- cc.c3b(0,255,0),     --绿
            -- cc.c3b(0,0,255),     --蓝
            -- cc.c3b(128,0,128),   --紫
            -- cc.c3b(255,165,0),   --橙
            -- cc.c3b(255,0,0),     --红
            -- cc.c3b(255,0,0),     --红
            cc.c3b(255,255,255), --白
            cc.c3b(171,255,38),     --绿
            cc.c3b(26,209,255),     --蓝
            cc.c3b(255,64,237),   --紫
            cc.c3b(255,255,25),   --橙
            cc.c3b(255,63,37),     --红
            cc.c3b(255,63,37),     --红
        }
    -- local nameNode = Functions.createBMFont({pos = pos, text = heroName,filePath = "fonts/heroName.fnt",scale = scale,color = colorValue[heroClass]})
     local nameNode = Functions.createLabel({pos = pos , text = heroName,scale = scale,color = colorValue[heroClass]},true)
    return nameNode
end
--更新英雄模型
function EmbattleViewController:updateHeroModel(target,heroId,heroClass)
    local nameNode = target:getChildByName("name")
    local bigClass = Functions.formatHeroClass(heroClass)
    Functions.initHeroName(nameNode,heroId,bigClass)

    nameNode:setPosition(cc.p(target:getPositionX(),target:getPositionX()+85))

    target:stopAllActions()
    self:playHeroAnimation(target,heroId)
end
--清除所有布阵信息
function EmbattleViewController:cleanZxMap(type)
    if type == 0 then
        local foot1 = self._gridPanel_t:getChildByTag(1000)
        if foot1 ~= nil then
            self._gridPanel_t:removeChildByTag(1000)
        end
        local foot2 = self._gridPanel_t:getChildByTag(2000)
        if foot2 ~= nil then
            self._gridPanel_t:removeChildByTag(2000)
        end
        local foot3 = self._gridPanel_t:getChildByTag(3000)
        if foot3 ~= nil then
            self._gridPanel_t:removeChildByTag(3000)
        end
        local hero1 = self._gridPanel_t:getChildByTag(10000)
        if hero1 ~= nil then
            self._gridPanel_t:removeChildByTag(10000)
            self._gridPanel_t:removeChildByTag(10001)
            self.heroNode.main = nil
        end
        local hero2 = self._gridPanel_t:getChildByTag(20000)
        if hero2 ~= nil then
            self._gridPanel_t:removeChildByTag(20000)
            self._gridPanel_t:removeChildByTag(20001)
            self.heroNode.vice1 = nil
        end
        local hero3 = self._gridPanel_t:getChildByTag(30000)
        if hero3 ~= nil then
            self._gridPanel_t:removeChildByTag(30000)
            self._gridPanel_t:removeChildByTag(30001)
            self.heroNode.vice2 = nil
        end
    end
    for x=0,6 do
        for y=0,8 do
            local element = self:getMapElement(x,y)
            element:setLocalZOrder(100-x*10-y)
            local child = element:getChildByTag(x*10+y)
            if child ~= nil then
                element:removeChild(child)
            end
            if type == 0 then
                element:setVisible(false)
            end
        end
    end
end


--tools  start
--根据坐标获取地图元素
function EmbattleViewController:getMapElement(x,y)
    return self._gridPanel_t:getChildByName("gird_" .. tostring(x) .. "_" .. tostring(y))
end
--清除英雄头像及模型资源
function EmbattleViewController:cleanAllHeroHead()
    Functions.cleanHeroHead(self._mainHero_t)
    Functions.cleanHeroHead(self._viceHero1_t)
    Functions.cleanHeroHead(self._viceHero2_t)
end
--获取当前阵型三种士兵的头像与卡牌并加载模型资源
function EmbattleViewController:updateSoldierHeadRes(data,callback)
    self.soldier1Type = data[1]
    self.soldier2Type = data[2]
    self.soldier3Type = data[3]

    self.soldierHeadImg1 = ConfigHandler:getSoldierHeadImageOfId(self.soldier1Type)
    local soldierAnimaName1 = Functions.getSoldierAnimaOfid(self.soldier1Type)
--    self.soldierRes.soldier1 = soldierAnimaName1.name

    self.soldierHeadImg2 = ConfigHandler:getSoldierHeadImageOfId(self.soldier2Type)
    local soldierAnimaName2 = Functions.getSoldierAnimaOfid(self.soldier2Type)
--    self.soldierRes.soldier2 = soldierAnimaName2.name

    self.soldierHeadImg3 = ConfigHandler:getSoldierHeadImageOfId(self.soldier3Type)
    local soldierAnimaName3 = Functions.getSoldierAnimaOfid(self.soldier3Type)
--    self.soldierRes.soldier3 = soldierAnimaName3.name
     
    local soldier1Head = self._soldier1_t:getChildByName("head")
    local soldier2Head = self._soldier2_t:getChildByName("head")
    local soldier3Head = self._soldier3_t:getChildByName("head")
    soldier1Head:setVisible(true)
    soldier2Head:setVisible(true)
    soldier3Head:setVisible(true)
    Functions.loadImageWithWidget(soldier1Head, self.soldierHeadImg1)
    Functions.loadImageWithWidget(soldier2Head, self.soldierHeadImg2)
    Functions.loadImageWithWidget(soldier3Head, self.soldierHeadImg3)
    local tempHandler = function (count)
        if count == 1 then 
            callback()
        end
    end
    local preLoadRes = {}
    if self.soldierRes.soldier1 == nil then 
        self.soldierRes.soldier1 = soldierAnimaName1.name
        preLoadRes[#preLoadRes+1]= soldierAnimaName1.name
    end
    if self.soldierRes.soldier2 == nil then 
        self.soldierRes.soldier2 = soldierAnimaName2.name
        preLoadRes[#preLoadRes+1]= soldierAnimaName2.name
    end
    if self.soldierRes.soldier3 == nil then 
        self.soldierRes.soldier3 = soldierAnimaName3.name
        preLoadRes[#preLoadRes+1]= soldierAnimaName3.name
    end
    if not table.empty(preLoadRes) then 
        ResManager:loadAnimations(preLoadRes,tempHandler)
    else
        callback()
    end

end
----加载士兵头像
--function EmbattleViewController:loadSoldierHead()
--    
--end
--计算阵型坐标
function EmbattleViewController:getZxCoord(prame)
    return Functions.subIntOfNum(prame["x"]/prame["width"]),Functions.subIntOfNum(prame["y"]/prame["height"])
end
--根据英雄信息得到英雄坐标
function EmbattleViewController:getHeroPositon(heroInf)
    return heroInf["x"],heroInf["y"]
end
--tools
-- --接受选将子场景数据
function EmbattleViewController:onReceivePopData(jump)
    if jump ~= nil then
        if jump.jumpData.heroType == 0 then
            EmbattleData.EmbattleInf.Soldiers = {} 
        end
    end
    self:initDisplay()
end

--保存布阵信息
function EmbattleViewController:saveEmbattleInf(handler)
    local onRequest = function(event)
        PromptManager:openTipPrompt(LanguageConfig.language_Teach16)
        EmbattleData:saveAllHeroState(self.Itype)
        self.isUpdate = true
        GameEventCenter:dispatchEvent({ name = HeroCardData.CARDS_DATA_SORT_EVENT })--发送排序卡牌事件
        if handler ~= nil then 
            handler()
        end
    end
    NetWork:addNetWorkListener({ 1, 3}, Functions.createNetworkListener(onRequest, true, "err"))

    local Soldiers = {}
    for k,v in pairs(EmbattleData.EmbattleInf.Soldiers) do
        Soldiers[k] = {}
        Soldiers[k].id = v.id
        Soldiers[k].x = v.x
        Soldiers[k].y = v.y
    end

    EmbattleData.EmbattleInf.SoldiersBak  =  clone(EmbattleData.EmbattleInf.Soldiers)
    local PartHero = {}
    for k,v in pairs(EmbattleData.PartHeroMark) do
        if EmbattleData.PartHeroMark[k] ~= 0 then
            PartHero[k] = EmbattleData.PartHeroMark[k]
        end
    end
    local ViceHeros = {}
    if EmbattleData.ViceHero1Mark ~= 0 then
        ViceHeros[1] = {idx = EmbattleData.ViceHero1Mark,x = EmbattleData.EmbattleInf.ViceHeros[1].x, y = EmbattleData.EmbattleInf.ViceHeros[1].y}
    end
    if EmbattleData.ViceHero2Mark ~= 0 then
        ViceHeros[2] = {idx = EmbattleData.ViceHero2Mark,x = EmbattleData.EmbattleInf.ViceHeros[2].x, y = EmbattleData.EmbattleInf.ViceHeros[2].y}
    end
    local MainHero = {}
    if EmbattleData.MainHeroMark ~= 0 then
        MainHero = {{idx = EmbattleData.MainHeroMark,x = EmbattleData.EmbattleInf.MainHero[1].x,y = EmbattleData.EmbattleInf.MainHero[1].y}}
    end
    local msg = {}

    if self.Itype == 1 then
        msg = {idx = {1, 3},rtype = 1,data = { AttackFormation = { Soldiers = Soldiers,PartHero = PartHero,ViceHeros = ViceHeros,MainHero = MainHero} }}
    elseif self.Itype == 2 then
        msg = {idx = {1, 3},rtype = 1,data = { DefenseFormation = { Soldiers = Soldiers,PartHero = PartHero,ViceHeros = ViceHeros,MainHero = MainHero } }}
    end
    NetWork:sendToServer(msg)
    -- body
end
--根据士兵id播放相应动画
function EmbattleViewController:playSoilderAnimation(target,id)
    local soldierAnimaName = Functions.getSoldierAnimaOfid(id)
    --ResManager:loadAnimaOfPlist(soldierAnimaName.name .. "_plist")
    local actionSequence = {{actionName = soldierAnimaName.idle_rightup_anim,repeatNum = 10},{actionName =soldierAnimaName.attack_rightup_anim,repeatNum = 1}}
    Functions.playSequenceAction(target,actionSequence,0)
    
end
function EmbattleViewController:playHeroAnimation(target,id)
    local heroAnimaName = Functions.getHeroAnimaOfid(id)
    target:setScale(1)
--    ResManager:loadAnimaOfPlist(heroAnimaName.name .. "_plist")
    local actionSequence = {{actionName = heroAnimaName.idle_rightup_anim,repeatNum = 10},{actionName =heroAnimaName.attack_rightup_anim,repeatNum = 1}}
    Functions.playSequenceAction(target,actionSequence,0)
    -- body
end
--jump格式:{data = {jumpType = ,jumpData = {embattleType = ,...}}} 
function EmbattleViewController:onReceivePushData(jump)
    self.jumpType = jump.jumpType
    self.jumpData = jump.jumpData 
    if self.jumpData ~= nil then
       self.Itype = self.jumpData.embattleType
    else
        self.Itype = EmbattleData.EmbattleTypeEnum.attack
    end
end
function EmbattleViewController:onReceivePopData(jump) 
    self:initDisplay(false)
end
return EmbattleViewController