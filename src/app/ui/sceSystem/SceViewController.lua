--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local SceViewController = class("SceViewController", BaseViewController)

local Functions = require("app.common.Functions")

SceViewController.debug = true
SceViewController.modulePath = ...
--@auto code head end

--@Pre loading
SceViewController.spriteFrameNames = 
    {
    }

SceViewController.animaNames = 
    {
    }


--@auto code uiInit
function SceViewController:onDidLoadView()

    --output list
    
    --button list
    

end
--@auto code uiInit end


--@auto code view display func
function SceViewController:onCreate()
    Functions.printInfo(self.debug_b," SceViewController controller create!")
end

function SceViewController:onDisplayView()
	Functions.printInfo(self.debug_b," SceViewController view enter display!")
end
--@auto code view display func end

return SceViewController