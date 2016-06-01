--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local IntegralShopViewController = class("IntegralShopViewController", BaseViewController)

local Functions = require("app.common.Functions")

IntegralShopViewController.debug = true
IntegralShopViewController.modulePath = ...
IntegralShopViewController.studioSpriteFrames = {"IntegralShopUI","CB_bgup","CB_blackbg","ShopUI_Text" }
--@auto code head end

--@Pre loading
IntegralShopViewController.spriteFrameNames = 
    {
    }

IntegralShopViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #IntegralShopViewController.studioSpriteFrames > 0 then
    IntegralShopViewController.spriteFrameNames = IntegralShopViewController.spriteFrameNames or {}
    table.insertto(IntegralShopViewController.spriteFrameNames, IntegralShopViewController.studioSpriteFrames)
end
function IntegralShopViewController:onDidLoadView()

    --output list
    self._resNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("resNode")
	self._ListView_shop_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("ListView_shop")
	
    --label list
    
    --button list
    self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

	self._Button_flush_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Button_flush")
	self._Button_flush_t:onTouch(Functions.createClickListener(handler(self, self.onButton_flushClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function IntegralShopViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
    GameCtlManager:pop(self)
end
--@auto code Button_back btFunc end

--@auto code Button_flush btFunc
function IntegralShopViewController:onButton_flushClick()
    Functions.printInfo(self.debug,"Button_flush button is click!")
    self:sendRefreshShop()
end
--@auto code Button_flush btFunc end

--@auto button backcall end


--@auto code view display func
function IntegralShopViewController:onCreate()
    Functions.printInfo(self.debug_b," IntegralShopViewController controller create!")
end

function IntegralShopViewController:onDisplayView()
	Functions.printInfo(self.debug_b," IntegralShopViewController view enter display!")
    self._ListView_shop_t:setVisible(false)
    Functions.initResNodeUI(self._resNode_t,{ "jifen" })
	--查询碎片
    self:sendIntegralShop()
    
    -- --监听函数
    -- local onSell = function(event)
    --     local data = IntegralShopData:getIntegralShopData()
    --     self:refresh(data)
    -- end

    -- Functions.bindEventListener(self.view_t, GameEventCenter, IntegralShopData.SELL_UP, onSell)
end
--@auto code view display func end


function IntegralShopViewController:sendIntegralShop()
    Functions.printInfo(self.debug_b,"sendIntegralShop")
    local onSendIntegralShop = function (event)
        self:ShopData(event)
        return true
    end
    NetWork:addNetWorkListener({ 5, 14 }, onSendIntegralShop)
    NetWork:sendToServer({ idx = { 5, 14 }})
    
end

function IntegralShopViewController:sendRefreshShop()
    Functions.printInfo(self.debug_b,"sendIntegralShop")
    local onSendIntegralShop = function (event)
        if event.ret == 1 then
        	self:ShopData(event)
        end
    return true
    end  

    NetWork:addNetWorkListener({ 5, 15 }, onSendIntegralShop)
    NetWork:sendToServer({ idx = { 5, 15 }})

end

--碎片数据
function IntegralShopViewController:ShopData(event)
    Functions.printInfo(self.debug_b,"onSendIntegralShop")
    
        local data = event.data
        IntegralShopData:clearIntegralShopData()--清空商城数据
        for k, v in pairs(data) do
            local IntegralData = Factory:createIntegralShopData()
            --积分商城道具属性
            IntegralData.m_DebrisIndex = k                      --索引(因为有可能是二个相同的物品,那么ID就是一样的，不能进行购买的判断)
            IntegralData.m_DebrisID = data[k].goodid            --道具ID
            IntegralData.m_DebrisType = data[k].goodtype        --道具类型
            IntegralData.m_DebrisCount = data[k].goodnum        --购买数量
            IntegralData.m_DebrisPrice = data[k].price          --道具价格
            --IntegralData.b_DebrisBuy = data[k][5]               --是否购买过(0:没有购买过。1：购买过)
            IntegralShopData:addIntegralShopData(IntegralData)
        end
    local _data = IntegralShopData:getIntegralShopData()
    
    self:refresh(_data)
end

function IntegralShopViewController:refresh(_data)
    Functions.printInfo(self.debug_b,"refresh")
    
    local listHandler = function(index, widget, model,data)
        local ban = widget:getChildByName("Image_ban")
        local banModel = model:getChildByName("Image_ban")
        local head = widget:getChildByName("Image_ban"):getChildByName("Image_head")
        Functions.initTextColor(banModel:getChildByName("Text_cargo_name"),ban:getChildByName("Text_cargo_name"))
        Functions.initTextColor(banModel:getChildByName("Text_buy_count"),ban:getChildByName("Text_buy_count"))
        
        local heroNode = nil
        if data.m_DebrisType == 4 then --4为道具
            ban:getChildByName("Text_cargo_name"):setText(ConfigHandler:getPropNameOfId(data.m_DebrisID))
            heroNode = Functions.createPartNode({nodeType = ItemType.Prop, nodeId = data.m_DebrisID})
        elseif data.m_DebrisType == 1 then--1为武将卡
            ban:getChildByName("Text_cargo_name"):setText(ConfigHandler:getHeroNameOfId(data.m_DebrisID))
            heroNode = Functions.createPartNode({nodeType = ItemType.HeroCard, nodeId = data.m_DebrisID})
        elseif data.m_DebrisType == 5 then--1为武将卡碎片
            ban:getChildByName("Text_cargo_name"):setText(ConfigHandler:getHeroNameOfId(data.m_DebrisID))
            heroNode = Functions.createPartNode({nodeType = ItemType.CardFragment, nodeId = data.m_DebrisID})
            ban:getChildByName("lmage_name_type"):setVisible(true)
            --Functions.loadImageWithWidget(head, ConfigHandler:getHeroHeadImageOfId(data.m_DebrisID))
        end
        
        Functions.copyParam(head, heroNode)
        head:setVisible(false)
        ban:addChild(heroNode)
        
        --ban:getChildByName("Text_cargo_name"):setText(ConfigHandler:getHeroNameOfId(data.m_DebrisID))
        --Functions.loadImageWithWidget(head, ConfigHandler:getHeroHeadImageOfId(data.m_DebrisID))

        ban:getChildByName("Text_buy_count"):setText(tostring(data.m_DebrisCount))
        ban:getChildByName("Text_cost_count"):setText(tostring(data.m_DebrisPrice))
        
        if data.b_DebrisBuy == 1 then
            ban:getChildByName("Image_sell_out_1"):setVisible(true)
        end


        local onShopBut = function(event)
            print("button click")
            --打开二级界面
            self:openChildView("app.ui.popViews.IntegralShopPopView", { data = index})
        end
        widget:getChildByName("Image_ban"):onTouch(Functions.createClickListener(onShopBut, "zoom"))

    end
    --绑定响应事件函数
    Functions.bindArryListWithData(self._ListView_shop_t,{firstData = _data}, listHandler,{direction = false,col = 2,firstSegment = 10,segment = 10})
    
end

function IntegralShopViewController:openBgMusic()
    Audio.playMusic("sound/combat.mp3",true)
end

return IntegralShopViewController