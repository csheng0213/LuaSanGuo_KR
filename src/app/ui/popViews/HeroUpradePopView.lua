--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local HeroUpradePopView = class("HeroUpradePopView", BasePopView)

local Functions = require("app.common.Functions")

HeroUpradePopView.csbResPath = "tyj/csb"
HeroUpradePopView.debug = true
HeroUpradePopView.studioSpriteFrames = {"CB_bgup","CBO_cardglow","PropUI","HeroUpgradePopUI","CBO_infor" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #HeroUpradePopView.studioSpriteFrames > 0 then
    HeroUpradePopView.spriteFrameNames = HeroUpradePopView.spriteFrameNames or {}
    table.insertto(HeroUpradePopView.spriteFrameNames, HeroUpradePopView.studioSpriteFrames)
end
function HeroUpradePopView:onInitUI()

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
function HeroUpradePopView:onButton_card1Click()
    Functions.printInfo(self.debug,"Button_card1 button is click!")
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data = {jumpType = JumpType.HeroUpgradeToSelectHero}})
end
--@auto code Button_card1 btFunc end

--@auto code Button_up_level btFunc
function HeroUpradePopView:onButton_up_levelClick()
    Functions.printInfo(self.debug,"Button_up_level button is click!")
    local handler = function(event)
    	local callBack = function( )
    		HeroCardData:addHeroCardLevel(self.heroMark,event.amount)
    		HeroCardData:cardsDataChange(self.heroMark)
    	end
    	Functions.level_Animation(self.heroMark, event.amount, self._Particle_li_zi_guang_t, self._Text_crad_chou_mou_t, callBack)
    end
    PropData:requestUseExpCard(self.heroMark,self.propId,self.curPropNum,handler)
end
--@auto code Button_up_level btFunc end

--@auto code Addbt btFunc
function HeroUpradePopView:onAddbtClick()
    Functions.printInfo(self.debug,"Addbt button is click!")
    if PropData:getPropNumOfId(self.propId) > self.curPropNum then
    	self.curPropNum = self.curPropNum + 1
    	self:updateDisplay()
    end
end
--@auto code Addbt btFunc end

--@auto code Miubt btFunc
function HeroUpradePopView:onMiubtClick()
    Functions.printInfo(self.debug,"Miubt button is click!")
    if self.curPropNum > 1 then
    	self.curPropNum = self.curPropNum - 1
    	self:updateDisplay()
    end
end
--@auto code Miubt btFunc end

--@auto code Miu10bt btFunc
function HeroUpradePopView:onMiu10btClick()
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
function HeroUpradePopView:onAdd10btClick()
    Functions.printInfo(self.debug,"Add10bt button is click!")
    if PropData:getPropNumOfId(self.propId) - self.curPropNum > 10 then
    	self.curPropNum = self.curPropNum + 10
    else
    	self.curPropNum = PropData:getPropNumOfId(self.propId)
    end
     self:updateDisplay()
end
--@auto code Add10bt btFunc end

--@auto code Closebt btFunc
function HeroUpradePopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:close()
end
--@auto code Closebt btFunc end

--@auto button backcall end


--@auto code output func
function HeroUpradePopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function HeroUpradePopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	self.propId = data[1]
	self.curPropNum = 0
    self.curExp = 0
    self.heroMark = 0 
	
end
function HeroUpradePopView:initDisplay()
	if self.propId ~= nil then 
		self._propName_t:setString(ConfigHandler:getPropNameOfId(self.propId))
		Functions.loadImageWithWidget(self._propView_t,ConfigHandler:getPropImageOfId(self.propId))
		self.curPropNum = PropData:getPropNumOfId(self.propId)
		self._propNum_t:setString(self.curPropNum)
        self.curExp = ConfigHandler:getPropPriceOfId(self.propId)
	end
	if self.heroMark > 0 then 
		Functions.getHeroCrad(self._ProjectNode_head_card1_t,{mark = self.heroMark})
		self._levelPanel_t:setVisible(true)
	else
		self._levelPanel_t:setVisible(false)
	end
	self:updateDisplay()
end
function HeroUpradePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function HeroUpradePopView:updateDisplay( )
	self._sellNum_t:setString(tostring(self.curPropNum))
	local addExp = self.propNum * g_expCardData[self.propId]
	local consumMoney = addExp * 10 
	self._Text_get_EXP_num_t:setString(tostring(addExp))
	self._Text_cost_money_num_t:setString(tostring(consumMoney))
	if self.heroMark > 0 then 
		Functions.allCardExp( self.heroMark, addExp, self._LoadingBar_1_t, self._LoadingBar_2_t)
	end
end
--接受选将子场景数据
function SellPropPopView:onReceivePopData(jump)
	self.heroMark = jump.jumpData.heroMark
end
return HeroUpradePopView