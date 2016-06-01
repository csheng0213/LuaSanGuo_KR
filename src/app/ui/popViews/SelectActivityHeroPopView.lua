--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local SelectActivityHeroPopView = class("SelectActivityHeroPopView", BasePopView)

local Functions = require("app.common.Functions")

SelectActivityHeroPopView.csbResPath = "tyj/csb"
SelectActivityHeroPopView.debug = true
SelectActivityHeroPopView.studioSpriteFrames = {"SelectActivityHeroPopUI_Text","ActivityHeroPopUI" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #SelectActivityHeroPopView.studioSpriteFrames > 0 then
    SelectActivityHeroPopView.spriteFrameNames = SelectActivityHeroPopView.spriteFrameNames or {}
    table.insertto(SelectActivityHeroPopView.spriteFrameNames, SelectActivityHeroPopView.studioSpriteFrames)
end
function SelectActivityHeroPopView:onInitUI()

    --output list
    self._btPanel_t = self.csbNode:getChildByName("btPanel")
	
    --label list
    
    --button list
    self._weiBt_t = self.csbNode:getChildByName("btPanel"):getChildByName("weiBt")
	self._weiBt_t:onTouch(Functions.createClickListener(handler(self, self.onWeibtClick), "zoom"))

	self._shuBt_t = self.csbNode:getChildByName("btPanel"):getChildByName("shuBt")
	self._shuBt_t:onTouch(Functions.createClickListener(handler(self, self.onShubtClick), "zoom"))

	self._wuBt_t = self.csbNode:getChildByName("btPanel"):getChildByName("wuBt")
	self._wuBt_t:onTouch(Functions.createClickListener(handler(self, self.onWubtClick), "zoom"))

	self._qunBt_t = self.csbNode:getChildByName("btPanel"):getChildByName("qunBt")
	self._qunBt_t:onTouch(Functions.createClickListener(handler(self, self.onQunbtClick), "zoom"))

	self._specialBt_t = self.csbNode:getChildByName("btPanel"):getChildByName("specialBt")
	self._specialBt_t:onTouch(Functions.createClickListener(handler(self, self.onSpecialbtClick), "zoom"))

	self._closeBt_t = self.csbNode:getChildByName("btPanel"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Weibt btFunc
function SelectActivityHeroPopView:onWeibtClick()
    Functions.printInfo(self.debug,"Weibt button is click!")
    self:getController():openChildView("app.ui.popViews.ActivityHeroPopView", {isRemove = false,data = {type = 1}})
end
--@auto code Weibt btFunc end

--@auto code Shubt btFunc
function SelectActivityHeroPopView:onShubtClick()
    Functions.printInfo(self.debug,"Shubt button is click!")
    self:getController():openChildView("app.ui.popViews.ActivityHeroPopView", {isRemove = false,data = {type = 2}})
end
--@auto code Shubt btFunc end

--@auto code Wubt btFunc
function SelectActivityHeroPopView:onWubtClick()
    Functions.printInfo(self.debug,"Wubt button is click!")
    self:getController():openChildView("app.ui.popViews.ActivityHeroPopView", {isRemove = false,data = {type = 3}})
end
--@auto code Wubt btFunc end

--@auto code Qunbt btFunc
function SelectActivityHeroPopView:onQunbtClick()
    Functions.printInfo(self.debug,"Qunbt button is click!")
    self:getController():openChildView("app.ui.popViews.ActivityHeroPopView", {isRemove = false,data = {type = 4}})
end
--@auto code Qunbt btFunc end

--@auto code Specialbt btFunc
function SelectActivityHeroPopView:onSpecialbtClick()
    Functions.printInfo(self.debug,"Specialbt button is click!")
    self:getController():openChildView("app.ui.popViews.ActivityHeroPopView", {isRemove = false,data = {type = 5}})
end
--@auto code Specialbt btFunc end

--@auto code Closebt btFunc
function SelectActivityHeroPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:getController():closeChildView(self)
end
--@auto code Closebt btFunc end

--@auto button backcall end


--@auto code output func
function SelectActivityHeroPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function SelectActivityHeroPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	Functions.bindUiWithModelAttr(self._qunBt_t, ActivityData, "activityHeroTime",function(event)
       	if event.data <= 1 then 
	   		self:getController():closeChildView(self)
	   	end
	end)
	for i = 1,#ActivityData.xsHero.isEnableHero do 
		if not ActivityData.xsHero.isEnableHero[i] then
			Functions.setEnabledBt(self._btPanel_t:getChildByTag(i), false)
		end
	end
end

function SelectActivityHeroPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return SelectActivityHeroPopView