--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local NewPlayerPopView = class("NewPlayerPopView", BasePopView)

local Functions = require("app.common.Functions")

NewPlayerPopView.csbResPath = "cs/csb"
NewPlayerPopView.debug = true
NewPlayerPopView.studioSpriteFrames = { }
--@auto code head end

NewPlayerPopView.SexEnum = {
    man = 0,
    woman = 1
}

--@auto code uiInit
--add spriteFrames
if #NewPlayerPopView.studioSpriteFrames > 0 then
    NewPlayerPopView.spriteFrameNames = NewPlayerPopView.spriteFrameNames or {}
    table.insertto(NewPlayerPopView.spriteFrameNames, NewPlayerPopView.studioSpriteFrames)
end
function NewPlayerPopView:onInitUI()

    --output list
    self._manSelected_t = self.csbNode:getChildByName("Panel_3"):getChildByName("selectSex_1"):getChildByName("manPanel"):getChildByName("manSelected")
	self._manNoSelect_t = self.csbNode:getChildByName("Panel_3"):getChildByName("selectSex_1"):getChildByName("manPanel"):getChildByName("manNoSelect")
	self._womanSelected_t = self.csbNode:getChildByName("Panel_3"):getChildByName("selectSex_1"):getChildByName("womanPanel"):getChildByName("womanSelected")
	self._womanNoSelect_t = self.csbNode:getChildByName("Panel_3"):getChildByName("selectSex_1"):getChildByName("womanPanel"):getChildByName("womanNoSelect")
	self._nameInput_t = self.csbNode:getChildByName("Panel_3"):getChildByName("selectSex_1"):getChildByName("nameInput")
	
    --label list
    
    --button list
    self._manPanel_t = self.csbNode:getChildByName("Panel_3"):getChildByName("selectSex_1"):getChildByName("manPanel")
	self._manPanel_t:onTouch(Functions.createClickListener(handler(self, self.onManpanelClick), ""))

	self._womanPanel_t = self.csbNode:getChildByName("Panel_3"):getChildByName("selectSex_1"):getChildByName("womanPanel")
	self._womanPanel_t:onTouch(Functions.createClickListener(handler(self, self.onWomanpanelClick), ""))

	self._sureBt_t = self.csbNode:getChildByName("Panel_3"):getChildByName("selectSex_1"):getChildByName("sureBt")
	self._sureBt_t:onTouch(Functions.createClickListener(handler(self, self.onSurebtClick), ""))

	self._randomNameBt_t = self.csbNode:getChildByName("Panel_3"):getChildByName("selectSex_1"):getChildByName("randomNameBt")
	self._randomNameBt_t:onTouch(Functions.createClickListener(handler(self, self.onRandomnamebtClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Manpanel btFunc
function NewPlayerPopView:onManpanelClick()
    Functions.printInfo(self.debug,"Manpanel button is click!")
    
    self._selectSex = NewPlayerPopView.SexEnum.man
    self:randomName_()
    
    self._womanNoSelect_t:show()
    self._womanSelected_t:hide()
    self._manSelected_t:show()
    self._manNoSelect_t:hide()
    
end
--@auto code Manpanel btFunc end

--@auto code Womanpanel btFunc
function NewPlayerPopView:onWomanpanelClick()
    Functions.printInfo(self.debug,"Womanpanel button is click!")
    
    self._selectSex = NewPlayerPopView.SexEnum.woman
    self:randomName_()
    
    self._womanNoSelect_t:hide()
    self._womanSelected_t:show()
    self._manSelected_t:hide()
    self._manNoSelect_t:show()
    
end
--@auto code Womanpanel btFunc end

--@auto code Randomnamebt btFunc
function NewPlayerPopView:onRandomnamebtClick()
    Functions.printInfo(self.debug,"Randomnamebt button is click!")
    
    self:randomName_()
end
--@auto code Randomnamebt btFunc end

--@auto code Surebt btFunc
function NewPlayerPopView:onSurebtClick()
    Functions.printInfo(self.debug,"Surebt button is click!")
    
    local data = { idx = { 6, 2 }, m_name = self._nameInput_t:getString(), m_sex = self._selectSex }
    
    local onSavePlayerInfo = function(event)
    
    	if event.ret == 1 then
            PlayerData.eventAttr.m_name = self._nameInput_t:getString()
            PlayerData.eventAttr.m_introSec = self._selectSex
            PlayerData.eventAttr.m_imgID = event.img
            PlayerData.eventAttr.m_sex = self._selectSex
            self:close()
        elseif event.ret == ErrorCode.NameRepeat then
            PromptManager:openTipPrompt(LanguageConfig.language_0_16)
        elseif event.ret == ErrorCode.NamEillegal then
            PromptManager:openTipPrompt(LanguageConfig.language_0_17)
    	end
    	
        return true
    end
    NetWork:addNetWorkListener({ 6, 2 }, onSavePlayerInfo)

    NetWork:sendToServer(data)
    
end
--@auto code Surebt btFunc end

--@auto button backcall end


--@auto code output func
function NewPlayerPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function NewPlayerPopView:onDisplayView(...)
	Functions.printInfo(self.debug,"pop action finish ")

end

function NewPlayerPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
	
	--属性初始化
    self._selectSex = NewPlayerPopView.SexEnum.man
	self._setName = self:randomName_()
	
end
--@auto code output func end

function NewPlayerPopView:randomName_()
    local randomName = cs_GetRoleName(self._selectSex)
    self._nameInput_t:setString(randomName)
    
    return randomName
end

return NewPlayerPopView