--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local EnlistViewController = class("EnlistViewController", BaseViewController)

local Functions = require("app.common.Functions")

EnlistViewController.debug = true
EnlistViewController.modulePath = ...
EnlistViewController.studioSpriteFrames = {"EnlistUI_Text","CB_blackbg","EnlistUI_Text_Bg" }
--@auto code head end

--@Pre loading
EnlistViewController.spriteFrameNames = 
    {
        "heroCardRes"
    }

EnlistViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #EnlistViewController.studioSpriteFrames > 0 then
    EnlistViewController.spriteFrameNames = EnlistViewController.spriteFrameNames or {}
    table.insertto(EnlistViewController.spriteFrameNames, EnlistViewController.studioSpriteFrames)
end
function EnlistViewController:onDidLoadView()

    --output list
    self._resNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("resNode")
	self._Text_mianFei_time_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_mianFei"):getChildByName("Text_mianFei_time")
	self._Text_mianFei_string_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_mianFei"):getChildByName("Text_mianFei_string_1")
	self._Text_mianFei_string_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_mianFei"):getChildByName("Text_mianFei_string_2")
	self._Text_mianFei_ti_shi_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_mianFei"):getChildByName("Text_mianFei_ti_shi_1")
	self._Text_bao_time_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_yuanBao"):getChildByName("Text_bao_time")
	self._Text_bao_string_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_yuanBao"):getChildByName("Text_bao_string_1")
	self._Text_bao_string_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_yuanBao"):getChildByName("Text_bao_string_2")
	self._Text_bao_ti_shi_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_yuanBao"):getChildByName("Text_bao_ti_shi_2")
	
    --label list
    
    --button list
    self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

	self._Button_mianFei_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_mianFei"):getChildByName("Button_mianFei_1")
	self._Button_mianFei_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_mianfei_1Click), "zoom"))

	self._Button_mianFei_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_mianFei"):getChildByName("Button_mianFei_2")
	self._Button_mianFei_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_mianfei_2Click), "zoom"))

	self._Button_bao_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_yuanBao"):getChildByName("Button_bao_1")
	self._Button_bao_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_bao_1Click), "zoom"))

	self._Button_bao_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_yuanBao"):getChildByName("Button_bao_2")
	self._Button_bao_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_bao_2Click), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function EnlistViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
    EnlistData.m_CardNum = 1
    GameCtlManager:pop(self)
end
--@auto code Button_back btFunc end

--@auto code Button_mianfei_1 btFunc
function EnlistViewController:onButton_mianfei_1Click()
    Functions.printInfo(self.debug,"Button_mianfei_1 button is click!")

    --武将已招满的提示
    if self:Judge(1) then
        return false
    end

    if EnlistData.m_sampleFNum == 1 then
        EnlistData.m_CardType = 1
    else
        EnlistData.m_CardType = 3
    end
    
    EnlistData.m_CardNum = 1   --抽一次为1

    EnlistData:sendGetCard(handler(self, self.onSuccess))
end
--@auto code Button_mianfei_1 btFunc end

--@auto code Button_mianfei_2 btFunc
function EnlistViewController:onButton_mianfei_2Click()
    Functions.printInfo(self.debug,"Button_mianfei_2 button is click!")
    --武将已招满的提示
    if self:Judge(10) then
        return false
    end
    EnlistData.m_CardType = 3
    EnlistData.m_CardNum = 10   --抽10

    EnlistData:sendGetCard(handler(self, self.onSuccess))
end
--@auto code Button_mianfei_2 btFunc end

--@auto code Button_bao_1 btFunc
function EnlistViewController:onButton_bao_1Click()
    Functions.printInfo(self.debug,"Button_bao_1 button is click!")
    --2-元宝免费抽   4-元宝抽
    --武将已招满的提示
    if self:Judge(1) then
        return false
    end
    
    if EnlistData.m_sampleGNum > 0 then
        EnlistData.m_CardType = 2
    else
        EnlistData.m_CardType = 4
    end
    EnlistData.m_CardNum = 1   --抽一次为1

    EnlistData:sendGetCard(handler(self, self.onSuccess))
end
--@auto code Button_bao_1 btFunc end

--@auto code Button_bao_2 btFunc
function EnlistViewController:onButton_bao_2Click()
    Functions.printInfo(self.debug,"Button_bao_2 button is click!")
    --武将已招满的提示
    if self:Judge(10) then
        return false
    end
    
    EnlistData.m_CardType = 4
    EnlistData.m_CardNum = 10   --抽10

    EnlistData:sendGetCard(handler(self, self.onSuccess))
end
--@auto code Button_bao_2 btFunc end

--@auto button backcall end


--@auto code view display func
function EnlistViewController:onCreate()
    Functions.printInfo(self.debug_b," EnlistViewController controller create!")
end

function EnlistViewController:onDisplayView()
	Functions.printInfo(self.debug_b," EnlistViewController view enter display!")
    Functions.setPopupKey("recruit")
    Functions.setAdbrixTag("retension","herohof_inter")

    --Functions.bindMGSDisplay({ moneyObj = self._Text_money_t, goldObj = self._Text_bao_t, soulObj = self._Text_soul_t })

    Functions.initResNodeUI(self._resNode_t,{ "jinbi" , "yuanbao", "soul" })

    --抽武将监听
    local onUI = function(event)
        self:updateUI()
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, EnlistData.ENLIST_CRAD_TIME, onUI)
    self:updateUI()
    
    self._Text_bao_string_2_t:setText(tostring(g_SampleNewCfg.TenGold))
    self._Text_mianFei_string_2_t:setText(tostring(g_SampleNewCfg.TenMoney))
end
--@auto code view display func end

function EnlistViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end

function EnlistViewController:onSuccess(data)
    Functions.printInfo(self.debug_b,"onSuccess")
    if data.ret == 1 then
        self:openChildView("app.ui.popViews.EnlistThreePopView", {isRemove = false })--isRemove = true 点击弹出界面以外的界面就自动关闭当前弹出的这个界面
    else
        --弹出报错信息
        PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(data.ret))
        --PromptManager:openTipPrompt(g_csErrorString[data.ret])
    end
end


function EnlistViewController:showTime()
    Functions.printInfo(self.debug_b,"showTime")
    local oooo = EnlistData.m_sampleFDCount
    if g_SampleNewCfg.M_Free_Num <= EnlistData.m_sampleFDCount then
    	return
    end
    --免费抽卡倒记时
    local onTime = function(event)
        local m_newtime = TimerManager:getCurrentSecond()
        local oooo = EnlistData.m_sampleFTime
        m_newtime = m_newtime - EnlistData.m_sampleFTime
        m_newtime = g_SampleNewCfg.MCD - m_newtime
        if m_newtime < 0 then
            m_newtime = 0
        end
        if m_newtime > g_SampleNewCfg.MCD then
            m_newtime = g_SampleNewCfg.MCD
            
        end
        --m_newtime = m_newtime - 1
        if m_newtime == 0 then
            --获取免费抽卡的时间cd
            --m_newtime = g_SampleNewCfg.SamFreeCD
            --免费次数
--            EnlistData.m_sampleFNum = EnlistData.m_sampleFNum + 1
--            if EnlistData.m_sampleFNum > 0 then
--
--            end

            --显示免费次数
            local str = LanguageConfig.language_Enlist_1..tostring(g_SampleNewCfg.M_Free_Num - EnlistData.m_sampleFDCount).."/"..tostring(g_SampleNewCfg.M_Free_Num)
            Functions.initLabelOfString( self._Text_mianFei_ti_shi_1_t, str)
            
            Functions.initLabelOfString( self._Text_mianFei_time_t, LanguageConfig.language_Enlist_2)
            Functions.initLabelOfString( self._Text_mianFei_string_1_t, LanguageConfig.language_Enlist_3)
            if g_SampleNewCfg.M_Free_Num <= EnlistData.m_sampleFDCount then
                Functions.initLabelOfString( self._Text_mianFei_time_t, LanguageConfig.language_Enlist_5)
                Functions.initLabelOfString( self._Text_mianFei_string_1_t, tostring(g_SampleNewCfg.Money))
            end
            return true
        end

        if g_SampleNewCfg.M_Free_Num <= EnlistData.m_sampleFDCount then
            Functions.initLabelOfString( self._Text_mianFei_time_t, LanguageConfig.language_Enlist_5)
            return true
        else 
            local time = TimerManager:formatOverTime("%02d:%02d", m_newtime)
            local str = time..LanguageConfig.language_Enlist_4
            Functions.initLabelOfString( self._Text_mianFei_time_t, str)
        end    
    end
    Functions.bindEventListener(self._Text_mianFei_time_t, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
    onTime()
end

function EnlistViewController:showBaoTime()
    Functions.printInfo(self.debug_b,"showBaoTime")
    --免费抽卡倒记时
    local onTime = function(event)
        local m_newtime = TimerManager:getCurrentSecond()
        m_newtime = m_newtime - EnlistData.m_sampleGTime
        m_newtime = g_SampleNewCfg.GCD - m_newtime
        if m_newtime < 0 then
            m_newtime = 0
        end
        if m_newtime > g_SampleNewCfg.GCD then
            m_newtime = g_SampleNewCfg.GCD
        end
        if m_newtime == 0 then
            --免费次数
            EnlistData.m_sampleGNum = EnlistData.m_sampleGNum + 1
            if EnlistData.m_sampleGNum > 0 then

            end
            --显示免费次数
            Functions.initLabelOfString( self._Text_bao_time_t, LanguageConfig.language_Enlist_2)
            Functions.initLabelOfString( self._Text_bao_string_1_t, LanguageConfig.language_Enlist_3)
            
            return true
        end
        local time = TimerManager:formatOverTime("%02d:%02d:%02d", m_newtime)
        local str = time..LanguageConfig.language_Enlist_4
        Functions.initLabelOfString( self._Text_bao_time_t, str)
    end
    Functions.bindEventListener(self._Text_bao_time_t, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
    onTime()
end

function EnlistViewController:updateUI()
    Functions.printInfo(self.debug_b,"onSuccess")
    
    if EnlistData.m_sampleFDCount >= g_SampleNewCfg.M_Free_Num then
        Functions.initLabelOfString( self._Text_mianFei_time_t, LanguageConfig.language_Enlist_5)
        Functions.initLabelOfString( self._Text_mianFei_string_1_t, tostring(g_SampleNewCfg.Money))
    else
        if EnlistData.m_sampleFNum <= 0 then
            self:showTime()
            Functions.initLabelOfString( self._Text_mianFei_string_1_t, tostring(g_SampleNewCfg.Money))
        else
            Functions.initLabelOfString( self._Text_mianFei_string_1_t, LanguageConfig.language_Enlist_3)
            Functions.initLabelOfString( self._Text_mianFei_time_t, LanguageConfig.language_Enlist_2)
        end
    end

    
    if EnlistData.m_sampleGNum <= 0 then
        self:showBaoTime()
        Functions.initLabelOfString( self._Text_bao_string_1_t, tostring(g_SampleNewCfg.Gold))
    else
        Functions.initLabelOfString( self._Text_bao_string_1_t, LanguageConfig.language_Enlist_3)
        Functions.initLabelOfString( self._Text_bao_time_t, LanguageConfig.language_Enlist_2)
    end
    
    --显示免费次数
    local str = LanguageConfig.language_Enlist_1..tostring(g_SampleNewCfg.M_Free_Num - EnlistData.m_sampleFDCount).."/"..tostring(g_SampleNewCfg.M_Free_Num)
    Functions.initLabelOfString( self._Text_mianFei_ti_shi_1_t, str)

    
    --第几次抽到5星卡提示
    local count = g_SampleNewCfg.CritNum - EnlistData.m_AllCount%g_SampleNewCfg.CritNum
    if count == 0 then
        --local str = "今日免费次数："..tostring(EnlistData.m_sampleFDCount).."/"..tostring(5)
        Functions.initLabelOfString( self._Text_bao_ti_shi_2_t, LanguageConfig.language_Enlist_6)
    else
        local str = LanguageConfig.language_Enlist_7..tostring(count)..LanguageConfig.language_Enlist_8
        Functions.initLabelOfString( self._Text_bao_ti_shi_2_t, str)
    end
end

function EnlistViewController:Judge(num)
    Functions.printInfo(self.debug,"Judge")
    if #HeroCardData:getAllHeroData() + num > HeroCardData:getBagBaseSize() then
        PromptManager:openTipPrompt(LanguageConfig.language_Enlist_9)
        return true
    else
        return false
    end
end

return EnlistViewController