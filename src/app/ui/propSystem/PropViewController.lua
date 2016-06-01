--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local PropViewController = class("PropViewController", BaseViewController)

local Functions = require("app.common.Functions")

PropViewController.debug = true
PropViewController.modulePath = ...
PropViewController.studioSpriteFrames = {"CBO_ban","CB_bgup","EquipmentUI","CB_blackbg","EquipEhancePopUI_Text","PropUI_Text" }
--@auto code head end

--@Pre loading
PropViewController.spriteFrameNames = 
    {
        "equipmentRes"
    }

PropViewController.animaNames = 
    {
        "An_enhance"
    }


--@auto code uiInit
--add spriteFrames
if #PropViewController.studioSpriteFrames > 0 then
    PropViewController.spriteFrameNames = PropViewController.spriteFrameNames or {}
    table.insertto(PropViewController.spriteFrameNames, PropViewController.studioSpriteFrames)
end
function PropViewController:onDidLoadView()

    --output list
    self._propInfPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("propListPanel"):getChildByName("propInfBg"):getChildByName("propInfPanel")
	self._propInfLabel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("propListPanel"):getChildByName("propInfBg"):getChildByName("propInfPanel"):getChildByName("propInfLabel")
	self._sellPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("propListPanel"):getChildByName("propInfBg"):getChildByName("propInfPanel"):getChildByName("sellPanel")
	self._equipInfPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("propListPanel"):getChildByName("propInfBg"):getChildByName("equipInfPanel")
	self._bt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("propListPanel"):getChildByName("propInfBg"):getChildByName("equipInfPanel"):getChildByName("bt")
	self._qiangHuaBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("propListPanel"):getChildByName("propInfBg"):getChildByName("equipInfPanel"):getChildByName("qiangHuaBt")
	self._propContainer_t = self.view_t.csbNode:getChildByName("main"):getChildByName("propListPanel"):getChildByName("propContainer")
	self._table_t = self.view_t.csbNode:getChildByName("main"):getChildByName("propListPanel"):getChildByName("table")
	self._equipContainer_t = self.view_t.csbNode:getChildByName("main"):getChildByName("propListPanel"):getChildByName("equipContainer")
	self._topNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("topNode")
	self._btPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("btPanel")
	
    --label list
    self._titleInfLabel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("propListPanel"):getChildByName("propInfBg"):getChildByName("propInfPanel"):getChildByName("titleInfLabel")
	self._titleInfLabel_t:setString(LanguageConfig.language_prop_13)

	self._huisouLabel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("huisouLabel")
	self._huisouLabel_t:setString(LanguageConfig.language_Teach36)
    --button list
    self._backBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), ""))

	self._quedBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("btPanel"):getChildByName("quedBt")
	self._quedBt_t:onTouch(Functions.createClickListener(handler(self, self.onQuedbtClick), ""))

	self._oneKeyBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("btPanel"):getChildByName("oneKeyBt")
	self._oneKeyBt_t:onTouch(Functions.createClickListener(handler(self, self.onOnekeybtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Usepropbt btFunc
function PropViewController:onUsepropbtClick()
    Functions.printInfo(self.debug,"Usepropbt button is click!")
end
--@auto code Usepropbt btFunc end

--@auto code Backbt btFunc
function PropViewController:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    if self.onkeyCount ~= 0 then 
        self.onkeyCount = 0 
        self._bt_t:setVisible(true)
        self._huisouLabel_t:setVisible(false)
        self._qiangHuaBt_t:setVisible(true)
        self._bt_t:setPositionX(58)
        local equipData = EquipmentData.equipmentInf
        local sortEquipData =  EquipmentData:sortEquip(equipData)
        self:setOneKeySellEquip(sortEquipData,nil)
        self:displayEquipList(sortEquipData,1)
        Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})
        Functions.loadImageWithSprite(self._oneKeyBt_t:getChildByName("btText"),"tyj/uiFonts_res/plcs.png")
    else
         GameCtlManager:pop(self)
    end
end
--@auto code Backbt btFunc end

--@auto code Quedbt btFunc
function PropViewController:onQuedbtClick()
    Functions.printInfo(self.debug,"Quedbt button is click!")

    local handler = function (event)
        self.onkeyCount = 0 
        self._huisouLabel_t:setVisible(false)
        local equipData = EquipmentData.equipmentInf
        self:setOneKeySellEquip(equipData,nil)
        Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})
        Functions.loadImageWithSprite(self._oneKeyBt_t:getChildByName("btText"),"tyj/uiFonts_res/plcs.png")
        --出售成功获得铜钱
        PlayerData.eventAttr.m_money =  PlayerData.eventAttr.m_money + self.huiShouMoney
        for k,v in pairs(self.willSellEquipMarks) do 
            EquipmentData:miuEquip( v )
        end
        self.willSellEquipMarks = {}
        self:displayEquipList(EquipmentData.equipmentInf,1)
        PromptManager:openTipPrompt(LanguageConfig.language_prop_3)       
    end
    if #self.willSellEquipMarks > 0 then 
        EquipmentData:requestSellEquip(self.willSellEquipMarks,handler)
    end
end
--@auto code Quedbt btFunc end

--@auto code Onekeybt btFunc
function PropViewController:onOnekeybtClick()
    Functions.printInfo(self.debug,"Onekeybt button is click!")
    self._qiangHuaBt_t:setVisible(false)
    self._bt_t:setPositionX(110)
    self._quedBt_t:setVisible(true)
    if self.onkeyCount == 0 then -- 显示选择框
        self.onkeyCount = 1
--        GameEventCenter:dispatchEvent({ name = "EQUIP_ONEKEY_SELL_EVENT"})
--        self:setOneKeySellEquip(false)
        self._bt_t:setVisible(false)
        Functions.loadImageWithSprite(self._oneKeyBt_t:getChildByName("btText"),"tyj/uiFonts_res/yjxz.png")
        local child = self._topNode_t:getChildByName("panel"):getChildByName("node1")
        child:setVisible(true)
        self._topNode_t:getChildByName("panel"):getChildByName("node2"):setVisible(false)
        self._topNode_t:getChildByName("panel"):getChildByName("node3"):setVisible(false)

        local text = child:getChildByName("text")
        text:setString(tostring(self.huiShouMoney))
        Functions.bindEventListener(text,GameEventCenter,"HUISHOUMONEY_CHANGE_EVENT",function()  -- 点中装备
            text:setString(tostring(self.huiShouMoney))
        end)

        self._huisouLabel_t:setVisible(true)
        local equipData = EquipmentData:getEquipWithoutAppareled()
        local sortEquipData =  EquipmentData:sortEquip(equipData)
        self:setOneKeySellEquip(sortEquipData,false)
        self:displayEquipList(sortEquipData,2)
    elseif self.onkeyCount == 1 then --键选中
        self.onkeyCount = 2
        Functions.loadImageWithSprite(self._oneKeyBt_t:getChildByName("btText"),"tyj/uiFonts_res/yjqx.png")
        local equipData = EquipmentData:getColorNumUpEquip(3)
        local sortEquipData =  EquipmentData:sortEquip(equipData)
        self:setOneKeySellEquip(sortEquipData,true) 
        GameEventCenter:dispatchEvent({ name = "EQUIP_ONEKEY_SELECTE_EVENT"}) 
        if #self.willSellEquipMarks > 0 then 
            self._quedBt_t:setVisible(true)
        else
            self._quedBt_t:setVisible(false)
        end       
        --数据操作
    elseif self.onkeyCount == 2 then
        self.onkeyCount = 1 
        Functions.loadImageWithSprite(self._oneKeyBt_t:getChildByName("btText"),"tyj/uiFonts_res/yjxz.png")
        -- local equipData = EquipmentData:getColorNumUpEquip(3)
        -- local sortEquipData =  EquipmentData:sortEquip(equipData)
        self:setOneKeySellEquip(EquipmentData.equipmentInf,false) 
        GameEventCenter:dispatchEvent({ name = "EQUIP_ONEKEY_SELECTE_EVENT"})
        if #self.willSellEquipMarks > 0 then 
            self._quedBt_t:setVisible(true)
        else
            self._quedBt_t:setVisible(false)
        end
    end
end
--@auto code Onekeybt btFunc end

--@auto button backcall end


--@auto code view display func
function PropViewController:onCreate()
    Functions.printInfo(self.debug_b," PropViewController controller create!")
end
function PropViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
function PropViewController:onDisplayView()
    self.onkeyCount = 0  --一键出售的状态
    self.willSellEquipMarks = { } --将要被卖出的装备mark
    self.huiShouMoney = 0 

    Functions.printInfo(self.debug_b," PropViewController view enter display!")
    
    Functions.loadImageWithSprite(self._oneKeyBt_t:getChildByName("btText"),"tyj/uiFonts_res/plcs.png")
    Functions.setPopupKey("package")
    Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","jitui"})
    -- Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})

    -- self:displayPropList()
    --英雄切换标签绑定
    local selectTableListener = function(target)
        if target == "tb1" then
            self:setOneKeySellEquip(EquipmentData.equipmentInf,nil)
            self.onkeyCount = 0 
            self._huisouLabel_t:setVisible(false)
            Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","jitui"})

            self:displayPropList()
        elseif target == "tb2" then
            if self.onkeyCount == 0 then 
                self._bt_t:setVisible(true)
                local equipData = EquipmentData.equipmentInf
                local sortEquipData =  EquipmentData:sortEquip(equipData)
                self:displayEquipList(sortEquipData,1)
            end
        end
    end
    Functions.initTabComWithSimple({widget = self._table_t ,listener = selectTableListener, firstName = "tb1"}) 
    Functions.bindEventListener(self.view_t, GameEventCenter, PropData.PROP_CHANGE_EVENT, function (event)
        self:displayPropList()
    end)
end

function PropViewController:setOneKeySellEquip(equipData,selecetFlag)
    for k,v in pairs(equipData) do 
        if v.atkFormFlag == 0 and v.defFormFlag == 0 then 
            v.selecetFlag = selecetFlag
        end
        if v.selecetFlag ~= nil and selecetFlag == nil then 
            v.selecetFlag = selecetFlag
        end
        if selecetFlag == true then 
            
            self:addWillSellEquipMark(v.mark)
            self:updateHuiShowMoney() 
        elseif selecetFlag == false then 
            table.removebyvalue(self.willSellEquipMarks,v.mark)
            self:updateHuiShowMoney()
            
        end
    end
end
function PropViewController:addWillSellEquipMark(mark)
    for k,v in pairs(self.willSellEquipMarks) do 
        if v == mark then 
            return
        end
    end
    self.willSellEquipMarks[#self.willSellEquipMarks+1] = mark
end
function PropViewController:updateHuiShowMoney()
    self.huiShouMoney = 0 
    for k,v in pairs(self.willSellEquipMarks) do 
        self.huiShouMoney = self.huiShouMoney + ConfigHandler:getEquipPriceOfId(EquipmentData:getEquipInf(v).m_id)
    end
    GameEventCenter:dispatchEvent({ name = "HUISHOUMONEY_CHANGE_EVENT"}) 
end
--显示装备列表
function PropViewController:displayEquipList(showData,showType)
--    self._propListView_t:setVisible(false)
    self._btPanel_t:setVisible(true)
    self._oneKeyBt_t:setVisible(true)
    self._quedBt_t:setVisible(false)

    self._propContainer_t:setVisible(false)
    self._equipContainer_t:setVisible(true)
    self._propInfPanel_t:setVisible(false)
    -- self._equipInfPanel_t:setVisible(true)
    local selectedFlag = 0
    local listHandler = function(index, widget, model, data)
        widget.index = index
        widget:setSwallowTouches(false)
        local checkBox = widget:getChildByName("equipmentPanel"):getChildByName("CheckBox_Mark") 
        checkBox:setSwallowTouches(false)

        if data.selecetFlag ~= nil then
            checkBox:setVisible(true)
            checkBox:setSelectedState(data.selecetFlag) 
        else
            checkBox:setVisible(false)
        end
        if index == 1  and selectedFlag == 0 then
            selectedFlag = index
            if showType == 1 then 
                Functions.setEquipSelected(widget,true)

            else
                Functions.setEquipSelected(widget,false) 
            end
            self._equipInfPanel_t:setVisible(true)
            Functions.displayEquipInf(self._equipInfPanel_t,data)
            self:bindSellBtHandler(widget,data)
            local qiangHuaBtHandler = function( )
                self:openChildView("app.ui.popViews.EquipEnhancePopView",{isRemove = false,name = "equipEnhancePopView",data = {mark = data.mark,
                    handler = function()
                        local equipData = EquipmentData.equipmentInf
                        local sortEquipData =  EquipmentData:sortEquip(equipData)
                        self:displayEquipList(sortEquipData,showType)
                end}})
            end
            self._qiangHuaBt_t:onTouch(Functions.createClickListener(qiangHuaBtHandler,"zoom"))
            if showType == 1 then 
                local selectedEquipId = EquipmentData:getEquipInf(data.mark).m_id
                local selectedEquipColorNum = ConfigHandler:getColorNumOfId(selectedEquipId)
                if selectedEquipColorNum > 3 then 
                    self._qiangHuaBt_t:setVisible(true)
                    self._bt_t:setPositionX(58)
                else
                    self._qiangHuaBt_t:setVisible(false)
                    self._bt_t:setPositionX(110)
                end
                self._bt_t:setVisible(true)
            end
        elseif selectedFlag == index then 
             if showType == 1 then 
                Functions.setEquipSelected(widget,true)
             else
                Functions.setEquipSelected(widget,false) 
             end   
        else
             Functions.setEquipSelected(widget,false) 
        end
        Functions.getEquipNode(widget,data) 
        Functions.bindEventListener(widget,GameEventCenter,"EQUIP_CANCAL_SELECTED_EVENT",function()  -- 点中装备
            if selectedFlag == widget.index  then             
                Functions.setEquipSelected(widget,false) 
            end
        end)
        -- Functions.bindEventListener(widget,GameEventCenter,"EQUIP_ONEKEY_SELL_EVENT",function() --选择装备出售
        --     local tmp = widget:getChildByName("equipmentPanel"):getChildByName("CheckBox_Mark")
        --     tmp:setVisible(true)
        -- end)
        Functions.bindEventListener(widget,GameEventCenter,"EQUIP_ONEKEY_SELECTE_EVENT",function() --一键选择装备出售
            if data.selecetFlag ~= nil then 
                widget:getChildByName("equipmentPanel"):getChildByName("CheckBox_Mark"):setSelectedState(data.selecetFlag) 
            end
        end)
        local clickHandler = function()
            if selectedFlag ~= index then 
                GameEventCenter:dispatchEvent({ name = "EQUIP_CANCAL_SELECTED_EVENT"})
            end
            if showType == 1 then 
                Functions.setEquipSelected(widget,true)
            else
                Functions.setEquipSelected(widget,false)
                if not checkBox:isSelected() then 
                    data.selecetFlag = true
                    checkBox:setSelectedState(true)
                    self:addWillSellEquipMark(data.mark)
                    self:updateHuiShowMoney()
                else
                    data.selecetFlag = false
                    checkBox:setSelectedState(false)
                    table.removebyvalue(self.willSellEquipMarks,data.mark)
                    self:updateHuiShowMoney()
                end
                if #self.willSellEquipMarks > 0 then 
                    self._quedBt_t:setVisible(true)
                else
                    self._quedBt_t:setVisible(false)
                end
            end
            self._equipInfPanel_t:setVisible(true)
            selectedFlag = index
            Functions.displayEquipInf(self._equipInfPanel_t,data)
            self:bindSellBtHandler(widget,data)
            
            if showType == 1 then 
                local selectedEquipId = EquipmentData:getEquipInf(data.mark).m_id
                local selectedEquipColorNum = ConfigHandler:getColorNumOfId(selectedEquipId)
                if selectedEquipColorNum > 3 then 
                    self._qiangHuaBt_t:setVisible(true)
                    self._bt_t:setPositionX(58)
                else
                    self._qiangHuaBt_t:setVisible(false)
                    self._bt_t:setPositionX(110)
                end
                self._bt_t:setVisible(true)
            end
            local qiangHuaBtHandler = function( )
                self:openChildView("app.ui.popViews.EquipEnhancePopView",{isRemove = false,name = "equipEnhancePopView",data = {mark = data.mark,
                    handler = function()
                        local equipData = EquipmentData.equipmentInf
                        local sortEquipData =  EquipmentData:sortEquip(equipData)
                        self:displayEquipList(sortEquipData,showType)
                end}})
            end
            self._qiangHuaBt_t:onTouch(Functions.createClickListener(qiangHuaBtHandler,"zoom"))
        end
        widget:setTouchEnabled(true)
        widget:onTouch(Functions.createTableViewClickListener(self._equipContainer_t,clickHandler, "movedis"))
    end    
    
    -- Functions.bindArryListWithData(self._equipListView_t,{firstData = sortEquipData,
    --                            secondData = PlayerData.eventAttr.m_curEquipmentBagSize},
    --                            listHandler,
    --                            {direction = true,col = 5,firstSegment = 5,segment = 12 })
    local cleanNodeHandler = function(target)
        Functions.cleanEquipNode(target)
        target:setTouchEnabled(false)
        Functions.setEquipSelected(target,false) 
        target:getChildByName("equipmentPanel"):getChildByName("CheckBox_Mark"):setVisible(false)
    end
    local romveNodeHandler = function(target)
        Functions.removeEventBeforeUiClean(target)
    end
     Functions.bindTableViewWithData(self._equipContainer_t,{firstData = showData,
                                                         secondData = PlayerData.eventAttr.m_curEquipmentBagSize},
                                                         {handler = listHandler,handler2 = cleanNodeHandler,romveNodeHandler = romveNodeHandler},
                                                         {direction = true,col = 5,firstSegment = 5,segment = 10,segmentY = 20})
end

--绑定装备出售按钮监听
function PropViewController:bindSellBtHandler(target,data)
    local sellBt = self._equipInfPanel_t:getChildByName("bt")
    local clickHandler = function()
        if EquipmentData:isAppareled(data.mark) then
            PromptManager:openTipPrompt(LanguageConfig.language_prop_1)
        elseif ConfigHandler:getColorNumOfId( EquipmentData:getEquipInf(data.mark).m_id) > 3 then
            local callBack = function()       
                self:sellEquip( target,data.mark )
            end
            NoticeManager:openTips(self,{title = LanguageConfig.language_prop_2,handler = callBack})
        else
           self:sellEquip(target,data.mark )
        end
    end
    sellBt:onTouch(Functions.createClickListener(clickHandler,"zoom"))
end

--出售装备
function PropViewController:sellEquip( target,mark )
    local handler = function (event)
        --出售成功获得铜钱
        PlayerData.eventAttr.m_money =  PlayerData.eventAttr.m_money + ConfigHandler:getEquipPriceOfId(EquipmentData:getEquipInf(mark).m_id)
        
        EquipmentData:miuEquip( mark )
        Functions.cleanEquipNode(target)
        self._equipInfPanel_t:setVisible(false)
        target:setTouchEnabled(false)
        self:displayEquipList(EquipmentData.equipmentInf,1)
        PromptManager:openTipPrompt(LanguageConfig.language_prop_3)       
    end
    EquipmentData:requestSellEquip({mark},handler)
end
--出售道具
function PropViewController:sellProp(id,sellPropNum)
    local handler = function (event)
        --出售成功获得铜钱
        PlayerData.eventAttr.m_money =  event.money
        PropData:miuProp({m_id = id,m_count = event.miuPropCount})
        self:displayPropList()
        PromptManager:openTipPrompt(LanguageConfig.language_prop_14)       
    end
    PropData:requestSellProp(id,sellPropNum,handler)
end
--显示道具列表
function PropViewController:displayPropList()
    -- self._propListView_t:setVisible(true)
    -- self._equipListView_t:setVisible(false)
    self._btPanel_t:setVisible(false)
    self._oneKeyBt_t:setVisible(false)
    self._quedBt_t:setVisible(false)

    self._equipContainer_t:setVisible(false)
    self._propContainer_t:setVisible(true)
    self._propInfPanel_t:setVisible(true)
    self._equipInfPanel_t:setVisible(false)
    local selectedFlag = 0 
    self:cleanPropInf(self._propInfPanel_t)
    local listHandler = function(index, widget, model, data)
        widget:setSwallowTouches(false)
        widget.index = index
        if index == 1 and selectedFlag == 0 then
            selectedFlag = index
            self:setPropSelected(widget, true )
            self:displayPropInf(self._propInfPanel_t,index,data)    
        elseif selectedFlag == index then
            self:setPropSelected(widget, true )       
        else
            self:setPropSelected(widget, false)  
        end    

        local propCnt = widget:getChildByName("propCntLabel")
        propCnt:setVisible(true)
        propCnt:setString("x" .. tostring(data.eventAttr.m_count))
       
        local prop = widget:getChildByName("prop")
        prop:setVisible(true)      
        prop:ignoreContentAdaptWithSize(true)
        Functions.loadImageWithWidget(prop, g_ItemConfig[data.m_id]["imgID"])

        local bindHandler = function (event)
            if event.data > 0 then
                propCnt:setString("x" .. tostring(event.data))
            else
                propCnt:setVisible(false) 
                prop:setVisible(false)
                widget:setTouchEnabled(false)  
                self._propInfPanel_t:setVisible(false) 
            end
        end
        Functions.bindUiWithModelAttr(propCnt, data, "m_count",bindHandler)
         Functions.bindEventListener(widget,GameEventCenter,"PROP_CANCAL_SELECTED_EVENT",function() 
            if selectedFlag == widget.index  then             
                self:setPropSelected(widget,false) 
            end
        end)
        local onWidgetClick = function(event)
            self._propInfPanel_t:setVisible(true)
            if selectedFlag ~= index then 
                GameEventCenter:dispatchEvent({ name = "PROP_CANCAL_SELECTED_EVENT"})
            end
            self:setPropSelected(widget,true)
            selectedFlag = index
            self:displayPropInf(self._propInfPanel_t,index,data)
        end
        widget:setTouchEnabled(true)
        if data.m_id == 45 then
            self._equipBt_t = widget
        end
        widget:onTouch(Functions.createTableViewClickListener(self._propContainer_t,onWidgetClick,"movedis"))
    end 
    -- Functions.bindArryListWithData(self._propListView_t,{firstData = PropData.propInf.m_itemBag,
    --                                                      secondData = PlayerData.eventAttr.m_curBagSize},
    --                                                      listHandler,
    --                                                      {direction = true,col = 5,firstSegment = 5,segment = 10 })
    local cleanNodeHandler = function(widget)
        local prop = widget:getChildByName("prop")
        prop:setVisible(false)  
        self:setPropSelected(widget, false)
        local propCnt = widget:getChildByName("propCntLabel")
        propCnt:setVisible(false) 
        widget:setTouchEnabled(false)
    end
    local removeNodeHandler = function(widget)
        local propCnt = widget:getChildByName("propCntLabel")
        Functions.removeEventBeforeUiClean(propCnt)
    end
    local displayPropData = {}
    if self.jumpType == JumpType.ExpChangeToProp then 
        displayPropData = PropData:getExpProp()
    else
        displayPropData = PropData.propInf.m_itemBag
    end
    Functions.bindTableViewWithData(self._propContainer_t,{firstData = displayPropData,
                                                         secondData = PlayerData.eventAttr.m_curBagSize},
                                                         {handler = listHandler,handler2 = cleanNodeHandler,removeNodeHandler = removeNodeHandler},
                                                         {direction = true,col = 5,firstSegment = 5,segment = 10,segmentY = 20})
end
--显示道具详情
function PropViewController:displayPropInf(target,index,data)
    target:setVisible(true)
    local prop =target:getChildByName("propNode"):getChildByName("prop")
    prop:ignoreContentAdaptWithSize(true)
    Functions.loadImageWithWidget(prop, ConfigHandler:getPropImageOfId(data.m_id))
    prop:setVisible(true)    
    target:getChildByName("titleInfLabel"):setString(tostring(ConfigHandler:getPropNameOfId(data.m_id)))
    target:getChildByName("titleInfLabel"):setVisible(true)
    target:getChildByName("propInfLabel"):setString(tostring(ConfigHandler:getPropInfOfId(data.m_id)))
    target:getChildByName("propInfLabel"):setVisible(true)
    local propType = ConfigHandler:getPropTypeOfId(data.m_id)
    target:getChildByName("usePropBt"):setVisible(true)
    if propType <= 0 then --是否可用
        if self.jumpType == JumpType.ExpChangeToProp then 
             Functions.loadImageWithWidget(target:getChildByName("usePropBt"):getChildByName("btText"), "tyj/uiFonts_res/xuanze.png")
             self._sellPanel_t:setVisible(false)
        else
           Functions.loadImageWithWidget(target:getChildByName("usePropBt"):getChildByName("btText"), "tyj/uiFonts_res/cs.png")
           self._sellPanel_t:setVisible(true)
        end
        self._sellPanel_t:getChildByName("price"):setString(tostring(ConfigHandler:getPropPriceOfId(data.m_id)))
    else      
        Functions.loadImageWithWidget(target:getChildByName("usePropBt"):getChildByName("btText"), "tyj/uiFonts_res/shiy.png")
        self._sellPanel_t:setVisible(false)
    end 
    local onUsePropBtClick = function ()
        if self.jumpType == JumpType.ExpChangeToProp then
             GameCtlManager:pop(self,{data = {jumpType = self.jumpType,jumpData = {propId =data.m_id }}})
        else            
            if propType == 5 then--改名字
                local handler = function(text)
                    if text ~= "" then
                        local isOk = function(event)
                            PromptManager:openTipPrompt(LanguageConfig.language_prop_4)
                            PropData:miuProp( {m_id = data.m_id,m_count = 1})
                            PlayerData.eventAttr.m_name = text
                        end
                        PropData:RequestModifyName(text,data.m_id,isOk)
                    else
                        PromptManager:openTipPrompt(LanguageConfig.language_prop_5)
                    end
                end  
                NoticeManager:openEditTips(self, {type = NoticeManager.EDIT_NAME_TIPS,handler = handler})
            elseif propType == 6 then--发广播
                local handler = function(text)
                    if text ~= "" then
                        local isOk = function(event)
                            PromptManager:openTipPrompt(LanguageConfig.language_prop_6)
                            PropData:miuProp( {m_id = data.m_id,m_count = 1})
                        end
                        PropData:RequestBroadcast(text,data.m_id,isOk)
                    else
                        PromptManager:openTipPrompt(LanguageConfig.language_prop_7)
                    end
                end  
                NoticeManager:openEditTips(self, {type = NoticeManager.EDIT_BROADCAST_TIPS,handler = handler})
            elseif propType == 3 then                    
                self:requestOpenBox(data.m_id)
            elseif propType == 2 then 
                local handler = function( event )
                    PromptManager:openTipPrompt(LanguageConfig.language_prop_8)
                    if PropData:getPropNumOfId(data.m_id) < 1 then
                        self:displayPropList()
                    end
                end
                PropData:RequestUsePower(data.m_id,handler)
            elseif propType == 7 then 
                 self:openChildView("app.ui.popViews.UseExpCardPopView", { isRemove = false, data = {data.m_id} })
            elseif propType <= 0 then 
                NoticeManager:openSellPropView(GameCtlManager.currentController_t, {propId = data.m_id  ,handler = function(sellPropNum)
                    self:sellProp(data.m_id,sellPropNum)
                end})
            end
        end
    end
    if data.m_id == 45 then
        self._useBt_t = target:getChildByName("usePropBt")
    end
    target:getChildByName("usePropBt"):onTouch(Functions.createClickListener(onUsePropBtClick, "")) 
end
function PropViewController:requestOpenBox(id)
    local handler = function(event)                
        PropData:miuProp( {m_id = id,m_count = 1})
        if event.gtype == 1 then    --抽卡                  
            HeroCardData:addCard({slot = event.gslot,id = event.gid}) 
            self:openChildView("app.ui.popViews.EnlistThreePopView", {isRemove = true,data = {slot = event.gslot,id = event.gid,type = 1} })   
        elseif event.gtype == 2 then--抽装备
            EquipmentData:addEquip({m_id = event.gid,mark = event.gslot,rdAttrType = event.gPlusPropType,rdAttrPercent = event.gPropValueTil })
            if PropData:getPropNumOfId(id) >= 1 then 
                NoticeManager:openRewardTips(self, {type = NoticeManager.REWARD_EQUIP_TIPS,data = {equipMark = event.gslot,propData = id,againHandler = handler(self,self.requestOpenBox)}})   
            else
                NoticeManager:openRewardTips(self, {type = NoticeManager.REWARD_EQUIP_TIPS,data = {equipMark = event.gslot}})
            end  
        elseif event.gtype == 3 then --开武将卡包
            for k,v in pairs(event.gslot) do
                HeroCardData:addCard({slot = v.slot,id = v.id})
            end
            NoticeManager:openRewardTips(self, {type = NoticeManager.REWARD_HERO_CARD_TIPS,data = {heroId = event.gid, heroNum = #event.gslot }}) 
        elseif event.gtype == 4 then --抽道具
            local propImg = ""
            if  event.gid == -2 then
                propImg = "property_gold.png"
            elseif  event.gid == -3 then
                propImg = "property_money.png"
            elseif event.gid == -5 then
                propImg = "soul80.png"
            elseif event.gid == -6 then
                propImg = "property_soulCrystal.png"
            else
                propImg = ConfigHandler:getPropImageOfId(event.gid)
            end
            local propCount = event.gcount
            if PropData:getPropNumOfId(id) >= 1 then 
                NoticeManager:openRewardTips(self, {type = NoticeManager.REWARD_PROP_TIPS,propData = id,againHandler = handler(self,self.requestOpenBox),data = {{img = propImg, num = propCount}}}) 
            else
                 NoticeManager:openRewardTips(self, {type = NoticeManager.REWARD_PROP_TIPS,data = {{img = propImg, num = propCount}}})
            end
            PropData:addProp({m_id=event.gid,m_count=propCount,handler = handler(self,self.displayPropList)})
        elseif event.gtype == 5 then --抽碎片
            local img = ConfigHandler:getHeroHeadImageOfId(event.gid) 
            local num = event.gcount                    
            Functions:addItemResources({id = event.gid,type = event.gtype,count = num,slot = event.gslot})   
            if PropData:getPropNumOfId(id) >= 1 then                  
                NoticeManager:openRewardTips(self, {type = NoticeManager.REWARD_CARD_FRAGMENT_TIPS,propData = id,againHandler = handler(self,self.requestOpenBox),data = {{img = img, num = num}}}) 
            else
                NoticeManager:openRewardTips(self, {type = NoticeManager.REWARD_CARD_FRAGMENT_TIPS,data = {{img = img, num = num}}}) 
            end
            --CompoundData:setCompoundData(event.gid)
        end
        if PropData:getPropNumOfId(id) < 1 then
            self:displayPropList()
        end
    end
    PropData:RequestUseCard(id,handler)
end
--清除道具详情
function PropViewController:cleanPropInf(target)
   local prop =target:getChildByName("propNode"):getChildByName("prop")
   prop:setVisible(false)
   target:getChildByName("usePropBt"):setVisible(false)
   target:getChildByName("titleInfLabel"):setVisible(false)
   target:getChildByName("propInfLabel"):setVisible(false)
   target:getChildByName("sellPanel"):setVisible(false)
end

function PropViewController:setPropSelected(target, isSelected )
    local selectView = target:getChildByName("choose")
    if isSelected == nil then isSelected = false end
    if isSelected then
        selectView:setVisible(true)
    else
        selectView:setVisible(false)
    end
    self._propInfPanel_t:setVisible(true)
end
function PropViewController:onReceivePushData(jump)
    if jump ~= nil then 
        self.jumpType = jump.jumpType
        self.jumpData = jump.jumpData 
    end
end
function PropViewController:onReceivePopData(jump)
    if jump ~= nil then 
        self.jumpType = jump.jumpType
        self.jumpData = jump.jumpData 
         --数据更新监听
         GameEventCenter:dispatchEvent({ name = "PROP_DATA_CHANGE" , data = jump })
    end
end
return PropViewController