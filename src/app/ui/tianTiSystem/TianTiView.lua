--@auto code head
local BaseView = require("app.baseMVC.BaseView")
local TianTiView = class("TianTiView", BaseView)

local Functions = require("app.common.Functions")

TianTiView.csbResPath = "tyj/csb"
TianTiView.debug = true
--@auto code head end


--@auto code uiInit
function TianTiView:onInitUI()

    --output list
    
    --label list
    
    --button list
    
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function TianTiView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
end
--@auto code Closebt btFunc end

--@auto button backcall end


return TianTiView