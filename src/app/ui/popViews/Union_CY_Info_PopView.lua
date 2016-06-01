--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local Union_CY_Info_PopView = class("Union_CY_Info_PopView", BasePopView)

local Functions = require("app.common.Functions")

Union_CY_Info_PopView.csbResPath = "lk/csb"
Union_CY_Info_PopView.debug = true
Union_CY_Info_PopView.studioSpriteFrames = {"UnionUI_Text","UnionUI","CBO_unionBg" }
--@auto code head end
--@Pre loading
Union_CY_Info_PopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

Union_CY_Info_PopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #Union_CY_Info_PopView.studioSpriteFrames > 0 then
    Union_CY_Info_PopView.spriteFrameNames = Union_CY_Info_PopView.spriteFrameNames or {}
    table.insertto(Union_CY_Info_PopView.spriteFrameNames, Union_CY_Info_PopView.studioSpriteFrames)
end
function Union_CY_Info_PopView:onInitUI()

    --output list
    self._Image_head_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Image_head_bg"):getChildByName("Image_head")
	self._Text_name_1_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Text_name_1")
	self._Text_level_1_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Text_level_1")
	self._Text_7_day_num_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Text_7_day_num")
	self._Text_last_time_num_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Text_last_time_num")
	self._Image_7_day_0_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Image_7_day_0")
	self._Image_7_day_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Image_7_day")
	self._Image_time_t = self.csbNode:getChildByName("Panel_c_y"):getChildByName("Image_time")
	
    --label list
    
    --button list
    
end
--@auto code uiInit end


--@auto code output func
function Union_CY_Info_PopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function Union_CY_Info_PopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
    --要判断操作人的职位
    Functions.initLabelOfString(self._Text_name_1_t, data.m_name, self._Text_level_1_t, data.m_level, self._Text_7_day_num_t, tostring(data.m_activity), 
    self._Text_last_time_num_t, TimerManager:formatTime("%m-%d %H:%M", data.m_logout_time))
    Functions.loadImageWithWidget(self._Image_head_t, Functions.getDisHeadFImagePathOfId(data.m_pic))
end

function Union_CY_Info_PopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return Union_CY_Info_PopView