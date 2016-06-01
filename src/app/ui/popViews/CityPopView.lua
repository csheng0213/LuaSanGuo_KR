--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local CityPopView = class("CityPopView", BasePopView)

local Functions = require("app.common.Functions")

CityPopView.csbResPath = "lk/csb"
CityPopView.debug = true
CityPopView.studioSpriteFrames = {"CBO_taxKuang","CityUI_Text" }
--@auto code head end
--@Pre loading
CityPopView.spriteFrameNames = 
    {
    }

CityPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #CityPopView.studioSpriteFrames > 0 then
    CityPopView.spriteFrameNames = CityPopView.spriteFrameNames or {}
    table.insertto(CityPopView.spriteFrameNames, CityPopView.studioSpriteFrames)
end
function CityPopView:onInitUI()

    --output list
    self._Text_UP_level_string_t = self.csbNode:getChildByName("Text_UP_level_string")
	
    --label list
    
    --button list
    self._Button_up_level_t = self.csbNode:getChildByName("Button_up_level")
	self._Button_up_level_t:onTouch(Functions.createClickListener(handler(self, self.onButton_up_levelClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_up_level btFunc
function CityPopView:onButton_up_levelClick()
    Functions.printInfo(self.debug,"Button_up_level button is click!")
    --打开奖励界面
    NoticeManager:openRewardTips(self._controller_t, {type = NoticeManager.REWARD_PROP_TIPS, data = self.itemDatas})
    self._controller_t:closeChildView(self)
end
--@auto code Button_up_level btFunc end

--@auto button backcall end


--@auto code output func
function CityPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function CityPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	local level = data.level
    local type = data.type
    self.itemDatas = data.item
	local str = ""
	if type == 1 then
        str = string.format( LanguageConfig.language_City_5, level, g_StructureBoxNumCfg[level] )
    elseif type == 2 then
        str = string.format( LanguageConfig.language_City_7, level, g_StructureGoldCfg[level] )
    elseif type == 3 then
        str = string.format( LanguageConfig.language_City_9, level, g_StructureCoinCfg[level] )
	end
	Functions.initLabelOfString(self._Text_UP_level_string_t, str)
	
end

function CityPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return CityPopView