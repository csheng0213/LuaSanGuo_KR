--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local Union_CY_PopView = class("Union_CY_PopView", BasePopView)

local Functions = require("app.common.Functions")

Union_CY_PopView.csbResPath = "lk/csb"
Union_CY_PopView.debug = true
Union_CY_PopView.studioSpriteFrames = {"UnionUI_Text","UnionUI","CBO_unionBg" }
--@auto code head end
--@Pre loading
Union_CY_PopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

Union_CY_PopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #Union_CY_PopView.studioSpriteFrames > 0 then
    Union_CY_PopView.spriteFrameNames = Union_CY_PopView.spriteFrameNames or {}
    table.insertto(Union_CY_PopView.spriteFrameNames, Union_CY_PopView.studioSpriteFrames)
end
function Union_CY_PopView:onInitUI()

    --output list
    self._Image_head_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Image_head_bg"):getChildByName("Image_head")
	self._Image_zhang_lao_1_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Button_zhang_lao_1"):getChildByName("Image_zhang_lao_1")
	self._Image_zhang_lao_2_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Button_zhang_lao_1"):getChildByName("Image_zhang_lao_2")
	self._Text_name_1_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Text_name_1")
	self._Text_level_1_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Text_level_1")
	
    --label list
    
    --button list
    self._Button_zhang_lao_1_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Button_zhang_lao_1")
	self._Button_zhang_lao_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_zhang_lao_1Click), "zoom"))

	self._Button_hui_zhang_2_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Button_hui_zhang_2")
	self._Button_hui_zhang_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_hui_zhang_2Click), "zoom"))

	self._Button_ti_chu_3_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Button_ti_chu_3")
	self._Button_ti_chu_3_t:onTouch(Functions.createClickListener(handler(self, self.onButton_ti_chu_3Click), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_zhang_lao_1 btFunc
function Union_CY_PopView:onButton_zhang_lao_1Click()
    Functions.printInfo(self.debug,"Button_zhang_lao_1 button is click!")
    self.type = 0
    local data = self.memberInfo
    if data.eventAttr.m_member_type == 2 then
        self.type = 1
    elseif data.eventAttr.m_member_type == 1 then
        self.type = 2
    end
    self:memberChange()
end
--@auto code Button_zhang_lao_1 btFunc end

--@auto code Button_hui_zhang_2 btFunc
function Union_CY_PopView:onButton_hui_zhang_2Click()
    Functions.printInfo(self.debug,"Button_hui_zhang_2 button is click!")
    --弹出框
    NoticeManager:openTips(self:getController(), { handler = handler(self,self.JobTransfer), title = LanguageConfig.language_Union_23})

end
--@auto code Button_hui_zhang_2 btFunc end

--@auto code Button_ti_chu_3 btFunc
function Union_CY_PopView:onButton_ti_chu_3Click()
    Functions.printInfo(self.debug,"Button_ti_chu_3 button is click!")
    --踢出公会
    self:memberTiChu()
end
--@auto code Button_ti_chu_3 btFunc end

--@auto button backcall end


--@auto code output func
function Union_CY_PopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function Union_CY_PopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	--要判断操作人的职位
    Functions.initLabelOfString(self._Text_name_1_t, data.m_name, self._Text_level_1_t, data.m_level)
    Functions.loadImageWithWidget(self._Image_head_t, Functions.getDisHeadFImagePathOfId(data.m_pic))
    self.memberInfo = data
    local MemberInfo = UnionData:getMemberInfoData()
    local zhiWei = 0
    for k, v in pairs(MemberInfo) do
        if PlayerData.eventAttr.m_uid == v.m_id then
            zhiWei = v.eventAttr.m_member_type
    	end
    end
    if data.m_id ~= PlayerData.eventAttr.m_uid then
    
    end
    if zhiWei == 3 then
        self._Button_zhang_lao_1_t:setVisible(true)
        self._Button_hui_zhang_2_t:setVisible(true)
        if data.eventAttr.m_member_type == 2 then
            self._Image_zhang_lao_1_t:setVisible(false)
            self._Image_zhang_lao_2_t:setVisible(true)
            --self._BitmapFontLabel_1_t:setString(LanguageConfig.language_Union_8)
        elseif data.eventAttr.m_member_type == 1 then
            self._Image_zhang_lao_1_t:setVisible(true)
            self._Image_zhang_lao_2_t:setVisible(false)
            --self._BitmapFontLabel_1_t:setString(LanguageConfig.language_Union_9)
        end
    elseif zhiWei == 2 then
        self._Button_zhang_lao_1_t:setVisible(false)
        self._Button_hui_zhang_2_t:setVisible(false)
    end
end

function Union_CY_PopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function Union_CY_PopView:memberChange()
    Functions.printInfo(self.debug,"memberChange")
    
    local data = self.memberInfo
    local onMemberInfo = function(event)
        if event.reqtype == 20  then
            if self.type == 1 then--撤消长老
            	self.memberInfo.eventAttr.m_member_type = 1
                self._controller_t:closeChildView(self)
            elseif self.type == 2 then--任命长老
                self.memberInfo.eventAttr.m_member_type = 2
                self._controller_t:closeChildView(self)
            elseif self.type == 3 then--任命会长
                --让出会长后，要退出管理界面
                self.memberInfo.eventAttr.m_member_type = 3
                GameCtlManager:pop(self._controller_t)
            end
            
            --数据更新监听
            GameEventCenter:dispatchEvent({ name = UnionData.MEMBER_POSITION_EVENT, data = {} })
        end   
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onMemberInfo,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 20,data = { id = data.m_id, t = self.type } })
    
end

--踢出公会
function Union_CY_PopView:memberTiChu()
    Functions.printInfo(self.debug,"memberTiChu")

    local data = self.memberInfo
    local onMemberInfo = function(event)
        
        if event.reqtype == 22  then
            local id = event.data.id
            UnionData:subMemberInfoData(id)
            self._controller_t:closeChildView(self)
            --数据更新监听
            GameEventCenter:dispatchEvent({ name = UnionData.MEMBER_POSITION_EVENT, data = {} })
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onMemberInfo,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 22, data = { id = data.m_id } })

end

--会长转让提示
function Union_CY_PopView:JobTransfer()
    --让出会长
    self.type = 3
    self:memberChange()
end

return Union_CY_PopView