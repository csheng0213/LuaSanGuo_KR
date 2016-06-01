--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local EquipmentPopView = class("EquipmentPopView", BasePopView)

local Functions = require("app.common.Functions")

EquipmentPopView.csbResPath = "tyj/csb"
EquipmentPopView.debug = true
EquipmentPopView.studioSpriteFrames = {"CB_unionTankuang","EquipmentUI" }
--@auto code head end
EquipmentPopView.spriteFrameNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #EquipmentPopView.studioSpriteFrames > 0 then
    EquipmentPopView.spriteFrameNames = EquipmentPopView.spriteFrameNames or {}
    table.insertto(EquipmentPopView.spriteFrameNames, EquipmentPopView.studioSpriteFrames)
end
function EquipmentPopView:onInitUI()

    --output list
    self._equipContainer_t = self.csbNode:getChildByName("Panel_1"):getChildByName("equipContainer")
	
    --label list
    
    --button list
    self._closeBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function EquipmentPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:getController():closeChildView(self)
end
--@auto code Closebt btFunc end

--@auto button backcall end


--@auto code output func
function EquipmentPopView:getPopAction()
    Functions.printInfo(self.debug,"pop actionFunc is call")
end

function EquipmentPopView:onDisplayView(inf)
    Functions.printInfo(self.debug,"pop action finish ")
    self:initDisplayUI(inf)    
end

function EquipmentPopView:onCreate()
    Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function EquipmentPopView:initDisplayUI(inf)
    local jumpData = inf
    local listHandler = function(index, widget, model, data)
        widget:setSwallowTouches(false)
        Functions.getEquipNode(widget,data) 
        local clickHandler = function()
            if jumpData.jumpType == 1 or jumpData.jumpType == 2 then --装备培养选择装备               
                jumpData.handler(data.mark)
                self:getController():closeChildView(self)
            else
                if jumpData.mark ~= nil and  jumpData.mark > 0 then
                    -- local equipReplaceView = require("app.ui.popViews.EquipmentReplacePopView"):new()--cs
                    self:getController():openChildView("app.ui.popViews.EquipmentReplacePopView",{isRemove = false,name = "equipReplaceView",
                                                        data={nowEquipMark = jumpData.mark,                                          
                                                        selectedEquipMark = data.mark,
                                                        embattleType = jumpData.embattleType,
                                                        pos = jumpData.pos,
                                                        tag = jumpData.tag}})  
                else
                    -- local equipInfView = require("app.ui.popViews.EquipmentInfPopView"):new()--cs
                    self:getController():openChildView("app.ui.popViews.EquipmentInfPopView",{isRemove = false,name = "equipInfView",
                                                        data={selectedEquipMark = data.mark,
                                                        embattleType = jumpData.embattleType,
                                                        pos = jumpData.pos,
                                                        tag = jumpData.tag,
                                                        handler= function( )
                                                            self:initDisplayUI(jumpData)  
                                                        end}}) 

                end
            end
        end
        if index == 1 then 
            self._firstEquipBt_t = widget
        end
        widget:setTouchEnabled(true)
        widget:onTouch(Functions.createTableViewClickListener(self._equipContainer_t,clickHandler, "movedis"))
    end
    local equipData = {}
    if jumpData.jumpType == 1 or jumpData.jumpType == 2 then --装备强化选择装备
        local unAppareledEquipData = EquipmentData:getEquipWithoutAppareled()
        local selectedEquipId = EquipmentData:getEquipInf(jumpData.mark).m_id
        local selectedEquipColorNum = ConfigHandler:getColorNumOfId(selectedEquipId )
        local colorEquipData = EquipmentData:getEquipInfOfColorNum(unAppareledEquipData,selectedEquipColorNum)
        local tempEquipData = {}
        if jumpData.jumpType == 2 then
            local selectedEquipStagNum = ConfigHandler:getStagOfId(selectedEquipId ) 
            tempEquipData = EquipmentData:getEquipInfOfStagNum(colorEquipData,selectedEquipStagNum)
        else
            tempEquipData = colorEquipData
        end
        equipData = EquipmentData:removeEquipOfMark(tempEquipData,jumpData.mark)
    else
        equipData = EquipmentData:getEquipDataOfType(jumpData.tag,jumpData.mark)
    end
    local sortEquipData = EquipmentData:sortEquip(equipData)
    
    -- Functions.bindArryListWithData(self._equipListView_t,{firstData = sortEquipData,
    --                                secondData = PlayerData.eventAttr.m_curEquipmentBagSize},
    --                                listHandler,
    --                                {direction = true,col = 6,firstSegment = 20,segment = 10 })
    local cleanNodeHandler = function(widget)
        Functions.cleanEquipNode(widget)
        widget:setTouchEnabled(false)
    end
    
    Functions.bindTableViewWithData(self._equipContainer_t,{firstData = sortEquipData,
                                                         secondData = PlayerData.eventAttr.m_curEquipmentBagSize},
                                                         {handler = listHandler,handler2 = cleanNodeHandler},
                                                         {direction = true,col = 6,firstSegment = 20,segment = 10,segmentY = 20})
end
return EquipmentPopView