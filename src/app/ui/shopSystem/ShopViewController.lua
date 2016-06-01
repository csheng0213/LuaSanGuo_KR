--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local ShopViewController = class("ShopViewController", BaseViewController)

local Functions = require("app.common.Functions")

ShopViewController.debug = true
ShopViewController.modulePath = ...
ShopViewController.studioSpriteFrames = {"IntegralShopUI","CB_bgup","CB_blackbg","ShopUI_Text" }
--@auto code head end

--@Pre loading
ShopViewController.spriteFrameNames = 
    {
    }

ShopViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #ShopViewController.studioSpriteFrames > 0 then
    ShopViewController.spriteFrameNames = ShopViewController.spriteFrameNames or {}
    table.insertto(ShopViewController.spriteFrameNames, ShopViewController.studioSpriteFrames)
end
function ShopViewController:onDidLoadView()

    --output list
    self._resNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("resNode")
	self._Image_Refresh_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Button_Refresh"):getChildByName("Image_Refresh_text")
	self._Image_Refresh_icon_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Image_Refresh_icon")
	self._Text_Refresh_num_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Text_Refresh_num")
	self._Text_Countdown_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_bg"):getChildByName("Text_Countdown")
	self._ListView_shop_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("ListView_shop")
	
    --label list
    
    --button list
    self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

	self._Button_help_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_help")
	self._Button_help_t:onTouch(Functions.createClickListener(handler(self, self.onButton_helpClick), "zoom"))

	self._Button_Refresh_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Button_Refresh")
	self._Button_Refresh_t:onTouch(Functions.createClickListener(handler(self, self.onButton_refreshClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function ShopViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
    
    GameCtlManager:pop(self)
end
--@auto code Button_back btFunc end

--@auto code Text_soul btFunc
function ShopViewController:onText_soulClick()
    Functions.printInfo(self.debug,"Text_soul button is click!")
end
--@auto code Text_soul btFunc end

--@auto code Button_cargo_bg btFunc
function ShopViewController:onButton_cargo_bgClick()
    Functions.printInfo(self.debug,"Button_cargo_bg button is click!")
end
--@auto code Button_cargo_bg btFunc end

--@auto code Button_cargo_bg_2 btFunc
function ShopViewController:onButton_cargo_bg_2Click()
    Functions.printInfo(self.debug,"Button_cargo_bg_2 button is click!")
end
--@auto code Button_cargo_bg_2 btFunc end

--@auto code Childmodel btFunc
function ShopViewController:onChildmodelClick()
    Functions.printInfo(self.debug,"Childmodel button is click!")
end
--@auto code Childmodel btFunc end

--@auto code Image_ban btFunc
function ShopViewController:onImage_banClick()
    Functions.printInfo(self.debug,"Image_ban button is click!")
end
--@auto code Image_ban btFunc end

--@auto code Button_refresh btFunc
function ShopViewController:onButton_refreshClick()
    Functions.printInfo(self.debug,"Button_refresh button is click!")
    --如果没有刷新令，就显示元宝数量
    local type = 0
    if PropData:getPropNumOfId(44) > 0 then
        type = 1
        self:sendRefreshShop(type)
    else
        type = 2
        local vipLevel = VipData.eventAttr.m_vipLevel
        if ShopData.shopRefreshCount <= g_VipCgf.VipRefreshCount[vipLevel] then
            self:sendRefreshShop(type)
        else
            --弹出报错信息
            PromptManager:openTipPrompt(LanguageConfig.language_Shop_1) 
        end
    end
end
--@auto code Button_refresh btFunc end

--@auto code Button_help btFunc
function ShopViewController:onButton_helpClick()
    Functions.printInfo(self.debug,"Button_help button is click!")
    NoticeManager:openNotice(self, {type = NoticeManager.SHOP_REFRESH})
end
--@auto code Button_help btFunc end

--@auto button backcall end


--@auto code view display func
function ShopViewController:onCreate()
    Functions.printInfo(self.debug_b," ShopViewController controller create!")
end

function ShopViewController:onDisplayView()
	Functions.printInfo(self.debug_b," ShopViewController view enter display!")
    self:showTime()
	self._ListView_shop_t:setVisible(false)
    Functions.setPopupKey("store")
    Functions.setAdbrixTag("retension","shop_inter")
    Functions.initResNodeUI(self._resNode_t,{ "jinbi" , "yuanbao", "hunjin" })
    self._Image_Refresh_icon_t:setVisible(false)
    self._Text_Refresh_num_t:setVisible(false)
    
    --查看商城物品
    self:sendShop()
    
    --监听购买后ui变化
    local onPosition = function(event)
        self:sendShop()
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, ShopData.BUY_REFRESH_CHANGE, onPosition)
    --监听物品刷新
    local onPosition = function(event)
        self:sendShop()
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, ShopData.REFRESH_CHANGE, onPosition)
end
--@auto code view display func end
--查看商城物品
function ShopViewController:sendShop()
    Functions.printInfo(self.debug,"sendShop")
    --Functions.bindMGSDisplay(self._Text_money_t, self._Text_bao_t, self._Text_soul_t )
    local onSendShop = function (event)
        local data = event.data
        ShopData:clearShopData()--清空商城数据
        for k, v in pairs(data) do
            ShopData:addShopData(v,k)	
        end
        ShopData.shopRefreshCount = event.refreshcount
        ShopData.nextFreshTime = event.nextFreshTime
        self:refresh()
    end
    NetWork:addNetWorkListener({ 5, 11 }, Functions.createNetworkListener(onSendShop,true,"ret"))
    NetWork:sendToServer({ idx = { 5, 11 }})
end

--查看商城物品
function ShopViewController:sendRefreshShop(type)
    Functions.printInfo(self.debug,"sendRefreshShop")
    --Functions.bindMGSDisplay(self._Text_money_t, self._Text_bao_t, self._Text_soul_t )
    local onRefreshShop = function (event)

        local data = event.data
        PlayerData.eventAttr.m_hunjing = event.hunjing
        ShopData:clearShopData()--清空商城数据
        for k, v in pairs(data) do
            ShopData:addShopData(v,k)   
        end
        ShopData.shopRefreshCount = event.refreshcount
        if PropData:getPropNumOfId(44) > 0 then
            PropData:miuProp( {m_id = 44, m_count = 1} )
        end
        self:refresh()
    end
    NetWork:addNetWorkListener({ 5, 18 }, Functions.createNetworkListener(onRefreshShop,true,"ret"))
    NetWork:sendToServer({ idx = { 5, 18 }, stype = type })
end

----查看商城物品
--function ShopViewController:sendRefreshShop(type)
--    Functions.printInfo(self.debug,"sendRefreshShop")
--    --Functions.bindMGSDisplay(self._Text_money_t, self._Text_bao_t, self._Text_soul_t )
--
--
--end

--商城刷新所需魂晶数量
function ShopViewController:shopHunJingNum()
    Functions.printInfo(self.debug,"sendRefreshShop")
    local count = ShopData.shopRefreshCount + 1
    local data = g_VipCgf.RefreshHunJing
    local NUM = 0
    if count > data[#data][2] then
        NUM = data[#data][3]
        return NUM
    end
    
    for k, v in pairs(data) do
    	if v[2] >= count then
    		NUM = v[3]
    		break
    	end
    end
    return NUM
end

function ShopViewController:showTime()
    Functions.printInfo(self.debug_b,"showTime")
    --倒记时
    local onTime = function(event)
        local m_newtime = TimerManager:getCurrentSecond()
        local CountdownTime = ShopData:getCountdown()
        m_newtime = CountdownTime - m_newtime 
        if m_newtime < 0 then
            m_newtime = 0
        end

        local time = TimerManager:formatOverTime("%02d:%02d:%02d", m_newtime)
        local str = LanguageConfig.language_Shop_3..time
        Functions.initLabelOfString( self._Text_Countdown_t, str)
    end
    Functions.bindEventListener(self._Text_Countdown_t, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
    onTime()
end

function ShopViewController:refresh()
    
    local shopdatas = ShopData:getShopDatas()
    
    --如果没有刷新令，就显示魂晶数量
    self._Image_Refresh_icon_t:setVisible(true)
    self._Text_Refresh_num_t:setVisible(true)
    self._Image_Refresh_icon_t:ignoreContentAdaptWithSize(true)
    if PropData:getPropNumOfId(44) > 0 then
        self._Image_Refresh_icon_t:setScale(0.5)
        Functions.loadImageWithWidget(self._Image_Refresh_icon_t, "commonUI/res/icons/refresh_Icon.png")
        Functions.initLabelOfString(self._Text_Refresh_num_t:setText(), tostring(PropData:getPropNumOfId(44)))
    else
        self._Image_Refresh_icon_t:setScale(1)
        Functions.loadImageWithWidget(self._Image_Refresh_icon_t, "commonUI/res/image/hunjin.png")
        Functions.initLabelOfString(self._Text_Refresh_num_t:setText(), self:shopHunJingNum())
    end
    
    local listHandler = function(index, widget, model, data)
        local ban = widget:getChildByName("Image_ban")
        local banModel = model:getChildByName("Image_ban")
        local head = widget:getChildByName("Image_ban"):getChildByName("Image_head")
        
        Functions.initTextColor(banModel:getChildByName("Text_cargo_name"),ban:getChildByName("Text_cargo_name"))
        Functions.initTextColor(banModel:getChildByName("Text_buy_count"),ban:getChildByName("Text_buy_count"))
        local heroNode = nil
        if data.m_ItemType == 4 then --4为道具
            ban:getChildByName("Text_cargo_name"):setText(ConfigHandler:getPropNameOfId(data.m_ItemID))
--            Functions.loadImageWithWidget(head, ConfigHandler:getPropImageOfId(data.m_ItemID))
            heroNode = Functions.createPartNode({nodeType = ItemType.Prop, nodeId = data.m_ItemID})
        elseif data.m_ItemType == 1 then--1为武将卡
            ban:getChildByName("Text_cargo_name"):setText(ConfigHandler:getHeroNameOfId(data.m_ItemID))
--            Functions.loadImageWithWidget(head, ConfigHandler:getHeroHeadImageOfId(data.m_ItemID))
            heroNode = Functions.createPartNode({nodeType = ItemType.HeroCard, nodeId = data.m_ItemID})
        elseif data.m_ItemType == 5 then--1为武将卡碎片
            ban:getChildByName("Text_cargo_name"):setText(ConfigHandler:getHeroNameOfId(data.m_ItemID))
            heroNode = Functions.createPartNode({nodeType = ItemType.CardFragment, nodeId = data.m_ItemID})
            Functions.loadImageWithWidget(head, ConfigHandler:getHeroHeadImageOfId(data.m_ItemID))
            ban:getChildByName("Image_name_type"):setVisible(true)
        else
            assert(false,"商店出售的商品类型 type = " .. data.m_ItemType .. "错误")
        end
        Functions.copyParam(head, heroNode)
        head:setVisible(false)
        ban:addChild(heroNode)

        --ban:getChildByName("Text_cargo_name"):setText(ConfigHandler:getHeroNameOfId(data.m_ItemID))
        ban:getChildByName("Image_cost_type"):ignoreContentAdaptWithSize(true)
        if data.m_MoneyType == 1 then--1为元宝
            Functions.loadImageWithWidget(ban:getChildByName("Image_cost_type"), "commonUI/res/image/bao.png")
        elseif data.m_MoneyType == 2 then--2为铜钱
            Functions.loadImageWithWidget(ban:getChildByName("Image_cost_type"), "commonUI/res/image/jinbi.png")
        elseif data.m_MoneyType == 3 then--2为铜钱
            Functions.loadImageWithWidget(ban:getChildByName("Image_cost_type"), "commonUI/res/image/hunjin.png")
        end

        ban:getChildByName("Text_buy_count"):setText(tostring(data.m_ItemNum))
        ban:getChildByName("Text_cost_count"):setText(tostring(data.m_ItemPrice))

        
        if data.m_ItemState == 0 then
            ban:getChildByName("Image_sell_out"):setVisible(true)
        else
            ban:getChildByName("Image_sell_out"):setVisible(false)
        end


        local onShopBut = function(event)
            print("button click")
            --打开二级界面
            if data.m_ItemState == 1 then
                self:openChildView("app.ui.popViews.ShopPopView", { data = data })
            else
                --弹出报错信息
                PromptManager:openTipPrompt(LanguageConfig.language_Shop_2)
            end
            
        end
        widget:getChildByName("Image_ban"):onTouch(Functions.createClickListener(onShopBut, "zoom"))
        
        if index == 1 then
            self._shopWidget_t = widget:getChildByName("Image_ban")
        end

    end
    --绑定响应事件函数
    Functions.bindArryListWithData(self._ListView_shop_t,{ firstData = shopdatas }, listHandler,{direction = false,col = 2,firstSegment = 3,segment = 10})
    
end

function ShopViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
return ShopViewController