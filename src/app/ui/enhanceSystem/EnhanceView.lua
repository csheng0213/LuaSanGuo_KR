--@auto code head
local BaseView = require("app.baseMVC.BaseView")
local EnhanceView = class("EnhanceView", BaseView)

local Functions = require("app.common.Functions")

EnhanceView.csbResPath = "lk/csb"
EnhanceView.debug = true
--@auto code head end


--@auto code uiInit
function EnhanceView:onInitUI()

    --output list
    
    --label list
    
    --button list
    self._Button_back_t = self.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function EnhanceView:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
end
--@auto code Button_back btFunc end

--@auto code Text_soul btFunc
function EnhanceView:onText_soulClick()
    Functions.printInfo(self.debug,"Text_soul button is click!")
end
--@auto code Text_soul btFunc end

--@auto code Button_shengji_1 btFunc
function EnhanceView:onButton_shengji_1Click()
    Functions.printInfo(self.debug,"Button_shengji_1 button is click!")
end
--@auto code Button_shengji_1 btFunc end

--@auto code Button_jinjie_2 btFunc
function EnhanceView:onButton_jinjie_2Click()
    Functions.printInfo(self.debug,"Button_jinjie_2 button is click!")
end
--@auto code Button_jinjie_2 btFunc end

--@auto button backcall end


return EnhanceView