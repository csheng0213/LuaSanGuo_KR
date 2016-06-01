--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local SelectHeroViewController = class("SelectHeroViewController", BaseViewController)

local Functions = require("app.common.Functions")

SelectHeroViewController.debug = true
SelectHeroViewController.modulePath = ...
SelectHeroViewController.studioSpriteFrames = {"CBO_ban","SelectHeroUI_Text","CB_bgup","CB_blackbg" }
--@auto code head end

--@Pre loading
SelectHeroViewController.spriteFrameNames = 
    {
        "headPilistRes","heroCardRes","CC_comHead"
    }

SelectHeroViewController.animaNames = 
    {
    }
--Enum
local HeroType = 
    {
        MainHero = 0,
        ViceHero1 = 1,
        ViceHero2 = 2,
        PartHero1 = 4,
        PartHero2 = 5,
        PartHero3 = 6,
        PartHero4 = 7,
        PartHero5 = 8,
        PartHero6 = 9,
    }
--

--@auto code uiInit
--add spriteFrames
if #SelectHeroViewController.studioSpriteFrames > 0 then
    SelectHeroViewController.spriteFrameNames = SelectHeroViewController.spriteFrameNames or {}
    table.insertto(SelectHeroViewController.spriteFrameNames, SelectHeroViewController.studioSpriteFrames)
end
function SelectHeroViewController:onDidLoadView()

    --output list
    self._topNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel_14"):getChildByName("topbarBg_61"):getChildByName("topNode")
	self._heroPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("box"):getChildByName("heroPanel")
	self._tableContainer_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("box"):getChildByName("tableContainer")
	self._tips_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("box"):getChildByName("tips")
	self._table_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("table")
	
    --label list
    
    --button list
    self._backBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel_14"):getChildByName("topbarBg_61"):getChildByName("Panel_3"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), ""))

	self._shangzhenBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("box"):getChildByName("heroPanel"):getChildByName("shangzhenBt")
	self._shangzhenBt_t:onTouch(Functions.createClickListener(handler(self, self.onShangzhenbtClick), "zoom"))

	self._xiangxiBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("box"):getChildByName("heroPanel"):getChildByName("xiangxiBt")
	self._xiangxiBt_t:onTouch(Functions.createClickListener(handler(self, self.onXiangxibtClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt btFunc
function SelectHeroViewController:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    GameCtlManager:pop(self)
end
--@auto code Backbt btFunc end

--@auto code Shangzhenbt btFunc
function SelectHeroViewController:onShangzhenbtClick()
    Functions.printInfo(self.debug,"Shangzhenbt button is click!")
    local nowHeroMark = EmbattleData:getHeroMarkOfType(self.jumpData.heroType)
    if self.jumpType == JumpType.EmbattleToSelectHero  or self.jumpType == JumpType.PartHeroToSelectHero then
        if  nowHeroMark~=nil and nowHeroMark >0 then
           -- local heroReplaceView = require("app.ui.popViews.HeroReplacePopView"):new()        
           self:openChildView("app.ui.popViews.HeroReplacePopView",{isRemove = false,data={nowHeroMark = nowHeroMark,selectedHeroMark = self.heroMark}})
        elseif self.heroMark ~= nil and self.heroId ~= nil then
            self:shangZhengHero(self.jumpData.heroType)            
        else
            PromptManager:openTipPrompt(LanguageConfig.language_selectHero_6)
        end
    elseif self.jumpType == JumpType.SevenStarToSelectHero then
        SevenStarData.heroMark = self.heroMark 
        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = {heroType = self.jumpData.heroType,heroMark = self.heroMark }}})
    elseif self.jumpType == JumpType.MainCityToSelectHero then
        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = {heroType = self.jumpData.heroType,heroMark = self.heroMark }}})
    elseif self.jumpType == JumpType.ExpChangeToSelectHero then
        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = {heroType = self.jumpData.heroType,heroMark = self.heroMark }}})
    elseif self.jumpType == JumpType.HeroUpgradeToSelectHero then
        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = {heroType = self.jumpData.heroType,heroMark = self.heroMark }}})
    end
end
--@auto code Shangzhenbt btFunc end

--@auto code Xiangxibt btFunc
function SelectHeroViewController:onXiangxibtClick()
    Functions.printInfo(self.debug,"Xiangxibt button is click!")
    if self.selectedHeroData ~= nil then
        if self.jumpType == JumpType.MainCityToSelectHero then
            self:openChildView("app.ui.popViews.CardInfoPopView", { data = {self.selectedHeroData, 2}})
        elseif self.jumpType == JumpType.SevenStarToSelectHero then
            self:openChildView("app.ui.popViews.CardInfoPopView", { data = {self.selectedHeroData, 2}})
        elseif self.jumpType == JumpType.ExpChangeToSelectHero then
            self:openChildView("app.ui.popViews.CardInfoPopView", { data = {self.selectedHeroData, 2}})
        elseif self.jumpType == JumpType.HeroUpgradeToSelectHero then
            self:openChildView("app.ui.popViews.CardInfoPopView", { data = {self.selectedHeroData, 2}})
        else
            self:openChildView("app.ui.popViews.CardInfoPopView", { data = {self.selectedHeroData, 1}})
        end
    else
        PromptManager.openTipPrompt(LanguageConfig.language_selectHero_6)
    end   
end
--@auto code Xiangxibt btFunc end

--@auto button backcall end


--@auto code view display func
function SelectHeroViewController:onCreate()
    Functions.printInfo(self.debug_b," SelectHeroViewController controller create!")
end

function SelectHeroViewController:onChangeView()
    -- body
end
function SelectHeroViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
function SelectHeroViewController:onDisplayView()
	Functions.printInfo(self.debug_b," SelectHeroViewController view enter display!")
    --新手引导相关


    --新手引导相关
    -- Functions.bindMGSDisplay({moneyObj = self._coinText_t,goldObj = self._goldText_t,soulObj = self._soulText_t})
    Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})
    self:initUiDisplay_()   
    Functions.bindEventListener(self.view_t, GameEventCenter, HeroCardData.CARDS_DATA_CHANGE_EVENT, function ( )
        self:initUiDisplay_()   
    end)
end
--对英雄过滤处理函数
function SelectHeroViewController:filterHandler(heroData)
    local filterData = {}
    for i=1,#heroData do
        local bigClass = Functions.formatHeroClass(heroData[i].m_class)
        if bigClass > 1 then
            filterData[#filterData+1] =  heroData[i]
        end
    end
    return filterData
end
function SelectHeroViewController:showHeroCard(getheroDataFunc)
    local Card = nil
    if self.jumpType == JumpType.SevenStarToSelectHero then
        Card = getheroDataFunc(handler(self,self.filterHandler))
        if table.nums(Card) < 1 then 
            self._tips_t:setVisible(true)
        else
            self._tips_t:setVisible(false)
        end
    elseif self.jumpType == JumpType.MainCityToSelectHero then
         Card = getheroDataFunc(handler(HeroCardData,HeroCardData.getTaskCard))
    elseif self.jumpType == JumpType.ExpChangeToSelectHero then
         Card = getheroDataFunc(handler(HeroCardData,HeroCardData.getExpCard))
    else
         Card = getheroDataFunc()
    end
    self:showCard(Card)
end
function SelectHeroViewController:initUiDisplay_()
    self:showView()
    HeroCardData:card_sort()
    local _Card = HeroCardData:getAllHeroData()
    if _Card == nil or #_Card < 1 then

        PromptManager:openTipPrompt(LanguageConfig.language_selectHero_5)
        GameCtlManager:pop(self)
    end
--    self:showHeroCard(handler(HeroCardData,HeroCardData.getAllHeroData))
        --添加标签页监听
    local tableListener = function(target)
        if target == "Panel_all" then
            self:showHeroCard(handler(HeroCardData,HeroCardData.getAllHeroData))
        elseif target == "Panel_li" then
            self:showHeroCard(handler(HeroCardData,HeroCardData.getliHeroData))     
        elseif target == "Panel_mou" then
            self:showHeroCard(handler(HeroCardData,HeroCardData.getMouHeroData)) 
        elseif target == "Panel_shu" then
            self:showHeroCard(handler(HeroCardData,HeroCardData.getShuHeroData)) 
        elseif target == "Panel_yi" then
            self:showHeroCard(handler(HeroCardData,HeroCardData.getYiHeroData))
        end
    end
    Functions.initTabComWithSimple({widget = self._table_t ,listener = tableListener,firstName = "Panel_all"})
    -- if self.jumpType == JumpType.SevenStarToSelectHero or self.jumpType == JumpType.MainCityToSelectHero then
    --     -- self._shangzhenBt_t:getChildByName("buttonText"):setString("确定")
    --     Functions.loadImageWithWidget(self._shangzhenBt_t:getChildByName("buttonText"),"tyj/uiFonts_res/xuanze.png")
    -- else
    --     Functions.loadImageWithWidget(self._shangzhenBt_t:getChildByName("buttonText"),"tyj/uiFonts_res/sz.png")
    -- end
    -- body
end
--@auto code view display func end
function SelectHeroViewController:showCard(_Card)
    Functions.printInfo(self.debug_b,"showCard")   
    
    if _Card and #_Card > 0 then
       
        if self.jumpData.heroType == 0 then 
            if EmbattleData.MainHeroMark ~= 0 then 
               self.selectedHeroData = HeroCardData:getHeroInfo(EmbattleData.MainHeroMark)
            else
               self.selectedHeroData = _Card[1] 
            end
        elseif self.jumpData.heroType == 1 then 
            if EmbattleData.ViceHero1Mark ~= 0 then 
               self.selectedHeroData = HeroCardData:getHeroInfo(EmbattleData.ViceHero1Mark)
            else
               self.selectedHeroData = _Card[1] 
            end
        elseif self.jumpData.heroType == 2 then 
            if EmbattleData.ViceHero2Mark ~= 0 then 
               self.selectedHeroData = HeroCardData:getHeroInfo(EmbattleData.ViceHero2Mark)
            else
               self.selectedHeroData = _Card[1] 
            end
        else
            self.selectedHeroData = _Card[1] 
        end
        self:displayHeroInf(self._heroPanel_t,self.selectedHeroData.m_mark)
        self.heroMark = self.selectedHeroData.m_mark
        self.heroId = self.selectedHeroData.m_id
       
         local selectedFlag = 0  
         local listHandler = function(index, widget, model, data)
             widget.index = index
             widget:setTouchEnabled(true)
             widget:getChildByName("heroView"):setTouchEnabled(false)
             widget:setSwallowTouches(false)
             if self.selectedHeroData == data and selectedFlag == 0 then
                 Functions.showHeroHead(widget,data,true)
                 selectedFlag = index
             elseif selectedFlag == index then
                Functions.showHeroHead(widget,data,true)   
             else
                 Functions.showHeroHead(widget,data,false)
             end
            Functions.bindEventListener(widget,GameEventCenter,"HERO_CANCAL_SELECTED_EVENT",function() 
                if selectedFlag == widget.index  then             
                    Functions.setHeroHeadSelected(widget,false) 
                end
             end)
             local onWidgetClick = function(event)
                 if selectedFlag ~= index then 
                    GameEventCenter:dispatchEvent({ name = "HERO_CANCAL_SELECTED_EVENT"})
                 end
                 Functions.setHeroHeadSelected(widget,true) 
                 selectedFlag = index
                 self:displayHeroInf(self._heroPanel_t,data.m_mark)
                 self.heroId = data.m_id 
                 self.heroMark = data.m_mark
                 self.selectedHeroData = data
             end
             --新手引导相关
             if index == 1 then
                 self._hero1Bt_t = widget
             end
             if index == 2 then 
                 self._hero2Bt_t = widget
             end
             if data.m_atkFormFlagTemp == 0 then 
                 self._hero4Bt_t = widget
             end
             --end
             widget:onTouch(Functions.createTableViewClickListener(self._tableContainer_t,onWidgetClick,"movedis"))
         end
--         --绑定响应事件函数
        self._heroPanel_t:setVisible(true)
        self._tableContainer_t:setVisible(false)
         -- self._heroListView_t:setVisible(true)
         self._shangzhenBt_t:setVisible(true)
         self._xiangxiBt_t:setVisible(true)
        -- Functions.bindArryListWithData(self._heroListView_t,{ firstData = _Card }, listHandler,{direction = true, col = 4, firstSegment = 0, segment = 6 })
        local romveNodeHandler = function(widget)
            Functions.removeEventBeforeUiClean(widget)
        end
        Functions.bindTableViewWithData(self._tableContainer_t,{ firstData = _Card },{handler = listHandler,romveNodeHandler = romveNodeHandler},{direction = true, col = 4, firstSegment = 0, segment = 6 })
       
    else
        self._heroPanel_t:setVisible(false)
        self._tableContainer_t:setVisible(false)
--        self._heroListView_t:setVisible(false)
        self._shangzhenBt_t:setVisible(false)
        self._xiangxiBt_t:setVisible(false)
    end
    
end
--显示英雄详情
function SelectHeroViewController:displayHeroInf(target,mark)
    local heroInf = HeroCardData:searchHeroOfMark(mark)
    local id = heroInf.m_id
    local nameView = target:getChildByName("name")
    nameView:setString("LV." .. heroInf.m_level .. ConfigHandler:getHeroNameOfId(id))
    nameView:setVisible(true)

    local star = ConfigHandler:getHeroStarOfId(id) 
    
    local heroView = target:getChildByName("heroView")
    if star > 5 then 
        local bigClass = Functions.formatHeroClass(heroInf.m_class)
        local heroImg = ConfigHandler:getHeroCardImageOfId(id,bigClass)
        local heroImgTemp = string.split(heroImg,".png")
        Functions.loadImageWithSprite(heroView,heroImgTemp[1] .. "_N.png")
    else
        local heroImg = ConfigHandler:getHeroCardImageOfId(id)
        Functions.loadImageWithSprite(heroView,heroImg)
    end
    heroView:setVisible(true)
    if star > 5 then
        UIActionTool:playPopAction({ target = heroView, beginScale = 0.15, endScale = 0.6, maxScale = 0.8, time = 0.15}) 
    else
        UIActionTool:playPopAction({ target = heroView, beginScale = 0.15, endScale = 0.5, maxScale = 0.6, time = 0.15}) 
    end
   -- local heroAtrr = {math.floor(heroInf.m_baseCombat),math.floor(heroInf.m_baseAttack),math.floor(heroInf.m_baseHp),math.floor(heroInf.m_baseSoldier),math.floor(heroInf.m_baseMp),ConfigHandler:getHeroZxNameOfId(id)}
    local total = cs_GetCardFightValue({heroInfo=HeroCardData:packageHeroAttr( mark )})
    local wuli = ConfigHandler:getHeroWuliId(id)
    local zhili = ConfigHandler:getHeroZhiliId(id)
    local tongyu = ConfigHandler:getHeroTongyuId(id)
    local heroAttr = {total,wuli,zhili,tongyu,ConfigHandler:getHeroZxNameOfId(id)}
    for i=1,5 do
        local lab = target:getChildByTag(i)
        lab:setString(tostring(heroAttr[i]))
        lab:setVisible(true)
    end
end

function SelectHeroViewController:isSameHeroId(heroId)
    local isSameHero = false 

    if EmbattleData.EmbattleInf.MainHero[1] ~= nil and EmbattleData.EmbattleInf.MainHero[1].id == heroId  and self.heroMark ~= EmbattleData.MainHeroMark then 
        isSameHero = true
    elseif EmbattleData.EmbattleInf.ViceHeros[1] ~= nil and EmbattleData.EmbattleInf.ViceHeros[1].id == self.heroId and self.heroMark ~= EmbattleData.ViceHero1Mark then
        isSameHero = true
    
    elseif EmbattleData.EmbattleInf.ViceHeros[2] ~= nil and EmbattleData.EmbattleInf.ViceHeros[2].id == self.heroId and self.heroMark ~= EmbattleData.ViceHero2Mark then
        isSameHero = true
    else
        for k,v in pairs(EmbattleData.EmbattleInf.PartHero) do
            if v ~= nil and v.id == heroId and self.heroMark ~= EmbattleData.PartHeroMark[k] then
                isSameHero = true
            end
        end
    end
    return isSameHero
end
function SelectHeroViewController:shangZhengHero(heroType) 
    -- self.parentController:closeChildController(self,{jumpType = self.jumpType,jumpData = {heroType = heroType ,heroId = self.heroId}})
    if not self:isSameHeroId(self.heroId) then
        if self.jumpType == JumpType.EmbattleToSelectHero then

            if heroType == HeroType.MainHero then
                local shangzhenType = self:getShangzhenType(self.heroId)    

                if shangzhenType > 0 then
                    NoticeManager:openTips(self, {title = self:getTipsOfShangzhenType(shangzhenType),handler = function()  
                        self:clearShangzhenHero(shangzhenType)                      
                        if EmbattleData.EmbattleInf.MainHero[1] ~= nil and EmbattleData.EmbattleInf.MainHero[1].id > 0 then
                            self:setHeroState(EmbattleData.MainHeroMark,0,self.jumpData.embattleType)
                            EmbattleData.EmbattleInf.MainHero[1].id = self.heroId
                            EmbattleData.MainHeroMark = self.heroMark
                            EmbattleData.EmbattleInf.Soldiers = {}
                        else
                            EmbattleData.EmbattleInf.MainHero[1] = {id = self.heroId}
                            EmbattleData.MainHeroMark = self.heroMark    
                        end
                        self:setHeroState(EmbattleData.MainHeroMark,1,self.jumpData.embattleType)
                        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                        Functions.playSound("changeHeroes.mp3") 
                    end})  
                else
                    self:clearShangzhenHero(shangzhenType)
                    if EmbattleData.EmbattleInf.MainHero[1] ~= nil and EmbattleData.EmbattleInf.MainHero[1].id > 0 then
                        self:setHeroState(EmbattleData.MainHeroMark,0,self.jumpData.embattleType)
                        EmbattleData.EmbattleInf.MainHero[1].id = self.heroId
                        EmbattleData.MainHeroMark = self.heroMark
                        EmbattleData.EmbattleInf.Soldiers = {}
                    else
                        EmbattleData.EmbattleInf.MainHero[1] = {id = self.heroId}
                        EmbattleData.MainHeroMark = self.heroMark    
                    end
                    self:setHeroState(EmbattleData.MainHeroMark,1,self.jumpData.embattleType)
                    GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                    Functions.playSound("changeHeroes.mp3") 
                end 
            elseif heroType == HeroType.ViceHero1 then
                local shangzhenType = self:getShangzhenType(self.heroId)
                if shangzhenType ~= 1 then                    
                    if shangzhenType > 0 then
                        NoticeManager:openTips(self, {title = self:getTipsOfShangzhenType(shangzhenType),handler = function() 
                            self:clearShangzhenHero(shangzhenType) 
                            if EmbattleData.EmbattleInf.ViceHeros[1] ~= nil and EmbattleData.EmbattleInf.ViceHeros[1].id > 0 then
                                self:setHeroState(EmbattleData.ViceHero1Mark,0,self.jumpData.embattleType)
                                EmbattleData.EmbattleInf.ViceHeros[1].id = self.heroId
                                EmbattleData.ViceHero1Mark = self.heroMark
                            else
                                EmbattleData.EmbattleInf.ViceHeros[1] = {id = self.heroId} 
                                EmbattleData.ViceHero1Mark = self.heroMark
                            end
                            self:setHeroState(EmbattleData.ViceHero1Mark,2,self.jumpData.embattleType)
                            GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                            Functions.playSound("changeHeroes.mp3") 
                        end})  
                    else    
                        self:clearShangzhenHero(shangzhenType)
                        if EmbattleData.EmbattleInf.ViceHeros[1] ~= nil and EmbattleData.EmbattleInf.ViceHeros[1].id > 0 then
                            self:setHeroState(EmbattleData.ViceHero1Mark,0,self.jumpData.embattleType)
                            EmbattleData.EmbattleInf.ViceHeros[1].id = self.heroId
                            EmbattleData.ViceHero1Mark = self.heroMark
                        else
                            EmbattleData.EmbattleInf.ViceHeros[1] = {id = self.heroId} 
                            EmbattleData.ViceHero1Mark = self.heroMark
                        end
                        self:setHeroState(EmbattleData.ViceHero1Mark,2,self.jumpData.embattleType)
                        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                        Functions.playSound("changeHeroes.mp3") 
                    end
                else
                    PromptManager:openTipPrompt(self:getTipsOfShangzhenType(shangzhenType))
                end
            elseif heroType == HeroType.ViceHero2 then
                local shangzhenType = self:getShangzhenType(self.heroId)
                if shangzhenType ~= 1 then                    
                    if shangzhenType > 0 then
                        NoticeManager:openTips(self, {title = self:getTipsOfShangzhenType(shangzhenType),handler = function()
                            self:clearShangzhenHero(shangzhenType)
                            if EmbattleData.EmbattleInf.ViceHeros[2] ~= nil and EmbattleData.EmbattleInf.ViceHeros[2].id > 0 then
                                self:setHeroState(EmbattleData.ViceHero2Mark,0,self.jumpData.embattleType)
                                EmbattleData.EmbattleInf.ViceHeros[2].id = self.heroId
                                EmbattleData.ViceHero2Mark = self.heroMark
                            else
                                EmbattleData.EmbattleInf.ViceHeros[2] = {id = self.heroId} 
                                EmbattleData.ViceHero2Mark = self.heroMark
                            end
                            self:setHeroState(EmbattleData.ViceHero2Mark,3,self.jumpData.embattleType)
                            GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                            Functions.playSound("changeHeroes.mp3") 
                        end})   
                    else 
                        self:clearShangzhenHero(shangzhenType)   
                        if EmbattleData.EmbattleInf.ViceHeros[2] ~= nil and EmbattleData.EmbattleInf.ViceHeros[2].id > 0 then
                            self:setHeroState(EmbattleData.ViceHero2Mark,0,self.jumpData.embattleType)
                            EmbattleData.EmbattleInf.ViceHeros[2].id = self.heroId
                            EmbattleData.ViceHero2Mark = self.heroMark
                        else
                            EmbattleData.EmbattleInf.ViceHeros[2] = {id = self.heroId} 
                            EmbattleData.ViceHero2Mark = self.heroMark
                        end
                        self:setHeroState(EmbattleData.ViceHero2Mark,3,self.jumpData.embattleType)
                        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                        Functions.playSound("changeHeroes.mp3") 
                    end
                else
                    PromptManager:openTipPrompt(self:getTipsOfShangzhenType(shangzhenType))
                end
            end

            -- end
        elseif self.jumpType == JumpType.PartHeroToSelectHero then
            -- if self:isShangzhen(self.heroId) then
            if heroType == HeroType.PartHero1 then
                local shangzhenType = self:getShangzhenType(self.heroId)
                if shangzhenType ~= 1 then                    
                    if shangzhenType > 0 then
                        NoticeManager:openTips(self, {title = self:getTipsOfShangzhenType(shangzhenType),handler = function()
                            self:clearShangzhenHero(shangzhenType)
                            if EmbattleData.EmbattleInf.PartHero[1] ~= nil then
                                self:setHeroState(EmbattleData.PartHeroMark[1],0,self.jumpData.embattleType)
                                EmbattleData.EmbattleInf.PartHero[1].id = self.heroId
                                EmbattleData.PartHeroMark[1] = self.heroMark
                            else
                                EmbattleData.EmbattleInf.PartHero[1] = {id = self.heroId} 
                                EmbattleData.PartHeroMark[1] = self.heroMark
                            end
                            self:setHeroState(EmbattleData.PartHeroMark[1],4,self.jumpData.embattleType)
                            GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                            Functions.playSound("changeHeroes.mp3") 
                        end})   
                    else    
                        self:clearShangzhenHero(shangzhenType)
                        if EmbattleData.EmbattleInf.PartHero[1] ~= nil then
                            self:setHeroState(EmbattleData.PartHeroMark[1],0,self.jumpData.embattleType)
                            EmbattleData.EmbattleInf.PartHero[1].id = self.heroId
                            EmbattleData.PartHeroMark[1] = self.heroMark
                        else
                            EmbattleData.EmbattleInf.PartHero[1] = {id = self.heroId} 
                            EmbattleData.PartHeroMark[1] = self.heroMark
                        end
                        self:setHeroState(EmbattleData.PartHeroMark[1],4,self.jumpData.embattleType)
                        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                        Functions.playSound("changeHeroes.mp3") 
                    end
                else
                    PromptManager:openTipPrompt(self:getTipsOfShangzhenType(shangzhenType))
                end

            elseif heroType == HeroType.PartHero2 then
                local shangzhenType = self:getShangzhenType(self.heroId)
                if shangzhenType ~= 1 then                    
                    if shangzhenType > 0 then
                        NoticeManager:openTips(self, {title = self:getTipsOfShangzhenType(shangzhenType),handler = function()
                            self:clearShangzhenHero(shangzhenType)
                            if EmbattleData.EmbattleInf.PartHero[2] ~= nil then
                                self:setHeroState(EmbattleData.PartHeroMark[2],0,self.jumpData.embattleType)
                                EmbattleData.EmbattleInf.PartHero[2].id = self.heroId
                                EmbattleData.PartHeroMark[2] = self.heroMark
                            else
                                EmbattleData.EmbattleInf.PartHero[2] = {id = self.heroId} 
                                EmbattleData.PartHeroMark[2] = self.heroMark
                            end
                            self:setHeroState(EmbattleData.PartHeroMark[2],5,self.jumpData.embattleType)
                            GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                            Functions.playSound("changeHeroes.mp3") 
                        end})   
                    else   
                        self:clearShangzhenHero(shangzhenType) 
                        if EmbattleData.EmbattleInf.PartHero[2] ~= nil then
                            self:setHeroState(EmbattleData.PartHeroMark[2],0,self.jumpData.embattleType)
                            EmbattleData.EmbattleInf.PartHero[2].id = self.heroId
                            EmbattleData.PartHeroMark[2] = self.heroMark
                        else
                            EmbattleData.EmbattleInf.PartHero[2] = {id = self.heroId} 
                            EmbattleData.PartHeroMark[2] = self.heroMark
                        end
                        self:setHeroState(EmbattleData.PartHeroMark[2],5,self.jumpData.embattleType)
                        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                        Functions.playSound("changeHeroes.mp3") 
                    end
                else
                    PromptManager:openTipPrompt(self:getTipsOfShangzhenType(shangzhenType))
                end

            elseif heroType == HeroType.PartHero3 then
                local shangzhenType = self:getShangzhenType(self.heroId)
                if shangzhenType ~= 1 then                    
                    if shangzhenType > 0 then
                        NoticeManager:openTips(self, {title = self:getTipsOfShangzhenType(shangzhenType),handler = function()
                            self:clearShangzhenHero(shangzhenType)
                            if EmbattleData.EmbattleInf.PartHero[3] ~= nil then
                                self:setHeroState(EmbattleData.PartHeroMark[3],0,self.jumpData.embattleType)
                                EmbattleData.EmbattleInf.PartHero[3].id = self.heroId
                                EmbattleData.PartHeroMark[3] = self.heroMark
                            else
                                EmbattleData.EmbattleInf.PartHero[3] = {id = self.heroId} 
                                EmbattleData.PartHeroMark[3] = self.heroMark
                            end
                            self:setHeroState(EmbattleData.PartHeroMark[3],6,self.jumpData.embattleType)
                            GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                            Functions.playSound("changeHeroes.mp3") 
                        end})   
                    else    
                        self:clearShangzhenHero(shangzhenType)
                        if EmbattleData.EmbattleInf.PartHero[3] ~= nil then
                            self:setHeroState(EmbattleData.PartHeroMark[3],0,self.jumpData.embattleType)
                            EmbattleData.EmbattleInf.PartHero[3].id = self.heroId
                            EmbattleData.PartHeroMark[3] = self.heroMark
                        else
                            EmbattleData.EmbattleInf.PartHero[3] = {id = self.heroId} 
                            EmbattleData.PartHeroMark[3] = self.heroMark
                        end
                        self:setHeroState(EmbattleData.PartHeroMark[3],6,self.jumpData.embattleType)
                        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                        Functions.playSound("changeHeroes.mp3") 
                    end
                else
                    PromptManager:openTipPrompt(self:getTipsOfShangzhenType(shangzhenType))
                end

            elseif heroType == HeroType.PartHero4 then
                local shangzhenType = self:getShangzhenType(self.heroId)
                if shangzhenType ~= 1 then

                    if shangzhenType > 0 then
                        NoticeManager:openTips(self, {title = self:getTipsOfShangzhenType(shangzhenType),handler = function()
                            self:clearShangzhenHero(shangzhenType)
                            if EmbattleData.EmbattleInf.PartHero[4] ~= nil then
                                self:setHeroState(EmbattleData.PartHeroMark[4],0,self.jumpData.embattleType)
                                EmbattleData.EmbattleInf.PartHero[4].id = self.heroId
                                EmbattleData.PartHeroMark[4] = self.heroMark
                            else
                                EmbattleData.EmbattleInf.PartHero[4] = {id = self.heroId} 
                                EmbattleData.PartHeroMark[4] = self.heroMark
                            end
                            self:setHeroState(EmbattleData.PartHeroMark[4],7,self.jumpData.embattleType)
                            GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                        end})   
                    else    
                        self:clearShangzhenHero(shangzhenType)
                        if EmbattleData.EmbattleInf.PartHero[4] ~= nil then
                            self:setHeroState(EmbattleData.PartHeroMark[4],0,self.jumpData.embattleType)
                            EmbattleData.EmbattleInf.PartHero[4].id = self.heroId
                            EmbattleData.PartHeroMark[4] = self.heroMark
                        else
                            EmbattleData.EmbattleInf.PartHero[4] = {id = self.heroId} 
                            EmbattleData.PartHeroMark[4] = self.heroMark
                        end
                        self:setHeroState(EmbattleData.PartHeroMark[4],7,self.jumpData.embattleType)
                        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                        Functions.playSound("changeHeroes.mp3") 
                    end
                else
                    PromptManager:openTipPrompt(self:getTipsOfShangzhenType(shangzhenType))
                end

            elseif heroType == HeroType.PartHero5 then
                local shangzhenType = self:getShangzhenType(self.heroId)
                if shangzhenType ~= 1 then

                    if shangzhenType > 0 then
                        NoticeManager:openTips(self, {title = self:getTipsOfShangzhenType(shangzhenType),handler = function() 
                            self:clearShangzhenHero(shangzhenType)
                            if EmbattleData.EmbattleInf.PartHero[5] ~= nil then
                                self:setHeroState(EmbattleData.PartHeroMark[5],0,self.jumpData.embattleType)
                                EmbattleData.EmbattleInf.PartHero[5].id = self.heroId
                                EmbattleData.PartHeroMark[5] = self.heroMark
                            else
                                EmbattleData.EmbattleInf.PartHero[5] = {id = self.heroId} 
                                EmbattleData.PartHeroMark[5] = self.heroMark
                            end
                            self:setHeroState(EmbattleData.PartHeroMark[5],8,self.jumpData.embattleType)
                            GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                            Functions.playSound("changeHeroes.mp3") 
                        end})   
                    else    
                        self:clearShangzhenHero(shangzhenType)
                        if EmbattleData.EmbattleInf.PartHero[5] ~= nil then
                            self:setHeroState(EmbattleData.PartHeroMark[5],0,self.jumpData.embattleType)
                            EmbattleData.EmbattleInf.PartHero[5].id = self.heroId
                            EmbattleData.PartHeroMark[5] = self.heroMark
                        else
                            EmbattleData.EmbattleInf.PartHero[5] = {id = self.heroId} 
                            EmbattleData.PartHeroMark[5] = self.heroMark
                        end
                        self:setHeroState(EmbattleData.PartHeroMark[5],8,self.jumpData.embattleType)
                        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                        Functions.playSound("changeHeroes.mp3") 
                    end
                else
                    PromptManager:openTipPrompt(self:getTipsOfShangzhenType(shangzhenType))
                end

            elseif heroType == HeroType.PartHero6 then
                local shangzhenType = self:getShangzhenType(self.heroId)
                if shangzhenType ~= 1 then

                    if shangzhenType > 0 then
                        NoticeManager:openTips(self, {title = self:getTipsOfShangzhenType(shangzhenType),handler = function()
                            self:clearShangzhenHero(shangzhenType)--清除选中武将的上阵标示
                            if EmbattleData.EmbattleInf.PartHero[6] ~= nil then
                                self:setHeroState(EmbattleData.PartHeroMark[6],0,self.jumpData.embattleType)--设置将要被替换武将的标志
                                EmbattleData.EmbattleInf.PartHero[6].id = self.heroId
                                EmbattleData.PartHeroMark[6] = self.heroMark
                            else
                                EmbattleData.EmbattleInf.PartHero[6] = {id = self.heroId} 
                                EmbattleData.PartHeroMark[6] = self.heroMark
                            end
                            self:setHeroState(EmbattleData.PartHeroMark[6],9,self.jumpData.embattleType) 
                            GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                            Functions.playSound("changeHeroes.mp3") 
                        end})   
                    else    
                        self:clearShangzhenHero(shangzhenType)--清除选中武将的上阵标示
                        if EmbattleData.EmbattleInf.PartHero[6] ~= nil then
                            self:setHeroState(EmbattleData.PartHeroMark[6],0,self.jumpData.embattleType)
                            EmbattleData.EmbattleInf.PartHero[6].id = self.heroId
                            EmbattleData.PartHeroMark[6] = self.heroMark
                        else
                            EmbattleData.EmbattleInf.PartHero[6] = {id = self.heroId} 
                            EmbattleData.PartHeroMark[6] = self.heroMark
                        end
                        self:setHeroState(EmbattleData.PartHeroMark[6],9,self.jumpData.embattleType)
                        GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = self.jumpData}})
                        Functions.playSound("changeHeroes.mp3") 
                    end
                else
                    PromptManager:openTipPrompt(self:getTipsOfShangzhenType(shangzhenType))
                end

            end 
            -- end        
        end
    else
        PromptManager:openTipPrompt(LanguageConfig.language_selectHero_9)
    end
end

function  SelectHeroViewController:setHeroState( mark,zxType,zxMode)
    local heroInf =  HeroCardData:searchHeroOfMark(mark)
    if heroInf ~= nil then
        if zxMode == 1 then
            heroInf.m_atkFormFlagTemp = zxType
        elseif zxMode == 2 then
            heroInf.m_defFormFlagTemp = zxType
        end
    end
end
--更加武将上阵类型获得提示
function SelectHeroViewController:getTipsOfShangzhenType( shangzhenType )
    local str = ""
    if shangzhenType == 1 then 
        str = LanguageConfig.language_selectHero_8 
    elseif shangzhenType == 2 then 
        str = string.format(LanguageConfig.language_selectHero_7,LanguageConfig.language_selectHero_3 .. "1")  
    elseif shangzhenType == 3 then
        str = string.format(LanguageConfig.language_selectHero_7,LanguageConfig.language_selectHero_3 .. "2")  
    elseif  shangzhenType > 3 then
         str = string.format(LanguageConfig.language_selectHero_7,LanguageConfig.language_selectHero_4 .. tostring(shangzhenType-3))
    end
   return str
end
--根据上阵类型清除上阵武将
function SelectHeroViewController:clearShangzhenHero(shangzhenType )
    if shangzhenType == 1 then 
        self:setHeroState(EmbattleData.MainHeroMark,0,self.jumpData.embattleType)
        EmbattleData.EmbattleInf.MainHero[1] = nil
        EmbattleData.MainHeroMark = 0
    elseif shangzhenType == 2 then
        self:setHeroState(EmbattleData.ViceHero1Mark,0,self.jumpData.embattleType)
        EmbattleData.EmbattleInf.ViceHeros[1] = nil
        EmbattleData.ViceHero1Mark = 0
    elseif shangzhenType == 3 then
        self:setHeroState(EmbattleData.ViceHero2Mark,0,self.jumpData.embattleType)
        EmbattleData.EmbattleInf.ViceHeros[2] = nil
        EmbattleData.ViceHero2Mark = 0
    elseif  shangzhenType > 3 then         
        self:setHeroState(EmbattleData.PartHeroMark[shangzhenType-3],0,self.jumpData.embattleType)
        EmbattleData.EmbattleInf.PartHero[shangzhenType-3] = {id=0}
        EmbattleData.PartHeroMark[shangzhenType-3] = 0

    end 
end
--获得上阵类型，0 为未上阵，1~9 对应主将~最后一个偏将
function SelectHeroViewController:getShangzhenType(heroId)
    local getShangzhenType = 0
    if EmbattleData.EmbattleInf.MainHero[1] ~= nil and EmbattleData.EmbattleInf.MainHero[1].id > 0 then
	    if  EmbattleData.EmbattleInf.MainHero[1].id == heroId then
           getShangzhenType = 1
	       -- PromptManager:openTipPrompt(string.format(LanguageConfig.language_selectHero_1,LanguageConfig.language_selectHero_2))
	       return getShangzhenType   
        end
	end
    if EmbattleData.EmbattleInf.ViceHeros[1] ~= nil and EmbattleData.EmbattleInf.ViceHeros[1].id > 0 then
	   if EmbattleData.EmbattleInf.ViceHeros[1].id == heroId then
            -- PromptManager:openTipPrompt(string.format(LanguageConfig.language_selectHero_1,LanguageConfig.language_selectHero_3 .. tostring(1)))
            getShangzhenType = 2
       return getShangzhenType          
       end
    end
    if EmbattleData.EmbattleInf.ViceHeros[2] ~= nil and EmbattleData.EmbattleInf.ViceHeros[2].id > 0 then
        if EmbattleData.EmbattleInf.ViceHeros[2].id == heroId then
            getShangzhenType = 3
            -- PromptManager:openTipPrompt(string.format(LanguageConfig.language_selectHero_1,LanguageConfig.language_selectHero_3 .. tostring(2)))
        end
    end
    for i= 1,6 do
        if EmbattleData.EmbattleInf.PartHero[i] ~= nil and EmbattleData.EmbattleInf.PartHero[i].id > 0 then
            if EmbattleData.EmbattleInf.PartHero[i].id == heroId then
                getShangzhenType = 3 + i 
                -- PromptManager:openTipPrompt(string.format(LanguageConfig.language_selectHero_1,LanguageConfig.language_selectHero_4 .. tostring(i)))
                return getShangzhenType   
            end 
        end
    end
    return getShangzhenType
end
function SelectHeroViewController:onReceivePushData(jump)
    self.jumpType = jump.jumpType
    self.jumpData = jump.jumpData 
end
return SelectHeroViewController