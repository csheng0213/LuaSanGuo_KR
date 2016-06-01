--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local GvgBidNumPopView = class("GvgBidNumPopView", BasePopView)

local Functions = require("app.common.Functions")

GvgBidNumPopView.csbResPath = "lk/csb"
GvgBidNumPopView.debug = true
GvgBidNumPopView.studioSpriteFrames = {"GvgUI_Text" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #GvgBidNumPopView.studioSpriteFrames > 0 then
    GvgBidNumPopView.spriteFrameNames = GvgBidNumPopView.spriteFrameNames or {}
    table.insertto(GvgBidNumPopView.spriteFrameNames, GvgBidNumPopView.studioSpriteFrames)
end
function GvgBidNumPopView:onInitUI()

    --output list
    self._TextField_jinjia_num_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("TextField_jinjia_num")
	self._Text_num_1_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Text_num_1")
	self._Text_num_2_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Text_num_2")
	
    --label list
    
    --button list
    self._Button_bid_close_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Button_bid_close")
	self._Button_bid_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_bid_closeClick), "zoom"))

	self._Button_quxiao_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Button_quxiao")
	self._Button_quxiao_t:onTouch(Functions.createClickListener(handler(self, self.onButton_quxiaoClick), "zoom"))

	self._Button_ok_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Button_ok")
	self._Button_ok_t:onTouch(Functions.createClickListener(handler(self, self.onButton_okClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_bid_close btFunc
function GvgBidNumPopView:onButton_bid_closeClick()
    Functions.printInfo(self.debug,"Button_bid_close button is click!")
    self:close(self)
end
--@auto code Button_bid_close btFunc end

--@auto code Button_quxiao btFunc
function GvgBidNumPopView:onButton_quxiaoClick()
    Functions.printInfo(self.debug,"Button_quxiao button is click!")
    self:close(self)
end
--@auto code Button_quxiao btFunc end

--@auto code Button_ok btFunc
function GvgBidNumPopView:onButton_okClick()
    Functions.printInfo(self.debug,"Button_ok button is click!")
    local data = GuildBattleData:getBidInfo()
    local biaoZhi = Functions.isNumber(self._TextField_jinjia_num_t:getString())
    if biaoZhi then
        GuildBattleData:sendBidMoney( data.id, tonumber(self._TextField_jinjia_num_t:getString()))
    else
        --弹出报错信息
        PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(1076))
    end
    self:close(self)
end
--@auto code Button_ok btFunc end

--@auto button backcall end


--@auto code output func
function GvgBidNumPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function GvgBidNumPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    local data = GuildBattleData:getBidInfo()
    self._Text_num_1_t:setString(tostring(data.allActif))
    self._Text_num_2_t:setString(tostring(data.bidBasePrice))
end

function GvgBidNumPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return GvgBidNumPopView