--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local DiscountPopView = class("DiscountPopView", BasePopView)

local Functions = require("app.common.Functions")

DiscountPopView.csbResPath = "lk/csb"
DiscountPopView.debug = true
DiscountPopView.studioSpriteFrames = {"Discount_Text","CBO_discountBg" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #DiscountPopView.studioSpriteFrames > 0 then
    DiscountPopView.spriteFrameNames = DiscountPopView.spriteFrameNames or {}
    table.insertto(DiscountPopView.spriteFrameNames, DiscountPopView.studioSpriteFrames)
end
function DiscountPopView:onInitUI()

    --output list
    self._Sprite_meizi_t = self.csbNode:getChildByName("Panel_Discount"):getChildByName("Sprite_meizi")
	self._Text_string_t = self.csbNode:getChildByName("Panel_Discount"):getChildByName("Text_string")
	self._BitmapFontLabel_time_t = self.csbNode:getChildByName("Panel_Discount"):getChildByName("BitmapFontLabel_time")
	self._Sprite_god_1_t = self.csbNode:getChildByName("Panel_Discount"):getChildByName("Sprite_item_1"):getChildByName("Sprite_god_1")
	self._Text_god_num_1_t = self.csbNode:getChildByName("Panel_Discount"):getChildByName("Sprite_item_1"):getChildByName("Text_god_num_1")
	self._Sprite_god_2_t = self.csbNode:getChildByName("Panel_Discount"):getChildByName("Sprite_item_1_0"):getChildByName("Sprite_god_2")
	self._Text_god_num_2_t = self.csbNode:getChildByName("Panel_Discount"):getChildByName("Sprite_item_1_0"):getChildByName("Text_god_num_2")
	self._Text_count_t = self.csbNode:getChildByName("Panel_Discount"):getChildByName("Text_count")
	
    --label list
    
    --button list
    self._Button_close_t = self.csbNode:getChildByName("Panel_Discount"):getChildByName("Button_close")
	self._Button_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_closeClick), "zoom"))

	self._Button_get_t = self.csbNode:getChildByName("Panel_Discount"):getChildByName("Button_get")
	self._Button_get_t:onTouch(Functions.createClickListener(handler(self, self.onButton_getClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_close btFunc
function DiscountPopView:onButton_closeClick()
    Functions.printInfo(self.debug,"Button_close button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_close btFunc end

--@auto code Button_get btFunc
function DiscountPopView:onButton_getClick()
    Functions.printInfo(self.debug,"Button_get button is click!")
    
    local onDiscount = function(event)
        PlayerData.eventAttr.m_gold = event.gold
        if DiscountData.eventAttr.DiscountDataBZ == 1 then
            self:show()
        end
    end
    NetWork:addNetWorkListener({ 20, 32 }, Functions.createNetworkListener(onDiscount,true,"ret"))
    NetWork:sendToServer({ idx = { 20, 32 }})
end
--@auto code Button_get btFunc end

--@auto button backcall end


--@auto code output func
function DiscountPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function DiscountPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	local closeShow = function()
		if DiscountData.eventAttr.DiscountDataBZ == 0 then
            self.close(self)
		end
	end
    Functions.bindUiWithModelAttr(self, DiscountData, "DiscountDataBZ", closeShow)
    self:show()
end

function DiscountPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end


function DiscountPopView:show()
    Functions.printInfo(self.debug,"show ")
    Functions.loadImageWithSprite(self._Sprite_meizi_t, "heroCard/-11.png")
    Functions.loadImageWithSprite(self._Sprite_god_1_t, "tyj/dynamicUI_res/pay_6.png")
    Functions.loadImageWithSprite(self._Sprite_god_2_t, "tyj/dynamicUI_res/pay_6.png")
    self._Text_string_t:setString(DiscountData:GetDescription())
    local str = string.format(LanguageConfig.language_Discount_1, 3 - DiscountData:GetCurCount())
    self._Text_count_t:setString(str)
    
    local pppp = DiscountData:GetFre()
    Functions.initLabelOfString( self._BitmapFontLabel_time_t, DiscountData.eventAttr.remainTimeStr)
    
    if DiscountData:GetDiscountDataBZ() == 1 then
    	Functions.initLabelOfString(self._Text_god_num_1_t, tostring(DiscountData:GetFre()), self._Text_god_num_2_t, tostring(DiscountData:GetNext()))
        if DiscountData:GetNext() <= 0 then
            Functions.setEnabledBt(self._Button_get_t,false)
            Functions.initLabelOfString(self._Text_god_num_2_t, "?????")
        end
    end
    local onShowTime = function(event)
        Functions.initLabelOfString( self._BitmapFontLabel_time_t, event.data)
    end
    
    Functions.bindUiWithModelAttr(self._BitmapFontLabel_time_t, DiscountData, "remainTimeStr", onShowTime)
end

--function DiscountPopView:showTime()
--    Functions.printInfo(self.debug_b,"showTime")
--    --倒记时
--    local onTime = function(event)
--        local m_newtime = TimerManager:getCurrentSecond()
--        local CountdownTime = ShopData:getCountdown()
--        m_newtime = CountdownTime - m_newtime 
--        if m_newtime < 0 then
--            m_newtime = 0
--        end
--
--        local time = TimerManager:formatOverTime("%02d:%02d:%02d", m_newtime)
--        local str = LanguageConfig.language_Shop_3..time
--        Functions.initLabelOfString( self._Text_Countdown_t, str)
--    end
--    Functions.bindEventListener(self._Text_Countdown_t, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
--    onTime()
--end

return DiscountPopView