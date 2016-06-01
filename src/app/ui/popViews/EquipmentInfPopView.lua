--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local EquipmentInfPopView = class("EquipmentInfPopView", BasePopView)

local Functions = require("app.common.Functions")

EquipmentInfPopView.csbResPath = "tyj/csb"
EquipmentInfPopView.debug = true
EquipmentInfPopView.studioSpriteFrames = {"EquipEhancePopUI_Text","CC_commZbxq" }
--@auto code head end

--@auto code uiInit
--add spriteFrames
if #EquipmentInfPopView.studioSpriteFrames > 0 then
    EquipmentInfPopView.spriteFrameNames = EquipmentInfPopView.spriteFrameNames or {}
    table.insertto(EquipmentInfPopView.spriteFrameNames, EquipmentInfPopView.studioSpriteFrames)
end
function EquipmentInfPopView:onInitUI()

    --output list
    self._choosePanel_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Image_1"):getChildByName("choosePanel")
	
    --label list
    self._Text_17_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Image_1"):getChildByName("choosePanel"):getChildByName("Text_17")
	self._Text_17_t:setString(LanguageConfig.ui_equip_1)
    --button list
    self._bt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Image_1"):getChildByName("choosePanel"):getChildByName("bt")
	self._bt_t:onTouch(Functions.createClickListener(handler(self, self.onBtClick), "zoom"))

	self._upBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Image_1"):getChildByName("choosePanel"):getChildByName("upBt")
	self._upBt_t:onTouch(Functions.createClickListener(handler(self, self.onUpbtClick), "zoom"))

	self._closeBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Bt btFunc
function EquipmentInfPopView:onBtClick()
    Functions.printInfo(self.debug,"Bt button is click!")
    if self.jumpData.jumpType == 2 then
        
        -- local equipmentView = require("app.ui.popViews.EquipmentPopView"):new()--cs
        self:getController():openChildView("app.ui.popViews.EquipmentPopView",{isRemove = false,name = "equipPopView",data = {tag = self.jumpData.tag,embattleType = self.jumpData.embattleType,pos = self.jumpData.pos,mark = self.jumpData.selectedEquipMark}})
        self:getController():closeChildView(self)
    else
        if EquipmentData:isAppareled(self.jumpData.selectedEquipMark) then
            local callBack = function()
                self:apparelEquip()
            end
            NoticeManager:openTips(self:getController(),{title = LanguageConfig.language_equip_2,handler = callBack})
        else
            self:apparelEquip()
        end
    end
end
--@auto code Bt btFunc end

--@auto code Closebt btFunc
function EquipmentInfPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!") 
    self:getController():closeChildView(self)    
end
--@auto code Closebt btFunc end

--@auto code Upbt btFunc
function EquipmentInfPopView:onUpbtClick()
    Functions.printInfo(self.debug,"Upbt button is click!")
    self:getController():openChildView("app.ui.popViews.EquipEnhancePopView",{isRemove = false,name = "equipEnhancePopView",data = {tag = self.jumpData.tag,embattleType = self.jumpData.embattleType,pos = self.jumpData.pos,mark = self.jumpData.selectedEquipMark,
        handler = function( eventMark)
            if self.jumpData.handler ~= nil then 
                self.jumpData.handler()
            end
            -- self.jumpData.selectedEquipMark = eventMark
            Functions.displayEquipInf(self._choosePanel_t,{mark = eventMark},self.jumpData.jumpType)
        
        end
        }})
end
--@auto code Upbt btFunc end

--@auto button backcall end


--@auto code output func
function EquipmentInfPopView:getPopAction()
    Functions.printInfo(self.debug,"pop actionFunc is call")
end

function EquipmentInfPopView:onDisplayView(data)
    Functions.printInfo(self.debug,"pop action finish ")
    self.jumpData = data
    self:initDisplayUI(self.jumpData)
end

function EquipmentInfPopView:onCreate()
    Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function EquipmentInfPopView:initDisplayUI(data)
    if data.jumpType== 2 then
        Functions.displayEquipInf(self._choosePanel_t,{mark = data.selectedEquipMark},data.jumpType)
    elseif data.jumpType== 4 then 
         Functions.displayEquipInf(self._choosePanel_t,{equipInf = data.equipInf},4)
    else
        Functions.displayEquipInf(self._choosePanel_t,{mark = data.selectedEquipMark})
    end
    if data.selectedEquipMark ~= nil  then
        local selectedEquipId = EquipmentData:getEquipInf(data.selectedEquipMark).m_id
        local selectedEquipColorNum = ConfigHandler:getColorNumOfId(selectedEquipId)
        if selectedEquipColorNum > 3 then 
            self._upBt_t:setVisible(true)
            self._bt_t:setPositionX(151)
        else
            self._upBt_t:setVisible(false)
            self._bt_t:setPositionX(200)
        end
    else
        self._upBt_t:setVisible(false)
        self._bt_t:setPositionX(200)
    end
end
function EquipmentInfPopView:apparelEquip()
    local handler = function ()
        if self:getController()._childViews["equipPopView"] ~= nil then
            self:getController():closeChildView("equipPopView")
        end
        EquipmentData:cleanEquipAppraleOfMark(self.jumpData.selectedEquipMark)
        EquipmentData:cleanApparelFlag(self.jumpData.selectedEquipMark)
        EquipmentData:setEquipAppareMark(self.jumpData.embattleType,self.jumpData.pos,self.jumpData.tag,self.jumpData.selectedEquipMark)
        EquipmentData:setApparelFalg(self.jumpData.embattleType,self.jumpData.pos,self.jumpData.tag,self.jumpData.selectedEquipMark)
        self:getController():showEquipment(self.jumpData.pos)
        self:getController():closeChildView(self)
    end  
    local inf = {}   
    if self.jumpData.embattleType == EmbattleData.EmbattleTypeEnum.attack then
        inf = {equipSlot = self.jumpData.selectedEquipMark ,isFighter = self.jumpData.embattleType,fightSlot = self.jumpData.pos, slot = self.jumpData.tag}
    elseif self.jumpData.embattleType == EmbattleData.EmbattleTypeEnum.defense then
        inf = {equipSlot = self.jumpData.selectedEquipMark ,isFighter = self.jumpData.embattleType,fightSlot = self.jumpData.pos + 3, slot = self.jumpData.tag}
    end  
    EquipmentData:RequestReplaceEquip(inf,handler)
end
return EquipmentInfPopView