--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local EnhanceTwoPopView = class("EnhanceTwoPopView", BasePopView)

local Functions = require("app.common.Functions")

EnhanceTwoPopView.csbResPath = "lk/csb"
EnhanceTwoPopView.debug = true
EnhanceTwoPopView.studioSpriteFrames = {"CB_bgup","EnhanceTwoPopUI_Text","EnhanceOnePopUI_Text","CBO_cardglow","CBO_infor" }
--@auto code head end
--@Pre loading
EnhanceTwoPopView.spriteFrameNames = 
    {
        "heroCardRes","headPilistRes"
    }

EnhanceTwoPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #EnhanceTwoPopView.studioSpriteFrames > 0 then
    EnhanceTwoPopView.spriteFrameNames = EnhanceTwoPopView.spriteFrameNames or {}
    table.insertto(EnhanceTwoPopView.spriteFrameNames, EnhanceTwoPopView.studioSpriteFrames)
end
function EnhanceTwoPopView:onInitUI()

    --output list
    self._ProjectNode_head_crad8_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card8"):getChildByName("ProjectNode_head_crad8")
	self._Text_crad8_level_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_crad8_level")
	self._Text_introduce_ladder_2_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_introduce_ladder_2")
	self._ProjectNode_9_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card9"):getChildByName("ProjectNode_9")
	self._Text_up_class_num_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card9"):getChildByName("ProjectNode_9"):getChildByName("Text_up_class_num")
	self._ProjectNode_head_crad10_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card10"):getChildByName("ProjectNode_head_crad10")
	self._Text_crad10_level_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card10"):getChildByName("Text_crad10_level")
	self._Text_crad10_HP_num_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card10"):getChildByName("Text_crad10_HP_num")
	self._Text_crad10_ATK_num_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card10"):getChildByName("Text_crad10_ATK_num")
	self._Text_crad10_ling_bing_num_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card10"):getChildByName("Text_crad10_ling_bing_num")
	self._Text_crad10_chou_mou_num_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card10"):getChildByName("Text_crad10_chou_mou_num")
	self._Text_crad8_HP_num_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_crad8_HP_num")
	self._Text_crad8_ATK_num_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_crad8_ATK_num")
	self._Text_crad8_ling_bing_num_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_crad8_ling_bing_num")
	self._Text_crad8_chou_mou_num_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_crad8_chou_mou_num")
	self._Text_introduce_ladder_1_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_introduce_ladder_1")
	self._Text_introduce_ladder_3_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_introduce_ladder_3")
	self._Text_Two_cost_money_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_Two_cost_money")
	self._Text_Two_cost_money_num_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_Two_cost_money"):getChildByName("Text_Two_cost_money_num")
	self._Text_Two_cost_soul_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_Two_cost_soul")
	self._Text_Two_soul_num_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_Two_cost_soul"):getChildByName("Text_Two_soul_num")
	
    --label list
    self._Text_crad8_name_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_crad8_name")
	self._Text_crad8_name_t:setString(LanguageConfig.ui_Enhance_1)

	self._Text_crad8_HP_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_crad8_HP")
	self._Text_crad8_HP_t:setString(LanguageConfig.lk_common_1)

	self._Text_crad8_ATK_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_crad8_ATK")
	self._Text_crad8_ATK_t:setString(LanguageConfig.lk_common_2)

	self._Text_crad8_ling_bing_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_crad8_ling_bing")
	self._Text_crad8_ling_bing_t:setString(LanguageConfig.lk_common_3)

	self._Text_crad8_chou_mou_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Text_crad8_chou_mou")
	self._Text_crad8_chou_mou_t:setString(LanguageConfig.lk_common_4)

	self._Text_crad10_name_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card10"):getChildByName("Text_crad10_name")
	self._Text_crad10_name_t:setString(LanguageConfig.ui_Enhance_1)

	self._Text_crad10_HP_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card10"):getChildByName("Text_crad10_HP")
	self._Text_crad10_HP_t:setString(LanguageConfig.lk_common_1)

	self._Text_crad10_ATK_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card10"):getChildByName("Text_crad10_ATK")
	self._Text_crad10_ATK_t:setString(LanguageConfig.lk_common_2)

	self._Text_crad10_ling_bing_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card10"):getChildByName("Text_crad10_ling_bing")
	self._Text_crad10_ling_bing_t:setString(LanguageConfig.lk_common_3)

	self._Text_crad10_chou_mou_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card10"):getChildByName("Text_crad10_chou_mou")
	self._Text_crad10_chou_mou_t:setString(LanguageConfig.lk_common_4)
    --button list
    self._Button_card8_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card8")
	self._Button_card8_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card8Click), ""))

	self._Button_up_ladder_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_up_ladder")
	self._Button_up_ladder_t:onTouch(Functions.createClickListener(handler(self, self.onButton_up_ladderClick), ""))

	self._Button_card9_t = self.csbNode:getChildByName("Panel_jinjie"):getChildByName("Button_card9")
	self._Button_card9_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card9Click), ""))

	self._Button_up_close_t = self.csbNode:getChildByName("Button_up_close")
	self._Button_up_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_up_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_card8 btFunc
function EnhanceTwoPopView:onButton_card8Click()
    Functions.printInfo(self.debug,"Button_card8 button is click!")
    local datas = Functions.filterDatas(HeroCardData:getAllHeroData(), handler(HeroCardData, HeroCardData.saiXuan))
    if #datas >= 1 then
        EnhanceData.HeroShowType = 3
        GameCtlManager:push("app.ui.heroSystem.HeroViewController", {data = {}})
    else
        --提示玩家没有可以进阶的武将
        PromptManager:openTipPrompt(LanguageConfig.language_Hero_4)
    end

end
--@auto code Button_card8 btFunc end

--@auto code Button_card9 btFunc
function EnhanceTwoPopView:onButton_card9Click()
    Functions.printInfo(self.debug,"Button_card9 button is click!")
    
--    --如果没有主卡
--    if #EnhanceData.MasterData <= 0 then
--        --弹出报错信息
--        PromptManager:openTipPrompt("请先添加需要进阶的卡")
--    	return false
--    end
--    
--    EnhanceData.HeroShowType = 4
--    GameCtlManager:push("app.ui.heroSystem.HeroViewController", {data = {}})
end
--@auto code Button_card9 btFunc end

--@auto code Button_up_ladder btFunc
function EnhanceTwoPopView:onButton_up_ladderClick()
    Functions.printInfo(self.debug,"Button_up_ladder button is click!")
    if #EnhanceData.MasterData == 0 then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_11)
    	return false
    end
    local iiii = g_csBaseCfg.upLevel[EnhanceData.MasterData[1].m_class]
    local var = EnhanceData.MasterData[1].m_level
    if EnhanceData.MasterData[1].m_class > #g_csBaseCfg.upCardCount then
    	return false
    end
    local iiop = EnhanceData.MasterData[1].m_class
    local kkkkk = EnhanceData.MasterData[1].m_level
    local llll = #g_csBaseCfg.upLevel
    
    if EnhanceData.MasterData[1].m_class <= #g_csBaseCfg.upLevel and EnhanceData.MasterData[1].m_level < g_csBaseCfg.upLevel[EnhanceData.MasterData[1].m_class] then
        --弹出报错信息
        local level = g_csBaseCfg.upLevel[EnhanceData.MasterData[1].m_class]
        local str = string.format(LanguageConfig.language_Enhance_12, level)    --LanguageConfig.language_Enhance_12..tostring(level)..LanguageConfig.language_Enhance_13
        PromptManager:openTipPrompt(str)
        return false
    end
    --发送进阶
    local onSendChat = function(event)

        local _stype = event.stype --类型用来判断,1是进阶，其他是进化
        local _class = event.class --当前阶强化等级，如果为进化，则为0
        local _id = event.nid --进化后新卡ID
        local _mark = event.slot--标记
        local money = event.m_money
        local m_soul = event.m_soul

        PlayerData.eventAttr.m_money = event.m_money
        PlayerData.eventAttr.m_soul = m_soul
        
        local allCard = HeroCardData:getAllHeroData()
        local deputyCard = EnhanceData.DeputyData
        
        --删除绘制UI的副卡
        local calss = EnhanceData.MasterData[1].m_class
        if EnhanceData.MasterData[1].m_class > 2 then
        	HeroCardData:getSellHeroData(deputyCard)
        end
        
        --给卡包主数据赋值
        for k, v in pairs(allCard) do
            if v.m_mark == EnhanceData.MasterData[1].m_mark then
                if 1 == _stype then
                    v.m_class = _class
                    
                    local oooooo = v.m_hp
                        
                    --card base data
                    local param = {heroInfo = { id = v.m_id, level = v.m_level, class = v.m_class, attackEx = v.m_attackEx,
                        hpEx = v.m_hpEx, fasEx = v.m_fasEx, fafEx = v.m_fafEx }}
                        
                    v.m_baseCombat  = math.floor(cs_GetCardFightValue(param)) --卡牌战斗力
                    v.m_baseAttack  = math.floor(pm_GetCardAttack(param)) --卡牌攻击力
                    v.m_baseHp      = math.floor(pm_GetCardHp(param)) -- 卡牌血量
                    v.m_baseFas     = math.floor(pm_GetCardFas(param)) -- 卡牌法术
                    v.m_baseFaf     = math.floor(pm_GetCardFaf(param)) -- 卡牌法防

                    --进阶后改变主卡数据
                    EnhanceData:MasterCardData(param)
                elseif 2 == _stype then --进化要改变id
--                        v.m_class = _class
--                        v.m_id = _id
--                        
--                        --card base data
--                        local param = { id = v.m_id, level = v.m_level, class = v.m_class, soldier = v.m_soldier, attack = v.m_attack,
--                            mp = v.m_mp, hp = v.m_hp }
--                        v.m_baseCombat  = Functions.getCardFightValue(param) --卡牌战斗力
--                        v.m_baseAttack  = Functions.getCardAttackValue(param) --卡牌攻击力
--                        v.m_baseHp      = Functions.getCardHp(param) -- 卡牌血量
--                        v.m_baseMp      = Functions.getCardMp(param) -- 卡牌筹谋
--                        v.m_baseSoldier = Functions.getCardLeadSoldierNum(param) -- 卡牌领兵
--                        
--                        --进阶后改变主卡数据
--                        EnhanceData:MasterCardData(param)
                end
                allCard.m_exp = _exp
            end
        end
        
        Functions.getHeroCrad(self._ProjectNode_head_crad8_t, {mark = EnhanceData.MasterData[1].m_mark})

        self._Button_card9_t:getChildByName("ProjectNode_9"):setVisible(false)
        EnhanceData.DeputyData = {}
        
        self:showCardInfo_up_one()
        
        --打开进阶动画
        Functions.playSound("upgradeEffect.mp3")
        self._controller_t:openChildView("app.ui.popViews.EnhanceActionPopView")
        
        --卡包数据变动监听
        HeroCardData:cardsDataChange(EnhanceData.MasterData[1].m_mark)
    end

    local met = EnhanceData.DeputyData
    local metMark = {}
    for k, v in pairs(met) do
        metMark[#metMark+1] = v.m_mark
    end
    local _type = 1
    local m_class = EnhanceData.MasterData[1].m_class
    local m_mark = EnhanceData.MasterData[1].m_mark
    local ooo = EnhanceData.MasterData[1].m_mark
    
    
    NetWork:addNetWorkListener({ 5, 30 }, Functions.createNetworkListener(onSendChat,true,"ret"))
    NetWork:sendToServer({ idx = { 5, 30 }, slot = EnhanceData.MasterData[1].m_mark, metSlot = metMark, type = _type }) --type (1为进阶)
end
--@auto code Button_up_ladder btFunc end

--@auto code Button_up_close btFunc
function EnhanceTwoPopView:onButton_up_closeClick()
    Functions.printInfo(self.debug,"Button_up_close button is click!")
    --武将显示类型
    EnhanceData.HeroShowType = 0
    if self.type == 2 then
        --保存控制器
        --local controller = self._controller_t
        self._controller_t:closeChildView(self)
        --GameCtlManager:pop(controller)
        
    else
        self._controller_t:closeChildView(self)
    end
    EnhanceData.DeputyData = {}
    EnhanceData.MasterData = {}
end
--@auto code Button_up_close btFunc end

--@auto button backcall end


--@auto code output func
function EnhanceTwoPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function EnhanceTwoPopView:onDisplayView(...)
	Functions.printInfo(self.debug,"pop action finish ")
    self._Text_introduce_ladder_2_t:setVisible(false)
    self._Text_introduce_ladder_1_t:setVisible(false)
	local data = {...}
    self.type = data[1].type
    --等于1为升级，等于2为进阶
    if self.type == 2 then
        if #EnhanceData.MasterData <= 0 then
            return false
        end
        self:showCardInfo_up_one()
    end
    

    --监听函数
    local onJinJie_zhu = function(event)
    
        if #EnhanceData.MasterData <= 0 then
        	return false
        end
        self:showCardInfo_up_one()
    end
    Functions.bindEventListener(self.csbNode, GameEventCenter, EnhanceData.ENHANCE_JIN_JIE_ZHU, onJinJie_zhu)
    
    --监听函数
    local onJinJie_fu = function(event)
        if #EnhanceData.DeputyData <= 0 then
        return false
        end
        if EnhanceData.DeputyData[1].m_id > 0 then
            self._Button_card9_t:getChildByName("ProjectNode_9"):setVisible(true)

            Functions.initHeadComOfId(self._Button_card9_t:getChildByName("ProjectNode_9"), EnhanceData.DeputyData[1].m_id)
        end
    end
    Functions.bindEventListener(self.csbNode, GameEventCenter, EnhanceData.ENHANCE_JIN_JIE_FU, onJinJie_fu)
end

function EnhanceTwoPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function EnhanceTwoPopView:showCardInfo_up_one()
    Functions.printInfo(self.debug,"child class create call")
    if #EnhanceData.DeputyData <= 0 then
        self._Button_card9_t:getChildByName("ProjectNode_9"):setVisible(false)
    end
    --打开主卡的显示
    self._ProjectNode_head_crad8_t:setVisible(true)
    --要进阶的卡片
    Functions.getHeroCrad(self._ProjectNode_head_crad8_t, {mark = EnhanceData.MasterData[1].m_mark})
    --进阶后的卡片
    self._ProjectNode_head_crad10_t:setVisible(true)
    --展示卡片
    if EnhanceData.MasterData[1].m_class < #g_csBaseCfg.upCardCount+1 then
        Functions.getHeroCrad(self._ProjectNode_head_crad10_t, {heroInf = {id = EnhanceData.MasterData[1].m_id,level = EnhanceData.MasterData[1].m_level,
            class = EnhanceData.MasterData[1].m_class+1, soldier = EnhanceData.MasterData[1].m_fafEx,attack =  EnhanceData.MasterData[1].m_attackEx, 
            mp =  EnhanceData.MasterData[1].m_fasEx, hp = EnhanceData.MasterData[1].m_hpEx}})
    end
    --EnhanceData.MasterData[1].m_soldier + EnhanceData.MasterData[1].m_attack +  EnhanceData.MasterData[1].m_hp + EnhanceData.MasterData[1].m_mp +
    local data = HeroCardData:getHeroInfo(EnhanceData.MasterData[1].m_mark)
    
    local maxClass, milClass = Functions.formatHeroClass(data.m_class)
    local str = ""
    if milClass > 0 then
        str = ConfigHandler:getHeroNameOfId(data.m_id).."+"..tostring(milClass)
    else
        str = ConfigHandler:getHeroNameOfId(data.m_id)
    end
    Functions.initLabelOfString( self._Text_crad8_name_t, str )

        
    --第二张展示卡牌
    local param = {}
    local ooo = data.m_class
    local   pppppp = #g_csBaseCfg.upLevel
    if data.m_class >= #g_csBaseCfg.upLevel + 1 then   --进化数为最高说明是皇（已到最高阶，已不能进阶
    
        Functions.initLabelOfString(self._Text_crad8_level_t, "lv"..tostring(data.m_level), self._Text_crad8_name_t, str,
            self._Text_crad8_HP_num_t, math.floor(data.m_baseHp), self._Text_crad8_ATK_num_t, math.floor(data.m_baseAttack), 
            self._Text_crad8_ling_bing_num_t, math.floor(data.m_baseFas), self._Text_crad8_chou_mou_num_t, math.floor(data.m_baseFaf) )
            
    --展示卡片
        Functions.getHeroCrad(self._ProjectNode_head_crad10_t, {heroInf = {id = EnhanceData.MasterData[1].m_id,level = EnhanceData.MasterData[1].m_level,
            class = EnhanceData.MasterData[1].m_class, soldier = EnhanceData.MasterData[1].m_fafEx,attack =  EnhanceData.MasterData[1].m_attackEx, 
            mp =  EnhanceData.MasterData[1].m_fasEx, hp = EnhanceData.MasterData[1].m_hpEx}})
            
        self._Text_introduce_ladder_1_t:setVisible(false)
        self._Text_introduce_ladder_2_t:setVisible(false)
        self._Text_introduce_ladder_3_t:setVisible(true)
        --进阶到最高阶时把数量都置为零
        Functions.setEnabledBt(self._Button_up_ladder_t,false)
        Functions.setGraySprite(self._Button_up_ladder_t:getChildByName("Sprite_up_ladder"), true)
        Functions.initLabelOfString( self._Text_Two_cost_money_num_t,  0, self._Text_Two_soul_num_t, 0 )

        self._Text_Two_cost_money_t:setVisible(false)
        self._Text_Two_cost_soul_t:setVisible(false)

        return true
--        if  ConfigHandler:getHeroJinHuaNumOfId(data.m_id) == 7 then--进化数为7说明是皇（已到最高阶，已不能进阶）
--
--        else
--            param = { id = data.m_id + 1, level = data.m_level, class = 0, soldier = data.m_soldier, attack = data.m_attack,
--                mp = data.m_mp, hp = data.m_hp }
--            Functions.initLabelOfString(self._Text_crad10_level_t, "lv"..tostring(data.m_level), self._Text_crad10_name_t, ConfigHandler:getHeroNameOfId(data.m_id),
--                self._Text_crad10_HP_num_t, math.floor(Functions.getCardHp(param)), self._Text_crad10_ATK_num_t, math.floor(Functions.getCardAttackValue(param)), 
--                self._Text_crad10_ling_bing_num_t, math.floor(Functions.getCardLeadSoldierNum(param)), self._Text_crad10_chou_mou_num_t, math.floor(Functions.getCardMp(param)) )
--    
--        end
    else
        self._Text_Two_cost_money_t:setVisible(true)
        self._Text_Two_cost_soul_t:setVisible(true)

        self._Text_introduce_ladder_1_t:setVisible(true)
        self._Text_introduce_ladder_2_t:setVisible(true)
        self._Text_introduce_ladder_3_t:setVisible(false)
        param = { id = data.m_id, level = data.m_level, class = data.m_class + 1, attackEx = data.m_attackEx, fasEx = data.m_fasEx, 
        hpEx = data.m_hpEx, fafEx = data.m_fafEx }

        local total,att,hp,fas,faf = cs_GetCardFightValue({heroInfo = param})
        
        local max, mil = Functions.formatHeroClass(data.m_class+1)
        
        local str = ""
        if mil > 0 then
            str = ConfigHandler:getHeroNameOfId(data.m_id).."+"..tostring(mil)
        else
            str = ConfigHandler:getHeroNameOfId(data.m_id)
        end
        
        Functions.initLabelOfString(self._Text_crad10_level_t, "lv"..tostring(data.m_level), self._Text_crad10_name_t, str,
            self._Text_crad10_HP_num_t, hp, self._Text_crad10_ATK_num_t, att, self._Text_crad10_ling_bing_num_t, fas, self._Text_crad10_chou_mou_num_t, faf )

    end
    
    Functions.initLabelOfString(self._Text_crad8_level_t, "lv"..tostring(data.m_level), self._Text_crad8_name_t, str,
        self._Text_crad8_HP_num_t, math.floor(data.m_baseHp), self._Text_crad8_ATK_num_t, math.floor(data.m_baseAttack), 
        self._Text_crad8_ling_bing_num_t, math.floor(data.m_baseFas), self._Text_crad8_chou_mou_num_t, math.floor(data.m_baseFaf) )
        
    local info = HeroCardData:getHeroInfo(EnhanceData.MasterData[1].m_mark)
    local _money = cs_GetRoleJinJie(info.m_class,info.m_class,ConfigHandler:getHeroStarOfId(info.m_id))
    local idx = EnhanceData.MasterData[1].m_class
    Functions.initLabelOfString( self._Text_Two_cost_money_num_t,  g_csBaseCfg.upMoney[idx], self._Text_Two_soul_num_t, g_csBaseCfg.upSoul[idx] )
    
    
    local hero = HeroCardData:getAllHeroData()
    --需要的副卡数量
    local cardNum = g_csBaseCfg.upCardCount[EnhanceData.MasterData[1].m_class]
    --副卡的总数量
    local count = 0
    EnhanceData.DeputyData = {}
    
   --在武将里挑选副卡
    local Num = g_csBaseCfg.upCardCount[EnhanceData.MasterData[1].m_class]
    for k, v in pairs(hero) do
        --阶数小于2不需要副卡
        if Num > 0 then
            --不为主卡,不为上阵武将，不为正在做主城任务和卡，才能加数量
            local taskHreo = CityData:getTaskHoreInfo()
            local _task = true
            for q,w in pairs(taskHreo) do
                if v.m_mark == w then
            		_task = fasle
            		break
            	end
            end
            if _task and v.m_id == EnhanceData.MasterData[1].m_id and v.m_atkFormFlag == 0 and v.m_defFormFlag == 0 and v.m_mark ~= EnhanceData.MasterData[1].m_mark then
                
                --if v.m_mark ~= EnhanceData.MasterData[1].m_mark then
                    if cardNum > 0 then
                        EnhanceData.DeputyData[#EnhanceData.DeputyData + 1] = v
                    end
                    cardNum = cardNum - 1
                    count = count + 1
                --end。
            end
        end
    end  
    
    Functions.initLabelOfString( self._Text_up_class_num_t, tostring(count).."/"..tostring(Num) )
    
    local ladder = EnhanceData.MasterData[1].m_class
    local LV = tostring(g_csBaseCfg.upLevel[ladder])
    
    if EnhanceData.MasterData[1].m_level < g_csBaseCfg.upLevel[ladder] then
        self._Text_introduce_ladder_2_t:setColor(cc.c3b(255, 0, 0))
    end
    self._Text_introduce_ladder_2_t:setText(LV)
    
--    self._Text_introduce_ladder_1_t:setVisible(true)
--    self._Text_introduce_ladder_2_t:setVisible(true)
    
    if Num > 0 then
        self._Button_card9_t:getChildByName("ProjectNode_9"):setVisible(true)
        Functions.initHeadComOfId(self._Button_card9_t:getChildByName("ProjectNode_9"), EnhanceData.MasterData[1].m_id)
        self._Button_card9_t:setVisible(true)

    else
        self._Button_card9_t:setVisible(false)
    end
        
        

    for k, v in pairs(hero) do
        --阶数小于2不需要副卡
        if EnhanceData.MasterData[1].m_class > 2 then
            if hero[k].m_id == EnhanceData.MasterData[1].m_id then
                self._Button_card9_t:getChildByName("ProjectNode_9"):setVisible(true)
                Functions.initHeadComOfId(self._Button_card9_t:getChildByName("ProjectNode_9"), EnhanceData.MasterData[1].m_id)
                --self._Text_introduce_ladder_1_t:setText("需要相同的武将")
                local count = g_csBaseCfg.upCardCount[EnhanceData.MasterData[1].m_class]
            end
        else
            --self._Text_introduce_ladder_1_t:setText("不需要任何的武将")
            break
        end
    end   
end

function EnhanceTwoPopView:showCardInfo_up_two()
    Functions.printInfo(self.debug,"child class create call ")
end

--@aut

return EnhanceTwoPopView