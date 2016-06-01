--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local CardInfoPopView = class("CardInfoPopView", BasePopView)

local Functions = require("app.common.Functions")

CardInfoPopView.csbResPath = "lk/csb"
CardInfoPopView.debug = true
CardInfoPopView.studioSpriteFrames = {"CardInfoPopUI_Text" }
--@auto code head end

--@Pre loading
CardInfoPopView.spriteFrameNames = 
    {
        "heroCardRes"
    }

CardInfoPopView.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #CardInfoPopView.studioSpriteFrames > 0 then
    CardInfoPopView.spriteFrameNames = CardInfoPopView.spriteFrameNames or {}
    table.insertto(CardInfoPopView.spriteFrameNames, CardInfoPopView.studioSpriteFrames)
end
function CardInfoPopView:onInitUI()

    --output list
    self._ProjectNode_card_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ProjectNode_card")
	self._ScrollView_info_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info")
	self._Panel_skill_show_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show")
	self._Image_line_3_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Image_line_3")
	self._Image_line_4_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Image_line_4")
	self._Text_wu_li_num_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_wu_li_num")
	self._Text_zhi_li_num_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_zhi_li_num")
	self._Text_tong_yu_num_2_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_tong_yu_num_2")
	self._Text_HP_num_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_HP_num")
	self._Text_ATK_num_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ATK_num")
	self._Text_CM_num_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_CM_num")
	self._Text_LB_num_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_LB_num")
	self._Text_LB_string_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_LB_string")
	self._Text_ji_nen_name_1_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_name_1")
	self._Text_ji_nen_string_1_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_string_1")
	self._Text_ji_nen_name_2_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_name_2")
	self._Text_ji_nen_string_2_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_string_2")
	self._Text_yuan_fen_name_1_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_yuan_fen_name_1")
	self._Text_yuan_fen_string_1_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_yuan_fen_string_1")
	self._Text_yuan_fen_name_2_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_yuan_fen_name_2")
	self._Text_yuan_fen_string_2_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_yuan_fen_string_2")
	self._Text_card_Description_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_card_Description")
	self._Text_ji_nen_name_3_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_name_3")
	self._Text_ji_nen_string_3_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_string_3")
	self._Text_ji_nen_name_4_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_name_4")
	self._Text_ji_nen_string_4_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_string_4")
	self._Text_ji_nen_name_5_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_name_5")
	self._Text_ji_nen_string_5_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_string_5")
	
    --label list
    self._Text_ji_nen_name_bei_2_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_name_bei_2")
	self._Text_ji_nen_name_bei_2_t:setString(LanguageConfig.language_CardIn_3)

	self._Text_ji_nen_name_bei_3_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_name_bei_3")
	self._Text_ji_nen_name_bei_3_t:setString(LanguageConfig.language_CardIn_3)

	self._Text_ji_nen_name_bei_4_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("ScrollView_info"):getChildByName("Panel_skill_show"):getChildByName("Text_ji_nen_name_bei_4")
	self._Text_ji_nen_name_bei_4_t:setString(LanguageConfig.language_CardIn_3)
    --button list
    self._Button_close_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("Button_close")
	self._Button_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_closeClick), "zoom"))

	self._Button_sheng_ji_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("Button_sheng_ji")
	self._Button_sheng_ji_t:onTouch(Functions.createClickListener(handler(self, self.onButton_sheng_jiClick), "zoom"))

	self._Button_jin_jie_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("Button_jin_jie")
	self._Button_jin_jie_t:onTouch(Functions.createClickListener(handler(self, self.onButton_jin_jieClick), "zoom"))

	self._Button_get_card_3_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("Button_get_card_3")
	self._Button_get_card_3_t:onTouch(Functions.createClickListener(handler(self, self.onButton_get_card_3Click), "zoom"))

	self._Button_big_card_t = self.csbNode:getChildByName("Panel_card_info"):getChildByName("Button_big_card")
	self._Button_big_card_t:onTouch(Functions.createClickListener(handler(self, self.onButton_big_cardClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_close btFunc
function CardInfoPopView:onButton_closeClick()
    Functions.printInfo(self.debug,"Button_close button is click!")
    local _type = false
    if self.type == 1 then
        _type = true
    end
    self._controller_t:closeChildView(self)
    if _type then
        --数据更新监听
        GameEventCenter:dispatchEvent({ name = HeroCardData.CARDS_ENHANCE})
    end
end
--@auto code Button_close btFunc end

--@auto code Button_sheng_ji btFunc
function CardInfoPopView:onButton_sheng_jiClick()
    Functions.printInfo(self.debug,"Button_sheng_ji button is click!")
    EnhanceData.MasterData = {}
    EnhanceData.MasterData[#EnhanceData.MasterData + 1]  = self.card
    --先跳转到升级的控制器，再转到弹出框
    --打开升级
    self._controller_t:openChildView("app.ui.popViews.EnhanceOnePopView",{data = {type = 1}, isRemove = false})
    --GameCtlManager:push("app.ui.enhanceSystem.EnhanceViewController", {data = {type = 1}})  --type 为1时为升级
end
--@auto code Button_sheng_ji btFunc end

--@auto code Button_jin_jie btFunc
function CardInfoPopView:onButton_jin_jieClick()
    Functions.printInfo(self.debug,"Button_jin_jie button is click!")

    if self.card.m_class == #g_csBaseCfg.upLevel+1 then
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_14)
    	return
    end
    EnhanceData.MasterData = {}
    EnhanceData.MasterData[#EnhanceData.MasterData + 1]  = self.card
    --先跳转到升级的控制器，再转到弹出框
    --打开进阶
    self._controller_t:openChildView("app.ui.popViews.EnhanceTwoPopView",{data = {type = 2}, isRemove = false})
    --GameCtlManager:push("app.ui.enhanceSystem.EnhanceViewController", {data = {type = 2}})  --type 为2时为进阶
end
--@auto code Button_jin_jie btFunc end

--@auto code Button_get_card_3 btFunc
function CardInfoPopView:onButton_get_card_3Click()
    Functions.printInfo(self.debug,"Button_get_card_3 button is click!")
    if self.type == 4 then
        local CompoundData = CompoundData:getCompoundData()
        local Switch = true
        for k, v in pairs(CompoundData) do
            if v.m_id == self.PokedexId then
                Switch = false
                --如果可以合成，跳转到合成界面，不能合成跳转到获得界面
                if v.m_compound == 0  then
                    self:openChildView("app.ui.popViews.CompoundPopView", { data = v })
                elseif v.m_compound == 1  then
                    GameCtlManager:push("app.ui.compoundSystem.CompoundViewController")
                end
                break
        	end
        end
        --如果没有碎片
        if Switch then
            self._controller_t:openChildView("app.ui.popViews.CompoundPopView", { data = {m_id = self.PokedexId, m_possessCount = 0}})
        end
    end
end
--@auto code Button_get_card_3 btFunc end

--@auto code Button_big_card btFunc
function CardInfoPopView:onButton_big_cardClick()
    Functions.printInfo(self.debug,"Button_big_card button is click!")
    if self.m_state == 0 then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_BigCard_1)
    else
        if self.type == 4 then
            self.card.m_class = self.n_class
        end
        self._controller_t:openChildView("app.ui.popViews.BigCardPopView", {data = {card = self.card} })
    end
    
end
--@auto code Button_big_card btFunc end

--@auto button backcall end


--@auto code output func
function CardInfoPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function CardInfoPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	--type为2和3时不显示升级，进阶（类型为3时代表数据从商店，积分商城传过来，为4时，代表数据从图鉴过来）
    --type为3时显示的是不存在于背包的卡的详细信息，所以需要虚拟一份数据用来显示。
    
    self.type = data[2]
    if self.type == 4 then
    	self.PokedexId = data[1]
        self.m_state = data[4]
    end
    
    
    if self.type == 2 or self.type == 3 or self.type == 4 then
    	self._Button_sheng_ji_t:setVisible(false)
        self._Button_jin_jie_t:setVisible(false)
        --self._Button_get_card_3_t:setVisible(true)
        --获得这张卡的数据
        if self.type == 2 then
            self.card = data[1]--HeroCardData:getHeroInfo(data[1])
        elseif self.type == 3 or self.type == 4 then
            --card base data
            self.n_class = 1
            if self.type == 4 then
                self.n_class = data[3]
            end
            --class是算武将生命，攻击等属性的值。self.n_class是用来看大图时传到大图里面的阶级。所以class只能是1，而self.n_class要的是真实数据
            local param           = { id = data[1], level = 1, class = 1 }
            local cardInfo        = {}
            cardInfo.m_id         = data[1]
            cardInfo.m_class      = 1
            cardInfo.m_baseCombat = cs_GetCardFightValue({ heroInfo = param}) --卡牌战斗力
            cardInfo.m_baseAttack = pm_GetCardAttack({ heroInfo = param}) --卡牌攻击力
            cardInfo.m_baseHp     = pm_GetCardHp({ heroInfo = param})   -- 卡牌血量
            cardInfo.m_baseFas    = pm_GetCardFas({ heroInfo = param})  -- 卡牌筹谋
            cardInfo.m_baseFaf    = pm_GetCardFaf({ heroInfo = param})  -- 卡牌领兵
            
            self.card             = cardInfo
        end

    elseif self.type == 1 then
        self.card = data[1]
    end

    self:setShow(self.card)
    
    --监听函数
    local onCard_info = function(event)
        local hero_info = HeroCardData:getHeroInfo(event.data)
        self:setShow(hero_info)
    end
    Functions.bindEventListener(self, GameEventCenter, HeroCardData.CARDS_DATA_CHANGE_EVENT, onCard_info)

end

function CardInfoPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")

end
--@auto code output func end

function CardInfoPopView:setShow(cardInfo)
    Functions.printInfo(self.debug,"child class create call ")
    local star = ConfigHandler:getHeroStarOfId(cardInfo.m_id) 
    if star < 6 then
        self._Button_big_card_t:setVisible(false)
    end
    if self.type == 3 or self.type == 4 then
        local pppppp = cardInfo.m_class 
        --为了图鉴的显示，这里武将阶级要设置成1
        Functions.getHeroCrad(self._ProjectNode_card_t, { id = cardInfo.m_id, class = 1})--cardInfo.m_class 
    else
        Functions.getHeroCrad(self._ProjectNode_card_t, { mark = cardInfo.m_mark })
    end
    
    Functions.initLabelOfString( self._Text_HP_num_t, cardInfo.m_baseHp, self._Text_ATK_num_t, cardInfo.m_baseAttack, self._Text_CM_num_t, cardInfo.m_baseFas, 
        self._Text_LB_num_t, cardInfo.m_baseFaf,  self._Text_LB_string_t, 
        ConfigHandler:getHeroZxNameOfId(cardInfo.m_id).."   "..ConfigHandler:getZxDescriptionOfHeroId(cardInfo.m_id),
        self._Text_card_Description_t, ConfigHandler:getHeroDescriptionId(cardInfo.m_id),
        self._Text_wu_li_num_t, ConfigHandler:getHeroWuliId(cardInfo.m_id), self._Text_zhi_li_num_t, ConfigHandler:getHeroZhiliId(cardInfo.m_id), 
        self._Text_tong_yu_num_2_t, ConfigHandler:getHeroTongyuId(cardInfo.m_id)
    )
    self:showSkill(cardInfo)
end

function CardInfoPopView:showSkill(cardInfo)
    Functions.printInfo(self.debug,"showSkill")
    --算出技能的坐标
    self.hangY = 0
    local rows = 0
    self.hangX = 0
    
    --技能id
    local skillId = ConfigHandler:getHeroSkillId(cardInfo.m_id, cardInfo.m_class)
    local skillDatas = ConfigHandler:getSkillInfos(skillId.mSpellId[1])

    self.hangY = self._Text_ji_nen_name_1_t:getPositionY()
    self.hangX = self._Text_ji_nen_name_1_t:getPositionX()+80
    local aappppaa = self.hangX
    
    local skillStr = self:skillText(skillDatas)
    self.hangY = self.hangY - 28
    self._Text_ji_nen_string_1_t:setPosition(self.hangX, self.hangY)
    
    local H = math.floor(self.hangY - self:rowsNum(skillStr,45))
    Functions.initTextSize(self._Text_ji_nen_string_1_t, { width = 320, height = H})
    Functions.initLabelOfString(self._Text_ji_nen_name_1_t, skillDatas["技能名字"], self._Text_ji_nen_string_1_t, skillStr, self._Text_ji_nen_name_5_t,
        LanguageConfig.language_CardIn_4, self._Text_ji_nen_string_5_t, LanguageConfig.language_CardIn_5)--LanguageConfig.language_CardIn_1

    --算出武将进化数，用来确定有几个被动技能
    --local ladder = ConfigHandler:getHeroJinHuaNumOfId(cardInfo.m_id)
    if skillId.passiveSpellId1 == nil or skillId.passiveSpellId1 == 0 then
        local test = self.hangY
        self._Text_ji_nen_name_5_t:setVisible(true)
        self._Text_ji_nen_string_5_t:setVisible(true)
        self._Text_ji_nen_name_5_t:setPositionY(self.hangY)
        
        local aaaa = self.hangX
        self.hangY = self.hangY - 28
        self._Text_ji_nen_string_5_t:setPosition(self.hangX, self.hangY)
        
        H = math.floor(self.hangY - self:rowsNum(LanguageConfig.language_CardIn_5,45))
        Functions.initTextSize(self._Text_ji_nen_string_5_t, { width = 320, height = H})
        
    end
    if skillId.passiveSpellId1 ~= nil and skillId.passiveSpellId1 > 0 then
        self._Text_ji_nen_name_5_t:setVisible(false)
        self._Text_ji_nen_string_5_t:setVisible(false)
        self._Text_ji_nen_name_2_t:setVisible(true)
        self._Text_ji_nen_name_bei_2_t:setVisible(true)
        self._Text_ji_nen_string_2_t:setVisible(true)
        self._Text_ji_nen_name_2_t:setPositionY(self.hangY)
        self._Text_ji_nen_name_bei_2_t:setPositionY(self.hangY)
            self.hangY = self.hangY - 28
            self._Text_ji_nen_string_2_t:setPosition(self.hangX, self.hangY)
        
        --skillId = ConfigHandler:getHeroSkillId(cardInfo.m_id, cardInfo.m_class)
        skillStr = ConfigHandler:getPassiveSkillTextId(skillId.passiveSpellId1)
        H = math.floor(self.hangY - self:rowsNum(skillStr,45))
        Functions.initTextSize(self._Text_ji_nen_string_2_t, { width = 320, height = H})
        
        Functions.initLabelOfString(self._Text_ji_nen_name_bei_2_t, LanguageConfig.language_CardIn_3)
        Functions.initLabelOfString(self._Text_ji_nen_name_2_t, ConfigHandler:getPassiveSkillNameId(skillId.passiveSpellId1), self._Text_ji_nen_string_2_t, skillStr)

    end    
    if skillId.passiveSpellId2 ~= nil and skillId.passiveSpellId2 > 0 then
        self._Text_ji_nen_name_3_t:setVisible(true)
        self._Text_ji_nen_name_bei_3_t:setVisible(true)
        self._Text_ji_nen_string_3_t:setVisible(true)
        self._Text_ji_nen_name_bei_3_t:setPositionY(self.hangY)
        self._Text_ji_nen_name_3_t:setPositionY(self.hangY)
            self.hangY = self.hangY - 28
            self._Text_ji_nen_string_3_t:setPosition(self.hangX, self.hangY)

        --skillId = ConfigHandler:getHeroPassiveSkillTwoId(cardInfo.m_id)
        skillStr = ConfigHandler:getPassiveSkillTextId(skillId.passiveSpellId2)
        H = math.floor(self.hangY - self:rowsNum(skillStr,45))
        Functions.initTextSize(self._Text_ji_nen_string_3_t, { width = 320, height = H})
            Functions.initLabelOfString(self._Text_ji_nen_name_bei_3_t, LanguageConfig.language_CardIn_3)
        Functions.initLabelOfString(self._Text_ji_nen_name_3_t, ConfigHandler:getPassiveSkillNameId(skillId.passiveSpellId2), self._Text_ji_nen_string_3_t, skillStr)
    end
    if skillId.passiveSpellId3 ~= nil and skillId.passiveSpellId3 > 0 then
        self._Text_ji_nen_name_4_t:setVisible(true)
        self._Text_ji_nen_name_bei_4_t:setVisible(true)
        self._Text_ji_nen_string_4_t:setVisible(true)
        self._Text_ji_nen_name_bei_4_t:setPositionY(self.hangY)
        self._Text_ji_nen_name_4_t:setPositionY(self.hangY)
        self.hangY = self.hangY - 28
        self._Text_ji_nen_string_4_t:setPosition(self.hangX, self.hangY)

        --skillId = ConfigHandler:getHeroPassiveSkillTwoId(cardInfo.m_id)
        skillStr = ConfigHandler:getPassiveSkillTextId(skillId.passiveSpellId3)
        H = math.floor(self.hangY - self:rowsNum(skillStr,45))
        Functions.initTextSize(self._Text_ji_nen_string_4_t, { width = 320, height = H})
        Functions.initLabelOfString(self._Text_ji_nen_name_bei_4_t, LanguageConfig.language_CardIn_3)
        Functions.initLabelOfString(self._Text_ji_nen_name_4_t, ConfigHandler:getPassiveSkillNameId(skillId.passiveSpellId3), self._Text_ji_nen_string_4_t, skillStr)
    end
    
    self.hangY = self.hangY - 15
    if ConfigHandler:getHeroFateInfosOfId(cardInfo.m_id) then
        self._Image_line_3_t:setPositionY(self.hangY)
        self.hangY = self.hangY - 25
        self._Text_yuan_fen_name_1_t:setPositionY(self.hangY)
        self._Text_yuan_fen_string_1_t:setPositionY(self.hangY)
        self.hangY = self.hangY - 25
        self._Text_yuan_fen_name_2_t:setPositionY(self.hangY)
        self._Text_yuan_fen_string_2_t:setPositionY(self.hangY)
        self.hangY = self.hangY - 25
        --缘份id
        
        Functions.initLabelOfString(self._Text_yuan_fen_name_1_t, ConfigHandler:getFateName1OfId(cardInfo.m_id), self._Text_yuan_fen_name_2_t, ConfigHandler:getFateName2OfId(cardInfo.m_id),
            self._Text_yuan_fen_string_1_t, ConfigHandler:getFateInf1OfId(cardInfo.m_id), self._Text_yuan_fen_string_2_t, ConfigHandler:getFateInf2OfId(cardInfo.m_id))
    else
        self._Image_line_3_t:setVisible(false)
        self._Text_yuan_fen_name_1_t:setVisible(false)
        self._Text_yuan_fen_string_1_t:setVisible(false)
        self._Text_yuan_fen_name_2_t:setVisible(false)
        self._Text_yuan_fen_string_2_t:setVisible(false)
    end

    self._Image_line_4_t:setPositionY(self.hangY)
    self.hangY = self.hangY - 15
    self._Text_card_Description_t:setPositionY(self.hangY)

    skillStr = ConfigHandler:getHeroDescriptionId(cardInfo.m_id)
    --self:rowsNum(skillStr,63)
    H = math.floor(self.hangY - self:rowsNum(skillStr,63))
    Functions.initTextSize(self._Text_card_Description_t, { width = 420, height = H})
    Functions.initLabelOfString(self._Text_card_Description_t, skillStr)
    local data = self._ScrollView_info_t:getInnerContainerSize()
    --self._ScrollView_info_t:getInnerContainer():setAnchorPoint({ x = 0, y = 1 })
    data.height = data.height - self.hangY

    self._ScrollView_info_t:setInnerContainerSize(data)
    local achoPos = self._ScrollView_info_t:getInnerContainer():getPositionY()
    self._Panel_skill_show_t:setPosition(cc.p(0,data.height))
end

function CardInfoPopView:rowsNum(str,wordNum)
    Functions.printInfo(self.debug,"rowsNum")
    local num = #str
    local pppppp1 = self.hangY
    if (num % wordNum) ~= 0 then
        local iiiiiiii = math.floor(num / wordNum)
        self.hangY = self.hangY - (math.floor(num / wordNum) + 1) * 28
    else
        self.hangY = self.hangY - math.floor(num / wordNum) * 28
    end
    return math.floor(self.hangY)
end

function CardInfoPopView:skillText(skillDatas)
    Functions.printInfo(self.debug,"skillText")
    local skillStr = skillDatas["技能描述"]--LanguageConfig.language_CardIn_2
    return skillStr
end

return CardInfoPopView