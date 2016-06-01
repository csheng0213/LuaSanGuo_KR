--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local MainSceneViewController = class("MainSceneViewController", BaseViewController)

local Functions = require("app.common.Functions")

MainSceneViewController.debug = true
MainSceneViewController.modulePath = ...
--@auto code head end

--@Pre loading
MainSceneViewController.spriteFrameNames = 
    {
    }

MainSceneViewController.animaNames = 
    {
    }


--@auto code uiInit
function MainSceneViewController:onDidLoadView()

    --output list
    
    --label list
    
    --button list
    self._aniBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("aniBt")
	self._aniBt_t:onTouch(Functions.createClickListener(handler(self, self.onAnibtClick), "zoom"))

	self._resBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("resBt")
	self._resBt_t:onTouch(Functions.createClickListener(handler(self, self.onResbtClick), "zoom"))

	self._langBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("langBt")
	self._langBt_t:onTouch(Functions.createClickListener(handler(self, self.onLangbtClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Anibt btFunc
function MainSceneViewController:onAnibtClick()
    Functions.printInfo(self.debug,"Anibt button is click!")
end
--@auto code Anibt btFunc end

--@auto code Resbt btFunc
function MainSceneViewController:onResbtClick()
    Functions.printInfo(self.debug,"Resbt button is click!")
end
--@auto code Resbt btFunc end

--@auto code Langbt btFunc
function MainSceneViewController:onLangbtClick()
    Functions.printInfo(self.debug,"Langbt button is click!")
end
--@auto code Langbt btFunc end

--@auto button backcall end


--@auto code view display func
function MainSceneViewController:onCreate()
    Functions.printInfo(self.debug_b," MainSceneViewController controller create!")
end

function MainSceneViewController:onDisplayView()
	Functions.printInfo(self.debug_b," MainSceneViewController view enter display!")
end
--@auto code view display func end

return MainSceneViewController