--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local HeroUpgradePopView = class("HeroUpgradePopView", BasePopView)

local Functions = require("app.common.Functions")

HeroUpgradePopView.csbResPath = "tyj/csb"
HeroUpgradePopView.debug = true
HeroUpgradePopView.studioSpriteFrames = {"HeroUpgradePopUI","CB_bgup","CBO_cardglow","PropUI","CBO_infor" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #HeroUpgradePopView.studioSpriteFrames > 0 then
    HeroUpgradePopView.spriteFrameNames = HeroUpgradePopView.spriteFrameNames or {}
    table.insertto(HeroUpgradePopView.spriteFrameNames, HeroUpgradePopView.studioSpriteFrames)
end
function HeroUpgradePopView:onInitUI()

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
function HeroUpgradePopView:onButton_card1Click()
    Functions.printInfo(self.debug,"Button_card1 button is click!")
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data = {jumpType = JumpType.HeroUpgradeToSelectHero,jumpData={heroType = 4}}})
end
--@auto code Button_card1 btFunc end

--@auto code Button_up_level btFunc
function HeroUpgradePopView:onButton_up_levelClick()
    Functions.printInfo(self.debug,"Button_up_level button is click!")
     local handler = function(event)
    	local callBack = function( )
    		HeroCardData:addHeroCardLevel(self.heroMark,event.amount)
    		local heroInfo = HeroCardData:getHeroInfo(self.heroMark)
    		local packageHeroInfo = EnhanceData:getParam(heroInfo)
    		EnhanceData:setHeroAttr(heroInfo, packageHeroInfo)
    	end
    	Functions.level_Animation(self.heroMark, event.amount, self._Particle_li_zi_guang_t, self._Text_crad_chou_mou_t, callBack)
    end
    PropData:requestUseExpCard(self.heroMark,self.propId,self.curPropNum,handler)
end
--@auto code Button_up_level btFunc end

--@auto code Closebt btFunc
function HeroUpgradePopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
        self:close()
end
--@auto code Closebt btFunc end

--@auto code Addbt btFunc
function HeroUpgradePopView:onAddbtClick()
    Functions.printInfo(self.debug,"Addbt button is click!")
    if PropData:getPropNumOfId(self.propId) > self.curPropNum then
    	self.curPropNum = self.curPropNum + 1
    	self:updateDisplay()
    end
end
--@auto code Addbt btFunc end

--@auto code Miubt btFunc
function HeroUpgradePopView:onMiubtClick()
    Functions.printInfo(self.debug,"Miubt button is click!")
     if self.curPropNum > 1 then
    	self.curPropNum = self.curPropNum - 1
    	self:updateDisplay()
    end
end
--@auto code Miubt btFunc end

--@auto code Miu10bt btFunc
function HeroUpgradePopView:onMiu10btClick()
    Functions.printInfo(self.debug,"Miu10bt button is click!")
       if self.curPropNum > 10 then
    	self.curPropNum = self.curPropNum - 10
    else
    	self.curPropNum = 1
    end
    self:updateDisplay()
end
--@auto code Miu10bt btFunc end

--@auto code Add10bt btFunc
function HeroUpgradePopView:onAdd10btClick()
    Functions.printInfo(self.debug,"Add10bt button is click!")
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
function HeroUpgradePopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function HeroUpgradePopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	self._Particle_li_zi_guang_t:resetSystem()
	self._Particle_li_zi_guang_t:setDuration(2)
	self.propId = data[1]
	self.curPropNum = 0
    self.curExp = 0
    self.heroMark = 0 
    Functions.bindEventListener(self, GameEventCenter, "PROP_DATA_CHANGE", function (event)
        self.heroMark = event.data.jumpData.heroMark
        self:initDisplay()
    end)
    self:initDisplay()
end
function HeroUpgradePopView:initDisplay()
	if self.propId ~= nil then 
		self._propName_t:setString(ConfigHandler:getPropNameOfId(self.propId))
		Functions.loadImageWithWidget(self._propView_t,ConfigHandler:getPropImageOfId(self.propId))
		self.curPropNum = PropData:getPropNumOfId(self.propId)
        self._propNum_t:setString("x".. tostring(self.curPropNum))
        self.curExp = ConfigHandler:getPropPriceOfId(self.propId)
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
function HeroUpgradePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function HeroUpgradePopView:updateDisplay( )
	self._sellNum_t:setString(tostring(self.curPropNum))
    local addExp = self.curPropNum * g_expCardData[self.propId]
	local consumMoney = addExp * 10 
	self._Text_get_EXP_num_t:setString(tostring(addExp))
	self._Text_cost_money_num_t:setString(tostring(consumMoney))
	if self.heroMark > 0 then 
		local curLevel = Functions.allCardExp( self.heroMark, addExp, self._LoadingBar_1_t, self._LoadingBar_2_t)
        self:setHeroLevel(curLevel)
        self:setHeroAttr()
	end
end
function HeroUpgradePopView:setHeroLevel(newLevel)
	self._levelPanel_t:getChildByName("Text_crad_level"):setString(tostring(HeroCardData:getHeroInfo(self.heroMark).m_level))
	self._levelPanel_t:getChildByName("Text_crad_up_level"):setString(newLevel)
end
function HeroUpgradePopView:setHeroAttr()
	local heroInfo = HeroCardData:getHeroInfo(self.heroMark)
	self._attributePanel_t:getChildByName("Text_crad_HP_num"):setString(tostring(heroInfo.m_baseHp))
	self._attributePanel_t:getChildByName("Text_crad_ATK_num"):setString(tostring(heroInfo.m_baseAttack))
	self._attributePanel_t:getChildByName("Text_crad_ling_bing_num"):setString(tostring(heroInfo.m_baseFas))
	self._attributePanel_t:getChildByName("Text_crad_chou_mou_num"):setString(tostring(heroInfo.m_baseFaf))
end
return HeroUpgradePopView