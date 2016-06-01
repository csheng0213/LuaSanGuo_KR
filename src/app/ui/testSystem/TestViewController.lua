--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local TestViewController = class("TestViewController", BaseViewController)

local Functions = require("app.common.Functions")

TestViewController.debug = true
TestViewController.modulePath = ...
--@auto code head end

--@Pre loading
TestViewController.spriteFrameNames = 
    {
    }

TestViewController.animaNames = 
    {
    }


--@auto code uiInit
function TestViewController:onDidLoadView()

    --output list
    self._anima_t = self.view_t.csbNode:getChildByName("main"):getChildByName("anima")
	
    --label list
    
    --button list
    self._Button_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Button_1")
	self._Button_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_1Click), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_1 btFunc
function TestViewController:onButton_1Click()
    Functions.printInfo(self.debug,"Button_1 button is click!")
end
--@auto code Button_1 btFunc end

--@auto button backcall end


--@auto code view display func
function TestViewController:onCreate()
    Functions.printInfo(self.debug_b," TestViewController controller create!")
end

function TestViewController:onDisplayView()
	Functions.printInfo(self.debug_b," TestViewController view enter display!")
end
--@auto code view display func end

return TestViewController