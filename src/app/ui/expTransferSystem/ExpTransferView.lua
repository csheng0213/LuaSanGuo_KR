--@auto code head
local BaseView = require("app.baseMVC.BaseView")
local ExpTransferView = class("ExpTransferView", BaseView)

local Functions = require("app.common.Functions")

ExpTransferView.csbResPath = "lk/csb"
ExpTransferView.debug = true
--@auto code head end


--@auto code uiInit
function ExpTransferView:onInitUI()

    --output list
    
    --label list
    
    --button list
    self._Button_back_t = self.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function ExpTransferView:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
end
--@auto code Button_back btFunc end

--@auto code Button_rule btFunc
function ExpTransferView:onButton_ruleClick()
    Functions.printInfo(self.debug,"Button_rule button is click!")
end
--@auto code Button_rule btFunc end

--@auto button backcall end


return ExpTransferView