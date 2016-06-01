--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local CityViewController = class("CityViewController", BaseViewController)

local Functions = require("app.common.Functions")

CityViewController.debug = true
CityViewController.modulePath = ...
CityViewController.studioSpriteFrames = {"CityUI_Text","CB_blackbg","CityUI" }
--@auto code head end
local CityData = require("app.gameData.CityData")
--@Pre loading
CityViewController.spriteFrameNames = 
    {
        "headPilistRes"
    }

CityViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #CityViewController.studioSpriteFrames > 0 then
    CityViewController.spriteFrameNames = CityViewController.spriteFrameNames or {}
    table.insertto(CityViewController.spriteFrameNames, CityViewController.studioSpriteFrames)
end
function CityViewController:onDidLoadView()

    --output list
    self._resNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("resNode")
	self._Text_bao_level_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_1"):getChildByName("Text_bao_level_1")
	self._Text_bao_wu_num_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_1"):getChildByName("Text_bao_wu_num_1")
	self._Text_bao_wu_EXP_num_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_1"):getChildByName("Text_bao_wu_EXP_num_1")
	self._Image_Start_Task_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_1"):getChildByName("Image_Start_Task_1")
	self._Text_dao_ji_shi_num_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_1"):getChildByName("Text_dao_ji_shi_num_1")
	self._Text_sheng_yu_num_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_1"):getChildByName("Text_sheng_yu_num_1")
	self._Image_ren_wu_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_1"):getChildByName("Image_ren_wu_1")
	self._Text_bao_level_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_2"):getChildByName("Text_bao_level_2")
	self._Text_bao_wu_num_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_2"):getChildByName("Text_bao_wu_num_2")
	self._Text_bao_wu_EXP_num_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_2"):getChildByName("Text_bao_wu_EXP_num_2")
	self._Text_dao_ji_shi_num_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_2"):getChildByName("Text_dao_ji_shi_num_2")
	self._Text_sheng_yu_num_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_2"):getChildByName("Text_sheng_yu_num_2")
	self._Image_ren_wu_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_2"):getChildByName("Image_ren_wu_2")
	self._Image_Start_Task_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_2"):getChildByName("Image_Start_Task_2")
	self._Text_bao_level_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_3"):getChildByName("Text_bao_level_3")
	self._Text_bao_wu_num_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_3"):getChildByName("Text_bao_wu_num_3")
	self._Text_bao_wu_EXP_num_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_3"):getChildByName("Text_bao_wu_EXP_num_3")
	self._Text_dao_ji_shi_num_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_3"):getChildByName("Text_dao_ji_shi_num_3")
	self._Text_sheng_yu_num_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_3"):getChildByName("Text_sheng_yu_num_3")
	self._Image_ren_wu_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_3"):getChildByName("Image_ren_wu_3")
	self._Image_Start_Task_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_3"):getChildByName("Image_Start_Task_3")
	self._ProjectNode_hreo_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_hero_1"):getChildByName("ProjectNode_hreo_1")
	self._ProjectNode_hreo_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_hero_2"):getChildByName("ProjectNode_hreo_2")
	self._ProjectNode_hreo_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_hero_3"):getChildByName("ProjectNode_hreo_3")
	
    --label list
    
    --button list
    self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

	self._Button_help_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_help")
	self._Button_help_t:onTouch(Functions.createClickListener(handler(self, self.onButton_helpClick), "zoom"))

	self._Button_hero_OK_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_1"):getChildByName("Button_hero_OK_1")
	self._Button_hero_OK_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_hero_ok_1Click), "zoom"))

	self._Button_hero_OK_add_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_1"):getChildByName("Button_hero_OK_add_1")
	self._Button_hero_OK_add_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_hero_ok_add_1Click), "zoom"))

	self._Button_hero_OK_get_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_1"):getChildByName("Button_hero_OK_get_1")
	self._Button_hero_OK_get_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_hero_ok_get_1Click), "zoom"))

	self._Button_hero_OK_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_2"):getChildByName("Button_hero_OK_2")
	self._Button_hero_OK_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_hero_ok_2Click), "zoom"))

	self._Button_hero_OK_add_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_2"):getChildByName("Button_hero_OK_add_2")
	self._Button_hero_OK_add_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_hero_ok_add_2Click), "zoom"))

	self._Button_hero_OK_get_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_2"):getChildByName("Button_hero_OK_get_2")
	self._Button_hero_OK_get_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_hero_ok_get_2Click), "zoom"))

	self._Button_hero_OK_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_3"):getChildByName("Button_hero_OK_3")
	self._Button_hero_OK_3_t:onTouch(Functions.createClickListener(handler(self, self.onButton_hero_ok_3Click), "zoom"))

	self._Button_hero_OK_add_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_3"):getChildByName("Button_hero_OK_add_3")
	self._Button_hero_OK_add_3_t:onTouch(Functions.createClickListener(handler(self, self.onButton_hero_ok_add_3Click), "zoom"))

	self._Button_hero_OK_get_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_3"):getChildByName("Button_hero_OK_get_3")
	self._Button_hero_OK_get_3_t:onTouch(Functions.createClickListener(handler(self, self.onButton_hero_ok_get_3Click), "zoom"))

	self._Panel_hero_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_hero_1")
	self._Panel_hero_1_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_hero_1Click), "zoom"))

	self._Panel_hero_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_hero_2")
	self._Panel_hero_2_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_hero_2Click), "zoom"))

	self._Panel_hero_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_hero_3")
	self._Panel_hero_3_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_hero_3Click), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function CityViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
    GameCtlManager:pop(self)
end
--@auto code Button_back btFunc end

--@auto code Button_hero_ok_1 btFunc
function CityViewController:onButton_hero_ok_1Click()
    Functions.printInfo(self.debug,"Button_hero_ok_1 button is click!")
    
    if self._Text_dao_ji_shi_num_1_t.handler ~= nil then
    	self._Text_dao_ji_shi_num_1_t.handler = nil
    end
    TimerManager:sendServerTimeRequest()
    self:sendStart()

end
--@auto code Button_hero_ok_1 btFunc end

--@auto code Button_hero_ok_2 btFunc
function CityViewController:onButton_hero_ok_2Click()
    Functions.printInfo(self.debug,"Button_hero_ok_2 button is click!")
    if self._Text_dao_ji_shi_num_2_t.handler ~= nil then
        self._Text_dao_ji_shi_num_2_t.handler = nil
    end
    TimerManager:sendServerTimeRequest()
    self:sendStart()
end
--@auto code Button_hero_ok_2 btFunc end

--@auto code Button_hero_ok_3 btFunc
function CityViewController:onButton_hero_ok_3Click()
    Functions.printInfo(self.debug,"Button_hero_ok_3 button is click!")
    if self._Text_dao_ji_shi_num_3_t.handler ~= nil then
        self._Text_dao_ji_shi_num_3_t.handler = nil
    end
    TimerManager:sendServerTimeRequest()
    self:sendStart()
end
--@auto code Button_hero_ok_3 btFunc end

--@auto code Panel_hero_1 btFunc
function CityViewController:onPanel_hero_1Click()
    Functions.printInfo(self.debug,"Panel_hero_1 button is click!")
    local data = CityData:getArchitectureInfo()
    if data[1].count == 0 then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_City_1)
        return false
    end 
    
    if data[1].state == 0 then
        self:showHoreHead()
        GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController", {data = {jumpType = JumpType.MainCityToSelectHero,jumpData = {heroType = 1}}})
    else
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_City_2)
        return false
    end 
end
--@auto code Panel_hero_1 btFunc end

--@auto code Panel_hero_2 btFunc
function CityViewController:onPanel_hero_2Click()
    Functions.printInfo(self.debug,"Panel_hero_2 button is click!")
    local data = CityData:getArchitectureInfo()
    if data[2].count == 0 then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_City_1)
        return false
    end 
    if data[2].state == 0 then
        self:showHoreHead()
        GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController", {data = {jumpType = JumpType.MainCityToSelectHero,jumpData = {heroType = 2}}})
    else
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_City_2)
    end
end
--@auto code Panel_hero_2 btFunc end

--@auto code Panel_hero_3 btFunc
function CityViewController:onPanel_hero_3Click()
    Functions.printInfo(self.debug,"Panel_hero_3 button is click!")
    local data = CityData:getArchitectureInfo()
    if data[3].count == 0 then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_City_1)
        return false
    end 
    if data[3].state == 0 then
        self:showHoreHead()
        GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController", {data = {jumpType = JumpType.MainCityToSelectHero,jumpData = {heroType = 3}}})
    else
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_City_2) 
    end
end
--@auto code Panel_hero_3 btFunc end

--@auto code Button_hero_ok_add_1 btFunc
function CityViewController:onButton_hero_ok_add_1Click()
    Functions.printInfo(self.debug,"Button_hero_ok_add_1 button is click!")
    --加速
    self.type = 1
    NoticeManager:openTips(self, { handler = handler(self,self.addTime), title = LanguageConfig.language_City_3})
end
--@auto code Button_hero_ok_add_1 btFunc end

--@auto code Button_hero_ok_get_1 btFunc
function CityViewController:onButton_hero_ok_get_1Click()
    Functions.printInfo(self.debug,"Button_hero_ok_get_1 button is click!")
    --领奖
    self:sendPrize(1)
end
--@auto code Button_hero_ok_get_1 btFunc end

--@auto code Button_hero_ok_add_2 btFunc
function CityViewController:onButton_hero_ok_add_2Click()
    Functions.printInfo(self.debug,"Button_hero_ok_add_2 button is click!")
    --加速
    self.type = 2
    NoticeManager:openTips(self, { handler = handler(self,self.addTime), title = LanguageConfig.language_City_3})
end
--@auto code Button_hero_ok_add_2 btFunc end

--@auto code Button_hero_ok_get_2 btFunc
function CityViewController:onButton_hero_ok_get_2Click()
    Functions.printInfo(self.debug,"Button_hero_ok_get_2 button is click!")
    --领奖
    self:sendPrize(2)
end
--@auto code Button_hero_ok_get_2 btFunc end

--@auto code Button_hero_ok_add_3 btFunc
function CityViewController:onButton_hero_ok_add_3Click()
    Functions.printInfo(self.debug,"Button_hero_ok_add_3 button is click!")
    --加速
    self.type = 3
    NoticeManager:openTips(self, { handler =handler(self,self.addTime), title = LanguageConfig.language_City_3})
end
--@auto code Button_hero_ok_add_3 btFunc end

--@auto code Button_hero_ok_get_3 btFunc
function CityViewController:onButton_hero_ok_get_3Click()
    Functions.printInfo(self.debug,"Button_hero_ok_get_3 button is click!")
    --领奖
    self:sendPrize(3)
end
--@auto code Button_hero_ok_get_3 btFunc end

--@auto code Button_help btFunc
function CityViewController:onButton_helpClick()
    Functions.printInfo(self.debug,"Button_help button is click!")
    NoticeManager:openNotice(self, {type = NoticeManager.TEAM_CITY_INFO})
end
--@auto code Button_help btFunc end

--@auto button backcall end


--@auto code view display func
function CityViewController:onCreate()
    Functions.printInfo(self.debug_b," CityViewController controller create!")
end

function CityViewController:onDisplayView()
	Functions.printInfo(self.debug_b," CityViewController view enter display!")
    Functions.setAdbrixTag("retension","castle_inter")
    
    Functions.setEnabledBt(self._Button_hero_OK_1_t, false)
    Functions.setEnabledBt(self._Button_hero_OK_2_t, false)
    Functions.setEnabledBt(self._Button_hero_OK_3_t, false)
    --初使化
    self:initShow()
    
    --监听函数
    local onUpdate = function(event)
        self.type = event.data.stIdx
        if self.type == 1 then
            self._Button_hero_OK_get_1_t:setVisible(true)
            self._Button_hero_OK_add_1_t:setVisible(false)
            self._Text_dao_ji_shi_num_1_t:setVisible(false)
            self._Image_ren_wu_1_t:setVisible(true)
        elseif self.type == 2 then
            self._Button_hero_OK_get_2_t:setVisible(true)
            self._Button_hero_OK_add_2_t:setVisible(false)
            self._Text_dao_ji_shi_num_2_t:setVisible(false)
            self._Image_ren_wu_2_t:setVisible(true)
        elseif self.type == 3 then
            self._Button_hero_OK_get_3_t:setVisible(true)
            self._Button_hero_OK_add_3_t:setVisible(false)
            self._Text_dao_ji_shi_num_3_t:setVisible(false)
            self._Image_ren_wu_3_t:setVisible(true)
        end
    end

    Functions.bindEventListener(self.view_t, GameEventCenter, CityData.UPDATE_TASK, onUpdate)

    Functions.initResNodeUI(self._resNode_t,{ "jinbi" , "yuanbao", "soul" })
    --Functions.bindMGSDisplay({ moneyObj = self._Text_money_t, goldObj = self._Text_bao_t, soulObj = self._Text_soul_t })
end
--@auto code view display func end

function CityViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end

--接受pop数据
--{data = {jumpType = self.jumpType,jumpData = {heroType = self.jumpData.heroType,heroMark = self.heroMark }}}
function CityViewController:onReceivePopData(data)
    if data == nil then
    	return false
    end

    self.Change = data.jumpData
    if self.Change.heroType == 1 then
        Functions.getHeroHead(self._ProjectNode_hreo_1_t,{mark = self.Change.heroMark})
        Functions.setEnabledBt(self._Button_hero_OK_1_t, true)
    elseif self.Change.heroType == 2 then
        Functions.getHeroHead(self._ProjectNode_hreo_2_t,{mark = self.Change.heroMark})
        Functions.setEnabledBt(self._Button_hero_OK_2_t, true)
    elseif self.Change.heroType == 3 then
        Functions.getHeroHead(self._ProjectNode_hreo_3_t,{mark = self.Change.heroMark})
        Functions.setEnabledBt(self._Button_hero_OK_3_t, true)
    end
end

--显示倒记时
function CityViewController:showTime(wiget, time)
    local iiii = TimerManager:getCurrentSecond()
    local pppp = TimerManager:getCurrentSecond()
    if time == 0 then
    	return
    end
    if wiget.timeSprite then
        return
    end
    
    wiget.timeSprite = Functions.createSprite()
    wiget:addChild(wiget.timeSprite)

    --任务倒记时
    local onTime = function(event)
        
        local m_newtime = TimerManager:getCurrentSecond()
        local tm = g_StructureCD - (m_newtime - time)
        if tm <= 1 then
            tm = 0
            wiget:removeChild(wiget.timeSprite)
            wiget.timeSprite = nil
            --提示完成
        end
        --local newtime = g_StructureCD - tm
        
        local time = TimerManager:formatTime("%M:%S", tm)
        Functions.initLabelOfString(wiget, time)
    end

    Functions.bindEventListener(wiget.timeSprite, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
    
    onTime()
end


--加速完成
function CityViewController:addTime()
    if PlayerData.eventAttr.m_gold >= 10 then
        self:sendAcceleration(self.type)
    else
        NoticeManager:openTips(self, { handler = handler(self,self.buyGold), title = LanguageConfig.language_City_4})
    end
end

function CityViewController:buyGold()
    self:openChildView("app.ui.popViews.PayPopView", {isRemove = false})
end


--领奖
--function CityViewController:getPrize(id)
--
--    local data = CityData:getArchitectureInfo()
--    if data[1].state == 0 and id == 1 then
--        self._Button_hero_OK_get_1_t:setVisible(false)
--        self._Image_ren_wu_1_t:setVisible(false)
--        self._Image_Start_Task_1_t:setVisible(true)
--        self._Button_hero_OK_1_t:setVisible(true)
--        Functions.setEnabledBt(self._Button_hero_OK_1_t, false)
--        Functions.cleanHeroHead(self._ProjectNode_hreo_1_t)
--    elseif data[2].state == 0 and id == 2 then
--        self._Button_hero_OK_get_2_t:setVisible(false)
--        self._Image_ren_wu_2_t:setVisible(false)
--        self._Image_Start_Task_2_t:setVisible(true)
--        self._Button_hero_OK_2_t:setVisible(true)
--        Functions.setEnabledBt(self._Button_hero_OK_2_t, false)
--        Functions.cleanHeroHead(self._ProjectNode_hreo_2_t)
--    elseif data[3].state == 0 and id == 3 then
--        self._Button_hero_OK_get_3_t:setVisible(false)
--        self._Image_ren_wu_3_t:setVisible(false)
--        self._Image_Start_Task_3_t:setVisible(true)
--        self._Button_hero_OK_3_t:setVisible(true)
--        Functions.setEnabledBt(self._Button_hero_OK_3_t, false)
--        Functions.cleanHeroHead(self._ProjectNode_hreo_3_t)
--    end
--end

--初使化界面显示
function CityViewController:initShow()
    local data = CityData:getArchitectureInfo()
    
    Functions.initLabelOfString( self._Text_bao_wu_num_1_t, tostring(g_StructureBoxNumCfg[data[1].CurLv]), self._Text_bao_wu_num_2_t, g_StructureGoldCfg[data[2].CurLv],
        self._Text_bao_wu_num_3_t, g_StructureCoinCfg[data[3].CurLv], self._Text_bao_wu_EXP_num_1_t, data[1].NeedExp,
        self._Text_bao_wu_EXP_num_2_t, data[2].NeedExp, self._Text_bao_wu_EXP_num_3_t, data[3].NeedExp,
        self._Text_bao_level_1_t, data[1].CurLv, self._Text_bao_level_2_t, data[2].CurLv, self._Text_bao_level_3_t, data[3].CurLv,
        self._Text_sheng_yu_num_1_t,  tostring(data[1].count).."/"..tostring(g_VipCgf.StructureCount[VipData.eventAttr.m_vipLevel]),
        self._Text_sheng_yu_num_2_t, tostring(data[2].count).."/"..tostring(g_VipCgf.StructureCount[VipData.eventAttr.m_vipLevel]),
        self._Text_sheng_yu_num_3_t, tostring(data[3].count).."/"..tostring(g_VipCgf.StructureCount[VipData.eventAttr.m_vipLevel]) )


    if data[1].state == 1 then
        self:showTime(self._Text_dao_ji_shi_num_1_t, data[1].InitTime)
        Functions.getHeroHead(self._ProjectNode_hreo_1_t,{mark = data[1].sloting})
        
        self._Button_hero_OK_add_1_t:setVisible(true)   -- 加速
        self._Text_dao_ji_shi_num_1_t:setVisible(true)  -- 倒记时
        
        self._Image_Start_Task_1_t:setVisible(false)     -- 开始任务
        self._Button_hero_OK_1_t:setVisible(false)      -- 开始
    end
    if data[2].state == 1 then
        self:showTime(self._Text_dao_ji_shi_num_2_t, data[2].InitTime)

        Functions.getHeroHead(self._ProjectNode_hreo_2_t,{mark = data[2].sloting}) 
        
        self._Button_hero_OK_add_2_t:setVisible(true)
        self._Text_dao_ji_shi_num_2_t:setVisible(true)
        
        self._Image_Start_Task_2_t:setVisible(false)
        self._Button_hero_OK_2_t:setVisible(false) 
    end
    if data[3].state == 1 then
        self:showTime(self._Text_dao_ji_shi_num_3_t, data[3].InitTime)
        Functions.getHeroHead(self._ProjectNode_hreo_3_t,{mark = data[3].sloting})
        
        self._Button_hero_OK_add_3_t:setVisible(true)
        self._Text_dao_ji_shi_num_3_t:setVisible(true)
        
        self._Image_Start_Task_3_t:setVisible(false)
        self._Button_hero_OK_3_t:setVisible(false)
    end
    
    if data[1].state == 2 then
    local oooo = data[1].sloting
        Functions.getHeroHead(self._ProjectNode_hreo_1_t,{mark = data[1].sloting})
        self._Image_ren_wu_1_t:setVisible(true)
        self._Button_hero_OK_get_1_t:setVisible(true)
        self._Image_Start_Task_1_t:setVisible(false)     -- 开始任务
        self._Button_hero_OK_1_t:setVisible(false)
    end
    if data[2].state == 2 then
        Functions.getHeroHead(self._ProjectNode_hreo_2_t,{mark = data[2].sloting})
        self._Image_ren_wu_2_t:setVisible(true)
        self._Button_hero_OK_get_2_t:setVisible(true)
        self._Image_Start_Task_2_t:setVisible(false)     -- 开始任务
        self._Button_hero_OK_2_t:setVisible(false)
    end
    if data[3].state == 2 then
        Functions.getHeroHead(self._ProjectNode_hreo_3_t,{mark = data[3].sloting})
        self._Image_ren_wu_3_t:setVisible(true)
        self._Button_hero_OK_get_3_t:setVisible(true)
        self._Image_Start_Task_3_t:setVisible(false)     -- 开始任务
        self._Button_hero_OK_3_t:setVisible(false)
    end
    
    if data[1].state == 0 then
        self._Button_hero_OK_get_1_t:setVisible(false)
        self._Image_ren_wu_1_t:setVisible(false)
        self._Image_Start_Task_1_t:setVisible(true)
        self._Button_hero_OK_1_t:setVisible(true)
        Functions.setEnabledBt(self._Button_hero_OK_1_t, false)
        Functions.cleanHeroHead(self._ProjectNode_hreo_1_t)
    end
    if data[2].state == 0 then
        self._Button_hero_OK_get_2_t:setVisible(false)
        self._Image_ren_wu_2_t:setVisible(false)
        self._Image_Start_Task_2_t:setVisible(true)
        self._Button_hero_OK_2_t:setVisible(true)
        Functions.setEnabledBt(self._Button_hero_OK_2_t, false)
        Functions.cleanHeroHead(self._ProjectNode_hreo_2_t)
    end
    if data[3].state == 0 then
        self._Button_hero_OK_get_3_t:setVisible(false)
        self._Image_ren_wu_3_t:setVisible(false)
        self._Image_Start_Task_3_t:setVisible(true)
        self._Button_hero_OK_3_t:setVisible(true)
        Functions.setEnabledBt(self._Button_hero_OK_3_t, false)
        Functions.cleanHeroHead(self._ProjectNode_hreo_3_t)
    end
end

function CityViewController:sendStart()
    Functions.printInfo(self.debug,"sendStart!")
    --开始任务
    local onStart = function(event)
        if event.ret == 1 then
            Functions.setAdbrixTag("retension","mgt_castle_mission_try")
            local time = event.InitTime
            local count = event.count
            local id = event.stIdx
            local Slot = event.Slot
            
            local data = CityData:getArchitectureInfo()
            data[id].state = 1
            data[id].sloting = Slot
            data[id].InitTime = time
            data[id].count = count
            CityData.taskOldCard[#CityData.taskOldCard + 1] = Slot
            
            local kkkkk = CityData:getArchitectureInfo()
            
            self:initShow()
        else
        --弹出报错信息
            PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
            --PromptManager:openTipPrompt(g_csErrorString[event.ret])
        end
        return true
    end
    local iii = self.Change.heroType
    local ppp = self.Change.heroMark
    NetWork:addNetWorkListener({ 24, 1 }, onStart)
    NetWork:sendToServer({ idx = { 24, 1 }, stIdx = self.Change.heroType, slot = self.Change.heroMark })
end

function CityViewController:sendAcceleration(type)
    Functions.printInfo(self.debug,"sendAcceleration!")

  --监听报错
    local onAdd = function(event)
        if event.ret == 1 then
            if type == 1 then
                self._Text_dao_ji_shi_num_1_t:removeChild(self._Text_dao_ji_shi_num_1_t.timeSprite)
                self._Text_dao_ji_shi_num_1_t.timeSprite = nil
            elseif type == 2 then
                self._Text_dao_ji_shi_num_2_t:removeChild(self._Text_dao_ji_shi_num_2_t.timeSprite)
                self._Text_dao_ji_shi_num_2_t.timeSprite = nil
            elseif type == 3 then
                self._Text_dao_ji_shi_num_3_t:removeChild(self._Text_dao_ji_shi_num_3_t.timeSprite)
                self._Text_dao_ji_shi_num_3_t.timeSprite = nil
            end
        else
            --弹出报错信息
            PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
            --PromptManager:openTipPrompt(g_csErrorString[event.ret])
        end
        return true
    end
    NetWork:addNetWorkListener({ 24, 2 }, onAdd)
    NetWork:sendToServer({ idx = { 24, 2 }, stIdx = type })
end


function CityViewController:sendPrize(type)
    Functions.printInfo(self.debug,"sendPrize!")
    --领取奖品
    local onPrize = function(event)
        
        --id = 建筑物id levle 等级 flag 升级标记 TemExp -本次增加经验 NeedExp 所需经验 - state -- 状态 
        local id = event.id
        local level = event.level
        local flag = event.flag
        local TemExp = event.TemExp
        local NeedExp = event.NeedExp
        local state = event.state
        local Sloted = event.Sloted
        local Item = event.Item
        
        local m_count = event.m_count
        if m_count > 0 then
            local str = "mgt_castle_mission_complete_"..tostring(m_count)
            Functions.setAdbrixTag("retension",str, PlayerData.eventAttr.m_level)
        end
        
        Functions.playSound("get_loot.mp3")

        local data = CityData:getArchitectureInfo()
        data[id].CurLv = level
        data[id].NeedExp = NeedExp
        data[id].state = state
         
        --self:showHoreHead()
        CityData:setCityDataBZ()
        self:initShow()
        
        local itemDatas = {}
        if Item then
            for k, v in pairs(Item) do
                if Item[k].id > 0 then
                    --PropData:addProp({m_id = Item[k].id, m_count = Item[k].num})
                    Functions:addItemResources( { id = Item[k].id, type = 4, count = Item[k].num } )
                end

                local img = "proptrey_6.png"
                local id = Item[k].id
                if Item[k].id == 31 then
                    img = "property_31.png"
                elseif Item[k].id == 32 then
                    img = "property_32.png"
                elseif Item[k].id == 36 then
                    img = "property_36.png"
                elseif Item[k].id == 37 then
                    img = "property_37.png"
                elseif Item[k].id == 38 then
                    img = "property_38.png"
                elseif Item[k].id == 39 then
                    img = "property_39.png"
                elseif Item[k].id == 40 then
                    img = "property_40.png"
                elseif Item[k].id == 41 then
                    img = "property_41.png"
                elseif Item[k].id == 42 then
                    img = "property_42.png"
                elseif Item[k].id == -2 then
                    PlayerData.eventAttr.m_gold = PlayerData.eventAttr.m_gold + Item[k].num
                    img = "property_gold.png"
                elseif Item[k].id == -3 then
                    PlayerData.eventAttr.m_money = PlayerData.eventAttr.m_money + Item[k].num
                    img = "property_money.png"
                end
                local itemNUM = {img = img ,num = Item[k].num}
                itemDatas[#itemDatas + 1] = itemNUM
            end
        end

        if flag ~= 0 then
            --打开二级界面
            self:openChildView("app.ui.popViews.CityPopView", { data = {level = level, type = id, item = itemDatas } })
        else
            NoticeManager:openRewardTips(self, {type = NoticeManager.REWARD_PROP_TIPS, data = itemDatas})
        end
    end
    NetWork:addNetWorkListener({ 24, 4 }, Functions.createNetworkListener(onPrize,true,"ret") )
    NetWork:sendToServer({ idx = { 24, 4 }, stIdx = type })
end

function CityViewController:showHoreHead()
    Functions.printInfo(self.debug,"showHoreHead!")
    local data = CityData:getArchitectureInfo()
    if data[1].state == 0 then
        Functions.cleanHeroHead(self._ProjectNode_hreo_1_t)
        Functions.setEnabledBt(self._Button_hero_OK_1_t, false)
    end
    if data[2].state == 0 then
        Functions.cleanHeroHead(self._ProjectNode_hreo_2_t)
        Functions.setEnabledBt(self._Button_hero_OK_2_t, false)
    end
    if data[3].state == 0 then
        Functions.cleanHeroHead(self._ProjectNode_hreo_3_t)
        Functions.setEnabledBt(self._Button_hero_OK_3_t, false)
    end

end

return CityViewController