--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local CompoundPopView = class("CompoundPopView", BasePopView)

local Functions = require("app.common.Functions")

CompoundPopView.csbResPath = "lk/csb"
CompoundPopView.debug = true
CompoundPopView.studioSpriteFrames = {"CompoundUI","Common_lk","CC_commHuodetujing" }
--@auto code head end

local CompoundData = require("app.gameData.CompoundData")

--@Pre loading
CompoundPopView.spriteFrameNames = 
    {
        "headPilistRes"
    }

CompoundPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #CompoundPopView.studioSpriteFrames > 0 then
    CompoundPopView.spriteFrameNames = CompoundPopView.spriteFrameNames or {}
    table.insertto(CompoundPopView.spriteFrameNames, CompoundPopView.studioSpriteFrames)
end
function CompoundPopView:onInitUI()

    --output list
    self._Image_head_icon_t = self.csbNode:getChildByName("Panel_Compound_two_page"):getChildByName("Image_head_frame"):getChildByName("Image_head_icon")
	self._Text_hero_name_t = self.csbNode:getChildByName("Panel_Compound_two_page"):getChildByName("Text_hero_name")
	self._Image_have_t = self.csbNode:getChildByName("Panel_Compound_two_page"):getChildByName("Image_have")
	self._Text_hero_have_count_t = self.csbNode:getChildByName("Panel_Compound_two_page"):getChildByName("Text_hero_have_count")
	self._ListView_level_t = self.csbNode:getChildByName("Panel_Compound_two_page"):getChildByName("ListView_level")
	self._Text_level_name_t = self.csbNode:getChildByName("Panel_Compound_two_page"):getChildByName("ListView_level"):getChildByName("model"):getChildByName("Button_level_ban"):getChildByName("Text_level_name")
	self._Text_level_name_1_t = self.csbNode:getChildByName("Panel_Compound_two_page"):getChildByName("ListView_level"):getChildByName("model"):getChildByName("Image_Description"):getChildByName("Text_level_name_1")
	
    --label list
    
    --button list
    
end
--@auto code uiInit end


--@auto code output func
function CompoundPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function CompoundPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
    assert(data, "data is nil error")
    self.debrisData = data
   
    local data = CompoundData:getCompoundData()
    Functions.loadImageWithWidget(self._Image_head_icon_t, ConfigHandler:getHeroHeadImageOfId(self.debrisData.m_id))
    self._Text_hero_name_t:setText(ConfigHandler:getHeroNameOfId(self.debrisData.m_id))
    local Star = ConfigHandler:getHeroStarOfId(self.debrisData.m_id) 
    self._Text_hero_have_count_t:setText(tostring(self.debrisData.m_possessCount).."/"..tostring(g_csBaseCfg.fragment[Star]))
    
    self:showLevel()
end

function CompoundPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end


function CompoundPopView:showLevel()
    Functions.printInfo(self.debug,"showLevel")
       
    local datas = ConfigHandler:getCardDescriptions(self.debrisData.m_id)
        
    local listHandler = function(index, widget, data, model)
        
        if data.m_type == 1 then
            local ban = widget:getChildByName("Button_level_ban")
            ban:setVisible(true)
            local modelBan = model:getChildByName("Button_level_ban")
            Functions.initTextColor(modelBan:getChildByName("Text_level_name"), ban:getChildByName("Text_level_name"))
            --关卡类型
            local type = CombatCenter.CombatType.RB_PVE
            if ConfigHandler:getCardType(self.debrisData.m_id) == 2 then
                type = CombatCenter.CombatType.RB_ElitePVE
            end

            --大关卡
            local big = ConfigHandler:getCardChapter(self.debrisData.m_id)
            --小关卡
            local Small = 1

            local buff = ""
            buff = ConfigHandler:getCheckPointNameOfID(big)
            local str = BiographyData:checkFbState({fbType = type, fbId = big, gkId = Small})
            if str == false then
                buff = buff..LanguageConfig.language_Compound_2
            end
            Functions.initLabelOfString( ban:getChildByName("Text_level_name"), buff)

            local onClick = function(event)
                print("button click")
                --打开二级界面
                --大关卡
                local big = ConfigHandler:getCardChapter(self.debrisData.m_id)
                --小关卡
                local Small = 1

                local str = BiographyData:checkFbState({fbType = type, fbId = big, gkId = Small})
                if str then
                    Functions.jumpFbSeleckOfData({fbType = type, fbId = big, gkId = Small})
                else
                    --弹出提示信息
                    PromptManager:openTipPrompt(LanguageConfig.language_Compound_3)
                end
            end
            ban:onTouch(Functions.createClickListener(onClick, "zoom"))
        elseif data.m_type == 2 then
            local ban = widget:getChildByName("Image_Description")
            ban:setVisible(true)
            local modelBan = model:getChildByName("Image_Description")
            Functions.initTextColor(modelBan:getChildByName("Text_level_name_1"), ban:getChildByName("Text_level_name_1"))
            Functions.initLabelOfString( ban:getChildByName("Text_level_name_1"), data.m_chapter)
        end
    end
    --绑定响应事件函数
    Functions.bindListWithData(self._ListView_level_t, datas, listHandler)
end


return CompoundPopView