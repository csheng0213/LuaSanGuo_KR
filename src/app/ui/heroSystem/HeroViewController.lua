--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local HeroViewController = class("HeroViewController", BaseViewController)

local Functions = require("app.common.Functions")

HeroViewController.debug = true
HeroViewController.modulePath = ...
HeroViewController.studioSpriteFrames = {"HeroUI_Text","CB_bgup","CB_blackbg" }
--@auto code head end

local HeroCardData = require("app.gameData.HeroCardData")
local CardModel = require("app.ui.heroSystem.CardModel")
local PokedexData = require("app.gameData.PokedexData")



--@Pre loading
HeroViewController.spriteFrameNames = 
    {
        "headPilistRes", "CC_comHead"
    }

HeroViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #HeroViewController.studioSpriteFrames > 0 then
    HeroViewController.spriteFrameNames = HeroViewController.spriteFrameNames or {}
    table.insertto(HeroViewController.spriteFrameNames, HeroViewController.studioSpriteFrames)
end
function HeroViewController:onDidLoadView()

    --output list
    self._Text_hero_num_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Text_hero_num")
	self._resNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("resNode")
	self._Image_sell_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_10"):getChildByName("Button_sell"):getChildByName("Image_sell_1")
	self._Image_sell_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_10"):getChildByName("Button_sell"):getChildByName("Image_sell_2")
	self._Panel_sell_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_sell")
	self._Text_money_sell_num_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_sell"):getChildByName("Image_money_sell"):getChildByName("Text_money_sell_num")
	self._Panel_all_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_all")
	self._Panel_li_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_li")
	self._Panel_mou_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_mou")
	self._Panel_shu_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_shu")
	self._Panel_yi_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_yi")
	self._Panel_hero_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_hero")
	
    --label list
    
    --button list
    self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

	self._Button_help_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_help")
	self._Button_help_t:onTouch(Functions.createClickListener(handler(self, self.onButton_helpClick), "zoom"))

	self._Button_sell_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_10"):getChildByName("Button_sell")
	self._Button_sell_t:onTouch(Functions.createClickListener(handler(self, self.onButton_sellClick), "zoom"))

	self._Button_Pokedex_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_10"):getChildByName("Button_Pokedex")
	self._Button_Pokedex_t:onTouch(Functions.createClickListener(handler(self, self.onButton_pokedexClick), "zoom"))

	self._Button_Selected_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_sell"):getChildByName("Button_Selected_1")
	self._Button_Selected_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_selected_1Click), "zoom"))

	self._Button_ok_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_sell"):getChildByName("Button_ok")
	self._Button_ok_t:onTouch(Functions.createClickListener(handler(self, self.onButton_okClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function HeroViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
    if EnhanceData.HeroShowType == 0 then
        for k,v in pairs(self.sell_Card) do 
            if v.seleceted ~= nil then
                v.seleceted = nil 
            end
        end
        if self.sellState == true then
            self._Button_sell_t:setVisible(true)
            self._Button_Pokedex_t:setVisible(true)
            self._Panel_sell_t:setVisible(false)
            self.sellState = false
            --排序
            HeroCardData:card_fen_zhu()
            HeroCardData:card_sort()
            self:sellShow()
            self:showCard(self._Card)
            self.sellMoney = 0
            self.sellSoul = 0
            self._Text_money_sell_num_t:setText(tostring(self.sellMoney))
        else
            GameCtlManager:pop(self)
        end
        
    elseif EnhanceData.HeroShowType == 2 or EnhanceData.HeroShowType == 4 then--(2，4为加副卡)
        
        --删除现在武将的选中状态
        local pppppp = self._Card
        for k,v in pairs(self._Card) do 
            if v.seleceted ~= nil then
                v.seleceted = nil 
            end
        end
        --武将背包数据中加入主卡

        HeroCardData:addCardData(EnhanceData.MasterData)
        if self.PickSacrifice then
            EnhanceData.DeputyData = {}
        else
            GameEventCenter:dispatchEvent({ name = EnhanceData.ENHANCE_SHENG_JI_FU, data = data })
        end
        
        GameCtlManager:pop(self, { data = nil })
    elseif EnhanceData.HeroShowType == 1 or EnhanceData.HeroShowType == 3 then--(1，3为加主卡)
        GameCtlManager:pop(self, { data = nil })
    end
end
--@auto code Button_back btFunc end

--@auto code Button_sell btFunc
function HeroViewController:onButton_sellClick()
    Functions.printInfo(self.debug,"Button_sell button is click!")
    if EnhanceData.HeroShowType == 2 then
        --武将背包数据中加入主卡
        HeroCardData:addCardData(EnhanceData.MasterData)
        --数据更新监听
        GameEventCenter:dispatchEvent({ name = EnhanceData.ENHANCE_SHENG_JI_FU, data = data })
        GameCtlManager:pop(self, { data = EnhanceData.DeputyData })
    else
        self._Button_ok_t:setVisible(true)
        self._Button_Pokedex_t:setVisible(false)
        self._Button_sell_t:setVisible(false)
        self._Panel_sell_t:setVisible(true)
        
        --出售状态
        self.sellState = true
        --排序（倒序）
        HeroCardData:sortReverse()
        local reverseCard = HeroCardData:getAllHeroData()
        --准备出售卡
        self.sell_Card = HeroCardData:getWillSellHeroData(reverseCard)
        --选择的祭品武将不能在退回武将界面后，出售时还是选中状态（所以在出售前先把所有状态清空）
        for k, v in pairs(self.sell_Card) do
            if nil ~= v.seleceted then
                v.seleceted = false
            end
        end
        --没上阵的卡才能显示
        self:showCard(self.sell_Card)
    end
end
--@auto code Button_sell btFunc end

--@auto code Button_selected_1 btFunc
function HeroViewController:onButton_selected_1Click()
    Functions.printInfo(self.debug,"Button_selected_1 button is click!")
    --self:dispatchEvent({ name = CardModel.HERO_SELECT_EVENT })

    for k, v in pairs(self.sell_Card) do
        local ppp = ConfigHandler:getHeroStarCountOfId(v.m_id)
        if ConfigHandler:getHeroStarCountOfId(v.m_id) <= 3 then --3星及以内的全部可以选中
            v.seleceted = true
            self.sell_Card[k]:seleckHero()
            
            local selected = true
            
                        --if nil ~= data.seleceted then 
            for y, j in pairs(self.sellTable) do --self.sellTable
                if v.m_mark == j.m_mark then
                  selected = false
              end
            end
                        --end
            if selected then
                self:sellCardMoney(v, 1)
                self.sellTable[#self.sellTable+1] = v
            end
            --self.sellTable[#self.sellTable+1] = v
            --if selected then
            --    self:sellCardMoney(v, 1)
            --end
            
        end
    end
end
--@auto code Button_selected_1 btFunc end

--@auto code Button_ok btFunc
function HeroViewController:onButton_okClick()
    Functions.printInfo(self.debug,"Button_ok button is click!")
    

    --同步数据
    local onSellCard = function(event)
        local data = event.data
        PlayerData.eventAttr.m_hunjing = event.hunjing
        local soulNum = 0
        soulNum = event.soul - PlayerData.eventAttr.m_soul
        if soulNum > 0 then
            local buff = string.format( LanguageConfig.language_Hero_5, soulNum )
            NoticeManager:openTips(self, { type = 5, title = buff })
        end

        PlayerData.eventAttr.m_soul = event.soul
        
        self:sellData()
        HeroCardData:getSellHeroData(self.sellTable)
        --显示卡
        self:showCard(self.sell_Card)

        --出售完了要清空
        self.sellTable = {}
        --self._Text_money_num_t:setText(tostring(PlayerData.eventAttr.m_hunjing))
        self._Text_hero_num_t:setText(tostring(#(HeroCardData:getAllHeroData()).."/"..tostring(HeroCardData:getBagBaseSize())))
        self.sellMoney = 0
        self.sellSoul = 0
        self._Text_money_sell_num_t:setText(tostring(self.sellMoney))
    end
    
    local sellMark = {}
    for k, v in pairs(self.sellTable) do
    	sellMark[#sellMark+1] = v.m_mark
    end

    NetWork:addNetWorkListener({ 13, 1 }, Functions.createNetworkListener(onSellCard,true,"ret"))
    NetWork:sendToServer({ idx = { 13, 1 }, slots = sellMark })
end
--@auto code Button_ok btFunc end

--@auto code Button_pokedex btFunc
function HeroViewController:onButton_pokedexClick()
    Functions.printInfo(self.debug,"Button_pokedex button is click!")
    --发送图鉴接口
    PokedexData:sendServerPokedex(handler(self, self.onSuccess))
    
end
--@auto code Button_pokedex btFunc end

--@auto code Button_help btFunc
function HeroViewController:onButton_helpClick()
    Functions.printInfo(self.debug,"Button_help button is click!")
    NoticeManager:openNotice(self, {type = NoticeManager.SELL_CARD_INFO})
end
--@auto code Button_help btFunc end

--@auto button backcall end


--@auto code view display func
function HeroViewController:onCreate()
    Functions.printInfo(self.debug_b," HeroViewController controller create!")
end

function HeroViewController:onDisplayView()
	Functions.printInfo(self.debug_b," HeroViewController view enter display!")
    Functions.setPopupKey("hero")
    Functions.initResNodeUI(self._resNode_t,{ "hunjin"})
	--显示武将
    --self._Text_money_num_t:setText(tostring(PlayerData.eventAttr.m_hunjing))
    self._Text_hero_num_t:setText(tostring(#(HeroCardData:getAllHeroData()).."/"..tostring(HeroCardData:getBagBaseSize())))

    
    --排序（正序）
    HeroCardData:card_fen_zhu()
    HeroCardData:card_sort()
    --HeroCardData:sort()
    
    local Card = HeroCardData:getAllHeroData()
    self._Card = Card
    --初使化准备出售卡的数据
    self.sell_Card = {}
    -- 如果不是选择升级的副卡，出售按扭就不显示
    if EnhanceData.HeroShowType == 1 or EnhanceData.HeroShowType == 3 or EnhanceData.HeroShowType == 4 then
        self._Button_sell_t:setVisible(false)
    end
    if EnhanceData.HeroShowType ~= 0 then
        self._Button_Pokedex_t:setVisible(false)
    end
    if EnhanceData.HeroShowType == 2 then 
        --主卡的删除
        --排序（倒序）
        HeroCardData:sortReverse()
        EnhanceData:deleteCard()
        self:sellShow(self._Card)
        self.PickSacrifice = false
        local pppppp =  EnhanceData.DeputyData
        if #EnhanceData.DeputyData <= 0 then
            self.PickSacrifice = true
        end
        --选择副卡时的按钮显示
        --self._BitmapFontLabel_sell_t:setString(LanguageConfig.language_Hero_2)
        self._Image_sell_1_t:setVisible(false)
        self._Image_sell_2_t:setVisible(true)
    elseif EnhanceData.HeroShowType == 4 then
        --主卡的删除
        EnhanceData:deleteCard()
--        --上阵卡的删除
--        EnhanceData:deleteShangZhenCard()
        self:sellShow(self._Card)
    
    elseif EnhanceData.HeroShowType == 3 then
        self:sellShow(self._Card)
    else
        self:showCard(Card)
    end
--    --挑选祭品武将时为了切换职业后不再出现选中祭品武将的状态而声明的一个开关。
--    self.PickSacrifice = true
    --初使化选中武将表
    self.sellTable = {}
    self.sellMoney = 0
    self.sellSoul = 0
  
    --当前选择武将类型(1为全部，2为力，3为谋，4为术，5为医)
    self.cardState = 1

	local onPanel1 = function()
		print("panel 1 click")
	   if self.cardState ~= 1 then
            self.sellMoney = 0
            self.sellSoul = 0
            self._Text_money_sell_num_t:setText(tostring(self.sellMoney))
            self.cardState = 1
            self:sellShow()
		end
	end
	
    local onPanel2 = function()
        print("panel 2 click")
        if self.cardState ~= 2 then
            self.sellMoney = 0
            self.sellSoul = 0
            self._Text_money_sell_num_t:setText(tostring(self.sellMoney))
            self.cardState = 2
            self:sellShow()
        end
    end 
    
    local onPanel3 = function()
        print("panel 3 click")
        if self.cardState ~= 3 then
            self.sellMoney = 0
            self.sellSoul = 0
            self._Text_money_sell_num_t:setText(tostring(self.sellMoney))
            self.cardState = 3
            self:sellShow()
        end
    end 
    
    local onPanel4 = function()
        print("panel 4 click")
        if self.cardState ~= 4 then
            self.sellMoney = 0
            self.sellSoul = 0
            self._Text_money_sell_num_t:setText(tostring(self.sellMoney))
            self.cardState = 4
            self:sellShow()
        end
    end 
    
    local onPanel5 = function()
        print("panel 5 click")
        if self.cardState ~= 5 then
            self.sellMoney = 0
            self.sellSoul = 0
            self._Text_money_sell_num_t:setText(tostring(self.sellMoney))
            self.cardState = 5
            self:sellShow()
        end
    end 
    
    Functions.initTabCom({ { self._Panel_all_t, onPanel1, true }, { self._Panel_li_t, onPanel2}, { self._Panel_mou_t, onPanel3}, { self._Panel_shu_t, onPanel4}, { self._Panel_yi_t, onPanel5}})
    --监听函数
    local onCard_info = function(event)
        --如果选了副卡，类型要清零
        EnhanceData.HeroShowType = 0
        self:sellShow()
        self._Text_hero_num_t:setText(tostring(#(HeroCardData:getAllHeroData()).."/"..tostring(HeroCardData:getBagBaseSize())))
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, HeroCardData.CARDS_DATA_CHANGE_EVENT, onCard_info)
    --监听函数
    local onCardInfo = function(event)
        Functions.initResNodeUI(self._resNode_t,{ "hunjin"})
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, HeroCardData.CARDS_ENHANCE, onCardInfo)
end
--@auto code view display func end

function HeroViewController:showCard(show_Card)
    Functions.printInfo(self.debug_b,"showCard")
    
    --local HeroCard = HeroCardData:getHeroData()
    
    local listHandler = function(index, widget, model, data)
        if nil == data.seleceted then
            data.seleceted = false
        end
        if data.seleceted then 
            widget:getChildByName("CheckBox_Mark"):setSelectedState(true)
        else
            widget:getChildByName("CheckBox_Mark"):setSelectedState(false)
        end
        
        widget:setTouchEnabled(true)
        widget:setSwallowTouches(false)
        
    
        if self.sellState == true and EnhanceData.HeroShowType ~= 2 then
            widget:getChildByName("CheckBox_Mark"):setVisible(true)
        elseif EnhanceData.HeroShowType == 2 then --如果再次选择副卡。要做判断
            widget:getChildByName("CheckBox_Mark"):setVisible(true)
            local selected = EnhanceData.DeputyData
            if #selected == 0 then--如果再次选择副卡。副卡数据为空，要删除以前的选中数据。
                --删除现在武将的选中状态
                for k,v in pairs(self._Card) do 
                    if v.seleceted ~= nil then
                        v.seleceted = nil 
                    end
                end
            end
            for k, v in pairs(selected) do
                if data.m_mark == v.m_mark then
                    widget:getChildByName("CheckBox_Mark"):setSelectedState(true)
                end
            end
        end

        --显示武将头像信息
        Functions.showHeroHead(widget,data)
        
        --一键选中的响应
        Functions.bindEventListener( widget, data, CardModel.HERO_SELECT_EVENT, function()
            --local selected = true
            if nil ~= data.seleceted then 
                widget:getChildByName("CheckBox_Mark"):setSelectedState(true)
            end
        end )
        
        local onClick = function(event)
            --通过判断CheckBox状态来进行选择
            --widget:getChildByName("CheckBox_Mark"):setVisible(true)--
            local checkBox = widget:getChildByName("CheckBox_Mark")
            local selected = checkBox:isSelected()
            
            if EnhanceData.HeroShowType == 2 or EnhanceData.HeroShowType == 0 then
                if EnhanceData.HeroShowType == 2 then
                	self.sellState = true
                end
                if self.sellState == true then
                    if selected == false then
                        if EnhanceData.HeroShowType == 2 then
                            if #EnhanceData.DeputyData < 6 then     --加的副卡最多只能是6个
                                widget:getChildByName("CheckBox_Mark"):setSelectedState(true)
                                data.seleceted = true
                                if ConfigHandler:getHeroStarCountOfId(data.m_id) >= 4 then
                                    --提示玩家选择了强力武将
                                    PromptManager:openTipPrompt(LanguageConfig.language_Hero_2)
                                end
                                EnhanceData.DeputyData[#EnhanceData.DeputyData + 1] = data
                                local oooo = EnhanceData.DeputyData
                                local pp = EnhanceData.DeputyData
                            else
                                --提示玩最多只能选6张
                                PromptManager:openTipPrompt(LanguageConfig.language_Hero_3)
                            end
                        else
                            widget:getChildByName("CheckBox_Mark"):setSelectedState(true)
                            data.seleceted = true
                            if ConfigHandler:getHeroStarCountOfId(data.m_id) >= 4 then
                                --提示玩家选择了强力武将
                                PromptManager:openTipPrompt(LanguageConfig.language_Hero_2)
                            end
                            self.sellTable[#self.sellTable+1] = data
                            self:sellCardMoney(data, 1)
                        end
                    else
                        widget:getChildByName("CheckBox_Mark"):setSelectedState(false)
                        data.seleceted = false
                        if EnhanceData.HeroShowType == 2 then      --选择升级副卡
                            local deputy = EnhanceData.DeputyData
                            for k, v in pairs(deputy) do
                                if v.m_mark == data.m_mark then
                                    table.remove( deputy, k )
                                    break
                                end
                            end
                        elseif EnhanceData.HeroShowType == 0  then --出售
                            for k, v in pairs(self.sellTable) do
                                if v.m_mark == data.m_mark then
                                    table.remove( self.sellTable, k )
                                    self:sellCardMoney( data, 2 )
                                    break
                                end
                            end
                        end
                    end
                else
                    --打开二级界面
                    Functions.initResNodeUI(self._resNode_t,{"jinbi", "soul"})
                    self:openChildView("app.ui.popViews.CardInfoPopView", { data = {data, 1},isRemove = false})
                end
            elseif EnhanceData.HeroShowType == 1 or EnhanceData.HeroShowType == 3 then
                EnhanceData.MasterData = {}
                EnhanceData.MasterData[#EnhanceData.MasterData + 1]  = data
                --if EnhanceData.HeroShowType == 3 then
                    EnhanceData.DeputyData = {}
                --end
                --删除现在武将的选中状态
                local pppppp = self._Card
                for k,v in pairs(self._Card) do 
                    if v.seleceted ~= nil then
                        v.seleceted = nil 
                    end
                end
                if EnhanceData.HeroShowType == 1 then
                    GameEventCenter:dispatchEvent({ name = EnhanceData.ENHANCE_SHENG_JI_ZHU, data = data })
                elseif EnhanceData.HeroShowType == 3 then
                    GameEventCenter:dispatchEvent({ name = EnhanceData.ENHANCE_JIN_JIE_ZHU, data = data })
                end
                GameCtlManager:pop(self, { data = EnhanceData.MasterData })
            elseif EnhanceData.HeroShowType == 4 then
--                --加入上阵的卡
--                EnhanceData:addShangZhenCard()
                --加入主卡
                HeroCardData:addCardData(EnhanceData.MasterData)
                
                EnhanceData.DeputyData = {}
                EnhanceData.DeputyData[#EnhanceData.DeputyData + 1] = data
                GameCtlManager:pop(self, { data = EnhanceData.DeputyData })
            end
        end
        widget:onTouch(Functions.createTableViewClickListener(self._Panel_hero_t,onClick,"movedis"))
        
        if index == 1  then
            self._guidCard_t = widget
        end

    end
    --绑定响应事件函数
    --Functions.bindArryListWithData(self._ListView_hero_t,{ firstData = show_Card }, listHandler,{direction = true, col = 6, firstSegment = 0, segment = 2 })
    local iiii = show_Card
    local romveNodeHandler = function(widget)
        Functions.removeEventBeforeUiClean(widget)
    end
    Functions.bindTableViewWithData(self._Panel_hero_t,{ firstData = show_Card },{handler = listHandler,romveNodeHandler = romveNodeHandler },{direction = true, col = 6, firstSegment = 0, segment = 2 }) 
end

function HeroViewController:sellData()
    Functions.printInfo(self.debug,"sellData")
    local data = self.sell_Card
    local sell = self.sellTable
    for k2,v2 in pairs(sell) do
        for k, v in pairs(data) do 
            if v2.m_mark == data[k].m_mark then
                table.remove(data, k)
            end
        end
    end
end

function HeroViewController:sellCardMoney(data,type)
    Functions.printInfo(self.debug,"sellCardMoney")
    local quality = ConfigHandler:getHeroStarCountOfId(data.m_id)
    local level = data.m_level
    local class = data.m_class
    
    
    local iiii = self.sellMoney
    local ppp = cs_SellCard(quality,level,class,evolution)
    
    if type == 1 then
        self.sellMoney = self.sellMoney + cs_SellCard(quality,level,class,evolution)
        if class > 1 then
            self.sellSoul = self.sellSoul + 0
        end
    elseif type == 2 then
        self.sellMoney = self.sellMoney - cs_SellCard(quality,level,class,evolution)
        if class > 1 then
            self.sellSoul = self.sellSoul - 0
        end
    end
    
    self._Text_money_sell_num_t:setText(tostring(self.sellMoney))
end

function HeroViewController:sellShow()
    Functions.printInfo(self.debug,"sellShow")
    if self.cardState == 1 then
        self._Card = HeroCardData:getAllHeroData()
    elseif self.cardState == 2 then
        self._Card = HeroCardData:getliHeroData()
    elseif self.cardState == 3 then
        self._Card = HeroCardData:getMouHeroData()
    elseif self.cardState == 4 then
        self._Card = HeroCardData:getShuHeroData()
    elseif self.cardState == 5 then
        self._Card = HeroCardData:getYiHeroData()
    end
    
    local opoppopopopopop = self._Card
            --出售完了要清空
        self.sellTable = {}
    if self.sellState == true and EnhanceData.HeroShowType ~= 2 then
        self.sell_Card = HeroCardData:getWillSellHeroData(self._Card)
        for k, v in pairs(self._Card) do
            if nil ~= v.seleceted then
                v.seleceted = false
            end
        end
        self:showCard(self.sell_Card)
    else
        local pppp = EnhanceData.HeroShowType
        --显示升阶卡
        if EnhanceData.HeroShowType ~= 1 then
            self:Show_upCard()
        end
        local ooo = self._Card
        for k, v in pairs(self._Card) do
            if nil ~= v.seleceted then
                v.seleceted = false
            end
        end
        self:showCard(self._Card)
    end
end

--显示升阶卡的
function HeroViewController:Show_upCard()
    Functions.printInfo(self.debug,"sellShow")
    if EnhanceData.HeroShowType > 0 then
        --进阶主卡的id
--        local id = HeroCardData:getHeroID(EnhanceData.MasterData[1].m_mark)
--        local class = HeroCardData:getHeroClass(EnhanceData.MasterData[1].m_mrak)
        local test = {}
        for k, v in pairs(self._Card) do
            
            if EnhanceData.HeroShowType == 2 then
                --不为上阵武将，不为正在做主城任务和卡，才能加数量
                local taskHreo = CityData:getTaskHoreInfo()
                local _task = true
                for q,w in pairs(taskHreo) do
                    if v.m_mark == w then
                        _task = fasle
                        break
                    end
                end
                if _task and v.m_atkFormFlag == 0 and v.m_defFormFlag == 0  then
                    test[#test+1] = v
            	end
            elseif EnhanceData.HeroShowType == 3 then
                local _test = {}
                _test = HeroCardData:getAllHeroData()
                --_test = Functions.filterDatas(HeroCardData:getAllHeroData(), handler(HeroCardData, HeroCardData.saiXuan))
                
                
                local liHeroDatas = {}
                local shuHeroDatas = {}
                local mouHeroDatas = {}
                local yiHeroDatas = {}
                for k, v in pairs(_test) do
                    if ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.LI then
                        liHeroDatas[#liHeroDatas+1] = v
                    elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.SHU then
                        shuHeroDatas[#shuHeroDatas+1] = v
                    elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.MOU then
                        mouHeroDatas[#mouHeroDatas+1] = v
                    elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.YI then
                        yiHeroDatas[#yiHeroDatas+1] = v
                    end
                end
                --默认为全部武将
                test = _test
                if self.cardState == 1 then
                    test = _test
                elseif self.cardState == 2 then
                    test = liHeroDatas
                elseif self.cardState == 3 then
                    test = mouHeroDatas
                elseif self.cardState == 4 then
                    test = shuHeroDatas
                elseif self.cardState == 5 then
                    test = yiHeroDatas
                end
                
                --提示玩家没有可以进阶的武将
                if #test <= 0 then
                    PromptManager:openTipPrompt(LanguageConfig.language_Hero_4)
                end
                
--                if ConfigHandler:getHeroStarCountOfId(v.m_id) > 2 then
--                    test[#test+1] = v
--                end
            elseif EnhanceData.HeroShowType == 4 then
                --没上阵的卡才能显示
                if v.m_atkFormFlag == 0 and v.m_defFormFlag == 0  then
                    if EnhanceData.MasterData[1].m_class == 5 then      --当进阶数为5时，说明要进化
                        if ConfigHandler:getHeroJinHuaNumOfId(v.m_id) == ConfigHandler:getHeroJinHuaNumOfId(EnhanceData.MasterData[1].m_id) and
                            ConfigHandler:getHeroStarCountOfId(v.m_id) == ConfigHandler:getHeroStarCountOfId(EnhanceData.MasterData[1].m_id) then
                        test[#test+1] = v
                    end
                    elseif ConfigHandler:getHeroStarCountOfId(v.m_id) == ConfigHandler:getHeroStarCountOfId(EnhanceData.MasterData[1].m_id) then
                        test[#test+1] = v
                    end
                end
            end
        end
        self._Card = test
    end
end

function HeroViewController:onSuccess(data)
    Functions.printInfo(self.debug_b,"onSuccess")
    if data.ret == 1 then
        --打开图鉴系统
        self.pokedexPopView = self:openChildView("app.ui.popViews.PokedexPopView",{isRemove = false})--isRemove = true 点击弹出界面以外的界面就自动关闭当前弹出的这个界面
    end
end

--接受pop数据
function HeroViewController:onReceivePopData(data)
    if PokedexData.Refresh then
        self.pokedexPopView:SelectedShow()
    end
end

function HeroViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end

return HeroViewController