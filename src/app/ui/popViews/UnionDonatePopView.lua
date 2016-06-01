--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionDonatePopView = class("UnionDonatePopView", BasePopView)

local Functions = require("app.common.Functions")

UnionDonatePopView.csbResPath = "lk/csb"
UnionDonatePopView.debug = true
UnionDonatePopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","UnionUI","ChatBgUI" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #UnionDonatePopView.studioSpriteFrames > 0 then
    UnionDonatePopView.spriteFrameNames = UnionDonatePopView.spriteFrameNames or {}
    table.insertto(UnionDonatePopView.spriteFrameNames, UnionDonatePopView.studioSpriteFrames)
end
function UnionDonatePopView:onInitUI()

    --output list
    self._Panel_today_1_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_today_1")
	self._Panel_history_2_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_history_2")
	self._ListView_donate_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("ListView_donate")
	self._Panel_cion_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_cion")
	self._Panel_bao_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_bao")
	self._Text_lei_ji_num_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_ban_1"):getChildByName("Text_lei_ji_num")
	self._Text_zi_jin_1_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_ban_1"):getChildByName("Text_zi_jin_1")
	self._Sprite_icon_2_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_ban_2"):getChildByName("Sprite_xiaoHao_1"):getChildByName("Sprite_icon_2")
	self._Text_xiaoHao_num_1_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_ban_2"):getChildByName("Sprite_xiaoHao_1"):getChildByName("Text_xiaoHao_num_1")
	self._Text_miao_shu_1_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_ban_2"):getChildByName("Text_miao_shu_1")
	self._Sprite_icon_3_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_ban_3"):getChildByName("Sprite_xiaoHao_2"):getChildByName("Sprite_icon_3")
	self._Text_xiaoHao_num_2_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_ban_3"):getChildByName("Sprite_xiaoHao_2"):getChildByName("Text_xiaoHao_num_2")
	self._Text_miao_shu_2_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_ban_3"):getChildByName("Text_miao_shu_2")
	
    --label list
    
    --button list
    self._Button_donate_close_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Button_donate_close")
	self._Button_donate_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_donate_closeClick), "zoom"))

	self._Button_donate_1_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_ban_2"):getChildByName("Button_donate_1")
	self._Button_donate_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_donate_1Click), "zoom"))

	self._Button_donate_2_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Panel_but"):getChildByName("Panel_ban_3"):getChildByName("Button_donate_2")
	self._Button_donate_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_donate_2Click), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_donate_close btFunc
function UnionDonatePopView:onButton_donate_closeClick()
    Functions.printInfo(self.debug,"Button_donate_close button is click!")
    self.close(self)
end
--@auto code Button_donate_close btFunc end

--@auto code Button_donate_1 btFunc
function UnionDonatePopView:onButton_donate_1Click()
    Functions.printInfo(self.debug,"Button_donate_1 button is click!")
    local type = 1
    local typeNum = 1
    if self.DonateType == 4 then
        type = 2
    end
    UnionData:sendDonateNum(type, typeNum, handler(self,self.show))
end
--@auto code Button_donate_1 btFunc end

--@auto code Button_donate_2 btFunc
function UnionDonatePopView:onButton_donate_2Click()
    Functions.printInfo(self.debug,"Button_donate_2 button is click!")
    local type = 1
    local typeNum = 2
    if self.DonateType == 4 then
        type = 2
    end
    UnionData:sendDonateNum(type, typeNum, handler(self,self.show))
end
--@auto code Button_donate_2 btFunc end

--@auto button backcall end


--@auto code output func
function UnionDonatePopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionDonatePopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	
	--（选中今日捐献资金为1，选中历史捐献资金为2）
	self.timeState = 1
    --（选中金币捐献为3，选中元宝捐献为4）
    self.DonateType = 3
    UnionData:sendDonateInfo(handler(self,self.show))
    
    local onPanel1 = function()
        print("panel 1 click")
        if self.timeState ~= 1 then
            self.timeState = 1
            self:showList(UnionData:getDonateInfo())
        end
        
    end

    local onPanel2 = function()
        print("panel 2 click")
        if self.timeState ~= 2 then
            self.timeState = 2
            self:showList(UnionData:getDonateAllInfo())
        end
    end 
	
    Functions.initTabCom({{ self._Panel_today_1_t, onPanel1, true }, { self._Panel_history_2_t, onPanel2}})
    --（选中金币捐献为3，选中元宝捐献为4）
    local onPanel3 = function()
        print("panel 3 click")
        if self.DonateType ~= 3 then
            self.DonateType = 3
            self:showDonate()
        end
    end

    local onPanel4 = function()
        print("panel 4 click")
        if self.DonateType ~= 4 then
            self.DonateType = 4
            self:showDonate()
        end
    end 

    Functions.initTabCom({{ self._Panel_cion_t, onPanel3, true }, { self._Panel_bao_t, onPanel4}})
end

function UnionDonatePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function UnionDonatePopView:showDonate()
    Functions.printInfo(self.debug,"showDonate ")
    if self.DonateType == 3 then
        Functions.loadImageWithSprite(self._Sprite_icon_2_t,"commonUI/res/icons/coin.png")
        Functions.loadImageWithSprite(self._Sprite_icon_3_t,"commonUI/res/icons/coin.png")
        Functions.initLabelOfString(self._Text_xiaoHao_num_1_t,tostring(g_guildComCfg.Actif[1][1][1]),self._Text_xiaoHao_num_2_t,tostring(g_guildComCfg.Actif[1][2][1]))
        --self._Text_xiaoHao_num_1_t:setString(99)
        local str = string.format(LanguageConfig.language_Union_37, g_guildComCfg.Actif[1][1][1], g_guildComCfg.Actif[1][1][2])
        self._Text_miao_shu_1_t:setString(str)
        local str2 = string.format(LanguageConfig.language_Union_37, g_guildComCfg.Actif[1][2][1], g_guildComCfg.Actif[1][2][2])
        self._Text_miao_shu_2_t:setString(str2)
    elseif self.DonateType == 4 then
        Functions.loadImageWithSprite(self._Sprite_icon_2_t,"commonUI/res/icons/bao.png")
        Functions.loadImageWithSprite(self._Sprite_icon_3_t,"commonUI/res/icons/bao.png")
        Functions.initLabelOfString(self._Text_xiaoHao_num_1_t,tostring(g_guildComCfg.Actif[2][1][1]),self._Text_xiaoHao_num_2_t,tostring(g_guildComCfg.Actif[2][2][1]))
        local str = string.format(LanguageConfig.language_Union_38, g_guildComCfg.Actif[2][1][1],g_guildComCfg.Actif[2][1][2])
        self._Text_miao_shu_1_t:setString(str)
        local str2 = string.format(LanguageConfig.language_Union_38, g_guildComCfg.Actif[2][2][1],g_guildComCfg.Actif[2][2][2])
        self._Text_miao_shu_2_t:setString(str2)
    end
    local str = string.format(LanguageConfig.language_Union_39, UnionData:getplayerActif())
    local str2 = string.format(LanguageConfig.language_Union_40, UnionData:getguildActif())
    Functions.initLabelOfString(self._Text_lei_ji_num_t, str, self._Text_zi_jin_1_t, str2)
end

function UnionDonatePopView:showList(list)
    Functions.printInfo(self.debug,"show ")
    local listHandler = function(index, widget, data, model)
        local ban = widget:getChildByName("Panel_list_fb")
        local banModel = model:getChildByName("Panel_list_fb")
        Functions.initTextColor(banModel:getChildByName("Text_CY_name"),ban:getChildByName("Text_CY_name"))
        Functions.initTextColor(banModel:getChildByName("Text_donate_num"),ban:getChildByName("Text_donate_num"))
        
        ban:getChildByName("BitmapFontLabel_rank"):setString(index)
        ban:getChildByName("Text_CY_name"):setString(data.name)
        if self.timeState == 1 then
            ban:getChildByName("Text_donate_num"):setString(data.todayActif)
        elseif  self.timeState == 2 then
            ban:getChildByName("Text_donate_num"):setString(data.allActif)
        end
    end
    Functions.bindListWithData(self._ListView_donate_t,list,listHandler)
end

function UnionDonatePopView:show()
    Functions.printInfo(self.debug,"show")
    local list = {}
    if self.timeState == 1 then
        list = UnionData:getDonateInfo()
    elseif  self.timeState == 2 then
        list = UnionData:getDonateAllInfo()
    end
    
    self:showList(list)
    self:showDonate()
end

return UnionDonatePopView