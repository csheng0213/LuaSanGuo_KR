--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local HeroReplacePopView = class("HeroReplacePopView", BasePopView)

local Functions = require("app.common.Functions")

HeroReplacePopView.csbResPath = "tyj/csb"
HeroReplacePopView.debug = true
HeroReplacePopView.studioSpriteFrames = {"CB_unionTankuang","HeroReplacePopUI","HeroReplacePopBgUI" }
--@auto code head end

HeroReplacePopView.spriteFrameNames = 
    {
    }
--@auto code uiInit
--add spriteFrames
if #HeroReplacePopView.studioSpriteFrames > 0 then
    HeroReplacePopView.spriteFrameNames = HeroReplacePopView.spriteFrameNames or {}
    table.insertto(HeroReplacePopView.spriteFrameNames, HeroReplacePopView.studioSpriteFrames)
end
function HeroReplacePopView:onInitUI()

    --output list
    self._nowPanel_t = self.csbNode:getChildByName("Panel_1"):getChildByName("nowPanel")
	self._selectedPanel_t = self.csbNode:getChildByName("Panel_1"):getChildByName("selectedPanel")
	
    --label list
    
    --button list
    self._closeBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))

	self._bt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("selectedPanel"):getChildByName("bt")
	self._bt_t:onTouch(Functions.createClickListener(handler(self, self.onBtClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function HeroReplacePopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:getController():closeChildView(self)
end
--@auto code Closebt btFunc end

--@auto code Bt btFunc
function HeroReplacePopView:onBtClick()
    Functions.printInfo(self.debug,"Bt button is click!")
    if self:getController().heroMark ~= nil and self:getController().heroId then 
        local controller = self:getController()
        controller:closeChildView(self)
        controller:shangZhengHero(controller.jumpData.heroType)
	end
end
--@auto code Bt btFunc end

--@auto button backcall end


--@auto code output func
function HeroReplacePopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function HeroReplacePopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	Functions.displayHeroInf(self._nowPanel_t,data.nowHeroMark)
    Functions.displayHeroInf(self._selectedPanel_t,data.selectedHeroMark)
end

function HeroReplacePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")    
end
--@auto code output func end

return HeroReplacePopView