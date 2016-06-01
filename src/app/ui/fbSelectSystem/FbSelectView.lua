--@auto code head
local BaseView = require("app.baseMVC.BaseView")
local FbSelectView = class("FbSelectView", BaseView)

local Functions = require("app.common.Functions")

FbSelectView.csbResPath = "cs/csb"
FbSelectView.debug = true
--@auto code head end


--@auto code uiInit
function FbSelectView:onInitUI()

    --output list
    
    --label list
    
    --button list
    
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_7 btFunc
function FbSelectView:onButton_7Click()
    Functions.printInfo(self.debug,"Button_7 button is click!")
end
--@auto code Button_7 btFunc end

--@auto button backcall end


return FbSelectView