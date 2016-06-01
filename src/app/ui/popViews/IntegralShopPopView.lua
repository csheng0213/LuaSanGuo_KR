--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local IntegralShopPopView = class("IntegralShopPopView", BasePopView)

local Functions = require("app.common.Functions")

IntegralShopPopView.csbResPath = "lk/csb"
IntegralShopPopView.debug = true
IntegralShopPopView.studioSpriteFrames = {"IntegralShopUI_Text" }
--@auto code head end
--@Pre loading
IntegralShopPopView.spriteFrameNames = 
    {
    }

IntegralShopPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #IntegralShopPopView.studioSpriteFrames > 0 then
    IntegralShopPopView.spriteFrameNames = IntegralShopPopView.spriteFrameNames or {}
    table.insertto(IntegralShopPopView.spriteFrameNames, IntegralShopPopView.studioSpriteFrames)
end
function IntegralShopPopView:onInitUI()

    --output list
    self._Sprite_integral_Pop_bg_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg")
	self._Image_head_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Image_head")
	self._Text_head_name_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Text_head_name")
	self._Text_Pop_have_count_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Text_Pop_have_count")
	self._Text_people_info_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Text_people_info")
	self._Text_buy_num_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Text_buy_num")
	self._Text_buy_cost_num_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Text_buy_cost_num")
	self._Sprite_buy_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Button_buy"):getChildByName("Sprite_buy")
	self._Sprite_debris_icon_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Sprite_debris_icon")
	self._Image_item_num_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Image_item_num")
	
    --label list
    
    --button list
    self._Panel_2_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Panel_2")
	self._Panel_2_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_2Click), "zoom"))

	self._Button_buy_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Button_buy")
	self._Button_buy_t:onTouch(Functions.createClickListener(handler(self, self.onButton_buyClick), "zoom"))

	self._Button_miu_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Button_miu")
	self._Button_miu_t:onTouch(Functions.createClickListener(handler(self, self.onButton_miuClick), "zoom"))

	self._Button_add_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_integral_Pop_bg"):getChildByName("Button_add")
	self._Button_add_t:onTouch(Functions.createClickListener(handler(self, self.onButton_addClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_buy btFunc
function IntegralShopPopView:onButton_buyClick()
    Functions.printInfo(self.debug,"Button_buy button is click!")
    self:sendBuy()
end
--@auto code Button_buy btFunc end

--@auto code Panel_2 btFunc
function IntegralShopPopView:onPanel_2Click()
    Functions.printInfo(self.debug,"Panel_2 button is click!")
    if self.itemData[self.param[1]].m_DebrisType == 1 or self.itemData[self.param[1]].m_DebrisType == 5 then--1为武将卡
        --打开二级界面
        self._controller_t:openChildView("app.ui.popViews.CardInfoPopView", { data = {self.itemData[self.param[1]].m_DebrisID, 3}, isRemove = false })
    end
end
--@auto code Panel_2 btFunc end

--@auto code Button_miu btFunc
function IntegralShopPopView:onButton_miuClick()
    Functions.printInfo(self.debug,"Button_miu button is click!")
    
    if self.itemData[self.param[1]].m_DebrisCount > 1 then
    	self.itemData[self.param[1]].m_DebrisCount = self.itemData[self.param[1]].m_DebrisCount - 1
    else
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_IntegralShop_2)
    end
    self:showText(self.itemData[self.param[1]].m_DebrisPrice, self.itemData[self.param[1]].m_DebrisCount)
--    --购买数量
--    self._Text_buy_num_t:setText(tostring(self.itemData[self.param[1]].m_DebrisCount))
--    --物品价格
--    self._Text_buy_cost_num_t:setText(tostring(self.itemData[self.param[1]].m_DebrisPrice * self.itemData[self.param[1]].m_DebrisCount))
end
--@auto code Button_miu btFunc end

--@auto code Button_add btFunc
function IntegralShopPopView:onButton_addClick()
    Functions.printInfo(self.debug,"Button_add button is click!")
    local count = math.floor(TianTiData:geTianTiScore() / self.itemData[self.param[1]].m_DebrisPrice)
    if self.itemData[self.param[1]].m_DebrisCount < count then
        self.itemData[self.param[1]].m_DebrisCount = self.itemData[self.param[1]].m_DebrisCount + 1
    else
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_IntegralShop_1)
    end
    self:showText(self.itemData[self.param[1]].m_DebrisPrice, self.itemData[self.param[1]].m_DebrisCount)
--    --购买数量
--    self._Text_buy_num_t:setText(tostring(self.itemData[self.param[1]].m_DebrisCount))
--    --物品价格
--    self._Text_buy_cost_num_t:setText(tostring(self.itemData[self.param[1]].m_DebrisPrice * self.itemData[self.param[1]].m_DebrisCount))
end
--@auto code Button_add btFunc end

--@auto button backcall end


--@auto code output func
function IntegralShopPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function IntegralShopPopView:onDisplayView(...)
	Functions.printInfo(self.debug,"pop action finish ")
	local param = {...}
    assert(#param > 0, "param is nil error")
    self.param = param
    local data = IntegralShopData:getIntegralShopData()
    self.itemData = data
    
    local have_count = 0
    
    local heroNode = nil
    if data[param[1]].m_DebrisType == 4 then--4为道具
        heroNode = Functions.createPartNode({nodeType = ItemType.Prop, nodeId = data[param[1]].m_DebrisID})
        self._Text_head_name_t:setText(ConfigHandler:getPropNameOfId(data[param[1]].m_DebrisID))
        Functions.initLabelOfString(self._Text_people_info_t, ConfigHandler:getPropInfOfId(data[param[1]].m_DebrisID))

        --已经有的个数
        have_count = PropData:getPropNumOfId(data[param[1]].m_DebrisID)
        
    elseif data[param[1]].m_DebrisType == 1 then--1为武将卡
        heroNode = Functions.createPartNode({nodeType = ItemType.HeroCard, nodeId = data[param[1]].m_DebrisID})

        self._Text_head_name_t:setText(ConfigHandler:getHeroNameOfId(data[param[1]].m_DebrisID))
        Functions.initLabelOfString(self._Text_people_info_t, ConfigHandler:getHeroDescriptionId(data[param[1]].m_DebrisID))
        
        have_count = HeroCardData:getHaveHeroNum(data[param[1]].m_DebrisID)
    elseif data[param[1]].m_DebrisType == 5 then--1为武将卡碎片
        heroNode = Functions.createPartNode({nodeType = ItemType.CardFragment, nodeId = data[param[1]].m_DebrisID})

        self._Text_head_name_t:setText(ConfigHandler:getHeroNameOfId(data[param[1]].m_DebrisID))
        Functions.initLabelOfString(self._Text_people_info_t, ConfigHandler:getHeroDescriptionId(data[param[1]].m_DebrisID))
        have_count = CompoundData:getCompoundDatanNum(data[param[1]].m_DebrisID)
    end

    Functions.copyParam(self._Image_head_t, heroNode)
    self._Image_head_t:setVisible(false)
    self._Sprite_integral_Pop_bg_t:addChild(heroNode)
    
    --self._Text_head_name_t:setText(ConfigHandler:getHeroNameOfId(data[param[1]].m_DebrisID))

    --已经有的个数
    self._Text_Pop_have_count_t:setText(tostring(have_count))
    self:showText(data[param[1]].m_DebrisPrice, data[param[1]].m_DebrisCount)
--    --购买数量
--    self._Text_buy_num_t:setText(tostring(data[param[1]].m_DebrisCount))
--    --物品价格
--    self._Text_buy_cost_num_t:setText(tostring(data[param[1]].m_DebrisPrice * data[param[1]].m_DebrisCount))
end

function IntegralShopPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

--数量价钱的显示
function IntegralShopPopView:showText(money, num)
    --购买数量
    self._Text_buy_num_t:setText(tostring(num))
    --物品价格
    self._Text_buy_cost_num_t:setText(tostring(money * num))
end

--购买物品
function IntegralShopPopView:sendBuy()
    Functions.printInfo(self.debug,"sendBuyShop")
    local data = IntegralShopData:getIntegralShopData()
    local onBuyShop = function (event)
        Functions.playSound("get_loot.mp3")
        local id = event.goodid
        local num = event.goodnum
        local type = event.goodtype --（约定为：1为整卡，5为碎片,4为道具）
        local mark = event.slot--//碎片或武将的索引

        TianTiData.eventAttr.m_tianTiScore = event.tianTiScore --天梯积分
        
        if type == 1 then
            assert(num > 1, "IntegralShopPopView input hero card num is error")
        end
        Functions:addItemResources( {id = id, type = type, count = num, slot = mark } )
        --弹出购买成功信息
        PromptManager:openTipPrompt(LanguageConfig.language_9_7) 
        
        
        --数据更新监听
        GameEventCenter:dispatchEvent({ name = IntegralShopData.SELL_UP, data = self.param[1] })
        self._controller_t:closeChildView(self)
    end

    NetWork:addNetWorkListener({ 5, 16 }, Functions.createNetworkListener(onBuyShop,true,"ret"))
    NetWork:sendToServer({ idx = { 5, 16 }, index = data[self.param[1]].m_DebrisIndex, count = self.itemData[self.param[1]].m_DebrisCount})
end
return IntegralShopPopView