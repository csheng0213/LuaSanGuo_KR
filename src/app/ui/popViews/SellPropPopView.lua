--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local SellPropPopView = class("SellPropPopView", BasePopView)

local Functions = require("app.common.Functions")

SellPropPopView.csbResPath = "tyj/csb"
SellPropPopView.debug = true
SellPropPopView.studioSpriteFrames = {"PropUI" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #SellPropPopView.studioSpriteFrames > 0 then
    SellPropPopView.spriteFrameNames = SellPropPopView.spriteFrameNames or {}
    table.insertto(SellPropPopView.spriteFrameNames, SellPropPopView.studioSpriteFrames)
end
function SellPropPopView:onInitUI()

    --output list
    self._rewardPanel_t = self.csbNode:getChildByName("rewardPanel")
	self._sellNum_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("sellNum")
	self._huishou_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("huishou")
	self._propView_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("propView")
	self._propName_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("propName")
	
    --label list
    
    --button list
    self._okBt_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("okBt")
	self._okBt_t:onTouch(Functions.createClickListener(handler(self, self.onOkbtClick), ""))

	self._cancalBt_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("cancalBt")
	self._cancalBt_t:onTouch(Functions.createClickListener(handler(self, self.onCancalbtClick), ""))

	self._addBt_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("addBt")
	self._addBt_t:onTouch(Functions.createClickListener(handler(self, self.onAddbtClick), ""))

	self._miuBt_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("miuBt")
	self._miuBt_t:onTouch(Functions.createClickListener(handler(self, self.onMiubtClick), ""))

	self._miu10Bt_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("miu10Bt")
	self._miu10Bt_t:onTouch(Functions.createClickListener(handler(self, self.onMiu10btClick), ""))

	self._add10Bt_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("add10Bt")
	self._add10Bt_t:onTouch(Functions.createClickListener(handler(self, self.onAdd10btClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Okbt btFunc
function SellPropPopView:onOkbtClick()
    Functions.printInfo(self.debug,"Okbt button is click!")
    if self.handler ~= nil then 
    	self.handler(self.curPropNum)
    end
    if self.close ~= nil then
        self:close()
    end
end
--@auto code Okbt btFunc end

--@auto code Cancalbt btFunc
function SellPropPopView:onCancalbtClick()
    Functions.printInfo(self.debug,"Cancalbt button is click!")
    if self.close ~= nil then
        self:close()
    end
end
--@auto code Cancalbt btFunc end

--@auto code Addbt btFunc
function SellPropPopView:onAddbtClick()
    Functions.printInfo(self.debug,"Addbt button is click!")    
    if PropData:getPropNumOfId(self.propId) > self.curPropNum then
    	self.curPropNum = self.curPropNum + 1
    	self:updateDisplay()
    end
end
--@auto code Addbt btFunc end

--@auto code Miubt btFunc
function SellPropPopView:onMiubtClick()
    Functions.printInfo(self.debug,"Miubt button is click!")
    if self.curPropNum > 1 then
    	self.curPropNum = self.curPropNum - 1
    	self:updateDisplay()
    end
end
--@auto code Miubt btFunc end

--@auto code Miu10bt btFunc
function SellPropPopView:onMiu10btClick()
    Functions.printInfo(self.debug,"Miu10bt button is click!")
    if self.curPropNum > 10 then
    	self.curPropNum = self.curPropNum - 10
    else
    	self.curPropNum = 1
    end
    self:updateDisplay()
end
--@auto code Miu10bt btFunc end

--@auto code Add10bt btFunc
function SellPropPopView:onAdd10btClick()
    Functions.printInfo(self.debug,"Add10bt button is click!")
    if PropData:getPropNumOfId(self.propId) - self.curPropNum > 10 then
    	self.curPropNum = self.curPropNum + 10
    else
    	self.curPropNum = PropData:getPropNumOfId(self.propId)
    end
     self:updateDisplay()
end
--@auto code Add10bt btFunc end

--@auto button backcall end


--@auto code output func
function SellPropPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function SellPropPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	self.curPropNum = 1
    self.propPrice = 0
	if self.propId ~= nil then 
		self._propName_t:setString(ConfigHandler:getPropNameOfId(self.propId))
		Functions.loadImageWithWidget(self._propView_t,ConfigHandler:getPropImageOfId(self.propId))
		self.curPropNum = PropData:getPropNumOfId(self.propId)
        self.propPrice = ConfigHandler:getPropPriceOfId(self.propId)
	end
	self:updateDisplay()
end

function SellPropPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function SellPropPopView:setPorp(propId)
	 self.propId = propId
end
function SellPropPopView:setHandler(handler )
	self.handler = handler
end
function SellPropPopView:updateDisplay( )
	self._sellNum_t:setString(tostring(self.curPropNum))
	self._huishou_t:setString(LanguageConfig.language_Teach41 .. tostring(self.curPropNum * self.propPrice))
end
return SellPropPopView