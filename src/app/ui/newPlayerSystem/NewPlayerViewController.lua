--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local NewPlayerViewController = class("NewPlayerViewController", BaseViewController)

local Functions = require("app.common.Functions")

NewPlayerViewController.debug = true
NewPlayerViewController.modulePath = ...
NewPlayerViewController.studioSpriteFrames = {"NewPlayerUI","NewPlayerPopUI" }
--@auto code head end

NewPlayerViewController.SexEnum = {
    man = 0,
    woman = 1
}

--@Pre loading
NewPlayerViewController.spriteFrameNames = 
    {
    }

NewPlayerViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #NewPlayerViewController.studioSpriteFrames > 0 then
    NewPlayerViewController.spriteFrameNames = NewPlayerViewController.spriteFrameNames or {}
    table.insertto(NewPlayerViewController.spriteFrameNames, NewPlayerViewController.studioSpriteFrames)
end
function NewPlayerViewController:onDidLoadView()

    --output list
    self._manSelected_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectSex_1"):getChildByName("manPanel"):getChildByName("manSelected")
	self._manNoSelect_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectSex_1"):getChildByName("manPanel"):getChildByName("manNoSelect")
	self._womanSelected_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectSex_1"):getChildByName("womanPanel"):getChildByName("womanSelected")
	self._womanNoSelect_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectSex_1"):getChildByName("womanPanel"):getChildByName("womanNoSelect")
	self._nameInput_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectSex_1"):getChildByName("nameInput")
	
    --label list
    
    --button list
    self._manPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectSex_1"):getChildByName("manPanel")
	self._manPanel_t:onTouch(Functions.createClickListener(handler(self, self.onManpanelClick), ""))

	self._womanPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectSex_1"):getChildByName("womanPanel")
	self._womanPanel_t:onTouch(Functions.createClickListener(handler(self, self.onWomanpanelClick), ""))

	self._randomNameBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectSex_1"):getChildByName("randomNameBt")
	self._randomNameBt_t:onTouch(Functions.createClickListener(handler(self, self.onRandomnamebtClick), "zoom"))

	self._sureBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("sureBt")
	self._sureBt_t:onTouch(Functions.createClickListener(handler(self, self.onSurebtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Manpanel btFunc
function NewPlayerViewController:onManpanelClick()
    Functions.printInfo(self.debug,"Manpanel button is click!")
    
    self._selectSex = NewPlayerViewController.SexEnum.man
    -- self:randomName_()

    self._womanNoSelect_t:show()
    self._womanSelected_t:hide()
    self._manSelected_t:show()
    self._manNoSelect_t:hide()
end
--@auto code Manpanel btFunc end

--@auto code Womanpanel btFunc
function NewPlayerViewController:onWomanpanelClick()
    Functions.printInfo(self.debug,"Womanpanel button is click!")
    
    self._selectSex = NewPlayerViewController.SexEnum.woman
    -- self:randomName_()

    self._womanNoSelect_t:hide()
    self._womanSelected_t:show()
    self._manSelected_t:hide()
    self._manNoSelect_t:show()
end
--@auto code Womanpanel btFunc end

--@auto code Randomnamebt btFunc
function NewPlayerViewController:onRandomnamebtClick()
    Functions.printInfo(self.debug,"Randomnamebt button is click!")
    
    -- self:randomName_()
end
--@auto code Randomnamebt btFunc end

--@auto code Surebt btFunc
function NewPlayerViewController:onSurebtClick()
    Functions.printInfo(self.debug,"Surebt button is click!")

    local tempInf = GameState.storeAttr.NaverUserName_s .."," .. GameState:getLoginType() .. "," .. G_SDKType
    --登陆方式："NaverSdk","CstoreLogin","GplayLogin"
    local data = { idx = { 6, 2 },  m_name = self._nameInput_t:getString(), m_sex = self._selectSex,sdkUserId = tempInf }

    local onSavePlayerInfo = function(event)
        PlayerData.eventAttr.m_name = self._nameInput_t:getString()
        PlayerData.eventAttr.m_introSec = self._selectSex
        PlayerData.eventAttr.m_imgID = event.img
        PlayerData.eventAttr.m_sex = self._selectSex

        --sdk
        Functions.setAdbrixTag("firstTimeExperience","loading_2_try")

        GameCtlManager:goTo("app.ui.mainSystem.MainViewController")
    end
    NetWork:addNetWorkListener({ 6, 2 }, Functions.createNetworkListener(onSavePlayerInfo,true,"ret"))
    NetWork:sendToServer(data)
    --sdk
    Functions.setAdbrixTag("firstTimeExperience","nickname_create_complete")
end
--@auto code Surebt btFunc end

--@auto button backcall end


--@auto code view display func
function NewPlayerViewController:onCreate()
    Functions.printInfo(self.debug_b," NewPlayerViewController controller create!")
end

function NewPlayerViewController:onDisplayView()
	Functions.printInfo(self.debug_b," NewPlayerViewController view enter display!")

    --sdk
    Functions.setAdbrixTag("firstTimeExperience","nickname_create_try")

    --设置输入占位符
    self._nameInput_t:setPlaceHolder(LanguageConfig.ui_NewPlayerView_1)

    --属性初始化
    self._selectSex = NewPlayerViewController.SexEnum.man
    -- self._setName = self:randomName_()
end
--@auto code view display func end

function NewPlayerViewController:randomName_()
    local randomName = cs_GetRoleName(self._selectSex)
    self._nameInput_t:setString(randomName)

    return randomName
end

return NewPlayerViewController