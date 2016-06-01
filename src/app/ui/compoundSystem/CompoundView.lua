--@auto code head
local BaseView = require("app.baseMVC.BaseView")
local CompoundView = class("CompoundView", BaseView)

local Functions = require("app.common.Functions")

CompoundView.csbResPath = "lk/csb"
CompoundView.debug = true
--@auto code head end


--@auto code uiInit
function CompoundView:onInitUI()

    --output list
    
    --label list
    
    --button list
    
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Text_soul btFunc
function CompoundView:onText_soulClick()
    Functions.printInfo(self.debug,"Text_soul button is click!")
end
--@auto code Text_soul btFunc end

--@auto button backcall end


return CompoundView