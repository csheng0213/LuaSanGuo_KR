--@auto code head
local BaseView = require("app.baseMVC.BaseView")
local PropView = class("PropView", BaseView)

local Functions = require("app.common.Functions")

PropView.csbResPath = "tyj/csb"
PropView.debug = true
--@auto code head end


--@auto code uiInit
function PropView:onInitUI()

    --output list
    
    --label list
    self._titleInfLabel_t = self.csbNode:getChildByName("main"):getChildByName("propListPanel"):getChildByName("propInfBg"):getChildByName("propInfPanel"):getChildByName("titleInfLabel")
	self._titleInfLabel_t:setString(LanguageConfig.language_prop_13)

	self._huisouLabel_t = self.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("huisouLabel")
	self._huisouLabel_t:setString(LanguageConfig.language_Teach36)
    --button list
    
end
--@auto code uiInit end


return PropView