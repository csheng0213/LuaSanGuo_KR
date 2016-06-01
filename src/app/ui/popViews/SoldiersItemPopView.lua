--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local SoldiersItemPopView = class("SoldiersItemPopView", BasePopView)

local Functions = require("app.common.Functions")

SoldiersItemPopView.csbResPath = "lk/csb"
SoldiersItemPopView.debug = true
SoldiersItemPopView.studioSpriteFrames = {"CC_commHuodetujing","Common_lk" }
--@auto code head end
--@Pre loading
SoldiersItemPopView.spriteFrameNames = 
    {
    }

SoldiersItemPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #SoldiersItemPopView.studioSpriteFrames > 0 then
    SoldiersItemPopView.spriteFrameNames = SoldiersItemPopView.spriteFrameNames or {}
    table.insertto(SoldiersItemPopView.spriteFrameNames, SoldiersItemPopView.studioSpriteFrames)
end
function SoldiersItemPopView:onInitUI()

    --output list
    self._Image_item_icon_t = self.csbNode:getChildByName("Panel_city_pop_bg"):getChildByName("Sprite_item_bg"):getChildByName("Image_item_icon")
	self._Text_item_name_t = self.csbNode:getChildByName("Panel_city_pop_bg"):getChildByName("Text_item_name")
	self._Image_item_have_string_t = self.csbNode:getChildByName("Panel_city_pop_bg"):getChildByName("Image_item_have_string")
	self._Text_item_have_num_t = self.csbNode:getChildByName("Panel_city_pop_bg"):getChildByName("Text_item_have_num")
	self._ListView_item_level_t = self.csbNode:getChildByName("Panel_city_pop_bg"):getChildByName("ListView_item_level")
	self._Text_level_name_t = self.csbNode:getChildByName("Panel_city_pop_bg"):getChildByName("ListView_item_level"):getChildByName("model"):getChildByName("Button_level_ban"):getChildByName("Text_level_name")
	self._Text_level_name_1_t = self.csbNode:getChildByName("Panel_city_pop_bg"):getChildByName("ListView_item_level"):getChildByName("model"):getChildByName("Image_Description"):getChildByName("Text_level_name_1")
	
    --label list
    
    --button list
    
end
--@auto code uiInit end


--@auto code output func
function SoldiersItemPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function SoldiersItemPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	self.itemId = data.id
    Functions.loadImageWithWidget(self._Image_item_icon_t, ConfigHandler:getPropImageOfId(self.itemId))
    Functions.initLabelOfString( self._Text_item_name_t, ConfigHandler:getPropNameOfId(self.itemId), self._Text_item_have_num_t, 
        PropData:getPropNumOfId(self.itemId).."/"..tostring(data.num))
    --显示关卡
    self:showLevel()
end

function SoldiersItemPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function SoldiersItemPopView:showLevel()
    Functions.printInfo(self.debug,"showLevel")

local ooooo = self.itemId
    local datas = {}
    local datas = ConfigHandler:getPropPlace(self.itemId)
--    local gkInfos = ConfigHandler:getPropGkOfId(self.itemId)
--    local num = table.nums(gkInfos)
--    for i=1, num do
--
--        local gkId = tonumber(gkInfos[i])
--
--        if gkId ~= 0 then
--            datas[#datas+1] = gkId
--            datas = 11111
--        end
--    end
    


    local listHandler = function(index, widget, data, model)

        if data.type == 1 then
            local ban = widget:getChildByName("Button_level_ban")
            ban:setVisible(true)
            local modelBan = model:getChildByName("Button_level_ban")
            Functions.initTextColor(modelBan:getChildByName("Text_level_name"), ban:getChildByName("Text_level_name"))
            Functions.initLabelOfString( ban:getChildByName("Text_level_name"), data.drop)
            --local button = widget:getChildByName("Button_level_ban")
        elseif data.type == 2 then
            local ban = widget:getChildByName("Image_Description")
            ban:setVisible(true)
            local modelBan = model:getChildByName("Image_Description")
            Functions.initTextColor(modelBan:getChildByName("Text_level_name_1"), ban:getChildByName("Text_level_name_1"))
            Functions.initLabelOfString( ban:getChildByName("Text_level_name_1"), data.drop)
        end


--        local onClick = function(event)
--            print("button click")
--            --打开二级界面
--            --大关卡
--            local big = (data - data%10)/10 + 1
--            --小关卡
--            local Small = data % 10
--            if Small == 0 then
--                Small = 10
--            end
--            local str = BiographyData:checkFbState({fbType = CombatCenter.CombatType.RB_PVE, fbId = big, gkId = Small})
--            if str then
--                Functions.jumpFbSeleckOfData({fbType = CombatCenter.CombatType.RB_PVE, fbId = big, gkId = Small})
--            else
--                --弹出提示信息
--                PromptManager:openTipPrompt(LanguageConfig.language_Compound_6)
--            end
--        end
--        button:onTouch(Functions.createClickListener(onClick, "zoom"))

    end
    --绑定响应事件函数
    Functions.bindListWithData(self._ListView_item_level_t, datas, listHandler)

end

return SoldiersItemPopView