--@auto code head
local BaseView = require("app.baseMVC.BaseView")
local UnionView = class("UnionView", BaseView)

local Functions = require("app.common.Functions")

UnionView.csbResPath = "lk/csb"
UnionView.debug = true
--@auto code head end


--@auto code uiInit
function UnionView:onInitUI()

    --output list
    
    --label list
    
    --button list
    
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Text_soul btFunc
function UnionView:onText_soulClick()
    Functions.printInfo(self.debug,"Text_soul button is click!")
end
--@auto code Text_soul btFunc end

--@auto code Checkbox_add_1 btFunc
function UnionView:onCheckbox_add_1Click()
    Functions.printInfo(self.debug,"Checkbox_add_1 button is click!")
end
--@auto code Checkbox_add_1 btFunc end

--@auto code Checkbox_creat_2 btFunc
function UnionView:onCheckbox_creat_2Click()
    Functions.printInfo(self.debug,"Checkbox_creat_2 button is click!")
end
--@auto code Checkbox_creat_2 btFunc end

--@auto code Checkbox_find_3 btFunc
function UnionView:onCheckbox_find_3Click()
    Functions.printInfo(self.debug,"Checkbox_find_3 button is click!")
end
--@auto code Checkbox_find_3 btFunc end

--@auto button backcall end


return UnionView