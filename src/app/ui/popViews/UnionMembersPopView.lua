--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionMembersPopView = class("UnionMembersPopView", BasePopView)

local Functions = require("app.common.Functions")

UnionMembersPopView.csbResPath = "lk/csb"
UnionMembersPopView.debug = true
UnionMembersPopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","UnionUI" }
--@auto code head end
--@Pre loading
UnionMembersPopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionMembersPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #UnionMembersPopView.studioSpriteFrames > 0 then
    UnionMembersPopView.spriteFrameNames = UnionMembersPopView.spriteFrameNames or {}
    table.insertto(UnionMembersPopView.spriteFrameNames, UnionMembersPopView.studioSpriteFrames)
end
function UnionMembersPopView:onInitUI()

    --output list
    self._Text_union_cheng_yuan_num_t = self.csbNode:getChildByName("Panel_dekaron_7"):getChildByName("Text_union_cheng_yuan_num")
	self._ListView_dekaron_t = self.csbNode:getChildByName("Panel_dekaron_7"):getChildByName("ListView_dekaron")
	self._Image_dekaron_head_icon_t = self.csbNode:getChildByName("Panel_dekaron_7"):getChildByName("ListView_dekaron"):getChildByName("model"):getChildByName("Panel_list_dekaron"):getChildByName("Image_dekaron_head_bg"):getChildByName("Image_dekaron_head_icon")
	
    --label list
    
    --button list
    self._Button_Members_close_t = self.csbNode:getChildByName("Panel_dekaron_7"):getChildByName("Button_Members_close")
	self._Button_Members_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_members_closeClick), "zoom"))

	self._CheckBox_time_1_t = self.csbNode:getChildByName("Panel_dekaron_7"):getChildByName("CheckBox_time_1")
	self._CheckBox_time_1_t:onTouch(Functions.createClickListener(handler(self, self.onCheckbox_time_1Click), "zoom"))

	self._CheckBox_7_day_2_t = self.csbNode:getChildByName("Panel_dekaron_7"):getChildByName("CheckBox_7_day_2")
	self._CheckBox_7_day_2_t:onTouch(Functions.createClickListener(handler(self, self.onCheckbox_7_day_2Click), "zoom"))

	self._CheckBox_dekaron_3_t = self.csbNode:getChildByName("Panel_dekaron_7"):getChildByName("CheckBox_dekaron_3")
	self._CheckBox_dekaron_3_t:onTouch(Functions.createClickListener(handler(self, self.onCheckbox_dekaron_3Click), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Checkbox_time_1 btFunc
function UnionMembersPopView:onCheckbox_time_1Click()
    Functions.printInfo(self.debug,"Checkbox_time_1 button is click!")
    self._CheckBox_time_1_t:setSelectedState(true)
    self._CheckBox_7_day_2_t:setSelectedState(false)
    self._CheckBox_dekaron_3_t:setSelectedState(false)
    self.type = 1
    self:showInfo()
    if self._CheckBox_time_1_t:getSelectedState() == false then

    end
end
--@auto code Checkbox_time_1 btFunc end

--@auto code Checkbox_7_day_2 btFunc
function UnionMembersPopView:onCheckbox_7_day_2Click()
    Functions.printInfo(self.debug,"Checkbox_7_day_2 button is click!")
    self._CheckBox_7_day_2_t:setSelectedState(true)
    self._CheckBox_time_1_t:setSelectedState(false)
    self._CheckBox_dekaron_3_t:setSelectedState(false)
    self.type = 2
    self:showInfo()
    if self._CheckBox_7_day_2_t:getSelectedState() == false then

    end
end
--@auto code Checkbox_7_day_2 btFunc end

--@auto code Checkbox_dekaron_3 btFunc
function UnionMembersPopView:onCheckbox_dekaron_3Click()
    Functions.printInfo(self.debug,"Checkbox_dekaron_3 button is click!")
    self._CheckBox_dekaron_3_t:setSelectedState(true)
    self._CheckBox_time_1_t:setSelectedState(false)
    self._CheckBox_7_day_2_t:setSelectedState(false)
    self.type = 3
    self:showInfo()
    if self._CheckBox_dekaron_3_t:getSelectedState() == false then

    end
end
--@auto code Checkbox_dekaron_3 btFunc end

--@auto code Button_members_close btFunc
function UnionMembersPopView:onButton_members_closeClick()
    Functions.printInfo(self.debug,"Button_members_close button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_members_close btFunc end

--@auto button backcall end


--@auto code output func
function UnionMembersPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionMembersPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	--初使化
    self._CheckBox_time_1_t:setSelectedState(true)
    self._CheckBox_7_day_2_t:setSelectedState(false)
    self._CheckBox_dekaron_3_t:setSelectedState(false)
    
    --监听函数
    local onPosition = function(event)
        self:showInfo()
    end
    Functions.bindEventListener(self, GameEventCenter, UnionData.MEMBER_POSITION_EVENT, onPosition)
    --默认为最后上线时间
    self.type = 1
    self:showInfo()
end

function UnionMembersPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

--成员信息
function UnionMembersPopView:showInfo()
    Functions.printInfo(self.debug,"showInfo")
    --排序
    if self.type == 1 then
        UnionData:getMemberTimeSort()
    elseif self.type == 2 then
        UnionData:getActivitySort()
    elseif self.type == 3 then
        UnionData:getMemberFBSort()
    end
    
    local MemberInfo = UnionData:getMemberInfoData()
    Functions.initLabelOfString(self._Text_union_cheng_yuan_num_t, tostring(#MemberInfo).."/50")
    local listHandler = function(index, widget, data, model)

        local ban = widget:getChildByName("Panel_list_dekaron")
        local banModel = model:getChildByName("Panel_list_dekaron")
        Functions.initTextColor(banModel:getChildByName("Text_members_name_level"),ban:getChildByName("Text_members_name_level"))
        Functions.initTextColor(banModel:getChildByName("Text_members_Position"),ban:getChildByName("Text_members_Position"))
        Functions.initTextColor(banModel:getChildByName("Text_type_text"),ban:getChildByName("Text_type_text"))
        Functions.initTextColor(banModel:getChildByName("Text_type_text"):getChildByName("Text_type_text_num"),ban:getChildByName("Text_type_text"):getChildByName("Text_type_text_num"))
        local str = " "
        if data.eventAttr.m_member_type == 3 then
            str = LanguageConfig.language_Union_6
        elseif data.eventAttr.m_member_type == 2 then
            str = LanguageConfig.language_Union_5
        else
            str = LanguageConfig.language_Union_7
        end
        local typeStr = ""
        local numStr = ""
        if self.type == 1 then
            typeStr = LanguageConfig.language_Union_15
            if data.m_status == 2 then
                numStr = TimerManager:formatTime("%m-%d %H:%M", data.m_logout_time)
            else
                numStr = LanguageConfig.language_Union_43
            end
            
        elseif self.type == 2 then
            typeStr = LanguageConfig.language_Union_16
            numStr = tostring(data.m_activity)
        elseif self.type == 3 then
            typeStr = LanguageConfig.language_Union_17
            numStr = tostring(data.m_copytimes)
        end

        
        
        local name = data.m_name.."    "..tostring(data.m_level)..LanguageConfig.language_Union_4
        Functions.initLabelOfString(ban:getChildByName("Text_members_name_level"), name, ban:getChildByName("Text_members_Position"), str,
            ban:getChildByName("Text_type_text"), typeStr,ban:getChildByName("Text_type_text"):getChildByName("Text_type_text_num"), numStr)

        Functions.loadImageWithWidget(ban:getChildByName("Image_dekaron_head_bg"):getChildByName("Image_dekaron_head_icon"), Functions.getDisHeadFImagePathOfId(data.m_pic))

        Functions.bindUiWithModelAttr(ban:getChildByName("Text_members_Position"), data, "m_member_type", function(event)
            if event.data == 3 then
                str = LanguageConfig.language_Union_6
            elseif event.data == 2 then
                str = LanguageConfig.language_Union_5
            else
                str = LanguageConfig.language_Union_7
            end
            ban:getChildByName("Text_members_Position"):setText(str)
        end)

        local onClick = function(event)
            print("button click")
            --打开二级界面
            --不能操作自己，不能操作会长
            if data.m_id ~= PlayerData.eventAttr.m_uid then
                if data.eventAttr.m_member_type == 2 or data.eventAttr.m_member_type ~= 3 then
                    self._controller_t:openChildView("app.ui.popViews.Union_CY_PopView", { data = data })
                end
            end
        end
        ban:onTouch(Functions.createClickListener(onClick, "zoom"))


    end
    --绑定响应事件函数
    Functions.bindListWithData(self._ListView_dekaron_t, MemberInfo, listHandler)
end

return UnionMembersPopView