--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UseExpCardPopView = class("UseExpCardPopView", BasePopView)

local Functions = require("app.common.Functions")

UseExpCardPopView.csbResPath = "tyj/csb"
UseExpCardPopView.debug = true
UseExpCardPopView.studioSpriteFrames = {"UseExpCardPopUI","CB_bgup","CBO_cardglow","PropUI","CBO_infor" }
--@auto code head end
UseExpCardPopView.spriteFrameNames = 
    {
        "heroCardRes","headPilistRes"
    }

--@auto code uiInit
--add spriteFrames
if #UseExpCardPopView.studioSpriteFrames > 0 then
    UseExpCardPopView.spriteFrameNames = UseExpCardPopView.spriteFrameNames or {}
    table.insertto(UseExpCardPopView.spriteFrameNames, UseExpCardPopView.studioSpriteFrames)
end
function UseExpCardPopView:onInitUI()

    --output list
    self._Panel_add_crad_t = self.csbNode:getChildByName("Panel_add_crad")
	self._ProjectNode_head_card1_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card1"):getChildByName("ProjectNode_head_card1")
	self._levelPanel_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("levelPanel")
	self._LoadingBar_2_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("levelPanel"):getChildByName("Sprite_bar_bg"):getChildByName("LoadingBar_2")
	self._LoadingBar_1_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("levelPanel"):getChildByName("Sprite_bar_bg"):getChildByName("LoadingBar_1")
	self._attributePanel_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("attributePanel")
	self._Text_get_EXP_num_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Sprite_get_EXP_1"):getChildByName("Text_get_EXP_num")
	self._Text_cost_money_num_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Sprite_cost_money"):getChildByName("Text_cost_money_num")
	self._rewardPanel_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("rewardPanel")
	self._sellNum_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("rewardPanel"):getChildByName("sellNum")
	self._propView_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("rewardPanel"):getChildByName("propView")
	self._propName_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("rewardPanel"):getChildByName("propName")
	self._propNum_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("rewardPanel"):getChildByName("propNum")
	self._Particle_li_zi_guang_t = self.csbNode:getChildByName("Particle_li_zi_guang")
	
    --label list
    self._Text_crad_name_1_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_name_1")
	self._Text_crad_name_1_t:setString(LanguageConfig.ui_Enhance_1)

	self._Text_crad_up_string_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("levelPanel"):getChildByName("Text_crad_up_string")
	self._Text_crad_up_string_t:setString(LanguageConfig.ui_Enhance_2)

	self._Text_crad_HP_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("attributePanel"):getChildByName("Text_crad_HP")
	self._Text_crad_HP_t:setString(LanguageConfig.lk_common_1)

	self._Text_crad_ATK_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("attributePanel"):getChildByName("Text_crad_ATK")
	self._Text_crad_ATK_t:setString(LanguageConfig.lk_common_2)

	self._Text_crad_ling_bing_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("attributePanel"):getChildByName("Text_crad_ling_bing")
	self._Text_crad_ling_bing_t:setString(LanguageConfig.lk_common_3)

	self._Text_crad_chou_mou_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("attributePanel"):getChildByName("Text_crad_chou_mou")
	self._Text_crad_chou_mou_t:setString(LanguageConfig.lk_common_4)
    --button list
    self._Button_card1_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card1")
	self._Button_card1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card1Click), ""))

	self._Button_up_level_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_up_level")
	self._Button_up_level_t:onTouch(Functions.createClickListener(handler(self, self.onButton_up_levelClick), "zoom"))

	self._closeBt_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))

	self._addBt_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("rewardPanel"):getChildByName("addBt")
	self._addBt_t:onTouch(Functions.createClickListener(handler(self, self.onAddbtClick), ""))

	self._miuBt_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("rewardPanel"):getChildByName("miuBt")
	self._miuBt_t:onTouch(Functions.createClickListener(handler(self, self.onMiubtClick), ""))

	self._miu10Bt_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("rewardPanel"):getChildByName("miu10Bt")
	self._miu10Bt_t:onTouch(Functions.createClickListener(handler(self, self.onMiu10btClick), ""))

	self._add10Bt_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("rewardPanel"):getChildByName("add10Bt")
	self._add10Bt_t:onTouch(Functions.createClickListener(handler(self, self.onAdd10btClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_card1 btFunc
function UseExpCardPopView:onButton_card1Click()
    Functions.printInfo(self.debug,"Button_card1 button is click!")
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data = {jumpType = JumpType.HeroUpgradeToSelectHero,jumpData={heroType = 4}}})
end
--@auto code Button_card1 btFunc end

--@auto code Button_up_level btFunc
function UseExpCardPopView:onButton_up_levelClick()
    Functions.printInfo(self.debug,"Button_up_level button is click!")
    if self.heroMark < 1 then
    	PromptManager:openTipPrompt(LanguageConfig.language_Enhance_2)
    	return
    end
    local heroInfo = HeroCardData:getHeroInfo(self.heroMark)
    local lv = heroInfo.m_level
    local exp = self.curPropNum * g_expCardData[self.propId]
    if (lv == PlayerData.eventAttr.m_level) and (exp > (g_roleCardUp[lv] - heroInfo.m_exp)) then
        --弹出提示信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_3)
        return false
    end
    if lv > PlayerData.eventAttr.m_level then
        --弹出提示信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_3)
        return false
    end
    if (lv < PlayerData.eventAttr.m_level) and self.curLevel  > PlayerData.eventAttr.m_level then
        --弹出框
        NoticeManager:openTips(self:getController(), { handler = handler(self,self.sendCardUPLevel), title = LanguageConfig.language_Enhance_16})
        return true
    end 
    self:sendCardUPLevel()
end
--@auto code Button_up_level btFunc end

--@auto code Closebt btFunc
function UseExpCardPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
     self:close()
end
--@auto code Closebt btFunc end

--@auto code Addbt btFunc
function UseExpCardPopView:onAddbtClick()
    Functions.printInfo(self.debug,"Addbt button is click!")
     if PropData:getPropNumOfId(self.propId) > self.curPropNum then
    	self.curPropNum = self.curPropNum + 1
    	self:updateDisplay()
    end
end
--@auto code Addbt btFunc end

--@auto code Miubt btFunc
function UseExpCardPopView:onMiubtClick()
    Functions.printInfo(self.debug,"Miubt button is click!")
     if self.curPropNum > 1 then
    	self.curPropNum = self.curPropNum - 1
    	self:updateDisplay()
    end
end
--@auto code Miubt btFunc end

--@auto code Miu10bt btFunc
function UseExpCardPopView:onMiu10btClick()
    Functions.printInfo(self.debug,"Miu10bt button is click!")
    if self.curPropNum > 10 then
    	self.curPropNum = self.curPropNum - 10
    else
    	if PropData:getPropNumOfId(self.propId) < 1 then 
    		self.curPropNum = 0
    	else
    		self.curPropNum = 1
    	end
    end
    self:updateDisplay()
end
--@auto code Miu10bt btFunc end

--@auto code Add10bt btFunc
function UseExpCardPopView:onAdd10btClick()
    Functions.printInfo(self.debug,"Add10bt button is click!")
    if PropData:getPropNumOfId(self.propId) - self.curPropNum > 10 then
    	self.curPropNum = self.curPropNum + 10
    else
    	self.curPropNum = PropData:getPropNumOfId(self.propId)
    end
     self:updateDisplay()
end
--@auto code Add10bt btFunc end

--@auto button backcall end


--@auto code output func
function UseExpCardPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UseExpCardPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	self._Text_crad_name_1_t:setColor(cc.c3b(255,165,0))
	self._Particle_li_zi_guang_t:stopSystem()
	self.propId = data[1]
	self.heroMark = 0 
	self.curPropNum = 0
    self.curLevel = 0
    Functions.bindEventListener(self, GameEventCenter, "PROP_DATA_CHANGE", function (event)
        self.heroMark = event.data.jumpData.heroMark
        self:initDisplay()
    end)
    self:initDisplay()
end

function UseExpCardPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function UseExpCardPopView:initDisplay()
	if self.propId ~= nil then 
		self._propName_t:setString(ConfigHandler:getPropNameOfId(self.propId))
		Functions.loadImageWithWidget(self._propView_t,ConfigHandler:getPropImageOfId(self.propId))
		self.curPropNum = PropData:getPropNumOfId(self.propId)
	    self._propNum_t:setString("x".. tostring(self.curPropNum))
        if self.curPropNum > 0 then
			self.curPropNum = 1
		end
	end
	if self.heroMark > 0 then 
		Functions.getHeroCrad(self._ProjectNode_head_card1_t,{mark = self.heroMark})
		self._ProjectNode_head_card1_t:setVisible(true)
		Functions.setHeroNameOfMark(self._Text_crad_name_1_t,self.heroMark)
		self._levelPanel_t:setVisible(true)
	else
		self._ProjectNode_head_card1_t:setVisible(false)
		self._Text_crad_name_1_t:setString(LanguageConfig.ui_Enhance_1)
		self._levelPanel_t:setVisible(false)
	end
	self:updateDisplay()
end
function UseExpCardPopView:updateDisplay( )
	self._sellNum_t:setString(tostring(self.curPropNum))
    local addExp = self.curPropNum * g_expCardData[self.propId]
	local consumMoney = addExp * 10 
	self._Text_get_EXP_num_t:setString(tostring(addExp))
	self._Text_cost_money_num_t:setString(tostring(consumMoney))
	if self.heroMark > 0 then 
		self.curLevel = Functions.allCardExp( self.heroMark, addExp, self._LoadingBar_1_t, self._LoadingBar_2_t)
        self:setHeroLevel(self.curLevel )
        self:setHeroAttr()
	end
end
function UseExpCardPopView:setHeroLevel(newLevel)
	self._levelPanel_t:getChildByName("Text_crad_level"):setString(tostring(HeroCardData:getHeroInfo(self.heroMark).m_level))
	self._levelPanel_t:getChildByName("Text_crad_up_level"):setString(newLevel)
end
function UseExpCardPopView:setHeroAttr()
	local heroInfo = HeroCardData:getHeroInfo(self.heroMark)
	self._attributePanel_t:getChildByName("Text_crad_HP_num"):setString(tostring(heroInfo.m_baseHp))
	self._attributePanel_t:getChildByName("Text_crad_ATK_num"):setString(tostring(heroInfo.m_baseAttack))
	self._attributePanel_t:getChildByName("Text_crad_ling_bing_num"):setString(tostring(heroInfo.m_baseFas))
	self._attributePanel_t:getChildByName("Text_crad_chou_mou_num"):setString(tostring(heroInfo.m_baseFaf))
end
function UseExpCardPopView:sendCardUPLevel()
	 local handler = function(event)
    	local callBack = function( )
             self:initDisplay()
    	end
    	if event.amount > 0 then 
    		Functions.level_Animation(self.heroMark, event.amount, self._Particle_li_zi_guang_t, self._attributePanel_t:getChildByName("Text_crad_chou_mou_num"), callBack)
    	else
    		self:initDisplay()
    	end
    	PromptManager:openTipPrompt(LanguageConfig.language_Teach42)
    end
    PropData:requestUseExpCard(self.heroMark,self.propId,self.curPropNum,handler)
end
return UseExpCardPopView