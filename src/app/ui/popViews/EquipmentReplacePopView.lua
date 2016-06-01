--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local EquipmentReplacePopView = class("EquipmentReplacePopView", BasePopView)

local Functions = require("app.common.Functions")

EquipmentReplacePopView.csbResPath = "tyj/csb"
EquipmentReplacePopView.debug = true
EquipmentReplacePopView.studioSpriteFrames = {"CB_unionTankuang","EquipmentReplacePopUI" }
--@auto code head end
EquipmentReplacePopView.spriteFrameNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #EquipmentReplacePopView.studioSpriteFrames > 0 then
    EquipmentReplacePopView.spriteFrameNames = EquipmentReplacePopView.spriteFrameNames or {}
    table.insertto(EquipmentReplacePopView.spriteFrameNames, EquipmentReplacePopView.studioSpriteFrames)
end
function EquipmentReplacePopView:onInitUI()

    --output list
    self._nowPanel_t = self.csbNode:getChildByName("Panel_1"):getChildByName("nowPanel")
	self._selectedPanel_t = self.csbNode:getChildByName("Panel_1"):getChildByName("selectedPanel")
	
    --label list
    self._Text_17_t = self.csbNode:getChildByName("Panel_1"):getChildByName("nowPanel"):getChildByName("Text_17")
	self._Text_17_t:setString(LanguageConfig.ui_equip_1)

	self._Text_17_t = self.csbNode:getChildByName("Panel_1"):getChildByName("selectedPanel"):getChildByName("Text_17")
	self._Text_17_t:setString(LanguageConfig.ui_equip_1)
    --button list
    self._closeBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))

	self._bt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("selectedPanel"):getChildByName("bt")
	self._bt_t:onTouch(Functions.createClickListener(handler(self, self.onBtClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function EquipmentReplacePopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
     self:getController():closeChildView(self)
end
--@auto code Closebt btFunc end

--@auto code Bt btFunc
function EquipmentReplacePopView:onBtClick()
    Functions.printInfo(self.debug,"Bt button is click!")
    if EquipmentData:isAppareled(self.jumpData.selectedEquipMark) then
	    local callBack = function()
		    self:replaceEquip()
	    end
        NoticeManager:openTips(self:getController(),{title = LanguageConfig.language_equip_2,handler = callBack})
    else
   		self:replaceEquip()
    end
end
--@auto code Bt btFunc end

--@auto button backcall end


--@auto code output func
function EquipmentReplacePopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function EquipmentReplacePopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	self.jumpData = data
    self:initDisplayUI(self.jumpData)
end

function EquipmentReplacePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function EquipmentReplacePopView:initDisplayUI(data)
    Functions.displayEquipInf(self._nowPanel_t,{mark = data.nowEquipMark})
    Functions.displayEquipInf(self._selectedPanel_t,{mark = data.selectedEquipMark})
end
function EquipmentReplacePopView:replaceEquip( )
    local handler = function ()
        self:getController():closeChildView("equipPopView")
        EquipmentData:cleanEquipAppraleOfMark(self.jumpData.selectedEquipMark)
        EquipmentData:cleanApparelFlag(self.jumpData.selectedEquipMark)
        EquipmentData:setEquipAppareMark(self.jumpData.embattleType,self.jumpData.pos,self.jumpData.tag,self.jumpData.selectedEquipMark)
        EquipmentData:setApparelFalg(self.jumpData.embattleType,0,self.jumpData.tag,self.jumpData.nowEquipMark)
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
return EquipmentReplacePopView