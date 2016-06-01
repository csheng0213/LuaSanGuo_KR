--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionSetPopView = class("UnionSetPopView", BasePopView)

local Functions = require("app.common.Functions")

UnionSetPopView.csbResPath = "lk/csb"
UnionSetPopView.debug = true
UnionSetPopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","UnionUI" }
--@auto code head end
--@Pre loading
UnionSetPopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionSetPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #UnionSetPopView.studioSpriteFrames > 0 then
    UnionSetPopView.spriteFrameNames = UnionSetPopView.spriteFrameNames or {}
    table.insertto(UnionSetPopView.spriteFrameNames, UnionSetPopView.studioSpriteFrames)
end
function UnionSetPopView:onInitUI()

    --output list
    self._Image_set_head_icon_t = self.csbNode:getChildByName("Panel_set_8"):getChildByName("Image_set_head_bg"):getChildByName("Image_set_head_icon")
	self._Text_level_num_t = self.csbNode:getChildByName("Panel_set_8"):getChildByName("Text_level_num")
	
    --label list
    self._Text_type_string_1_t = self.csbNode:getChildByName("Panel_set_8"):getChildByName("Text_type_string_1")
	self._Text_type_string_1_t:setString(LanguageConfig.language_Union_21)
    --button list
    self._Button_Modify_t = self.csbNode:getChildByName("Panel_set_8"):getChildByName("Button_Modify")
	self._Button_Modify_t:onTouch(Functions.createClickListener(handler(self, self.onButton_modifyClick), "zoom"))

	self._Button_type_1_t = self.csbNode:getChildByName("Panel_set_8"):getChildByName("Button_type_1")
	self._Button_type_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_type_1Click), "zoom"))

	self._Button_type_2_t = self.csbNode:getChildByName("Panel_set_8"):getChildByName("Button_type_2")
	self._Button_type_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_type_2Click), "zoom"))

	self._Button_level_1_t = self.csbNode:getChildByName("Panel_set_8"):getChildByName("Button_level_1")
	self._Button_level_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_level_1Click), "zoom"))

	self._Button_level_2_t = self.csbNode:getChildByName("Panel_set_8"):getChildByName("Button_level_2")
	self._Button_level_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_level_2Click), "zoom"))

	self._Button_set_ok_t = self.csbNode:getChildByName("Panel_set_8"):getChildByName("Button_set_ok")
	self._Button_set_ok_t:onTouch(Functions.createClickListener(handler(self, self.onButton_set_okClick), "zoom"))

	self._Button_set_close_t = self.csbNode:getChildByName("Panel_set_8"):getChildByName("Button_set_close")
	self._Button_set_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_set_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_modify btFunc
function UnionSetPopView:onButton_modifyClick()
    Functions.printInfo(self.debug,"Button_modify button is click!")
    --打开二级界面
    self._controller_t:openChildView("app.ui.popViews.UnionIconPopView")
end
--@auto code Button_modify btFunc end

--@auto code Button_type_1 btFunc
function UnionSetPopView:onButton_type_1Click()
    Functions.printInfo(self.debug,"Button_type_1 button is click!")
    if self.type > 1 then
        self.type = self.type - 1
    else
        self.type = 1
    end
    self:showType(self.type)
end
--@auto code Button_type_1 btFunc end

--@auto code Button_type_2 btFunc
function UnionSetPopView:onButton_type_2Click()
    Functions.printInfo(self.debug,"Button_type_2 button is click!")
    if self.type < 3 then
        self.type = self.type + 1
    else
        self.type = 3
    end
    self:showType(self.type)
end
--@auto code Button_type_2 btFunc end

--@auto code Button_level_1 btFunc
function UnionSetPopView:onButton_level_1Click()
    Functions.printInfo(self.debug,"Button_level_1 button is click!")
    if self.level > g_csOpen.GonghuiOpen.level then
        self.level = self.level - 1
    else
        self.level = g_csOpen.GonghuiOpen.level
    end
    self._Text_level_num_t:setText(self.level)
end
--@auto code Button_level_1 btFunc end

--@auto code Button_level_2 btFunc
function UnionSetPopView:onButton_level_2Click()
    Functions.printInfo(self.debug,"Button_level_2 button is click!")
    if self.level < 99 then
        self.level = self.level + 1
    else
        self.level = 99
    end
    self._Text_level_num_t:setText(self.level)
end
--@auto code Button_level_2 btFunc end

--@auto code Button_set_ok btFunc
function UnionSetPopView:onButton_set_okClick()
    Functions.printInfo(self.debug,"Button_set_ok button is click!")
    local onUnionSet = function(event)
        if event.reqtype == 8 then

            local data = UnionData:getUnionInfoData()[1]
            local pppp = self.pic
            data.eventAttr.m_pic = self.pic
            data.eventAttr.m_join_type = self.type
            data.eventAttr.m_join_level = self.level
            --数据更新监听
            GameEventCenter:dispatchEvent({ name = UnionData.ADD_UNION_CHANGE_ICON_EVENT, data = data.eventAttr.m_pic })

            --关闭弹出框
            self._controller_t:closeChildView(self)
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onUnionSet,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 8, data = { pic = self.pic, join_type = self.type, join_level = self.level } })
end
--@auto code Button_set_ok btFunc end

--@auto code Button_set_close btFunc
function UnionSetPopView:onButton_set_closeClick()
    Functions.printInfo(self.debug,"Button_set_close button is click!")
    local data = UnionData:getUnionInfoData()[1]
    data.eventAttr.m_pic = self.icon
    data.eventAttr.m_join_type = self.join_type
    data.eventAttr.m_join_level = self.join_level
    --关闭弹出框
    self._controller_t:closeChildView(self)
end
--@auto code Button_set_close btFunc end

--@auto button backcall end


--@auto code output func
function UnionSetPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionSetPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    local data = UnionData:getUnionInfoData()[1]
    --加入等级
    self.join_level = data.eventAttr.m_join_level
    self.level = data.eventAttr.m_join_level
    --加入类型
    self.join_type = data.eventAttr.m_join_type
    self.type = data.eventAttr.m_join_type
    --公会图标
    self.icon = data.eventAttr.m_pic
    self.pic = data.eventAttr.m_pic
    
    Functions.loadImageWithWidget(self._Image_set_head_icon_t, Functions:getGongHuiImageOfId(data.eventAttr.m_pic) )
    --Functions.loadImageWithWidget(self._Image_set_head_icon_t, ConfigHandler:getHeroHeadImageOfId(data.eventAttr.m_pic))
    self._Text_level_num_t:setText(self.level)
    --监听函数
    local onChecked = function(event)
        self.pic = event.data
        Functions.loadImageWithWidget(self._Image_set_head_icon_t, Functions:getGongHuiImageOfId(event.data) )
        --Functions.loadImageWithWidget(self._Image_set_head_icon_t, Functions:getGongHuiImageOfId(event.data) ) 
    end
    Functions.bindEventListener(self, GameEventCenter, UnionData.ADD_UNION_ICON_EVENT, onChecked)
end

function UnionSetPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function UnionSetPopView:showType(type)
    Functions.printInfo(self.debug,"showType")
    if type == 1 then
        self._Text_type_string_1_t:setText(LanguageConfig.language_Union_19)
    elseif type == 2 then
        self._Text_type_string_1_t:setText(LanguageConfig.language_Union_20)
    elseif type == 3 then
        self._Text_type_string_1_t:setText(LanguageConfig.language_Union_21)
    end
    
end

return UnionSetPopView