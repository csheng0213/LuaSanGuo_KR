--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local SevenStarViewController = class("SevenStarViewController", BaseViewController)

local Functions = require("app.common.Functions")

SevenStarViewController.debug = true
SevenStarViewController.modulePath = ...
SevenStarViewController.studioSpriteFrames = {"SevenStar","SevenStarUI","CB_blackbg" }
--@auto code head end

--@Pre loading
SevenStarViewController.spriteFrameNames = 
    {
        "heroCardRes","headPilistRes"
    }

SevenStarViewController.animaNames = 
    {
        "An_bao","An_card"
    }


--@auto code uiInit
--add spriteFrames
if #SevenStarViewController.studioSpriteFrames > 0 then
    SevenStarViewController.spriteFrameNames = SevenStarViewController.spriteFrameNames or {}
    table.insertto(SevenStarViewController.spriteFrameNames, SevenStarViewController.studioSpriteFrames)
end
function SevenStarViewController:onDidLoadView()

    --output list
    self._topNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("topNode")
	self._card_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("card")
	self._tips_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("tips")
	self._nomalPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("nomalPanel")
	self._prop5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("nomalPanel"):getChildByName("prop5")
	self._prop1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("nomalPanel"):getChildByName("prop1")
	self._prop2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("nomalPanel"):getChildByName("prop2")
	self._prop3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("nomalPanel"):getChildByName("prop3")
	self._prop4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("nomalPanel"):getChildByName("prop4")
	self._fuyinLabel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("nomalPanel"):getChildByName("fuyinLabel")
	
    --label list
    
    --button list
    self._backBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), ""))

	self._helpBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("helpBt")
	self._helpBt_t:onTouch(Functions.createClickListener(handler(self, self.onHelpbtClick), ""))

	self._zhenBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("zhenBt")
	self._zhenBt_t:onTouch(Functions.createClickListener(handler(self, self.onZhenbtClick), ""))

	self._guiBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("guiBt")
	self._guiBt_t:onTouch(Functions.createClickListener(handler(self, self.onGuibtClick), ""))

	self._shenBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("shenBt")
	self._shenBt_t:onTouch(Functions.createClickListener(handler(self, self.onShenbtClick), ""))

	self._shengBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("shengBt")
	self._shengBt_t:onTouch(Functions.createClickListener(handler(self, self.onShengbtClick), ""))

	self._wangBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("wangBt")
	self._wangBt_t:onTouch(Functions.createClickListener(handler(self, self.onWangbtClick), ""))

	self._huangBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("huangBt")
	self._huangBt_t:onTouch(Functions.createClickListener(handler(self, self.onHuangbtClick), ""))

	self._refrashBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("nomalPanel"):getChildByName("refrashBt")
	self._refrashBt_t:onTouch(Functions.createClickListener(handler(self, self.onRefrashbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt btFunc
function SevenStarViewController:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    GameCtlManager:pop(self)
end
--@auto code Backbt btFunc end

--@auto code Zhenbt btFunc
function SevenStarViewController:onZhenbtClick()
    Functions.printInfo(self.debug,"Zhenbt button is click!")
    self.hunType = 1
    self._tips_t:setVisible(false)
    self._nomalPanel_t:setVisible(true)
    --self:setOpenLevelString(self.hunType)
    self:clearAtrrSlot()
    self:showAllStarAtrr(self.hunType,SevenStarData.heroMark)

    self:playerParticle(self._zhenBt_t)

    Functions.playAnimationWithRemove(self._card_t,"An_card",0,0)
end
--@auto code Zhenbt btFunc end

--@auto code Guibt btFunc
function SevenStarViewController:onGuibtClick()
    Functions.printInfo(self.debug,"Guibt button is click!")
    self.hunType = 2
    self._tips_t:setVisible(false)
    self._nomalPanel_t:setVisible(true)
    --self:setOpenLevelString(self.hunType)
    self:clearAtrrSlot()
    self:showAllStarAtrr(self.hunType,SevenStarData.heroMark)
    self:playerParticle(self._guiBt_t)
    Functions.playAnimationWithRemove(self._card_t,"An_card",0,0)
end
--@auto code Guibt btFunc end
    
--@auto code Shenbt btFunc
function SevenStarViewController:onShenbtClick()
    Functions.printInfo(self.debug,"Shenbt button is click!")
    self.hunType = 3
    self._tips_t:setVisible(false)
    self._nomalPanel_t:setVisible(true)
    --self:setOpenLevelString(self.hunType)
    self:clearAtrrSlot()
    self:showAllStarAtrr(self.hunType,SevenStarData.heroMark)
    self:playerParticle(self._shenBt_t)
    Functions.playAnimationWithRemove(self._card_t,"An_card",0,0)
end
--@auto code Shenbt btFunc end

--@auto code Wangbt btFunc
function SevenStarViewController:onWangbtClick()
    Functions.printInfo(self.debug,"Wangbt button is click!")
    self.hunType = 5
    self._tips_t:setVisible(false)
    self._nomalPanel_t:setVisible(true)
    --self:setOpenLevelString(self.hunType)
    self:clearAtrrSlot()
    self:showAllStarAtrr(self.hunType,SevenStarData.heroMark)
    self:playerParticle(self._wangBt_t)
    Functions.playAnimationWithRemove(self._card_t,"An_card",0,0)
end
--@auto code Wangbt btFunc end

--@auto code Huangbt btFunc
function SevenStarViewController:onHuangbtClick()
    Functions.printInfo(self.debug,"Huangbt button is click!")
    self.hunType = 6
    self._tips_t:setVisible(false)
    self._nomalPanel_t:setVisible(true)
    --self:setOpenLevelString(self.hunType)
    self:clearAtrrSlot()
    self:showAllStarAtrr(self.hunType,SevenStarData.heroMark)
    self:playerParticle(self._huangBt_t)
    Functions.playAnimationWithRemove(self._card_t,"An_card",0,0)

end
--@auto code Huangbt btFunc end

--@auto code Refrashbt btFunc
function SevenStarViewController:onRefrashbtClick()
    if PlayerData.eventAttr.m_guideId == 600 then
        self:refrashStar()
    else
        if self.isTips then
            local handler = function (  )
                self:refrashStar()
            end
            local fuyinNum ,fuyinIndex = PropData:getPropNumOfId(4)
            if fuyinNum == nil or fuyinNum < 1  then 
                self.isTips = false
                NoticeManager:openTips(self, {type = NoticeManager.SEVENSTAR_TIPS,handler = handler })
            else
                handler()
            end
        else
            self:refrashStar()
        end
    end
    
end
--@auto code Refrashbt btFunc end

--@auto code Shengbt btFunc
function SevenStarViewController:onShengbtClick()
    Functions.printInfo(self.debug,"Shengbt button is click!")
    self.hunType = 4
    self._tips_t:setVisible(false)
    self._nomalPanel_t:setVisible(true)
    --self:setOpenLevelString(self.hunType)
    self:clearAtrrSlot()
    self:showAllStarAtrr(self.hunType,SevenStarData.heroMark)
    self:playerParticle(self._shengBt_t)
    Functions.playAnimationWithRemove(self._card_t,"An_card",0,0)
end
--@auto code Shengbt btFunc end

--@auto code Helpbt btFunc
function SevenStarViewController:onHelpbtClick()
    Functions.printInfo(self.debug,"Helpbt button is click!")
     NoticeManager:openNotice(self, {type = NoticeManager.SEVENSTAR_INFO})
end
--@auto code Helpbt btFunc end

--@auto button backcall end


--@auto code view display func
function SevenStarViewController:onCreate()
    Functions.printInfo(self.debug_b," SevenStarViewController controller create!")
end

function SevenStarViewController:onDisplayView()
    Functions.printInfo(self.debug_b," SevenStarViewController view enter display!")
    Functions.setAdbrixTag("retension","seven_castle_try")
    Functions.setPopupKey("seven_star")
    if PlayerData.eventAttr.m_guideId == 600 then 
        if #HeroCardData:getBigClass() < 1 then
            GuideManager:handlerStopCurGuide()
            GuideManager:finishGuide()
        end
    end
     --读取七星信息
    -- local sevenStarFilePath = "data/sevenstar.txt"
    -- local TextReader = require("app.common.TextReader")
    -- self.sevenStarInf = TextReader.parserFile(sevenStarFilePath,true) 
    SevenStarData.heroMark = 0
    self.isTips = true
    self:initUiDisplay_()
end
--@auto code view display func end
function SevenStarViewController:onCardClick()
    Functions.printInfo(self.debug,"Refrashbt button is click!")   
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data = {jumpType = 2,jumpData = {heroType = 0}}})
end

function SevenStarViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
----------------------------------------------------------------------
function SevenStarViewController:refrashStar()
    Functions.printInfo(self.debug,"Refrashbt button is click!")
    if PropData.propInf.m_itemBag[4] ~= nil and PlayerData.eventAttr["m_gold"] <= 0 then
        PromptManager:openTipPrompt(LanguageConfig.language_sevenStar_1) 
    else
        local handler = function (event) 
            Functions.playSound("awakenSevenStarpodium.mp3") 
            self:clearAtrrSlot()
            self:showAllStarAtrr(self.hunType,SevenStarData.heroMark)
            Functions.setAdbrixTag("retension","seven_castle_try_complete")
        end
        SevenStarData:RequestRefrashAtrr(SevenStarData.heroMark,self.hunType,handler)
    end
end
--播放粒子效果
function SevenStarViewController:playerParticle(target)
    if self.particleSprite ~= nil then
       self.particleSprite:removeFromParent()
    end
    self.particleSprite = cc.Sprite:create()
    self.particleSprite:setOpacity(100)
    local animation = cc.ParticleSystemQuad:create("tyj/animaRes/zhenlist.plist")
    animation:setScale(0.5);
    animation:setPosition(cc.p(target:getContentSize().width/2, target:getContentSize().height/2))
    self.particleSprite:addChild(animation)
    target:addChild(self.particleSprite)
end

function SevenStarViewController:showHeroCard(mark)
    local heroCard = self._card_t:getChildByName("heroCard")
    local add = self._card_t:getChildByName("add")
    heroCard:setVisible(true)
    add:setVisible(false)
--    self._tips_t:setString(LanguageConfig.language_sevenStar_2) 
    Functions.getHeroCrad(heroCard,{mark = mark })
    local heroInf = HeroCardData:searchHeroOfMark(mark)
    local heroId = heroInf.m_id
    
    local  btTable = {self._zhenBt_t,self._guiBt_t,self._shenBt_t,self._shengBt_t,self._wangBt_t,self._huangBt_t}
    for i = 1, 6 do
        Functions.setEnabledBt(btTable[i],false)
    end
    for i = 2, Functions.formatHeroClass(heroInf.m_class) do
        Functions.setEnabledBt(btTable[i-1],true)
    end
    -- body
end
--根据英雄卡牌在背包中的Id得到英雄数据
function SevenStarViewController:getHeroSevenStarOfid(heroSoltId)
    for k,v in pairs(SevenStarData.sevenStarData) do
        if v["m_slot"] == heroSoltId then
            return v
        end
    end
end
--根据魂显示所有属性
function SevenStarViewController:showAllStarAtrr(hun,cardSlot)
    local starData = self:getHeroSevenStarOfid(cardSlot)
    if starData ~= nil then
        for i=1,5 do
            self:showSingleStarAtrr(self._nomalPanel_t:getChildByName("prop" .. i),starData["m_stamp"][hun]["m_box"][i],starData["m_stamp"][hun]["m_var"][i],hun) 
        end
    end
end
--显示单个属性
function SevenStarViewController:showSingleStarAtrr(target,index,var,hun)
    local propImg = nil
    local propInf = nil
    local tips1Label = target:getChildByName("tips1Label")
    local tips2Label = target:getChildByName("tips2Label")

    tips2Label:setVisible(false)
    local tips = target:getChildByName("tips")
  
    if var > 4 then
        var = var - 4
    end
    if var == 1 then
        propImg = "seven_starts_army.png"
        -- propInf = starData[index]["轩辕"]
        propInf = LanguageConfig.language_sevenStar_4 .. "+" .. StartAttrCfg[hun][var][index] 
    elseif var == 2  then
        propImg = "seven_starts_attack.png"
        -- propInf = starData[index]["盘古"]
        propInf = LanguageConfig.language_sevenStar_5 .. "+" .. StartAttrCfg[hun][var][index] 
    elseif var == 3 then
        propImg = "seven_starts_life.png"
        -- propInf = starData[index]["神农"]
        propInf = LanguageConfig.language_sevenStar_6 .. "+" .. StartAttrCfg[hun][var][index] 
    elseif var == 4 then
        propImg = "seven_starts_mp.png"
        -- propInf = starData[index]["昊天"]
        propInf = LanguageConfig.language_sevenStar_7 .. "+" .. StartAttrCfg[hun][var][index] 
    end
    local propView = target:getChildByName("propView")
    Functions.playAnimationWithRemove(propView,"An_bao",0,0)
    Functions.playAnimationWithRemove(self._card_t,"An_card",0,0)
    if propImg ~= nil then
        Functions.loadImageWithWidget(propView,propImg)
        propView:setVisible(true)
    end
    if propInf ~= nil then
        tips1Label:setString(propInf)
        tips1Label:setVisible(true)
        if tips ~= nil then 
            tips:setVisible(false)
        end
    else
        tips1Label:setVisible(false)
        if tips ~= nil then 
            tips:setVisible(true)
        end
    end
    if index > 0 then 
        local str = "LV" .. tostring(index)
        tips2Label:setString(str)  
        tips2Label:setVisible(true)
    end
end

function SevenStarViewController:initUiDisplay_()
    --钱币显示
    -- Functions.bindMGSDisplay({moneyObj = self._coinText_t,goldObj = self._goldText_t,soulObj = self._soulText_t})
    Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})

    local fuyinObj =  self._nomalPanel_t:getChildByName("fuyinLabel")
    local fuyinNum ,fuyinIndex = PropData:getPropNumOfId(4)
    fuyinObj:setString(fuyinNum)
    if fuyinIndex ~= nil then
        Functions.bindUiWithModelAttr(fuyinObj, PropData.propInf.m_itemBag[fuyinIndex], "m_count")
    end
    self._card_t:onTouch(Functions.createClickListener(handler(self, self.onCardClick), ""))
    if SevenStarData.heroMark > 0  then
        self:showHeroCard(SevenStarData.heroMark)
    end
    self._tips_t:setVisible(true)
    self._nomalPanel_t:setVisible(false)
    self:clearAtrrSlot()
    if self.particleSprite ~= nil then
        self.particleSprite:removeFromParent()
        self.particleSprite = nil
    end
end

--获取英雄头像
function SevenStarViewController:loadHeroHead(target,data)
    if data ~= {} then
        local id = data["id"]
        local heroHeadImg = ConfigHandler:getHeroHeadImageOfId(id)
        Functions.loadImageWithWidget(target, heroHeadImg)
        target:setScale(1.30)
    end
end
--清空所有魂属性显示
function SevenStarViewController:clearAtrrSlot()
    self._prop1_t:getChildByName("propView"):setVisible(false)
    self._prop2_t:getChildByName("propView"):setVisible(false)
    self._prop3_t:getChildByName("propView"):setVisible(false)
    self._prop4_t:getChildByName("propView"):setVisible(false)
    self._prop5_t:getChildByName("propView"):setVisible(false)

    self._prop1_t:getChildByName("tips1Label"):setVisible(false)
    self._prop2_t:getChildByName("tips1Label"):setVisible(false)
    self._prop3_t:getChildByName("tips1Label"):setVisible(false)
    self._prop4_t:getChildByName("tips1Label"):setVisible(false)

    self._prop1_t:getChildByName("tips2Label"):setVisible(false)
    self._prop2_t:getChildByName("tips2Label"):setVisible(false)
    self._prop3_t:getChildByName("tips2Label"):setVisible(false)
    self._prop4_t:getChildByName("tips2Label"):setVisible(false)
end

--设置开放等级
function SevenStarViewController:setOpenLevelString(typeId)   
    local zhenTable = {"1级开放","5级开放","10级开放","15级开放"}
    local guiTable = {"15级开放","20级开放","25级开放","30级开放"}
    local shenTable = {"30级开放","35级开放","40级开放","45级开放"}
    local shengTable = {"45级开放","50级开放","55级开放","65级开放"}
    local wangTable = {"65级开放","70级开放","80级开放","90级开放"}
    local huangTable = {"90级开放","95级开放","100级开放","110级开放"}
    local typeTable = {zhenTable,guiTable,shenTable,shengTable,wangTable,huangTable}
    for i = 1, 4 do
        local openLevellabel = self._nomalPanel_t:getChildByTag(i):getChildByTag(3)
        openLevellabel:setString(typeTable[typeId][i])
    end   
end
--接受pop数据
function SevenStarViewController:onReceivePopData(data)
    self:initUiDisplay_()
end

return SevenStarViewController