--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local EulaSceneViewController = class("EulaSceneViewController", BaseViewController)

local Functions = require("app.common.Functions")

EulaSceneViewController.debug = true
EulaSceneViewController.modulePath = ...
EulaSceneViewController.studioSpriteFrames = {"CB_zbsnsg","EquipmentUI" }
--@auto code head end
-- local TextReader = require("app.common.TextReader")

--@Pre loading
EulaSceneViewController.spriteFrameNames = 
    {
    }

EulaSceneViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #EulaSceneViewController.studioSpriteFrames > 0 then
    EulaSceneViewController.spriteFrameNames = EulaSceneViewController.spriteFrameNames or {}
    table.insertto(EulaSceneViewController.spriteFrameNames, EulaSceneViewController.studioSpriteFrames)
end
function EulaSceneViewController:onDidLoadView()

    --output list
    
    --label list
    
    --button list
    self._agreeBox1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("blackColorLayer"):getChildByName("Image_1"):getChildByName("agreeBox1")
	self._agreeBox1_t:onTouch(Functions.createClickListener(handler(self, self.onAgreebox1Click), ""))

	self._chakanBt1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("blackColorLayer"):getChildByName("Image_1"):getChildByName("chakanBt1")
	self._chakanBt1_t:onTouch(Functions.createClickListener(handler(self, self.onChakanbt1Click), ""))

	self._confirmBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("blackColorLayer"):getChildByName("confirmBt")
	self._confirmBt_t:onTouch(Functions.createClickListener(handler(self, self.onConfirmbtClick), ""))

	self._agreeBox2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("blackColorLayer"):getChildByName("Image_1_0"):getChildByName("agreeBox2")
	self._agreeBox2_t:onTouch(Functions.createClickListener(handler(self, self.onAgreebox2Click), ""))

	self._chakanBt2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("blackColorLayer"):getChildByName("Image_1_0"):getChildByName("chakanBt2")
	self._chakanBt2_t:onTouch(Functions.createClickListener(handler(self, self.onChakanbt2Click), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Agreebox1 btFunc
function EulaSceneViewController:onAgreebox1Click()
    Functions.printInfo(self.debug,"Agreebox1 button is click!")
    if self.agreeFlag1 then
        self.agreeFlag1 = false 
    else
        self.agreeFlag1 = true
    end
    self:updateConfirmBt()
end
--@auto code Agreebox1 btFunc end

--@auto code Agreebox2 btFunc
function EulaSceneViewController:onAgreebox2Click()
    Functions.printInfo(self.debug,"Agreebox2 button is click!")
    if self.agreeFlag2 then
        self.agreeFlag2 = false 
    else
        self.agreeFlag2 = true
    end
    self:updateConfirmBt()
end
--@auto code Agreebox2 btFunc end

--@auto code Leftdownbt btFunc
function EulaSceneViewController:onLeftdownbtClick()
    Functions.printInfo(self.debug,"Leftdownbt button is click!")
    self._ScrollView1_t:scrollToTop(0.1,true)
    if self.termsIndex < #self.termsData then
        self.termsIndex = self.termsIndex + 1 
        self:updatePageBt(1)
        self._Text_1_t:setString(self.termsData[self.termsIndex])
        local renderSize = self._Text_1_t:getVirtualRendererSize ()
        self._Text_1_t:setTextAreaSize(renderSize)
        self._Text_1_t:setPositionY(renderSize.height)
        self._ScrollView1_t:setInnerContainerSize(renderSize)        
    end    
end
--@auto code Leftdownbt btFunc end

--@auto code Rightdownbt btFunc
function EulaSceneViewController:onRightdownbtClick()
    self._ScrollView2_t:scrollToTop(0.1,true)
    if self.policiesIndex < #self.policiesData then
        self.policiesIndex = self.policiesIndex + 1 
        self:updatePageBt(2)       
        self._Text_2_t:setString(self.policiesData[self.policiesIndex])
        local renderSize = self._Text_2_t:getVirtualRendererSize ()
        self._Text_2_t:setTextAreaSize(renderSize)
        self._Text_2_t:setPositionY(renderSize.height)
        self._ScrollView2_t:setInnerContainerSize(renderSize)
    end    
end
--@auto code Rightdownbt btFunc end

--@auto code Leftupbt btFunc
function EulaSceneViewController:onLeftupbtClick()
    Functions.printInfo(self.debug,"Leftupbt button is click!")
    self._ScrollView1_t:scrollToTop(0.1,true)
    if self.termsIndex > 1 then
        self.termsIndex = self.termsIndex - 1 
        self:updatePageBt(1)
        self._Text_1_t:setString(self.termsData[self.termsIndex])
        local renderSize = self._Text_1_t:getVirtualRendererSize()
        self._Text_1_t:setTextAreaSize(renderSize)
        self._Text_1_t:setPositionY(renderSize.height)
        self._ScrollView1_t:setInnerContainerSize(renderSize)
    end
end
--@auto code Leftupbt btFunc end

--@auto code Rightupbt btFunc
function EulaSceneViewController:onRightupbtClick()
    Functions.printInfo(self.debug,"Rightupbt button is click!")
    self._ScrollView2_t:scrollToTop(0.1,true)
    if self.policiesIndex > 1 then
        self.policiesIndex = self.policiesIndex - 1 
        self:updatePageBt(2)        
        self._Text_2_t:setString(self.policiesData[self.policiesIndex])
        local renderSize = self._Text_2_t:getVirtualRendererSize ()
        self._Text_2_t:setTextAreaSize(renderSize)
        self._ScrollView2_t:setInnerContainerSize(renderSize)
        self._Text_2_t:setPositionY(renderSize.height)
    end
end
--@auto code Rightupbt btFunc end

--@auto code Confirmbt btFunc
function EulaSceneViewController:onConfirmbtClick()
    Functions.printInfo(self.debug,"Confirmbt button is click!")
    Functions.setAdbrixTag("firstTimeExperience","terms_complete")
    GameState.storeAttr.isConfirmEula_b = true
    Functions.goToLoginView()
end
--@auto code Confirmbt btFunc end

--@auto code Chakanbt1 btFunc
function EulaSceneViewController:onChakanbt1Click()
    Functions.printInfo(self.debug,"Chakanbt1 button is click!")
    Functions.callJavaFuc(function ( )
        NativeUtil:javaCallHanler({command = "nanoo",url = SDKConfig.eulaOneUrl,isAddParameter = false})
    end)
end
--@auto code Chakanbt1 btFunc end

--@auto code Chakanbt2 btFunc
function EulaSceneViewController:onChakanbt2Click()
    Functions.printInfo(self.debug,"Chakanbt2 button is click!")
     Functions.callJavaFuc(function ( )
        NativeUtil:javaCallHanler({command = "nanoo",url = SDKConfig.eulaTwoUrl,isAddParameter = false})
    end)
end
--@auto code Chakanbt2 btFunc end

--@auto button backcall end

function EulaSceneViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
--@auto code view display func
function EulaSceneViewController:onCreate()
    Functions.printInfo(self.debug_b," EulaSceneViewController controller create!")
end

function EulaSceneViewController:onDisplayView()
    Functions.printInfo(self.debug_b," EulaSceneViewController view enter display!")
    Functions.setAdbrixTag("firstTimeExperience","terms_try")
    local termsInf = cc.FileUtils:getInstance():getStringFromFile("data/terms.txt")
    self.termsData = string.split(termsInf, "#")
    local policiesInf = cc.FileUtils:getInstance():getStringFromFile("data/policies.txt")
    self.policiesData = string.split(policiesInf, "#")
    self.termsIndex = 1
    self.policiesIndex = 1
    if self._agreeBox1_t:isSelected() then
        self.agreeFlag1 = true
    else
        self.agreeFlag1 = false
    end
    if self._agreeBox2_t:isSelected() then
        self.agreeFlag2 = true
    else
        self.agreeFlag2 = false
    end
    self:initDisplayUi()
end
--@auto code view display func end
function EulaSceneViewController:initDisplayUi()
    -- self._Text_1_t:ignoreContentAdaptWithSize(false)
    -- self._Text_1_t:setTextAreaSize(cc.size(280,0))
    -- self._Text_2_t:ignoreContentAdaptWithSize(false)
    -- self._Text_2_t:setTextAreaSize(cc.size(280,0))
    -- if self.termsData ~= nil then       
    --     self._Text_1_t:setString(self.termsData[self.termsIndex])
    --     local renderSize = self._Text_1_t:getVirtualRendererSize ()
    --     self._Text_1_t:setTextAreaSize(renderSize)
    --     self._ScrollView1_t:setInnerContainerSize(renderSize)
    --     self._Text_1_t:setPositionY(renderSize.height)
    -- end
    -- if self.policiesData ~= nil then
    --     self._Text_2_t:setText(self.policiesData[self.policiesIndex])
    --     local renderSize = self._Text_2_t:getVirtualRendererSize ()
    --     self._Text_2_t:setTextAreaSize(renderSize)
    --     self._ScrollView2_t:setInnerContainerSize(renderSize)
    --     self._Text_2_t:setPositionY(renderSize.height)
    -- end    
    -- self:updatePageBt(1)
    -- self:updatePageBt(2)
    self:updateConfirmBt()
end
function EulaSceneViewController:updatePageBt(type)
    if type == 1 then
        if self.termsIndex == 1 then 
            self._leftupBt_t:setVisible(false)
            self._leftdownBt_t:setVisible(true)
        elseif self.termsIndex == #self.termsData then 
            self._leftupBt_t:setVisible(true)
            self._leftdownBt_t:setVisible(false)
        else
            self._leftupBt_t:setVisible(true)
            self._leftdownBt_t:setVisible(true)
        end
    elseif type == 2 then 
        if self.policiesIndex == 1 then 
            self._rightupBt_t:setVisible(false)
            self._rightdownBt_t:setVisible(true)
        elseif self.policiesIndex == #self.policiesData then 
            self._rightupBt_t:setVisible(true)
            self._rightdownBt_t:setVisible(false)
        else
            self._rightupBt_t:setVisible(true)
            self._rightdownBt_t:setVisible(true)
        end
    end
end
function EulaSceneViewController:updateConfirmBt()
    if self.agreeFlag1 and self.agreeFlag2 then 
        Functions.setEnabledBt(self._confirmBt_t, true)
    else
        Functions.setEnabledBt(self._confirmBt_t, false)
    end
end
return EulaSceneViewController