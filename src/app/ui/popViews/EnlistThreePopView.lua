--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local EnlistThreePopView = class("EnlistThreePopView", BasePopView)

local Functions = require("app.common.Functions")

EnlistThreePopView.csbResPath = "lk/csb"
EnlistThreePopView.debug = true
EnlistThreePopView.studioSpriteFrames = {"EnlistUI_Text","CB_night" }
--@auto code head end

local scheduler = require("app.common.scheduler")


--@Pre loading
EnlistThreePopView.spriteFrameNames = 
    {
        
    }

EnlistThreePopView.animaNames = 
    {
        "AwardCard_bai", "AwardCard_fei","AwardCard_Star"
    }


--@auto code uiInit
--add spriteFrames
if #EnlistThreePopView.studioSpriteFrames > 0 then
    EnlistThreePopView.spriteFrameNames = EnlistThreePopView.spriteFrameNames or {}
    table.insertto(EnlistThreePopView.spriteFrameNames, EnlistThreePopView.studioSpriteFrames)
end
function EnlistThreePopView:onInitUI()

    --output list
    self._Sprite_three_bg_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Sprite_three_bg")
	self._Panel_two_2_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_two_2")
	self._Sprite_two_have_text_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_two_2"):getChildByName("Sprite_two_have_text")
	self._Image_bao_money_1_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_two_2"):getChildByName("Image_bao_money_1")
	self._Text_bao_money_1_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_two_2"):getChildByName("Image_bao_money_1"):getChildByName("Text_bao_money_1")
	self._HeroCard_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_two_2"):getChildByName("HeroCard")
	self._Panel_three_3_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3")
	self._Image_bao_money_2_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Image_bao_money_2")
	self._Text_bao_money_2_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Image_bao_money_2"):getChildByName("Text_bao_money_2")
	self._Sprite_Three_have_text_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Sprite_Three_have_text")
	self._ProjectNode_1_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_1"):getChildByName("ProjectNode_1")
	self._ProjectNode_2_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_2"):getChildByName("ProjectNode_2")
	self._ProjectNode_3_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_3"):getChildByName("ProjectNode_3")
	self._ProjectNode_4_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_4"):getChildByName("ProjectNode_4")
	self._ProjectNode_5_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_5"):getChildByName("ProjectNode_5")
	self._ProjectNode_6_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_6"):getChildByName("ProjectNode_6")
	self._ProjectNode_7_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_7"):getChildByName("ProjectNode_7")
	self._ProjectNode_8_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_8"):getChildByName("ProjectNode_8")
	self._ProjectNode_9_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_9"):getChildByName("ProjectNode_9")
	self._ProjectNode_10_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_10"):getChildByName("ProjectNode_10")
	
    --label list
    
    --button list
    self._Button_again_1_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_two_2"):getChildByName("Button_again_1")
	self._Button_again_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_again_1Click), "zoom"))

	self._Button_see_1_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_two_2"):getChildByName("Button_see_1")
	self._Button_see_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_see_1Click), "zoom"))

	self._Button_back_1_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_two_2"):getChildByName("Button_back_1")
	self._Button_back_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_back_1Click), "zoom"))

	self._Button_jump_1_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_two_2"):getChildByName("Button_jump_1")
	self._Button_jump_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_jump_1Click), "zoom"))

	self._Panel_see_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_two_2"):getChildByName("Panel_see")
	self._Panel_see_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_seeClick), ""))

	self._Button_again_2_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_again_2")
	self._Button_again_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_again_2Click), "zoom"))

	self._Button_back_2_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_back_2")
	self._Button_back_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_back_2Click), "zoom"))

	self._Button_head_1_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_1")
	self._Button_head_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_head_1Click), "zoom"))

	self._Button_head_2_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_2")
	self._Button_head_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_head_2Click), "zoom"))

	self._Button_head_3_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_3")
	self._Button_head_3_t:onTouch(Functions.createClickListener(handler(self, self.onButton_head_3Click), "zoom"))

	self._Button_head_4_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_4")
	self._Button_head_4_t:onTouch(Functions.createClickListener(handler(self, self.onButton_head_4Click), "zoom"))

	self._Button_head_5_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_5")
	self._Button_head_5_t:onTouch(Functions.createClickListener(handler(self, self.onButton_head_5Click), "zoom"))

	self._Button_head_6_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_6")
	self._Button_head_6_t:onTouch(Functions.createClickListener(handler(self, self.onButton_head_6Click), "zoom"))

	self._Button_head_7_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_7")
	self._Button_head_7_t:onTouch(Functions.createClickListener(handler(self, self.onButton_head_7Click), "zoom"))

	self._Button_head_8_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_8")
	self._Button_head_8_t:onTouch(Functions.createClickListener(handler(self, self.onButton_head_8Click), "zoom"))

	self._Button_head_9_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_9")
	self._Button_head_9_t:onTouch(Functions.createClickListener(handler(self, self.onButton_head_9Click), "zoom"))

	self._Button_head_10_t = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3"):getChildByName("Button_head_10")
	self._Button_head_10_t:onTouch(Functions.createClickListener(handler(self, self.onButton_head_10Click), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_again_2 btFunc
function EnlistThreePopView:onButton_again_2Click()
    Functions.printInfo(self.debug,"Button_again_2 button is click!")
    
    --武将已招满的提示
    if self:Judge(10) then
        return false
    end
    
    self.cardCount = EnlistData.m_CardNum--抽到卡的记数标识
    if EnlistData.m_CardType == 3 then
        if self.cardCount == 1 then
            if PlayerData.eventAttr.m_money < g_SampleNewCfg.Money then
                --弹出报错信息
                PromptManager:openTipPrompt(LanguageConfig.language_Enlist_10)
                return false
            end
            
        else
            if PlayerData.eventAttr.m_money < g_SampleNewCfg.TenMoney then
                --弹出报错信息
                PromptManager:openTipPrompt(LanguageConfig.language_Enlist_10)
                return false
            end
    	end
    end
    
    if EnlistData.m_CardType == 4 then
        if self.cardCount == 1 then
            if PlayerData.eventAttr.m_gold < g_SampleNewCfg.Gold then
                --弹出报错信息
                PromptManager:openTipPrompt(LanguageConfig.language_Enlist_11)
                return false
            end

        else
            if PlayerData.eventAttr.m_gold < g_SampleNewCfg.TenGold then
                --弹出报错信息
                PromptManager:openTipPrompt(LanguageConfig.language_Enlist_11)
                return false
            end
        end
    end
    self._Panel_three_3_t:setVisible(false)
    --发送抽卡接口
    EnlistData:sendGetCard(handler(self, self.onSuccess))
end
--@auto code Button_again_2 btFunc end

--@auto code Button_back_2 btFunc
function EnlistThreePopView:onButton_back_2Click()
    Functions.printInfo(self.debug,"Button_back_2 button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_back_2 btFunc end

--@auto code Button_again_1 btFunc
function EnlistThreePopView:onButton_again_1Click()
    Functions.printInfo(self.debug,"Button_again_1 button is click!")
    
    --武将已招满的提示
    if self:Judge(1) then
        return false
    end
    if self.jumpData ~= nil and self.jumpData.type == 1 then
        self.jumpData.handler()
        self.close(self)
        return
    end
    
    if EnlistData.m_CardType == 1 or EnlistData.m_CardType == 3 then
        EnlistData.m_CardType = 3
        local dta  = EnlistData.m_CardNum
        if EnlistData.m_CardNum == 1 then
        local uuuuu = PlayerData.eventAttr.m_money
            if PlayerData.eventAttr.m_money < g_SampleNewCfg.Money then
                --弹出报错信息
                PromptManager:openTipPrompt(LanguageConfig.language_Enlist_10)
                return false
            end
        else
            if PlayerData.eventAttr.m_money < g_SampleNewCfg.TenMoney then
                --弹出报错信息
                PromptManager:openTipPrompt(LanguageConfig.language_Enlist_10)
                return false
            end
        end

    elseif EnlistData.m_CardType == 2 or EnlistData.m_CardType == 4 then
        EnlistData.m_CardType = 4
        if EnlistData.m_CardNum == 1 then
            if PlayerData.eventAttr.m_gold < g_SampleNewCfg.Gold then
                --弹出报错信息
                PromptManager:openTipPrompt(LanguageConfig.language_Enlist_11)
                return false
            end

        else
            if PlayerData.eventAttr.m_gold < g_SampleNewCfg.TenGold then
                --弹出报错信息
                PromptManager:openTipPrompt(LanguageConfig.language_Enlist_11)
                return false
            end
        end
    end
    self:removeSprite()
    
    self._Panel_two_2_t:setVisible(false)
    self._HeroCard_t:setVisible(false)
    self._Button_again_1_t:setVisible(false)
    self._Image_bao_money_1_t:setVisible(false)
    self._Panel_see_t:setVisible(false)
    self._Button_back_1_t:setVisible(false)
    self._Sprite_two_have_text_t:setVisible(false)
    self.cardCount = EnlistData.m_CardNum--抽到卡的记数标识
    EnlistData:sendGetCard(handler(self, self.onSuccess))
end
--@auto code Button_again_1 btFunc end

--@auto code Button_back_1 btFunc
function EnlistThreePopView:onButton_back_1Click()
    Functions.printInfo(self.debug,"Button_back_1 button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_back_1 btFunc end

--@auto code Button_jump_1 btFunc
function EnlistThreePopView:onButton_jump_1Click()
    Functions.printInfo(self.debug,"Button_jump_1 button is click!")
    if self.getcard_Sound then
        Audio.stopSound(self.getcard_Sound)
    end
    
    self:removeSprite()
    
    self._Panel_three_3_t:setVisible(true)
    self:showMoneyType()
    self._Button_jump_1_t:setVisible(false)
    
    self.cardCount = 0
    self._HeroCard_t:setVisible(false)
    self._Sprite_two_have_text_t:setVisible(false)
    
    self._Panel_two_2_t:setVisible(false)
    
end
--@auto code Button_jump_1 btFunc end

--@auto code Button_head_1 btFunc
function EnlistThreePopView:onButton_head_1Click()
    Functions.printInfo(self.debug,"Button_head_1 button is click!")
    self:showHeroInfo(1)
end
--@auto code Button_head_1 btFunc end

--@auto code Button_head_2 btFunc
function EnlistThreePopView:onButton_head_2Click()
    Functions.printInfo(self.debug,"Button_head_2 button is click!")
    self:showHeroInfo(2)
end
--@auto code Button_head_2 btFunc end

--@auto code Button_head_3 btFunc
function EnlistThreePopView:onButton_head_3Click()
    Functions.printInfo(self.debug,"Button_head_3 button is click!")
    self:showHeroInfo(3)
end
--@auto code Button_head_3 btFunc end

--@auto code Button_head_4 btFunc
function EnlistThreePopView:onButton_head_4Click()
    Functions.printInfo(self.debug,"Button_head_4 button is click!")
    self:showHeroInfo(4)
end
--@auto code Button_head_4 btFunc end

--@auto code Button_head_5 btFunc
function EnlistThreePopView:onButton_head_5Click()
    Functions.printInfo(self.debug,"Button_head_5 button is click!")
    self:showHeroInfo(5)
end
--@auto code Button_head_5 btFunc end

--@auto code Button_head_6 btFunc
function EnlistThreePopView:onButton_head_6Click()
    Functions.printInfo(self.debug,"Button_head_6 button is click!")
    self:showHeroInfo(6)
end
--@auto code Button_head_6 btFunc end

--@auto code Button_head_7 btFunc
function EnlistThreePopView:onButton_head_7Click()
    Functions.printInfo(self.debug,"Button_head_7 button is click!")
    self:showHeroInfo(7)
end
--@auto code Button_head_7 btFunc end

--@auto code Button_head_8 btFunc
function EnlistThreePopView:onButton_head_8Click()
    Functions.printInfo(self.debug,"Button_head_8 button is click!")
    self:showHeroInfo(8)
end
--@auto code Button_head_8 btFunc end

--@auto code Button_head_9 btFunc
function EnlistThreePopView:onButton_head_9Click()
    Functions.printInfo(self.debug,"Button_head_9 button is click!")
    self:showHeroInfo(9)
end
--@auto code Button_head_9 btFunc end

--@auto code Button_head_10 btFunc
function EnlistThreePopView:onButton_head_10Click()
    Functions.printInfo(self.debug,"Button_head_10 button is click!")
    self:showHeroInfo(10)
end
--@auto code Button_head_10 btFunc end

--@auto code Panel_see btFunc
function EnlistThreePopView:onPanel_seeClick()
    Functions.printInfo(self.debug,"Panel_see button is click!")
    --这里传的mark分为招募查看，还有其它地方传过来的抽卡动画时调用的查看功能
    local mark = nil
    local heroData = nil
    if self.jumpData ~= nil then
        mark = self.jumpData.slot
    else
        heroData = EnlistData:getEnlistData()
        mark = heroData[1].m_mark
    end
    --打开武将详情界面
    self._controller_t:openChildView("app.ui.popViews.CardInfoPopView", { data = {HeroCardData:getHeroInfo(mark), 2}, isRemove = false})
end
--@auto code Panel_see btFunc end

--@auto code Button_see_1 btFunc
function EnlistThreePopView:onButton_see_1Click()
    Functions.printInfo(self.debug,"Button_see_1 button is click!")
end
--@auto code Button_see_1 btFunc end

--@auto button backcall end


--@auto code output func
function EnlistThreePopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end


function EnlistThreePopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
    
    self.jumpData = data
    if data ~= nil and self.jumpData.type == 1 then
    	EnlistData.m_CardNum = 1
    elseif data ~= nil and self.jumpData.type == 10 then
        EnlistData.m_CardNum = 10
    end
    self.cardCount = EnlistData.m_CardNum--抽到卡的记数标识

    --显示
    self:initShow()
    self:animationShow()
end

function EnlistThreePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function EnlistThreePopView:showHeroHead()
    Functions.printInfo(self.debug,"showHeroHead")
    local heroData = EnlistData:getEnlistData()
    local frame = self.csbNode:getChildByName("Panel_Three_page"):getChildByName("Panel_three_3")
    for k, v in pairs(heroData) do
--        local heroHead = frame:getChildByName("Button_head_"..tostring(k)):getChildByName("Image_head_"..tostring(k))
        local heroName = frame:getChildByName("Button_head_"..tostring(k)):getChildByName("Text_head_"..tostring(k))
--        Functions.loadImageWithWidget(heroHead, ConfigHandler:getHeroHeadImageOfId(heroData[k].m_id))
        heroName:setText(ConfigHandler:getHeroNameOfId(heroData[k].m_id))
        local str = ("_ProjectNode_"..tostring(k).."_t")


        if self.jumpData ~= nil then
            Functions.getHeroHead(self[str],{mark = self.jumpData.slot})
        else
            Functions.getHeroHead(self[str],{mark = heroData[k].m_mark})
        end

    end
end

function EnlistThreePopView:showHeroInfo(idx)
    Functions.printInfo(self.debug,"showHeroInfo")
    local heroData = EnlistData:getEnlistData()
    --打开武将详情界面
    self._controller_t:openChildView("app.ui.popViews.CardInfoPopView", { data = {HeroCardData:getHeroInfo(heroData[idx].m_mark), 2}, isRemove = false})
end

function EnlistThreePopView:onSuccess(data)
    if data.ret == 1 then
        --显示
        self:initShow()
        self:animationShow()
    else
        --弹出报错信息
        PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(data.ret))
    end
end

function EnlistThreePopView:initShow()
    Functions.printInfo(self.debug,"pop action finish ")
    --显示
    if self.cardCount and self.cardCount == 10 then
        self:showHeroHead()
    end

    self._Panel_three_3_t:setVisible(false)
    self._Panel_two_2_t:setVisible(true)
   
    if EnlistData.m_CardNum == 1 then
        
    elseif EnlistData.m_CardNum == 10 then
        self._Button_jump_1_t:setVisible(true)
    end
end

function EnlistThreePopView:animationShow()
    Functions.printInfo(self.debug,"animationShow")
    
    self:removeSprite()
    
    local ooooooo = EnlistData.m_CardNum
    local pppp = EnlistData.m_CardNum
    --初使化动画所需
    self.sX = self._Panel_two_2_t:getContentSize().width/2
    self.sY = self._Panel_two_2_t:getContentSize().height/2
    self.sprite = Functions.createSprite({scale = 1, pos = {x = self.sX + 8, y = self.sY - 8 }, zorder = 0}) 
    self.spriteOne = Functions.createSprite({scale = 1, pos = {x = self.sX + 8, y = self.sY - 8 }, zorder = 0}) 
    self.sprite:setScale(1.55)
    self.spriteOne:setScale(1.55)
    self._Panel_two_2_t:addChild(self.sprite,4)
    self._Panel_two_2_t:addChild(self.spriteOne,2)
    
    local onActionbaiFei = function()
        
        self.spr = Functions.createSpriteOfSfName("lk/uiFonts_res/xuanzhuan.png")
        self.spr:setPosition(self.sX, self.sY)
        self._Panel_two_2_t:addChild(self.spr, -1)
        Functions.setRotateBy(self.spr, 1.5, 0.1, 720, 6, 0, true)
        
        self.spr2 = Functions.createSpriteOfSfName("lk/uiFonts_res/xuanzhuan.png")
        self.spr2:setPosition(self.sX, self.sY)
        
        self._Panel_two_2_t:addChild(self.spr2, -1)
        Functions.setRotateBy(self.spr2, 1.5, 0.1, -720, 6, 0, true)
        
        
        if self.jumpData ~= nil then
            Functions.getHeroCrad(self._HeroCard_t, {mark = self.jumpData.slot})
        else
            if self.cardCount > 0 then
                Functions.getHeroCrad(self._HeroCard_t, {mark = EnlistData:getEnlistData()[self.cardCount].m_mark})
            end
        end
        --获得
        Functions.setScaleTo(self._Sprite_two_have_text_t, 1, 0.3)
        self._Sprite_two_have_text_t:setVisible(true)
        --武将卡
        self._HeroCard_t:setLocalZOrder(3)
        self._HeroCard_t:setPosition(self.sX, self.sY)
        self._HeroCard_t:setVisible(true)
        
        self.getcard_Sound = Audio.playSound("sound/ui_mp3/summonHeroes.mp3")
        Functions.setScaleTo(self._HeroCard_t, 1, 0.5)
        --生成第二个循环动画
        Functions.playAnimaOfUI(self.spriteOne, "AwardCard_bai", 0, true)
        
        self:showStar()
    end
    --第一个动画
    Functions.playActionWithBackCall(self.sprite, "AwardCard_fei", onActionbaiFei)
end

function EnlistThreePopView:showStar()
    Functions.printInfo(self.debug,"showStar")

    local onActionbaiStar = function()
        DebugHoldTime("ResManager--DebugHoldTime------" )
        if self.jumpData ~= nil then
            --self.jumpData = nil
            if self.jumpData.type == 1 then
                self._Text_bao_money_1_t:setString(ActivityData.eventAttr.gold)
                self._Panel_two_2_t:setVisible(true)
                self._Button_back_1_t:setVisible(true)
                self._Panel_see_t:setVisible(true)
                self._Image_bao_money_1_t:setVisible(true)
                self._Button_again_1_t:setVisible(true)
            elseif self.jumpData.type == 5 then
                self._Text_bao_money_1_t:setString(ActivityData.eventAttr.gold)
                self._Panel_two_2_t:setVisible(true)
                self._Button_back_1_t:setVisible(true)
                self._Panel_see_t:setVisible(true)
                self._Button_back_1_t:setPosition(cc.p(570,100))
                --self._Image_bao_money_1_t:setVisible(false)
                --self._Button_again_1_t:setVisible(false)
            end

            --self._Button_back_1_t:setPosition(cc.p(570,100))
        else
            self.cardCount = self.cardCount - 1
            
            if self.cardCount <= 0 then
                if EnlistData.m_CardNum == 10 then
                    self:removeSprite()
                    self._HeroCard_t:setVisible(false)
                    
                    self._Panel_two_2_t:setVisible(false)
                    self._Button_jump_1_t:setVisible(false)
                    self._Panel_three_3_t:setVisible(true)
                    self._Sprite_two_have_text_t:setVisible(false)
                    self:showMoneyType()
                elseif EnlistData.m_CardNum == 1 then
                    self._Panel_two_2_t:setVisible(true)
                    self._Button_again_1_t:setVisible(true)
                    self._Image_bao_money_1_t:setVisible(true)
                    self:showMoneyType()
                    self._Panel_see_t:setVisible(true)
                    self._Button_back_1_t:setVisible(true)
                end
            else
                --隐藏卡片
                local onDelayFinish = function()

                    self._HeroCard_t:setVisible(false)
                    self._Sprite_two_have_text_t:setVisible(false)
                    --调用第一个动画
                    self:animationShow()
                end
                scheduler.performWithDelayGlobal(onDelayFinish, 1)
                
                --释放动画资源
    --            cc.Node:removeAllChildren()
    --            cc.Node:removeAllChildrenWithCleanup()
            end
        end
        DebugDelayTime("ResManager--DebugHoldTime------")
    end
    Functions.playActionWithBackCall(self.sprite, "AwardCard_Star", onActionbaiStar)
end

function EnlistThreePopView:showMoneyType()
    Functions.printInfo(self.debug,"showMoneyType")
    --显示钱的类型和数量

    if EnlistData.m_CardNum == 1 then
        self._Text_bao_money_1_t:ignoreContentAdaptWithSize(true)
        self._Image_bao_money_1_t:ignoreContentAdaptWithSize(true)
        if EnlistData.m_CardType == 3 or EnlistData.m_CardType == 1 then
            Functions.initLabelOfString( self._Text_bao_money_1_t, tostring(g_SampleNewCfg.Money ))
            Functions.loadImageWithWidget(self._Image_bao_money_1_t, "commonUI/res/image/jinbi.png")
    	elseif EnlistData.m_CardType == 4 or EnlistData.m_CardType == 2 then
            Functions.initLabelOfString( self._Text_bao_money_1_t, tostring(g_SampleNewCfg.Gold ))
            Functions.loadImageWithWidget(self._Image_bao_money_1_t, "commonUI/res/image/bao.png")
        end

    elseif EnlistData.m_CardNum == 10 then
        self._Text_bao_money_2_t:ignoreContentAdaptWithSize(true)
        self._Image_bao_money_2_t:ignoreContentAdaptWithSize(true)
        if EnlistData.m_CardType == 3  then
            Functions.initLabelOfString( self._Text_bao_money_2_t, tostring(g_SampleNewCfg.TenMoney ))
            Functions.loadImageWithWidget(self._Image_bao_money_2_t, "commonUI/res/image/jinbi.png")
        elseif EnlistData.m_CardType == 4 then
            Functions.initLabelOfString( self._Text_bao_money_2_t, tostring(g_SampleNewCfg.TenGold ))
            Functions.loadImageWithWidget(self._Image_bao_money_2_t, "commonUI/res/image/bao.png")
        end
    end
end

function EnlistThreePopView:removeSprite()
    Functions.printInfo(self.debug,"removeSprite")
    --清空图片
    if self.sprite then
        self.sprite:removeSelf()
    end
    if self.spr then
        self.spr:removeSelf()
    end
    if self.spr2 then
        self.spr2:removeSelf()
    end
    
    if self.spriteOne then
        self.spriteOne:removeSelf()
    end

    self.spriteOne = nil
    self.spr = nil
    self.spr2 = nil
    self.sprite = nil
end

function EnlistThreePopView:Judge(num)
    Functions.printInfo(self.debug,"Judge")
    if HeroCardData:getAllHeroData() == nil then
        assert(HeroCardData:getAllHeroData(), "HeroCardData:getAllHeroData()".."数量为空")
        return
    end
    if #HeroCardData:getAllHeroData() + num > HeroCardData:getBagBaseSize() then
        PromptManager:openTipPrompt(LanguageConfig.language_Enlist_9)
        return true
    else
        return false
    end
end

return EnlistThreePopView