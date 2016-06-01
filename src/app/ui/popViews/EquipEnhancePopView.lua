--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local EquipEnhancePopView = class("EquipEnhancePopView", BasePopView)

local Functions = require("app.common.Functions")

EquipEnhancePopView.csbResPath = "tyj/csb"
EquipEnhancePopView.debug = true
EquipEnhancePopView.studioSpriteFrames = {"EquipEhancePopUI","TianTiUI","EquipEhancePopUI_Text","CBO_infor" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #EquipEnhancePopView.studioSpriteFrames > 0 then
    EquipEnhancePopView.spriteFrameNames = EquipEnhancePopView.spriteFrameNames or {}
    table.insertto(EquipEnhancePopView.spriteFrameNames, EquipEnhancePopView.studioSpriteFrames)
end
function EquipEnhancePopView:onInitUI()

    --output list
    self._qiangHuaPanel_t = self.csbNode:getChildByName("Panel_1"):getChildByName("qiangHuaPanel")
	self._heChengPanel_t = self.csbNode:getChildByName("Panel_1"):getChildByName("heChengPanel")
	self._xiLianPanel_t = self.csbNode:getChildByName("Panel_1"):getChildByName("xiLianPanel")
	self._table_t = self.csbNode:getChildByName("Panel_1"):getChildByName("table")
	
    --label list
    
    --button list
    self._closeBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))

	self._helpBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("helpBt")
	self._helpBt_t:onTouch(Functions.createClickListener(handler(self, self.onHelpbtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function EquipEnhancePopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:getController():closeChildView(self)
end
--@auto code Closebt btFunc end

--@auto code Helpbt btFunc
function EquipEnhancePopView:onHelpbtClick()
    Functions.printInfo(self.debug,"Helpbt button is click!")
    NoticeManager:openNotice(self:getController(), {type = NoticeManager.EQUIP_ENHANCE})
end
--@auto code Helpbt btFunc end

--@auto button backcall end


--@auto code output func
function EquipEnhancePopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function EquipEnhancePopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")	
	self.jumpData = data
	self:initDisplayUI()
end

function EquipEnhancePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function EquipEnhancePopView:initDisplayUI()
    --出售化强化数据
    local tabs = {}
    tabs[#tabs+1] =self._table_t:getChildByName("tb1")
    tabs[#tabs+1] =self._table_t:getChildByName("tb2")
    tabs[#tabs+1] =self._table_t:getChildByName("tb3")
    local nowTab = {}
	local tableListener = function(target)
        if target == "tb1" then
        	if EquipmentData:getEquipQiangHuaIdOfMark(self.jumpData.mark) ~= nil then
        		self:selectEhanceType(1)
        		nowTab = tabs[1]
        	else
        		PromptManager:openTipPrompt(LanguageConfig.language_equip_3)
        	end
        elseif target == "tb2" then
            if EquipmentData:getEquipHeChengIdOfMark(self.jumpData.mark) ~= nil then
        		self:selectEhanceType(2)
        		nowTab = tabs[2]
        	else
        		PromptManager:openTipPrompt(LanguageConfig.language_equip_4)
        		
        	end

        elseif target == "tb3" then
        	self:selectEhanceType(3)
        	nowTab = tabs[3]
        end
        Functions.openTabs( tabs ,nowTab)
    end
    if EquipmentData:getEquipQiangHuaIdOfMark(self.jumpData.mark) ~= nil then 
    	Functions.initTabComWithSimple({widget = self._table_t ,listener = tableListener,firstName = "tb1"})
    	nowTab = tabs[1]
	elseif EquipmentData:getEquipHeChengIdOfMark(self.jumpData.mark) ~= nil then 
		Functions.initTabComWithSimple({widget = self._table_t ,listener = tableListener,firstName = "tb2"})
		nowTab = tabs[2]
	else
		Functions.initTabComWithSimple({widget = self._table_t ,listener = tableListener,firstName = "tb3"})
		nowTab = tabs[3]
	end
end
-- function EquipEnhancePopView:setTab(tabs)
-- 	if EquipmentData:getEquipQiangHuaIdOfMark(self.jumpData.mark) ~= nil then 
-- 		Functions.openTabs( tabs ,tabs[1])
-- 	elseif EquipmentData:getEquipHeChengIdOfMark(self.jumpData.mark) ~= nil then 
-- 		Functions.openTabs( tabs ,tabs[2])
-- 	else
-- 		Functions.openTabs( tabs ,tabs[3])
-- 	end
-- end
function EquipEnhancePopView:selectEhanceType(type)

	local equipData = EquipmentData:getEquipInf(self.jumpData.mark)
	local enhanceSelectedMark = 0
	if type == 1 then --强化
		self._qiangHuaPanel_t:setVisible(true)
		self._heChengPanel_t:setVisible(false)
		self._xiLianPanel_t:setVisible(false)

		local equipBanOne = self._qiangHuaPanel_t:getChildByName("equipOne")

        self:showEquipBan(equipBanOne,{mark = self.jumpData.mark})
        local equipBanTwo = self._qiangHuaPanel_t:getChildByName("equipTwo")
       
        local equipOneData = EquipmentData:getEquipInf(self.jumpData.mark)
        self:showEquipBan(equipBanTwo,{id = ConfigHandler:getQiangHuaId(equipData.m_id),atkFormFlag = equipData.atkFormFlag,defFormFlag = equipData.defFormFlag,rdAttrType = equipOneData.rdAttrType,rdAttrPercent =  equipOneData.rdAttrPercent})
		--显示所需材料
		local needProp = self._qiangHuaPanel_t:getChildByName("needProp")
		self:showNeedPropofEquipId(needProp,equipData.m_id,type)
        local moneyNode = self._qiangHuaPanel_t:getChildByName("needMoney"):getChildByName("prizeCntLabel")
		local needMoneyData = ConfigHandler:getQiangHuaRes(equipData.m_id)[2]
		moneyNode:setString(tostring(needMoneyData[3]))
		--是否显示所需装备
		local needEquip = self._qiangHuaPanel_t:getChildByName("needEquip")
		
		if ConfigHandler:getColorNumOfId(equipData.m_id) >= 6 and  ConfigHandler:getStagOfId(equipData.m_id) >= 5 then
			Functions.cleanEquipNode(needEquip)     
			if enhanceSelectedMark > 0 then 
				Functions.getEquipNode(needEquip,{mark = enhanceSelectedMark })
			else
                local clickHandler = function()
                    self:getController():openChildView("app.ui.popViews.EquipmentPopView",{isRemove = false,name = "equipPopView",
                        data = {tag = 1,embattleType = self.jumpData.embattleType,pos = self.jumpData.pos,mark = self.jumpData.mark,jumpType = 1,
                            handler = function(eventMark)
                                enhanceSelectedMark =  eventMark
                                Functions.getEquipNode(needEquip,{mark = eventMark })
                            end}})
                end
                needEquip:getChildByName("equipmentPanel"):onTouch(Functions.createClickListener(clickHandler, ""))
	            self:setAddEquipStatus(needEquip)
        	end     
        else
        	Functions.cleanEquipNode(needEquip,true,1)     
		end

		--强化操作
		local qiangHuaBt = self._qiangHuaPanel_t:getChildByName("qiangHuaBt")
		local qiangHuaBtHandler = function()
			local handler = function( event )
				local returnData = event.data
				for k,v in pairs(returnData.lose.items) do --消耗道具
                        PropData:miuProp({m_id = v[1],m_count = v[3]} )
                    end
                for k,v in pairs(returnData.lose.oldEquip) do --消耗装备
                    EquipmentData:miuEquip(v.slot)
                end
                self:showNeedPropofEquipId(needProp,equipData.m_id,type)
				if returnData.isSuccess then 
					local atkFormFlag, defFormFlag = EquipmentData:getEquipApparelFlag(returnData.newEquip.useFlag)
                    EquipmentData:addEquip({m_id = returnData.newEquip.id, defFormFlag = defFormFlag, atkFormFlag = atkFormFlag,mark = returnData.newEquip.slot,rdAttrType = returnData.newEquip.gPlusPropType,rdAttrPercent = returnData.newEquip.gPropValueTil })
                    EquipmentData:modifyEquipAppare(returnData.newEquip.useFlag,returnData.newEquip.slot)
                    NoticeManager:openRewardTips(self:getController(), {type = NoticeManager.REWARD_EQUIPQIANGHUA_TIPS,data = {equipMark = returnData.newEquip.slot,
                    	handler = function( )
                            self:initDisplayUI()
                            self.jumpData.handler(returnData.newEquip.slot)
                    	end}}) 
                    self.jumpData.mark = returnData.newEquip.slot
				else
					PromptManager:openTipPrompt(LanguageConfig.language_equip_5)
					enhanceSelectedMark = 0
					if ConfigHandler:getColorNumOfId(equipData.m_id) >= 6 and  ConfigHandler:getStagOfId(equipData.m_id) >= 5 then
						Functions.cleanEquipNode(needEquip) 
                        local clickHandler = function()
                            self:getController():openChildView("app.ui.popViews.EquipmentPopView",{isRemove = false,name = "equipPopView",
                                data = {tag = 1,embattleType = self.jumpData.embattleType,pos = self.jumpData.pos,mark = self.jumpData.mark,jumpType = 1,
                                    handler = function(eventMark)
                                        enhanceSelectedMark =  eventMark
                                        Functions.getEquipNode(needEquip,{mark = eventMark })
                                    end}})
                        end
                        needEquip:getChildByName("equipmentPanel"):onTouch(Functions.createClickListener(clickHandler, ""))
			            self:setAddEquipStatus(needEquip)
		        	end
				end               
			end
			EquipmentData:requestEquipEnhance({enhanceType = 1,equipMark = self.jumpData.mark,needEquipMark = enhanceSelectedMark},handler)
		end
		qiangHuaBt:onTouch(Functions.createClickListener(qiangHuaBtHandler, ""))
	elseif type == 2 then --合成
		self._qiangHuaPanel_t:setVisible(false)
		self._heChengPanel_t:setVisible(true)
		self._xiLianPanel_t:setVisible(false)

		local equipNodeOne = self._heChengPanel_t:getChildByName("equipOne")
	    Functions.getEquipNode(equipNodeOne,{mark = self.jumpData.mark,isName=true})
		
        local equipNodeThree = self._heChengPanel_t:getChildByName("equipThree")
        local heChengId = EquipmentData:getEquipHeChengIdOfMark(self.jumpData.mark)
        Functions.getEquipNode(equipNodeThree:getChildByName("equip"),{equipInf ={id = heChengId,atkFormFlag = equipData.atkFormFlag,defFormFlag = equipData.defFormFlag,isName=true}})
        local whPanel = equipNodeThree:getChildByName("whPanel")
		whPanel:setVisible(true)

		--显示所需材料
		local needProp = self._heChengPanel_t:getChildByName("needProp")
		self:showNeedPropofEquipId(needProp,equipData.m_id,type)
		
		--是否显示所需装备
		local equipBanTwo = self._heChengPanel_t:getChildByName("equipTwo")
		
		
        Functions.cleanEquipNode(equipBanTwo)     
		if enhanceSelectedMark > 0 then 
            Functions.getEquipNode(equipBanTwo,{mark = enhanceSelectedMark,isName=true})
		else
            local clickHandler = function()
                self:getController():openChildView("app.ui.popViews.EquipmentPopView",{isRemove = false,name = "equipPopView",data = {tag = 1,embattleType = self.jumpData.embattleType,pos = self.jumpData.pos,mark = self.jumpData.mark,jumpType = 2,
                	handler = function(eventMark)
                		enhanceSelectedMark = eventMark
	                	Functions.getEquipNode(equipBanTwo,{mark = eventMark,isName=true})
	                end}})
            end
            equipBanTwo:getChildByName("equipmentPanel"):onTouch(Functions.createClickListener(clickHandler, ""))
            local equipment = equipBanTwo:getChildByName("equipmentPanel"):getChildByName("equipment")
            equipment:setVisible(true)
            equipment:setScale(0.8)
            Functions.loadImageWithWidget(equipment,"commonUI/res/icons/adddd.png")
            local bgView = equipBanTwo:getChildByName("equipmentPanel"):getChildByName("bg")
            bgView:setVisible(false)
    	end     
    	--合成操作
		local heChengBt = self._heChengPanel_t:getChildByName("heChengBt")
		local heChengBtHandler = function()
			local handler = function( event )
				local returnData = event.data
				for k,v in pairs(returnData.lose.items) do --消耗道具
                        PropData:miuProp({m_id = v[1],m_count = v[3]} )
                    end
                for k,v in pairs(returnData.lose.oldEquip) do --消耗装备
                    EquipmentData:miuEquip(v.slot)
                end
				if returnData.isSuccess then 
					local atkFormFlag, defFormFlag = EquipmentData:getEquipApparelFlag(returnData.newEquip.useFlag)
					EquipmentData:addEquip({m_id = returnData.newEquip.id, defFormFlag = defFormFlag, atkFormFlag = atkFormFlag,mark = returnData.newEquip.slot,rdAttrType = returnData.newEquip.gPlusPropType,rdAttrPercent = returnData.newEquip.gPropValueTil })
                    EquipmentData:modifyEquipAppare(returnData.newEquip.useFlag,returnData.newEquip.slot)
                    NoticeManager:openRewardTips(self:getController(), {type = NoticeManager.REWARD_EQUIPHECHENG_TIPS,data = {equipMark = returnData.newEquip.slot,
                    	handler = function( )
                            self:initDisplayUI()
                            self.jumpData.handler(returnData.newEquip.slot)
                    	end}}) 
                    self.jumpData.mark = returnData.newEquip.slot
				else
					PromptManager:openTipPrompt(LanguageConfig.language_equip_5)                    
				end               
			end
			EquipmentData:requestEquipEnhance({enhanceType = 2,equipMark = self.jumpData.mark,needEquipMark = enhanceSelectedMark},handler)
		end
		heChengBt:onTouch(Functions.createClickListener(heChengBtHandler, ""))
	elseif type == 3 then --洗练
		self._qiangHuaPanel_t:setVisible(false)
		self._heChengPanel_t:setVisible(false)
		self._xiLianPanel_t:setVisible(true)
		local equipBan = self._xiLianPanel_t:getChildByName("equipOne")
        self:showEquipBan(equipBan,{mark = self.jumpData.mark})
        --显示所需材料
		local needProp = self._xiLianPanel_t:getChildByName("needProp")
		self:showNeedPropofEquipId(needProp,equipData.m_id,type)
		local moneyNode = self._xiLianPanel_t:getChildByName("needMoney"):getChildByName("prizeCntLabel")
		local needMoneyData = ConfigHandler:getXiLianRes(equipData.m_id)[1]
		moneyNode:setString(tostring(needMoneyData[3]))
		local xiLianBt = self._xiLianPanel_t:getChildByName("xiLianBt")
		local xiLianBtHandler = function( )
			local handler = function( event )
				local returnData = event.data
                for k,v in pairs(returnData.lose.items) do 
                    PropData:miuProp({m_id = v[1],m_count = v[3]} )
                end
				if returnData.isSuccess then 
					Functions.playSound("awakenSevenStarpodium.mp3")
					EquipmentData:setEquipRdAttr(returnData.newEquip.slot,returnData.newEquip.rdAttrType,returnData.newEquip.rdAttrPercent)
                    self:showEquipBan(equipBan,{mark = self.jumpData.mark})
                    Functions.playAnimationWithRemove(equipBan:getChildByName("equip"),"An_enhance",12,10)
                   	self:showNeedPropofEquipId(needProp,equipData.m_id,type)
                    self.jumpData.handler(returnData.newEquip.slot)
				else
					PromptManager:openTipPrompt(LanguageConfig.language_equip_6)
				end
			end
			EquipmentData:requestEquipEnhance({enhanceType = 3,equipMark = self.jumpData.mark,needEquipMark = 0},handler)
		end
		xiLianBt:onTouch(Functions.createClickListener(xiLianBtHandler, ""))
	end
end
function EquipEnhancePopView:setAddEquipStatus(target)
	
	local equipment = target:getChildByName("equipmentPanel"):getChildByName("equipment")
    equipment:setVisible(true)
    equipment:setScale(0.8)
    Functions.loadImageWithWidget(equipment,"commonUI/res/icons/adddd.png")
    local bgView = target:getChildByName("equipmentPanel"):getChildByName("bg")
    bgView:setVisible(false)
end
function EquipEnhancePopView:setEquipNode(target,mark )
	Functions.getEquipNode(target,{mark = mark,isName=true})
	local name = target:getChildByName("name")
	local equipData = EquipmentData:getEquipInf(mark)
    name:setString(ConfigHandler:getEquipNameOfId(equipData.m_id))
    name:setVisible(true)
end
function EquipEnhancePopView:showEquipBan(target,equipInf,extAttrStr)
	local equipNode = target:getChildByName("equip")
	local equipId = 0
    
	local extAttr = target:getChildByName("extAttr")
	equipInf.isName = true
	if equipInf.mark ~= nil then 
		Functions.getEquipNode(equipNode,equipInf)		
        local equipData = EquipmentData:getEquipInf(equipInf.mark)
        extAttr:setString(self:getEquipExtAttrStr(equipData))
	    equipId = equipData.m_id
	elseif equipInf.id ~= nil then 
		equipId = equipInf.id 
        local tempData = equipInf
        tempData.rdAttr = {}
        tempData.rdAttr.type = equipInf.rdAttrType
        tempData.rdAttr.value = equipInf.rdAttrPercent
        Functions.getEquipNode(equipNode,{equipInf = tempData,isName = true})
        extAttr:setString(self:getEquipExtAttrStr(equipInf))
		-- extAttr:setString(LanguageConfig.language_prop_11 .. LanguageConfig.ui_CardIn_1 .. ":???")
		-- local whPanel = target:getChildByName("whPanel")
		-- whPanel:setVisible(true)
	end
  
    local attr = target:getChildByName("attr")
    local attrTypeTable = {LanguageConfig.ui_selectHero_2 .. ":",LanguageConfig.ui_selectHero_3 .. ":",
        LanguageConfig.ui_selectHero_5 .. ":",LanguageConfig.ui_selectHero_4 ..":"}
    attr:setString(attrTypeTable[ConfigHandler:getEquipAttrTypeOfId(equipId)])
    local buff = target:getChildByName("buff")
    buff:setString(" +" .. tostring(ConfigHandler:getEquipAttrValueOfId(equipId)))
end
function EquipEnhancePopView:getEquipExtAttrStr(equipData)
	--随机属性
	local str = ""
	local attrTypeTable = {LanguageConfig.ui_selectHero_2 .. ":",LanguageConfig.ui_selectHero_3 .. ":",
        LanguageConfig.ui_selectHero_5 .. ":",LanguageConfig.ui_selectHero_4 ..":"}
    if equipData.rdAttrType > 0 then 
        str = LanguageConfig.language_prop_11 .. attrTypeTable[equipData.rdAttrType] .. "+" .. tostring(equipData.rdAttrPercent) .. "%"
    else
        str = LanguageConfig.language_prop_12
    end
    return str
end
function EquipEnhancePopView:showNeedPropofEquipId(target,equipId,type)
	local needPropData = {}
	if type == 1 then 
		needPropData = ConfigHandler:getQiangHuaRes(equipId)[1]
	elseif type == 2 then
		needPropData = ConfigHandler:getHeChengRes(equipId)[1]
	elseif type == 3 then
		needPropData = ConfigHandler:getXiLianRes(equipId)[2]
	end 

	local needPropId = needPropData[1]
	local bagNum = PropData:getPropNumOfId(needPropId)
	local needPropImg = ConfigHandler:getPropImageOfId(needPropId)
	Functions.loadImageWithWidget(target:getChildByName("prize"), needPropImg)
	target:getChildByName("prizeCntLabel"):setString(tostring(bagNum) .. "/" .. tostring(needPropData[3]))
	local onTargetClick = function( )
		PromptManager:openInfPrompt({type = ItemType.Prop,id = needPropId,target = target})
	end
	target:onTouch(Functions.createClickListener(handler(target, onTargetClick), ""))
end

return EquipEnhancePopView