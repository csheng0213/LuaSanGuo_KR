--@auto code head
local BaseView = require("app.baseMVC.BaseView")
local ShopView = class("ShopView", BaseView)

local Functions = require("app.common.Functions")

ShopView.csbResPath = "lk/csb"
ShopView.debug = true
--@auto code head end


--@auto code uiInit
function ShopView:onInitUI()

    --output list
    
    --label list
    
    --button list
    
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Text_soul btFunc
function ShopView:onText_soulClick()
    Functions.printInfo(self.debug,"Text_soul button is click!")
end
--@auto code Text_soul btFunc end

--@auto button backcall end


return ShopView