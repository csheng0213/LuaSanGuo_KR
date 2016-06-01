--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local ZhenRongEquipPopView = class("ZhenRongEquipPopView", BasePopView)

local Functions = require("app.common.Functions")

ZhenRongEquipPopView.csbResPath = "tyj/csb"
ZhenRongEquipPopView.debug = true
ZhenRongEquipPopView.studioSpriteFrames = {"CBO_zrEquipBg","EquipmentUI" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #ZhenRongEquipPopView.studioSpriteFrames > 0 then
    ZhenRongEquipPopView.spriteFrameNames = ZhenRongEquipPopView.spriteFrameNames or {}
    table.insertto(ZhenRongEquipPopView.spriteFrameNames, ZhenRongEquipPopView.studioSpriteFrames)
end
function ZhenRongEquipPopView:onInitUI()

    --output list
    self._heroView_t = self.csbNode:getChildByName("board"):getChildByName("heroView")
	self._equipPanel_t = self.csbNode:getChildByName("board"):getChildByName("equipPanel")
	self._name_t = self.csbNode:getChildByName("board"):getChildByName("nameBg"):getChildByName("name")
	
    --label list
    
    --button list
    self._closeBt_t = self.csbNode:getChildByName("board"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function ZhenRongEquipPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:close()
end
--@auto code Closebt btFunc end

--@auto button backcall end


--@auto code output func
function ZhenRongEquipPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function ZhenRongEquipPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
    self:displayAllEquipment(data.equipInf,data.pos,data.embattleType)
    self._name_t:setString(data.heroInf.nameString)
    if data.heroInf.star > 5 then
        Functions.loadImageWithSprite(self._heroView_t,data.heroInf.heroImg,0.8)
    else
        Functions.loadImageWithSprite(self._heroView_t,data.heroInf.heroImg,0.7)
    end
end

function ZhenRongEquipPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
--显示所有装备
function ZhenRongEquipPopView:displayAllEquipment(equipInf,pos,embattleType)
    self:cleanAllEquipDisplay()
    for i = 1,6 do 
        if i < 5 then
            local equip = self._equipPanel_t:getChildByName("equip_" .. tostring(i))
            if embattleType == 1 then --攻击阵型
                equipInf[i].atkFormFlag = pos
            else
                equipInf[i].atkFormFlag = 0
            end
            if embattleType == 2 then
                equipInf[i].defFormFlag = pos
            else
                equipInf[i].defFormFlag = 0
            end
            self:showSigleEquip(equip,equipInf[i],i,pos,embattleType)
            local clickHandler = function()
                if equipInf[i].id > 0 then
                     self:getController():openChildView("app.ui.popViews.EquipmentInfPopView",{isRemove = false,
                            data={equipInf = equipInf[i],
                            jumpType = 4}})
                end
            end
            equip:getChildByName("equipmentPanel"):onTouch(Functions.createClickListener(clickHandler, ""))
        else
            local equip = self._equipPanel_t:getChildByName("equip_" .. tostring(i))
            Functions.cleanEquipNode(equip,false)
        end
    end
end
--清空所有装备显示
function ZhenRongEquipPopView:cleanAllEquipDisplay()
    for i = 1,4 do 
        local equip = self._equipPanel_t:getChildByName("equip_" .. tostring(i))
        Functions.cleanEquipNode(equip)
    end
end
--显示单个装备
function ZhenRongEquipPopView:showSigleEquip(target,equipInf,index,pos,embattleType)

    if equipInf.id < 1 then
        self:setEquipSlot(target,index) 
    else
        Functions.getEquipNode(target,{equipInf=equipInf})   
    end
end
--设置装备栏阴影
function ZhenRongEquipPopView:setEquipSlot(target,type)
    local equip=target:getChildByName("equipmentPanel"):getChildByName("equipment")
    equip:setScale(0.8)
    Functions.loadImageWithWidget(equip,"yy" .. tostring(type) .. ".png")
    equip:setVisible(true)
end
return ZhenRongEquipPopView