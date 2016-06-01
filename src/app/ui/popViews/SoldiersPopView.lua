--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local SoldiersPopView = class("SoldiersPopView", BasePopView)

local Functions = require("app.common.Functions")

SoldiersPopView.csbResPath = "lk/csb"
SoldiersPopView.debug = true
SoldiersPopView.studioSpriteFrames = {"CBO_ban","SoldiersPopUI_Text","CB_bgup" }
--@auto code head end
local SoldiersData = require("app.gameData.SoldiersData")
--@Pre loading
SoldiersPopView.spriteFrameNames = 
    {
		"sodiersRes"
    }

SoldiersPopView.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #SoldiersPopView.studioSpriteFrames > 0 then
    SoldiersPopView.spriteFrameNames = SoldiersPopView.spriteFrameNames or {}
    table.insertto(SoldiersPopView.spriteFrameNames, SoldiersPopView.studioSpriteFrames)
end
function SoldiersPopView:onInitUI()

    --output list
    self._Panel_tax_two_t = self.csbNode:getChildByName("Panel_tax_two")
	self._Panel_lable_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Panel_lable")
	self._Panel_bu_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Panel_lable"):getChildByName("Panel_bu")
	self._Sprite_bu_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Panel_lable"):getChildByName("Panel_bu"):getChildByName("Sprite_bu")
	self._Panel_qi_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Panel_lable"):getChildByName("Panel_qi")
	self._Sprite_qi_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Panel_lable"):getChildByName("Panel_qi"):getChildByName("Sprite_qi")
	self._Panel_gong_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Panel_lable"):getChildByName("Panel_gong")
	self._Sprite_gong_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Panel_lable"):getChildByName("Panel_gong"):getChildByName("Sprite_gong")
	self._Sprite_bing_bg_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_bing_bg")
	self._Sprite_Soldiers_icon_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_bing_bg"):getChildByName("Sprite_Soldiers_icon")
	self._Text_Soldiers_level_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_bing_bg"):getChildByName("Text_Soldiers_level")
	self._Text_Soldiers_name_two_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_bing_bg"):getChildByName("Text_Soldiers_name_two")
	self._Text_Soldiers_info_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_bing_bg"):getChildByName("Text_Soldiers_info")
	self._Image_Soldiers_head_two_icon_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Image_Soldiers_head_two_icon_1")
	self._Sprite_two_bu_mark_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Sprite_two_bu_mark")
	self._Sprite_two_gong_mark_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Sprite_two_gong_mark")
	self._Text_head_level_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_head_level_1")
	self._Text_head_name_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_head_name_1")
	self._Text_head_hp_num_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_head_hp_num_1")
	self._Text_head_atk_num_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_head_atk_num_1")
	self._Text_head_ke_num_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_head_ke_num_1")
	self._Text_fa_shu_num_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_fa_shu_num_1")
	self._Text_fa_fang_num_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_fa_fang_num_1")
	self._Image_bu_icon_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Image_bu_icon_1")
	self._Image_qi_icon_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Image_qi_icon_1")
	self._Image_gong_icon_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Image_gong_icon_1")
	self._Image_Soldiers_head_two_icon_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Image_Soldiers_head_two_icon_2")
	self._Sprite_two_bu_mark_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Sprite_two_bu_mark_2")
	self._Sprite_two_gong_mark_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Sprite_two_gong_mark_2")
	self._Text_head_level_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_head_level_2")
	self._Text_head_name_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_head_name_2")
	self._Text_head_hp_num_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_head_hp_num_2")
	self._Text_head_atk_num_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_head_atk_num_2")
	self._Text_head_ke_num_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_head_ke_num_2")
	self._Text_fa_shu_num_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_fa_shu_num_2")
	self._Text_fa_fang_num_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_fa_fang_num_2")
	self._Image_bu_icon_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Image_bu_icon_2")
	self._Image_qi_icon_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Image_qi_icon_2")
	self._Image_gong_icon_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Image_gong_icon_2")
	self._Image_item_icon_5_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_5"):getChildByName("Image_item_icon_5")
	self._Text_item_name_5_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_5"):getChildByName("Text_item_name_5")
	self._Text_item_num_5_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_5"):getChildByName("Text_item_num_5")
	self._Text_soul_num_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Text_soul_num")
	self._Image_item_icon_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_1"):getChildByName("Image_item_icon_1")
	self._Text_item_num_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_1"):getChildByName("Text_item_num_1")
	self._Image_item_icon_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_2"):getChildByName("Image_item_icon_2")
	self._Text_item_num_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_2"):getChildByName("Text_item_num_2")
	self._Image_item_icon_3_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_3"):getChildByName("Image_item_icon_3")
	self._Text_item_num_3_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_3"):getChildByName("Text_item_num_3")
	self._Image_item_icon_4_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_4"):getChildByName("Image_item_icon_4")
	self._Text_item_num_4_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_4"):getChildByName("Text_item_num_4")
	self._Text_up_string_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Text_up_string")
	self._Text_item_name_4_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Text_item_name_4")
	self._Text_item_name_3_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Text_item_name_3")
	self._Text_item_name_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Text_item_name_2")
	self._Text_item_name_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Text_item_name_1")
	self._Image_big_string_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Image_big_string")
	
    --label list
    self._Text_head_hp_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_head_hp_1")
	self._Text_head_hp_1_t:setString(LanguageConfig.lk_common_1)

	self._Text_head_atk_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_head_atk_1")
	self._Text_head_atk_1_t:setString(LanguageConfig.lk_common_2)

	self._Text_head_ke_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_head_ke_1")
	self._Text_head_ke_1_t:setString(LanguageConfig.ui_Soldiers_2)

	self._Text_fa_fang_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_fa_fang_1")
	self._Text_fa_fang_1_t:setString(LanguageConfig.lk_common_4)

	self._Text_fa_shu_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Text_fa_shu_1")
	self._Text_fa_shu_1_t:setString(LanguageConfig.lk_common_3)

	self._Text_head_hp_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_head_hp_2")
	self._Text_head_hp_2_t:setString(LanguageConfig.lk_common_1)

	self._Text_head_atk_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_head_atk_2")
	self._Text_head_atk_2_t:setString(LanguageConfig.lk_common_2)

	self._Text_head_ke_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_head_ke_2")
	self._Text_head_ke_2_t:setString(LanguageConfig.ui_Soldiers_2)

	self._Text_fa_shu_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_fa_shu_2")
	self._Text_fa_shu_2_t:setString(LanguageConfig.lk_common_3)

	self._Text_fa_fang_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Sprite_Soldiers_head_two_2"):getChildByName("Text_fa_fang_2")
	self._Text_fa_fang_2_t:setString(LanguageConfig.lk_common_4)
    --button list
    self._Button_item_5_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_5")
	self._Button_item_5_t:onTouch(Functions.createClickListener(handler(self, self.onButton_item_5Click), "zoom"))

	self._Button_up_level_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_up_level")
	self._Button_up_level_t:onTouch(Functions.createClickListener(handler(self, self.onButton_up_levelClick), "zoom"))

	self._Button_item_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_1")
	self._Button_item_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_item_1Click), "zoom"))

	self._Button_item_2_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_2")
	self._Button_item_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_item_2Click), "zoom"))

	self._Button_item_3_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_3")
	self._Button_item_3_t:onTouch(Functions.createClickListener(handler(self, self.onButton_item_3Click), "zoom"))

	self._Button_item_4_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_item_4")
	self._Button_item_4_t:onTouch(Functions.createClickListener(handler(self, self.onButton_item_4Click), "zoom"))

	self._Button_ladder_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_ladder")
	self._Button_ladder_t:onTouch(Functions.createClickListener(handler(self, self.onButton_ladderClick), "zoom"))

	self._Button_close_1_t = self.csbNode:getChildByName("Panel_tax_two"):getChildByName("Button_close_1")
	self._Button_close_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_close_1Click), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_up_level btFunc
function SoldiersPopView:onButton_up_levelClick()
    Functions.printInfo(self.debug,"Button_up_level button is click!")
    --升级小兵
    local onUpLevel = function(event)
    --g_errorCode.StrenthSFail

        if event.ret == 563 then
            --升级道具数量显示
            local money = event.money
            PlayerData.eventAttr.m_money = money
            local data = SoldiersData:getSoldiersDatas()[self.type]
            local ladder = ConfigHandler:getSoldierLadderOfId(data.m_id)
            local propID = g_csBaseCfg.soldierItemId[self.type][ladder][1]
            local lv = 0
            
            for k = 1, ladder do
                if k < ladder then
                    lv = lv + g_csBaseCfg.soldierClsLevel[k]
                end
                if k == ladder then
                    lv = lv + data.m_level
                end
            end
--            if ladder == 1 then
--                lv = data.m_level
--            elseif ladder == 2 then
--                lv = g_csBaseCfg.soldierClsLevel[ladder-1]+data.m_level
--            elseif ladder == 3 then
--                lv = g_csBaseCfg.soldierClsLevel[ladder-2] + g_csBaseCfg.soldierClsLevel[ladder-1] + data.m_level
--            end
            local num = ConfigHandler:getSoldierOfNum(lv) --g_csBaseCfg.soldierItemId[self.type][ladder][3]
            PropData:miuProp({ m_id = propID,m_count = num })

            Functions.initLabelOfString(self._Text_item_num_5_t, PropData:getPropNumOfId(propID).."/"..tostring(num) )
            --弹出报错信息
            PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
            return false
        end
        if event.ret == 1 then
            
            local level = event.level
            local stype = event.stype
            
            
            local data = SoldiersData:getSoldiersDatas()[self.type]
            local ladder = ConfigHandler:getSoldierLadderOfId(data.m_id)
            local propID = g_csBaseCfg.soldierItemId[self.type][ladder][1]
            local lv = 0
            
            for k = 1, ladder do
                if k < ladder then
                    lv = lv + g_csBaseCfg.soldierClsLevel[k]
                end
                if k == ladder then
                    lv = lv + data.m_level
                end
            end
--            if ladder == 1 then
--                lv = data.m_level
--            elseif ladder == 2 then
--                lv = g_csBaseCfg.soldierClsLevel[ladder-1]+data.m_level
--            elseif ladder == 3 then
--                lv = g_csBaseCfg.soldierClsLevel[ladder-2] + g_csBaseCfg.soldierClsLevel[ladder-1] + data.m_level
--            end
            
            --设置兵的数据
            SoldiersData:setSoldiersData(self.type, level)
            
            --升级道具减少
            local num = ConfigHandler:getSoldierOfNum(lv)
            PropData:miuProp({ m_id = propID,m_count = num })
            
            local money = event.money
            PlayerData.eventAttr.m_money = money
            
            --改变兵的数据
            self:SoldiersDatas()
            --改变进阶道具
            self:LadderData()

            --动画
            self:actionLevel()
            self:showSoldiersBZ()
        else
            --弹出报错信息
            PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
        end
        return true
    end

    NetWork:addNetWorkListener({ 3, 2 }, onUpLevel)
    NetWork:sendToServer({ idx = { 3, 2 }, stype = self.type })
end
--@auto code Button_up_level btFunc end

--@auto code Button_ladder btFunc
function SoldiersPopView:onButton_ladderClick()
    Functions.printInfo(self.debug,"Button_ladder button is click!")
    local data = SoldiersData:getSoldiersDatas()[self.type]
    local ladder = ConfigHandler:getSoldierLadderOfId(data.m_id)
    local str = ""
    if ladder == 1 then
        if PlayerData.eventAttr.m_level < g_csBaseCfg.soldierUplevel[ladder] then
            --弹出报错信息
            str = LanguageConfig.language_Soldiers_7..tostring(g_csBaseCfg.soldierUplevel[ladder])..LanguageConfig.language_Soldiers_8
            PromptManager:openTipPrompt(str)
    	end
    elseif ladder == 2 then
        if PlayerData.eventAttr.m_level < g_csBaseCfg.soldierUplevel[ladder] then
            --弹出报错信息
            str = LanguageConfig.language_Soldiers_7..tostring(g_csBaseCfg.soldierUplevel[ladder])..LanguageConfig.language_Soldiers_8
            PromptManager:openTipPrompt(str)
        end
    end
    
    local data = SoldiersData:getSoldiersDatas()[self.type]
    local onUpLadder = function(event)
        local id = event.id
        local soul = event.soul
        local stype = event.stype
        --消耗道具

        local ID = clone(data.m_id)
        --设置兵的数据
        SoldiersData:setSoldiersData(self.type, 1, id)

        local data = SoldiersData:getSoldiersDatas()[self.type]
        local ladderItem = ConfigHandler:getItemLadderOfId(ID)
        --进阶道具减少
        for i = 1, 4 do
            PropData:miuProp( {m_id = ladderItem[i][1],m_count = ladderItem[i][3]} )
        end
        --改变兵的数据
        self:SoldiersDatas()
        --改变进阶道具
        self:LadderData()
        --打开士兵进阶动画
        self._controller_t:openChildView("app.ui.popViews.SoldiersActionPopView", {data = {self.type}, isRemove = false})
        --刷新标志
        SoldiersData:refreshSoldiers()
        self:showSoldiersBZ()
    end

    NetWork:addNetWorkListener({ 3, 3 }, Functions.createNetworkListener(onUpLadder,true,"ret"))
    NetWork:sendToServer({ idx = { 3, 3 }, stype = self.type })
end
--@auto code Button_ladder btFunc end

--@auto code Button_item_5 btFunc
function SoldiersPopView:onButton_item_5Click()
    Functions.printInfo(self.debug,"Button_item_5 button is click!")
    self:showItemInfo(5)
end
--@auto code Button_item_5 btFunc end

--@auto code Button_item_1 btFunc
function SoldiersPopView:onButton_item_1Click()
    Functions.printInfo(self.debug,"Button_item_1 button is click!")
    self:showItemInfo(1)
end
--@auto code Button_item_1 btFunc end

--@auto code Button_item_2 btFunc
function SoldiersPopView:onButton_item_2Click()
    Functions.printInfo(self.debug,"Button_item_2 button is click!")
    self:showItemInfo(2)
end
--@auto code Button_item_2 btFunc end

--@auto code Button_item_3 btFunc
function SoldiersPopView:onButton_item_3Click()
    Functions.printInfo(self.debug,"Button_item_3 button is click!")
    self:showItemInfo(3)
end
--@auto code Button_item_3 btFunc end

--@auto code Button_item_4 btFunc
function SoldiersPopView:onButton_item_4Click()
    Functions.printInfo(self.debug,"Button_item_4 button is click!")
    self:showItemInfo(4)
end
--@auto code Button_item_4 btFunc end

--@auto code Button_close_1 btFunc
function SoldiersPopView:onButton_close_1Click()
    Functions.printInfo(self.debug,"Button_close_1 button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_close_1 btFunc end

--@auto button backcall end


--@auto code output func
function SoldiersPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function SoldiersPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	self:showSoldiersBZ()
	
	self.type = 1   -- (type:1为步, 2为骑, 3为弓)
    local onLable = function(event)
        if "Panel_bu" == event then
            self.type = 1
            --显示ui
            self:SoldiersDatas()
            self:LadderData()
        elseif "Panel_qi" == event then
            self.type = 2
            --显示ui
            self:SoldiersDatas()
            self:LadderData()
        elseif "Panel_gong" == event then
            self.type = 3
            --显示ui
            self:SoldiersDatas()
            self:LadderData()
        end
	end
    Functions.initTabComWithSimple({widget = self._Panel_lable_t, listener = onLable, firstName = "Panel_bu"})
    --显示ui
    self:SoldiersDatas()
    self:LadderData()
end

function SoldiersPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function SoldiersPopView:actionLevel(level)
    Functions.printInfo(self.debug,"addActionUP")
    
    Functions.playSound("soldierlevelup.mp3")
    
    local spr = Functions.createSpriteOfSfName("lk/uiFonts_res/soldier_shengji_guang.png")
    local spr2 = Functions.createSpriteOfSfName("lk/uiFonts_res/soldier_shengji_guang.png")
    local sX = self._Sprite_Soldiers_icon_t:getContentSize().width/2
    local sY = self._Sprite_Soldiers_icon_t:getContentSize().height/2
    spr:setPosition(sX, sY)
    spr2:setPosition(sX, sY)
    self._Sprite_Soldiers_icon_t:addChild(spr, -1)
    self._Sprite_Soldiers_icon_t:addChild(spr2, -1)
    
    local scaleTo = cc.ScaleTo:create(checknumber(0.1), 0.7, 0.7)
    local scaleTo2 = cc.ScaleTo:create(checknumber(0.1), 0.7, 0.7)
    local rotateBy = cc.RotateBy:create(0.6, 120)
    local rotateBy2 = cc.RotateBy:create(0.6, -120)
    local fadeOutUPguang = cc.FadeOut:create(0.1)--渐隐
    local fadeOutUPguang2 = cc.FadeOut:create(0.1)--渐隐
    local spawn_guang = cc.Spawn:create(scaleTo, rotateBy)
    local spawn_guang2 = cc.Spawn:create(scaleTo2, rotateBy2)
    
    local play = cc.Sequence:create(spawn_guang,fadeOutUPguang)
    local play2 = cc.Sequence:create(spawn_guang2,fadeOutUPguang2)
    spr:runAction(play)
    spr2:runAction(play2)
    
    local w = self._Sprite_Soldiers_icon_t:getPositionX()
    local h = self._Sprite_Soldiers_icon_t:getPositionY()
    local LV = Functions.createSpriteOfSfName("commonUI/res/lk/SoldiersPopUI/soldier_dengjiUP.png")
    LV:setPosition( w*0.6, h*0.5)
    self._Sprite_Soldiers_icon_t:addChild( LV)

    local fadeinUP = cc.FadeIn:create(0.1)--渐显
    local scaletoUP = cc.ScaleTo:create(0.1, 1) --缩放
    local MoveBy = cc.MoveBy:create(0.2, cc.p(0, 100))
    local fadeOutUP = cc.FadeOut:create(0.2)--渐隐
    
    local seqUP = cc.Sequence:create(fadeinUP, scaletoUP, cc.DelayTime:create(0.2), MoveBy, fadeOutUP)

    LV:runAction(seqUP)
    --Functions.setRotateBy(self.spr, 1.5, 0.1, 720, 6, 0, true)
    
end
function SoldiersPopView:actionLadder(id)
    Functions.printInfo(self.debug,"addActionUP")
end

function SoldiersPopView:SoldiersDatas()
    Functions.printInfo(self.debug,"SoldiersData")
    local data = SoldiersData:getSoldiersDatas()[self.type]
    local ladder = ConfigHandler:getSoldierLadderOfId(data.m_id)

    
    local head = ConfigHandler:getSoldierHeadImageOfId(data.m_id)
    local res = ConfigHandler:getSoldierCardImageOfId(data.m_id)
    
    Functions.loadImageWithWidget(self._Image_Soldiers_head_two_icon_1_t, head)
    local _UPlevel = g_csBaseCfg.soldierClsLevel[ladder]
    if data.m_level == g_csBaseCfg.soldierClsLevel[ladder] and ladder ~= #g_csBaseCfg.soldierClsLevel then --3阶是最高阶
        Functions.loadImageWithWidget(self._Image_Soldiers_head_two_icon_2_t, ConfigHandler:getSoldierHeadImageOfId(data.m_id + 1))
        Functions.initLabelOfString(self._Text_head_level_2_t, "LV 1", self._Text_head_name_2_t, ConfigHandler:getSoldierNameOfId(data.m_id + 1))
        self:level_Data(data.m_id + 1, 1)
        --克敌描述
        Functions.initLabelOfString( self._Text_head_ke_num_1_t, ConfigHandler:getKeZhiOfId(data.m_id), self._Text_head_ke_num_2_t, 
            ConfigHandler:getKeZhiOfId(data.m_id + 1), self._Text_up_string_t, string.format(LanguageConfig.language_Soldiers_12, _UPlevel) )
        
--        self._Text_up_string_t:setVisible(false)
--        self._Sprite_up_icon_t:setVisible(true)
        
     elseif data.m_level == g_csBaseCfg.soldierClsLevel[ladder] and ladder == #g_csBaseCfg.soldierClsLevel then --3阶是最高阶
        Functions.loadImageWithWidget(self._Image_Soldiers_head_two_icon_2_t, ConfigHandler:getSoldierHeadImageOfId(data.m_id))
        Functions.initLabelOfString(self._Text_head_level_2_t, "LV "..tostring(g_csBaseCfg.soldierClsLevel[ladder]), self._Text_head_name_2_t, 
        ConfigHandler:getSoldierNameOfId(data.m_id))
        self:level_Data(data.m_id, g_csBaseCfg.soldierClsLevel[ladder])
        --克敌描述
        Functions.initLabelOfString( self._Text_head_ke_num_1_t, ConfigHandler:getKeZhiOfId(data.m_id), self._Text_head_ke_num_2_t, 
            ConfigHandler:getKeZhiOfId(data.m_id), self._Text_up_string_t, string.format(LanguageConfig.language_Soldiers_12, _UPlevel) )
--        self._Text_up_string_t:setVisible(false)
--        self._Sprite_up_icon_t:setVisible(true)
    else
        Functions.loadImageWithWidget(self._Image_Soldiers_head_two_icon_2_t, head)
        Functions.initLabelOfString(self._Text_head_level_2_t, "LV "..tostring(data.m_level + 1))
        local lv = data.m_level + 1
        self:level_Data(data.m_id, data.m_level + 1)
        --克敌描述
        Functions.initLabelOfString( self._Text_head_ke_num_1_t, ConfigHandler:getKeZhiOfId(data.m_id), self._Text_head_ke_num_2_t, 
        ConfigHandler:getKeZhiOfId(data.m_id) )
        Functions.initLabelOfString(self._Text_head_name_2_t, ConfigHandler:getSoldierNameOfId(data.m_id), self._Text_up_string_t, string.format(LanguageConfig.language_Soldiers_12, _UPlevel) )
--        self._Text_up_string_t:setVisible(true)
--        self._Sprite_up_icon_t:setVisible(false)
    end
    --兵全身像
    Functions.loadImageWithSprite(self._Sprite_Soldiers_icon_t, res)
    
    --升级道具

    local propID = g_csBaseCfg.soldierItemId[self.type][ladder][1]
    Functions.loadImageWithWidget(self._Image_item_icon_5_t, ConfigHandler:getPropImageOfId(propID))
    
    --所有文字初使化
    local soul = 0
    if ladder == 1 then
    	soul = g_csBaseCfg.UpClassSoul[1]
    elseif ladder == 2 then
        soul = g_csBaseCfg.UpClassSoul[2]
    end
    
    
    
    
    Functions.initLabelOfString(self._Text_head_level_1_t, "LV "..tostring(data.m_level), self._Text_head_name_1_t, ConfigHandler:getSoldierNameOfId(data.m_id),
        self._Text_item_name_5_t, ConfigHandler:getPropNameOfId(propID), self._Text_Soldiers_level_t, "LV "..tostring(data.m_level), self._Text_Soldiers_name_two_t,
        ConfigHandler:getSoldierNameOfId(data.m_id), self._Text_up_soul_t, soul)
    
    
    --获得士兵属性
    local hp = Functions:getSoldierhHp(data.m_id,data.m_level)
    local atk = Functions:getSoldierhAtk(data.m_id,data.m_level)
    local fas = Functions:getSoldierhFas(data.m_id,data.m_level)
    local faf = Functions:getSoldierhFaf(data.m_id,data.m_level)
    Functions.initLabelOfString(self._Text_head_hp_num_1_t, tostring(hp), self._Text_head_atk_num_1_t, atk, self._Text_fa_shu_num_1_t, fas, 
        self._Text_fa_fang_num_1_t, faf)
    --升级道具数量显示
    local lv = 0
    
    for k = 1, ladder do
        if k < ladder then
            lv = lv + g_csBaseCfg.soldierClsLevel[k]
        end
        if k == ladder then
            lv = lv + data.m_level
        end
    end
--    if ladder == 1 then
--        lv = data.m_level
--    elseif ladder == 2 then
--        lv = g_csBaseCfg.soldierClsLevel[ladder-1]+data.m_level
--    elseif ladder == 3 then
--        lv = g_csBaseCfg.soldierClsLevel[ladder-2] + g_csBaseCfg.soldierClsLevel[ladder-1] + data.m_level
--    end
--    
    
    local num = ConfigHandler:getSoldierOfNum(lv) --g_csBaseCfg.soldierItemId[self.type][ladder][3]
    local money = ConfigHandler:getSoldierOfMoney(lv)
    Functions.initLabelOfString(self._Text_item_num_5_t, PropData:getPropNumOfId(propID).."/"..tostring(num), 
        self._Text_soul_num_t, tostring(money))
    

    if self.type == 1 then
    
        self._Image_bu_icon_1_t:setVisible(true)
        self._Image_qi_icon_1_t:setVisible(false)
        self._Image_gong_icon_1_t:setVisible(false)
        
        self._Image_bu_icon_2_t:setVisible(true)
        self._Image_qi_icon_2_t:setVisible(false)
        self._Image_gong_icon_2_t:setVisible(false)
        
        Functions.initLabelOfString(self._Text_Soldiers_info_t, LanguageConfig.language_Soldiers_9)
    elseif self.type == 2 then
        self._Image_bu_icon_1_t:setVisible(false)
        self._Image_qi_icon_1_t:setVisible(true)
        self._Image_gong_icon_1_t:setVisible(false)

        self._Image_bu_icon_2_t:setVisible(false)
        self._Image_qi_icon_2_t:setVisible(true)
        self._Image_gong_icon_2_t:setVisible(false)
        
        Functions.initLabelOfString(self._Text_Soldiers_info_t, LanguageConfig.language_Soldiers_10)
    elseif self.type == 3 then
        self._Image_bu_icon_1_t:setVisible(false)
        self._Image_qi_icon_1_t:setVisible(false)
        self._Image_gong_icon_1_t:setVisible(true)

        self._Image_bu_icon_2_t:setVisible(false)
        self._Image_qi_icon_2_t:setVisible(false)
        self._Image_gong_icon_2_t:setVisible(true)
        
        Functions.initLabelOfString(self._Text_Soldiers_info_t, LanguageConfig.language_Soldiers_11)
    end
    
    --置灰
    if data.m_level >= g_csBaseCfg.soldierClsLevel[ladder] then
        Functions.setEnabledBt(self._Button_ladder_t, true)
        Functions.setEnabledBt(self._Button_up_level_t, false)

        local propID = g_csBaseCfg.soldierItemId[self.type][ladder][1]
        Functions.initLabelOfString(self._Text_item_num_5_t, PropData:getPropNumOfId(propID).."/"..tostring(0), self._Text_soul_num_t, tostring(0) )

    else
        Functions.setEnabledBt(self._Button_ladder_t, false)
        Functions.setEnabledBt(self._Button_up_level_t, true)
    end
    
    if ladder == #g_csBaseCfg.soldierClsLevel then --3阶是最高阶 then
    	self._Text_up_string_t:setVisible(false)
--        self._Sprite_up_icon_t:setVisible(false)
    end
end

function SoldiersPopView:LadderData()
    Functions.printInfo(self.debug,"addActionUP")
    local data = SoldiersData:getSoldiersDatas()[self.type]
    if ConfigHandler:getUpLadderOfId(data.m_id) == 0 then
        self._Button_item_1_t:setVisible(false)
        self._Button_item_2_t:setVisible(false)
        self._Button_item_3_t:setVisible(false)
        self._Button_item_4_t:setVisible(false)
        self._Text_item_name_1_t:setVisible(false)
        self._Text_item_name_2_t:setVisible(false)
        self._Text_item_name_3_t:setVisible(false)
        self._Text_item_name_4_t:setVisible(false)
        self._Button_ladder_t:setVisible(false)
        self._Image_big_string_t:setVisible(true)
        return false
    else
        self._Button_item_1_t:setVisible(true)
        self._Button_item_2_t:setVisible(true)
        self._Button_item_3_t:setVisible(true)
        self._Button_item_4_t:setVisible(true)
        self._Text_item_name_1_t:setVisible(true)
        self._Text_item_name_2_t:setVisible(true)
        self._Text_item_name_3_t:setVisible(true)
        self._Text_item_name_4_t:setVisible(true)
        self._Button_ladder_t:setVisible(true)
        self._Image_big_string_t:setVisible(false)
    end
    --进阶道具名
    local ladderItem = ConfigHandler:getItemLadderOfId(data.m_id)
    Functions.initLabelOfString(self._Text_item_name_1_t, ConfigHandler:getPropNameOfId(ladderItem[1][1]),
        self._Text_item_name_2_t, ConfigHandler:getPropNameOfId(ladderItem[2][1]),
        self._Text_item_name_3_t, ConfigHandler:getPropNameOfId(ladderItem[3][1]),
        self._Text_item_name_4_t, ConfigHandler:getPropNameOfId(ladderItem[4][1]))
    --进阶道具
    self._Image_item_icon_1_t:ignoreContentAdaptWithSize(true)
    Functions.loadImageWithWidget(self._Image_item_icon_1_t, ConfigHandler:getPropImageOfId(ladderItem[1][1]))
    self._Image_item_icon_2_t:ignoreContentAdaptWithSize(true)
    Functions.loadImageWithWidget(self._Image_item_icon_2_t, ConfigHandler:getPropImageOfId(ladderItem[2][1]))
    self._Image_item_icon_3_t:ignoreContentAdaptWithSize(true)
    Functions.loadImageWithWidget(self._Image_item_icon_3_t, ConfigHandler:getPropImageOfId(ladderItem[3][1]))
    self._Image_item_icon_4_t:ignoreContentAdaptWithSize(true)
    Functions.loadImageWithWidget(self._Image_item_icon_4_t, ConfigHandler:getPropImageOfId(ladderItem[4][1]))
    --进阶道具数量显示
    Functions.initLabelOfString(self._Text_item_num_1_t, PropData:getPropNumOfId(ladderItem[1][1]).."/"..tostring(ladderItem[1][3]),
        self._Text_item_num_2_t, PropData:getPropNumOfId(ladderItem[2][1]).."/"..tostring(ladderItem[2][3]),
        self._Text_item_num_3_t, PropData:getPropNumOfId(ladderItem[3][1]).."/"..tostring(ladderItem[3][3]),
        self._Text_item_num_4_t, PropData:getPropNumOfId(ladderItem[4][1]).."/"..tostring(ladderItem[4][3]))
end
--获得士兵属性
function SoldiersPopView:level_Data(id, level)
    local hp = Functions:getSoldierhHp(id, level)
    local atk = Functions:getSoldierhAtk(id, level)
    local fas = Functions:getSoldierhFas(id, level)
    local faf = Functions:getSoldierhFaf(id, level)
    Functions.initLabelOfString(self._Text_head_hp_num_2_t, tostring(hp), self._Text_head_atk_num_2_t, atk, self._Text_fa_shu_num_2_t, fas, 
        self._Text_fa_fang_num_2_t, faf)
end

function SoldiersPopView:showItemInfo(type)

    local data = SoldiersData:getSoldiersDatas()[self.type]
    local ladderItem = ConfigHandler:getItemLadderOfId(data.m_id)
    local id = 0
    local num = 0
    if type ~= 5 then
        id = ladderItem[type][1]
        num = ladderItem[type][3]
    else
        --升级道具
        local ladder = ConfigHandler:getSoldierLadderOfId(data.m_id) 
        id = g_csBaseCfg.soldierItemId[self.type][ladder][1]
        --升级道具数量显示
        num = g_csBaseCfg.soldierItemId[self.type][ladder][3]
    end
    local iii = id
    self._controller_t:openChildView("app.ui.popViews.SoldiersItemPopView", {data = {id = id, num = num}})
end


function SoldiersPopView:showSoldiersBZ()
	SoldiersData:SoldiersMark()
	local bu = SoldiersData:getBuSoldiers()
	local qi = SoldiersData:getQiSoldiers()
	local gong = SoldiersData:getGongSoldiers()

	if bu == 1 then
		self._Sprite_bu_t:setVisible(true)
	else
		self._Sprite_bu_t:setVisible(false)
	end

	if qi == 1 then
		self._Sprite_qi_t:setVisible(true)
	else
		self._Sprite_qi_t:setVisible(false)
	end

	if gong == 1 then
		self._Sprite_gong_t:setVisible(true)
	else
		self._Sprite_gong_t:setVisible(false)
	end

end

return SoldiersPopView