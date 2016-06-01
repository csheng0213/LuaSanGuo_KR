--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local EnlistTwoPopView = class("EnlistTwoPopView", BasePopView)

local Functions = require("app.common.Functions")

EnlistTwoPopView.csbResPath = "lk/csb"
EnlistTwoPopView.debug = true
EnlistTwoPopView.studioSpriteFrames = { }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #EnlistTwoPopView.studioSpriteFrames > 0 then
    EnlistTwoPopView.spriteFrameNames = EnlistTwoPopView.spriteFrameNames or {}
    table.insertto(EnlistTwoPopView.spriteFrameNames, EnlistTwoPopView.studioSpriteFrames)
end
function EnlistTwoPopView:onInitUI()

    --output list
    
    --label list
    
    --button list
    self._Button_again_t = self.csbNode:getChildByName("Panel_Two_page"):getChildByName("Button_again")
	self._Button_again_t:onTouch(Functions.createClickListener(handler(self, self.onButton_againClick), "zoom"))

	self._Button_see_t = self.csbNode:getChildByName("Panel_Two_page"):getChildByName("Button_see")
	self._Button_see_t:onTouch(Functions.createClickListener(handler(self, self.onButton_seeClick), "zoom"))

	self._Button_back_t = self.csbNode:getChildByName("Panel_Two_page"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

	self._Button_jump_t = self.csbNode:getChildByName("Panel_Two_page"):getChildByName("Button_jump")
	self._Button_jump_t:onTouch(Functions.createClickListener(handler(self, self.onButton_jumpClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_again btFunc
function EnlistTwoPopView:onButton_againClick()
    Functions.printInfo(self.debug,"Button_again button is click!")
end
--@auto code Button_again btFunc end

--@auto code Button_see btFunc
function EnlistTwoPopView:onButton_seeClick()
    Functions.printInfo(self.debug,"Button_see button is click!")
end
--@auto code Button_see btFunc end

--@auto code Button_back btFunc
function EnlistTwoPopView:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
end
--@auto code Button_back btFunc end

--@auto code Button_jump btFunc
function EnlistTwoPopView:onButton_jumpClick()
    Functions.printInfo(self.debug,"Button_jump button is click!")
end
--@auto code Button_jump btFunc end

--@auto button backcall end


--@auto code output func
function EnlistTwoPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function EnlistTwoPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
end

function EnlistTwoPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return EnlistTwoPopView