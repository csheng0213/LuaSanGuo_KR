--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local ExpTransferPopView = class("ExpTransferPopView", BasePopView)

local Functions = require("app.common.Functions")

ExpTransferPopView.csbResPath = "lk/csb"
ExpTransferPopView.debug = true
ExpTransferPopView.studioSpriteFrames = {"UnionUI","CB_bgup","EnhanceTwoPopUI_Text","EnhanceOnePopUI_Text","CBO_cardglow","CBO_infor" }
--@auto code head end

ExpTransferPopView.spriteFrameNames = 
    {
        "headPilistRes"
    }
    
ExpTransferPopView.animaNames = 
    {
        "An_card"
    }

--@auto code uiInit
--add spriteFrames
if #ExpTransferPopView.studioSpriteFrames > 0 then
    ExpTransferPopView.spriteFrameNames = ExpTransferPopView.spriteFrameNames or {}
    table.insertto(ExpTransferPopView.spriteFrameNames, ExpTransferPopView.studioSpriteFrames)
end
function ExpTransferPopView:onInitUI()

    --output list
    self._ProjectNode_head_crad8_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card8"):getChildByName("ProjectNode_head_crad8")
	self._Text_crad8_level_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Text_crad8_level")
	self._Image_item_9_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card9"):getChildByName("Image_item_9")
	self._ProjectNode_head_crad10_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10"):getChildByName("ProjectNode_head_crad10")
	self._Text_crad10_level_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10"):getChildByName("Text_crad10_level")
	self._Text_crad10_HP_num_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10"):getChildByName("Text_crad10_HP_num")
	self._Text_crad10_ATK_num_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10"):getChildByName("Text_crad10_ATK_num")
	self._Text_crad10_ling_bing_num_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10"):getChildByName("Text_crad10_ling_bing_num")
	self._Text_crad10_chou_mou_num_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10"):getChildByName("Text_crad10_chou_mou_num")
	self._Text_crad8_HP_num_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Text_crad8_HP_num")
	self._Text_crad8_ATK_num_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Text_crad8_ATK_num")
	self._Text_crad8_ling_bing_num_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Text_crad8_ling_bing_num")
	self._Text_crad8_chou_mou_num_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Text_crad8_chou_mou_num")
	self._Text_EXP_explain_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Text_EXP_explain")
	
    --label list
    self._Text_crad8_name_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Text_crad8_name")
	self._Text_crad8_name_t:setString(LanguageConfig.ui_Enhance_1)

	self._Text_crad8_HP_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Text_crad8_HP")
	self._Text_crad8_HP_t:setString(LanguageConfig.lk_common_1)

	self._Text_crad8_ATK_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Text_crad8_ATK")
	self._Text_crad8_ATK_t:setString(LanguageConfig.lk_common_2)

	self._Text_crad8_ling_bing_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Text_crad8_ling_bing")
	self._Text_crad8_ling_bing_t:setString(LanguageConfig.lk_common_3)

	self._Text_crad8_chou_mou_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Text_crad8_chou_mou")
	self._Text_crad8_chou_mou_t:setString(LanguageConfig.lk_common_4)

	self._Text_crad10_name_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10"):getChildByName("Text_crad10_name")
	self._Text_crad10_name_t:setString(LanguageConfig.ui_Enhance_1)

	self._Text_crad10_HP_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10"):getChildByName("Text_crad10_HP")
	self._Text_crad10_HP_t:setString(LanguageConfig.lk_common_1)

	self._Text_crad10_ATK_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10"):getChildByName("Text_crad10_ATK")
	self._Text_crad10_ATK_t:setString(LanguageConfig.lk_common_2)

	self._Text_crad10_ling_bing_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10"):getChildByName("Text_crad10_ling_bing")
	self._Text_crad10_ling_bing_t:setString(LanguageConfig.lk_common_3)

	self._Text_crad10_chou_mou_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10"):getChildByName("Text_crad10_chou_mou")
	self._Text_crad10_chou_mou_t:setString(LanguageConfig.lk_common_4)
    --button list
    self._Button_card8_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card8")
	self._Button_card8_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card8Click), ""))

	self._Button_up_ladder_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_up_ladder")
	self._Button_up_ladder_t:onTouch(Functions.createClickListener(handler(self, self.onButton_up_ladderClick), ""))

	self._Button_card9_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card9")
	self._Button_card9_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card9Click), "zoom"))

	self._Button_card10_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_card10")
	self._Button_card10_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card10Click), ""))

	self._Button_close_t = self.csbNode:getChildByName("Panel_transfer"):getChildByName("Button_close")
	self._Button_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_card8 btFunc
function ExpTransferPopView:onButton_card8Click()
    Functions.printInfo(self.debug,"Button_card8 button is click!")
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController", {data = {jumpType = JumpType.ExpChangeToSelectHero,jumpData = {heroType = 3}}})
end
--@auto code Button_card8 btFunc end

--@auto code Button_up_ladder btFunc
function ExpTransferPopView:onButton_up_ladderClick()
    Functions.printInfo(self.debug,"Button_up_ladder button is click!")
    if ExpTransferData:getMarkTwo() == 0 or ExpTransferData:getMarkOne() == 0 then
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_11)
        return
    end
    --弹出框
    NoticeManager:openTips(self:getController(), { handler = handler(self,self.tanChu), title = LanguageConfig.language_ExpTransfer_4})
end
--@auto code Button_up_ladder btFunc end

--@auto code Button_card9 btFunc
function ExpTransferPopView:onButton_card9Click()
    Functions.printInfo(self.debug,"Button_card9 button is click!")
    GameCtlManager:push("app.ui.propSystem.PropViewController", {data = {jumpType = JumpType.ExpChangeToProp}})
    
end
--@auto code Button_card9 btFunc end

--@auto code Button_card10 btFunc
function ExpTransferPopView:onButton_card10Click()
    Functions.printInfo(self.debug,"Button_card10 button is click!")
    if ExpTransferData:getMarkOne() == 0 then
        --提示让玩家选择第一张武将
    else
        GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController", {data = {jumpType = JumpType.ExpChangeToSelectHero,jumpData = {heroType = 4}}})
    end
    
end
--@auto code Button_card10 btFunc end

--@auto code Button_close btFunc
function ExpTransferPopView:onButton_closeClick()
    Functions.printInfo(self.debug,"Button_close button is click!")
    --关闭时记录全部清空
    ExpTransferData:setMarkOne(0)
    ExpTransferData:setMarkTwo(0)
    self.close(self)
end
--@auto code Button_close btFunc end

--@auto button backcall end


--@auto code output func
function ExpTransferPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function ExpTransferPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    --转移的比例数
    self.proportion = g_roleExpMoveConfig.base
    local str = string.format(LanguageConfig.language_ExpTransfer_1, self.proportion) 
    self._Text_EXP_explain_t:setString(str)
	
    --监听函数
    local onChecked = function(event) 
        --（类型5为选择武将，6为选择道具）
        if event.data.jumpType == 6 then
            self.propId = event.data.jumpData.propId
            self.proportion = g_roleExpMoveConfig.base
            
            --转移的比例数
            if self.propId ~= nil then
                self.proportion = self.proportion + g_roleExpMoveConfig.items[self.propId]
                Functions.loadImageWithWidget(self._Image_item_9_t, ConfigHandler:getPropImageOfId(self.propId))
            end 
            local str = string.format(LanguageConfig.language_ExpTransfer_1, self.proportion) 
            self._Text_EXP_explain_t:setString(str)
            
            if ExpTransferData:getMarkOne() ~= 0 then
                self:showOne(ExpTransferData:getMarkOne())
            end
            
            if ExpTransferData:getMarkTwo() ~= 0 then
                self:showTwo(ExpTransferData:getMarkTwo())
            end
            
        elseif event.data.jumpType == 5 then
            if event.data.jumpData.heroType == 3 then
                local markOne = event.data.jumpData.heroMark
                ExpTransferData:setMarkOne(markOne)
                self:showOne(markOne)
                if ExpTransferData:getMarkTwo() ~= 0 then
                    self:showTwo(ExpTransferData:getMarkTwo())
                end
            elseif event.data.jumpData.heroType == 4 then
                local markTwo = event.data.jumpData.heroMark
                ExpTransferData:setMarkTwo(markTwo)
                self:showTwo(markTwo)
            end
        end
    end
    Functions.bindEventListener(self, GameEventCenter, ExpTransferData.EXP_HERO, onChecked)
end

function ExpTransferPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function ExpTransferPopView:showOne(mark)
    Functions.printInfo(self.debug,"showOne")
    local info = HeroCardData:getHeroInfo(mark)
    --打开主卡的显示
    self._ProjectNode_head_crad8_t:setVisible(true)
    Functions.getHeroCrad(self._ProjectNode_head_crad8_t, {mark = mark})
    
    --展示卡片

--    Functions.getHeroCrad(self._ProjectNode_head_crad8_t, {heroInf = {id = info.m_id,level = info.m_level,
--        class = info.m_class, soldier = info.m_fafEx,attack = info.m_attackEx, 
--        mp = info.m_fasEx, hp = info.m_hpEx}})


    local maxClass, milClass = Functions.formatHeroClass(info.m_class)
    local str = ""
    if milClass > 0 then
        str = ConfigHandler:getHeroNameOfId(info.m_id).."+"..tostring(milClass)
    else
        str = ConfigHandler:getHeroNameOfId(info.m_id)
    end
    Functions.initLabelOfString( self._Text_crad8_name_t, str )
    
    local param = { id = info.m_id, level = info.m_level, class = info.m_class, attackEx = info.m_attackEx, fasEx = info.m_fasEx, 
        hpEx = info.m_hpEx, fafEx = info.m_fafEx }

    local total,att,hp,fas,faf = cs_GetCardFightValue({heroInfo = param})
    
    Functions.initLabelOfString(self._Text_crad8_level_t, "lv"..tostring(info.m_level), self._Text_crad8_name_t, str,
        self._Text_crad8_HP_num_t, hp, self._Text_crad8_ATK_num_t, att, self._Text_crad8_ling_bing_num_t, fas, self._Text_crad8_chou_mou_num_t, faf )
        
end

function ExpTransferPopView:showTwo(mark)
    Functions.printInfo(self.debug,"showTwo")
    local info = HeroCardData:getHeroInfo(mark)
    --展示卡片
    --转移后的卡片
    self._ProjectNode_head_crad10_t:setVisible(true)
    local level = self:showCardTwoExp(mark)
    Functions.getHeroCrad(self._ProjectNode_head_crad10_t, {heroInf = {id = info.m_id,level = level,
        class = info.m_class, soldier = info.m_fafEx,attack = info.m_attackEx, 
        mp = info.m_fasEx, hp = info.m_hpEx}})
        
    local maxClass, milClass = Functions.formatHeroClass(info.m_class)
    local str = ""
    if milClass > 0 then
        str = ConfigHandler:getHeroNameOfId(info.m_id).."+"..tostring(milClass)
    else
        str = ConfigHandler:getHeroNameOfId(info.m_id)
    end
    Functions.initLabelOfString( self._Text_crad10_name_t, str )
    
    local param = { id = info.m_id, level = level, class = info.m_class, attackEx = info.m_attackEx, fasEx = info.m_fasEx, 
        hpEx = info.m_hpEx, fafEx = info.m_fafEx }

    local total,att,hp,fas,faf = cs_GetCardFightValue({heroInfo = param})
        
        
    Functions.initLabelOfString(self._Text_crad10_level_t, "lv"..tostring(level), self._Text_crad10_name_t, str,
        self._Text_crad10_HP_num_t, hp, self._Text_crad10_ATK_num_t, att, self._Text_crad10_ling_bing_num_t, fas, self._Text_crad10_chou_mou_num_t, faf )
        
end

--接受转移提升到的等级
function ExpTransferPopView:showCardTwoExp(mark)
    Functions.printInfo(self.debug,"allCardExp")

    local cardInfo = HeroCardData:getHeroInfo(mark)

    local i_exp = cardInfo.m_exp    --当前主卡的经验和等级
    local lv = cardInfo.m_level
    if lv <= 0 then
        return false
    end

    local _iExp = 0 -- 本级所需经验

    repeat

        _iExp = _iExp + g_roleCardUp[lv]  
        if ((_iExp - i_exp) <= self:getCardOneExp()) then
            lv = lv + 1
        else
            lv = lv 
--            if lv > 1 then
--                lv = lv - 1   --卡片为了获取下一级经验，等级多加了一，所以这里要减一
--            else
--                lv = lv 
--            end    
        end

    until ((_iExp - i_exp) > self:getCardOneExp() or lv > #g_roleCardUp)
    --不能大于当前配置等级
    if lv > #g_roleCardUp then
    	lv = #g_roleCardUp
    end
    return lv
end

--接受转移提升的经验
function ExpTransferPopView:getCardOneExp()

    local mark = ExpTransferData:getMarkOne()
    local cardInfo = HeroCardData:getHeroInfo(mark)
    
    local exp = cardInfo.m_exp    --当前被转移武将的经验和等级
    local lv = cardInfo.m_level-1
    for k = 1, lv do
        exp = exp + g_roleCardUp[k]
    end

    return (exp * (self.proportion / 100))
end

--转移后ui改变
function ExpTransferPopView:showCard()
    self.propId = nil
    self.proportion = g_roleExpMoveConfig.base
    self:showOne(ExpTransferData:getMarkOne())
    self:showTwo(ExpTransferData:getMarkTwo())
    if self.heroNode ~= nil then
        self.heroNode:setVisible(false)
    end
    Functions.playAnimationWithRemove(self._ProjectNode_head_crad10_t,"An_card",0,0)
    
    Functions.loadImageWithWidget(self._Image_item_9_t, "commonUI/res/icons/adddd.png")

    local str = string.format(LanguageConfig.language_ExpTransfer_1, self.proportion) 
    self._Text_EXP_explain_t:setString(str)
    --弹出报错信息
    PromptManager:openTipPrompt(LanguageConfig.language_ExpTransfer_3)
--    local buff = string.format( LanguageConfig.language_ExpTransfer_2)
--    NoticeManager:openTips(GameCtlManager:getCurrentController(), { type = 5, title = buff })
end

--弹出框
function ExpTransferPopView:tanChu()

    local level = self:showCardTwoExp(ExpTransferData:getMarkTwo())
    if level >= PlayerData.eventAttr.m_level then
        --弹出框
        NoticeManager:openTips(self:getController(), { handler = handler(self,self.sendExp), title = LanguageConfig.language_ExpTransfer_5})
    else
        self:sendExp()
    end
end

--弹出框
function ExpTransferPopView:sendExp()
    local data = {makeOne = ExpTransferData:getMarkOne(), makeTwo = ExpTransferData:getMarkTwo(), itemId = self.propId}
    ExpTransferData:SendExpTransfer(data, handler(self, self.showCard))
end
return ExpTransferPopView