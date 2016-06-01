--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local EnhanceOnePopView = class("EnhanceOnePopView", BasePopView)

local Functions = require("app.common.Functions")

EnhanceOnePopView.csbResPath = "lk/csb"
EnhanceOnePopView.debug = true
EnhanceOnePopView.studioSpriteFrames = {"CB_bgup","EnhanceOnePopUI_Text","CBO_cardglow","CBO_infor" }
--@auto code head end
--@Pre loading
EnhanceOnePopView.spriteFrameNames = 
    {
        "heroCardRes","headPilistRes"
    }

EnhanceOnePopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #EnhanceOnePopView.studioSpriteFrames > 0 then
    EnhanceOnePopView.spriteFrameNames = EnhanceOnePopView.spriteFrameNames or {}
    table.insertto(EnhanceOnePopView.spriteFrameNames, EnhanceOnePopView.studioSpriteFrames)
end
function EnhanceOnePopView:onInitUI()

    --output list
    self._Panel_add_crad_t = self.csbNode:getChildByName("Panel_add_crad")
	self._ProjectNode_head_card1_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card1"):getChildByName("ProjectNode_head_card1")
	self._Text_crad_level_text_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_level_text")
	self._Text_crad_level_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_level")
	self._LoadingBar_2_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Sprite_bar_bg"):getChildByName("LoadingBar_2")
	self._LoadingBar_1_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Sprite_bar_bg"):getChildByName("LoadingBar_1")
	self._Text_crad_up_level_text_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_up_level_text")
	self._Text_crad_up_level_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_up_level")
	self._Text_crad_up_num_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_up_num")
	self._Text_crad_HP_num_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_HP_num")
	self._Text_crad_ATK_num_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_ATK_num")
	self._Text_crad_ling_bing_num_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_ling_bing_num")
	self._Text_crad_chou_mou_num_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_chou_mou_num")
	self._Sprite_card_add_2_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card2"):getChildByName("Sprite_card_add_2")
	self._Sprite_card_add_3_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card3"):getChildByName("Sprite_card_add_3")
	self._Sprite_card_add_4_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card4"):getChildByName("Sprite_card_add_4")
	self._Sprite_card_add_5_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card5"):getChildByName("Sprite_card_add_5")
	self._Sprite_card_add_6_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card6"):getChildByName("Sprite_card_add_6")
	self._Sprite_card_add_7_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card7"):getChildByName("Sprite_card_add_7")
	self._Text_get_EXP_num_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Sprite_get_EXP_1"):getChildByName("Text_get_EXP_num")
	self._Text_cost_money_num_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Sprite_cost_money"):getChildByName("Text_cost_money_num")
	self._Particle_li_zi_guang_t = self.csbNode:getChildByName("Particle_li_zi_guang")
	self._Panel_Action_t = self.csbNode:getChildByName("Panel_Action")
	
    --label list
    self._Text_crad_name_1_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_name_1")
	self._Text_crad_name_1_t:setString(LanguageConfig.ui_Enhance_1)

	self._Text_crad_up_string_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_up_string")
	self._Text_crad_up_string_t:setString(LanguageConfig.ui_Enhance_2)

	self._Text_crad_HP_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_HP")
	self._Text_crad_HP_t:setString(LanguageConfig.lk_common_1)

	self._Text_crad_ATK_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_ATK")
	self._Text_crad_ATK_t:setString(LanguageConfig.lk_common_2)

	self._Text_crad_ling_bing_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_ling_bing")
	self._Text_crad_ling_bing_t:setString(LanguageConfig.lk_common_3)

	self._Text_crad_chou_mou_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Text_crad_chou_mou")
	self._Text_crad_chou_mou_t:setString(LanguageConfig.lk_common_4)
    --button list
    self._Button_card1_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card1")
	self._Button_card1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card1Click), ""))

	self._Button_auto_add_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_auto_add")
	self._Button_auto_add_t:onTouch(Functions.createClickListener(handler(self, self.onButton_auto_addClick), "zoom"))

	self._Button_up_level_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_up_level")
	self._Button_up_level_t:onTouch(Functions.createClickListener(handler(self, self.onButton_up_levelClick), "zoom"))

	self._Button_card2_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card2")
	self._Button_card2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card2Click), ""))

	self._Button_card3_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card3")
	self._Button_card3_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card3Click), ""))

	self._Button_card4_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card4")
	self._Button_card4_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card4Click), ""))

	self._Button_card5_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card5")
	self._Button_card5_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card5Click), ""))

	self._Button_card6_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card6")
	self._Button_card6_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card6Click), ""))

	self._Button_card7_t = self.csbNode:getChildByName("Panel_add_crad"):getChildByName("Button_card7")
	self._Button_card7_t:onTouch(Functions.createClickListener(handler(self, self.onButton_card7Click), ""))

	self._Button_sheng_ji_close_t = self.csbNode:getChildByName("Button_sheng_ji_close")
	self._Button_sheng_ji_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_sheng_ji_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_card1 btFunc
function EnhanceOnePopView:onButton_card1Click()
    Functions.printInfo(self.debug,"Button_card1 button is click!")
    if #EnhanceData.DeputyData > 0 then
        local card_fu = EnhanceData.DeputyData
        for k, v in pairs(card_fu) do
            local str = ("_Button_card"..tostring(k+1).."_t")

            self[str]:getChildByName(("Text_card_name_"..tostring(k+1))):setVisible(false)
            self[str]:getChildByName(("ProjectNode_head_icon_"..tostring(k+1))):setVisible(false)
        end
    end
    EnhanceData.DeputyData = {}
    self:getCardExp()
    --升级所需要的钱数 参数为（副卡的总经验，主卡的等级）
    self._money = self:getCardExp() * g_csBaseCfg.CardMoney
    Functions.initLabelOfString( self._Text_get_EXP_num_t, self:getCardExp(), self._Text_cost_money_num_t, self._money)
    --self:showCardInfo_level_fu()

    EnhanceData.HeroShowType = 1
    GameCtlManager:push("app.ui.heroSystem.HeroViewController", {data = {}})
end
--@auto code Button_card1 btFunc end
 
--@auto code Button_auto_add btFunc
function EnhanceOnePopView:onButton_auto_addClick()
    Functions.printInfo(self.debug,"Button_auto_add button is click!")
    if EnhanceData.MasterData == nil or #EnhanceData.MasterData <= 0 then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_2)
        return false
    end
    if EnhanceData.MasterData[1].m_level >= PlayerData.eventAttr.m_level then
        --弹出提示信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_3)
        return false
    end
    if #EnhanceData.MasterData > 0 then
        self:AutoAdd()
    end
end
--@auto code Button_auto_add btFunc end

--@auto code Button_up_level btFunc
function EnhanceOnePopView:onButton_up_levelClick()
    Functions.printInfo(self.debug,"Button_up_level button is click!")
    if #EnhanceData.MasterData <= 0 then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_2)
        return false
    elseif #EnhanceData.DeputyData <= 0 then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_4)
        return false
    end
    local lv = EnhanceData.MasterData[1].m_level
    if (lv == PlayerData.eventAttr.m_level) and (self:getCardExp() > (g_roleCardUp[lv] - EnhanceData.MasterData[1].m_exp)) then
        --弹出提示信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_3)
        return false
    end
    if lv > PlayerData.eventAttr.m_level then
        --弹出提示信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_3)
        return false
    end
    if (lv < PlayerData.eventAttr.m_level) and self:allCardExp() > PlayerData.eventAttr.m_level then
        --弹出框
        NoticeManager:openTips(self:getController(), { handler = handler(self,self.sendCardUPLevel), title = LanguageConfig.language_Enhance_6})
        return true
    end
    
    self:sendCardUPLevel()
end
--@auto code Button_up_level btFunc end

--@auto code Button_card2 btFunc
function EnhanceOnePopView:onButton_card2Click()
    Functions.printInfo(self.debug,"Button_card2 button is click!")
    self:addCard()
end
--@auto code Button_card2 btFunc end

--@auto code Button_card3 btFunc
function EnhanceOnePopView:onButton_card3Click()
    Functions.printInfo(self.debug,"Button_card3 button is click!")
    self:addCard()
end
--@auto code Button_card3 btFunc end

--@auto code Button_card4 btFunc
function EnhanceOnePopView:onButton_card4Click()
    Functions.printInfo(self.debug,"Button_card4 button is click!")
    self:addCard()
end
--@auto code Button_card4 btFunc end

--@auto code Button_card5 btFunc
function EnhanceOnePopView:onButton_card5Click()
    Functions.printInfo(self.debug,"Button_card5 button is click!")
    self:addCard()
end
--@auto code Button_card5 btFunc end

--@auto code Button_card6 btFunc
function EnhanceOnePopView:onButton_card6Click()
    Functions.printInfo(self.debug,"Button_card6 button is click!")
    self:addCard()
end
--@auto code Button_card6 btFunc end

--@auto code Button_card7 btFunc
function EnhanceOnePopView:onButton_card7Click()
    Functions.printInfo(self.debug,"Button_card7 button is click!")
    self:addCard()
end
--@auto code Button_card7 btFunc end

--@auto code Button_sheng_ji_close btFunc
function EnhanceOnePopView:onButton_sheng_ji_closeClick()
    Functions.printInfo(self.debug,"Button_sheng_ji_close button is click!")
    --武将排序
    --HeroCardData:card_sort()

    --HeroCardData:card_sort()
    --武将显示类型
    EnhanceData.HeroShowType = 0
    if self.type == 1 then     
        --保存控制器
        --local controller = self._controller_t
        self._controller_t:closeChildView(self)
        --GameCtlManager:pop(controller)
    
    else
        self._controller_t:closeChildView(self)
    end
    EnhanceData.MasterData = {}
    EnhanceData.DeputyData = {}
    
    --HeroCardData:card_sort()
    
end
--@auto code Button_sheng_ji_close btFunc end

--@auto button backcall end


--@auto code output func
function EnhanceOnePopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function EnhanceOnePopView:onDisplayView(...)
	Functions.printInfo(self.debug,"pop action finish ")
	--停止粒子
    self._Particle_li_zi_guang_t:stopSystem()
    self._Text_crad_name_1_t:setColor(cc.c3b(255,165,0))
    local data = {...}
    self.type = data[1].type
    --等于1为升级，等于2为进阶
    if self.type == 1 then
        if #EnhanceData.MasterData <= 0 then
            return false
        end
        self._ProjectNode_head_card1_t:setVisible(true)
        Functions.getHeroCrad(self._ProjectNode_head_card1_t, {mark = EnhanceData.MasterData[1].m_mark})
        self:showOneCard()
    end

    --监听函数
    local onShenJi_zhu = function(event)
        if #EnhanceData.MasterData <= 0 then
            return false
        end
        self._ProjectNode_head_card1_t:setVisible(true)
        Functions.getHeroCrad(self._ProjectNode_head_card1_t, {mark = EnhanceData.MasterData[1].m_mark})
        self:showOneCard()
        --self:showCardInfo_level()
    end
    Functions.bindEventListener(self.csbNode, GameEventCenter, EnhanceData.ENHANCE_SHENG_JI_ZHU, onShenJi_zhu)
    
    --监听函数
    local onShenJi_fu = function(event)
--        self._ProjectNode_head_card1_t:setVisible(true)
--        Functions.getHeroCrad(self._ProjectNode_head_card1_t, {mark = EnhanceData.MasterData})
        self:showCardInfo_level_fu()
    end
    Functions.bindEventListener(self.csbNode, GameEventCenter, EnhanceData.ENHANCE_SHENG_JI_FU, onShenJi_fu)
    
end

function EnhanceOnePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

--card1 的信息ui
function EnhanceOnePopView:showCardInfo_level()
    Functions.printInfo(self.debug,"ShowCardInfo_level")
    
    
end

--card2到卡7 的信息ui
function EnhanceOnePopView:showCardInfo_level_fu()
    Functions.printInfo(self.debug,"ShowCardInfo_level_fu")
    
    local card_fu = EnhanceData.DeputyData
    for k = 1, 6 do
        local str = ("_Button_card"..tostring(k+1).."_t")
        self[str]:getChildByName(("Text_card_name_"..tostring(k+1))):setVisible(false)
        self[str]:getChildByName(("ProjectNode_head_icon_"..tostring(k+1))):setVisible(false)
    end

    local card_fu = EnhanceData.DeputyData
    for k, v in pairs(card_fu) do
        local str = ("_Button_card"..tostring(k+1).."_t")
        
        self[str]:getChildByName(("Text_card_name_"..tostring(k+1))):setVisible(true)
        self[str]:getChildByName(("ProjectNode_head_icon_"..tostring(k+1))):setVisible(true)
        --str:getChildByName("Text_card_name_"..tostring(k+1)):setVisible(true)
        self[str]:getChildByName(("Text_card_name_"..tostring(k+1))):setText(ConfigHandler:getHeroNameOfId(v.m_id))
       -- Functions.initHeadComOfId(self[str]:getChildByName( ("ProjectNode_head_icon_"..tostring(k+1)) ), v.m_id)
        Functions.getHeroHead(self[str]:getChildByName( ("ProjectNode_head_icon_"..tostring(k+1)) ), {id = v.m_id , class = v.m_class })
    end
    
--    local card_num = 6 - (6 - #EnhanceData.DeputyData)
--    local num = 6 - card_num
--    if card_num >= 1 and  #EnhanceData.DeputyData < 6 then
--        for k = card_num, num  do
--            local str = ("_Button_card"..tostring(k+1).."_t")
--            self[str]:getChildByName(("Text_card_name_"..tostring(k+1))):setVisible(false)
--            self[str]:getChildByName(("ProjectNode_head_icon_"..tostring(k+1))):setVisible(false)
--        end
--    end

    
    --升级所需要的钱数 参数为（副卡的总经验，主卡的等级）
    self._money = self:getCardExp() * g_csBaseCfg.CardMoney
    Functions.initLabelOfString( self._Text_get_EXP_num_t, self:getCardExp(), self._Text_cost_money_num_t, self._money, self._Text_crad_up_level_t, self:allCardExp())
    
    if self:allCardExp() <= 0 then
        Functions.initLabelOfString( self._Text_crad_up_level_t, EnhanceData.MasterData[1].m_level)
    end
    --升级进度条
    local bar1 = math.floor(EnhanceData.MasterData[1].m_exp) / math.floor(g_roleCardUp[EnhanceData.MasterData[1].m_level]) * 100 --self:Parameterlist(EnhanceData.MasterData[1].m_mark)
    self._LoadingBar_1_t:setPercent(bar1)
    local bar2 = math.floor(self:getCardExp()+ EnhanceData.MasterData[1].m_exp) / math.floor(g_roleCardUp[EnhanceData.MasterData[1].m_level]) * 100
    if bar2 > 100 then
    	bar2 = 100
    end
    self._LoadingBar_2_t:setPercent(bar2)

end

function EnhanceOnePopView:addCard()
    Functions.printInfo(self.debug,"addCard")
    
    if #EnhanceData.MasterData == 0 then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_2)
        return false
    end
    
--    local card_fu = EnhanceData.DeputyData
--    for k, v in pairs(card_fu) do
--        local str = ("_Button_card"..tostring(k+1).."_t")
--        self[str]:getChildByName(("Text_card_name_"..tostring(k+1))):setVisible(false)
--        self[str]:getChildByName(("ProjectNode_head_icon_"..tostring(k+1))):setVisible(false)
--    end
    
    EnhanceData.HeroShowType = 2
    GameCtlManager:push("app.ui.heroSystem.HeroViewController", {data = {}})
end


function EnhanceOnePopView:showOneCard()
    Functions.printInfo(self.debug,"showOneCard")
    local data = HeroCardData:getHeroInfo(EnhanceData.MasterData[1].m_mark)
    
    Functions.setHeroNameOfMark(self._Text_crad_name_1_t,EnhanceData.MasterData[1].m_mark)
    --self._Text_crad_name_1_t, ConfigHandler:getHeroNameOfId(data.m_id)
    
    local pppp = data.m_baseHp
    Functions.initLabelOfString(self._Text_crad_HP_num_t, data.m_baseHp, self._Text_crad_ATK_num_t, data.m_baseAttack, 
        self._Text_crad_ling_bing_num_t, data.m_baseFas, self._Text_crad_chou_mou_num_t, data.m_baseFaf, 
        self._Text_crad_level_t, data.m_level, 
        self._Text_crad_up_num_t, math.floor(EnhanceData.MasterData[1].m_exp).."/"..g_roleCardUp[EnhanceData.MasterData[1].m_level], self._Text_crad_up_level_t, EnhanceData.MasterData[1].m_level)
    --升级进度条
    local bar1 = math.floor(EnhanceData.MasterData[1].m_exp) / math.floor(g_roleCardUp[EnhanceData.MasterData[1].m_level]) * 100
    self._LoadingBar_1_t:setPercent(bar1)
    local bar2 = math.floor(self:getCardExp()+ EnhanceData.MasterData[1].m_exp) / math.floor(g_roleCardUp[EnhanceData.MasterData[1].m_level]) * 100
    self._LoadingBar_2_t:setPercent(bar2)
    --显示副卡的加号
    for i = 2, 7 do
        local str = ("_Sprite_card_add_"..tostring(i).."_t")
        self[str]:setVisible(true)
    end
end

function EnhanceOnePopView:AutoAdd()
    Functions.printInfo(self.debug,"showOneCard")
    
    if #EnhanceData.DeputyData == 6 then
        return false
    end
    --排序（倒序）
    HeroCardData:sortReverse()
    local cardData = HeroCardData:getAllHeroData()
    local prompt = true
    for k, v in pairs(cardData) do
    
        --不为主卡,不为上阵武将，不为正在做主城任务和卡，才能加数量
        local taskHreo = CityData:getTaskHoreInfo()
        local _task = true
        for q,w in pairs(taskHreo) do
            if v.m_mark == w then
                _task = fasle
                break
            end
        end
        if _task and ConfigHandler:getHeroStarOfId(v.m_id) <= 3 and v.m_atkFormFlag == 0 and v.m_defFormFlag == 0 and #EnhanceData.DeputyData < 6 then --只能自动添加1至3星卡，而且不能上阵
            --如果副卡里已经有它了，就不能重复添加
            local Choice = true
            for y, u  in pairs(EnhanceData.DeputyData) do
            	if v.m_mark == u.m_mark then
            	   Choice = false
            	end 
            end
            if EnhanceData.MasterData[1].m_mark == v.m_mark then
                Choice = false
            end
            if Choice then
                
                if self:allCardExp() >= PlayerData.eventAttr.m_level then
                    break 
                else
                    EnhanceData.DeputyData[#EnhanceData.DeputyData+1] = v
                    prompt = false
                end
            end
        end
    end
    if prompt then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_15)
    end
    self:showCardInfo_level_fu()
    
    local iiii = HeroCardData:getAllHeroData()
    local ppp = HeroCardData:getAllHeroData()
    
    --HeroCardData:card_sort()
    --self:allCardExp()
end

function requstUpgrade(requistType,reaistData,handler)
    local requstHander = function(event)

        if handler~=nil then 
            handler()
        end
    end
    NetWork:addNetWorkListener({ 5, 6 }, Functions.createNetworkListener(requstHander,true,"ret"))
    if requistType == 1 then 
        NetWork:sendToServer({ idx = { 5, 6 }, reqtype = 1, slot = reaistData.m_mark, metSlot = reaistData.metMark })
    else
        NetWork:sendToServer({ idx = { 5, 6 }, reqtype = 2, slot = reaistData.m_mark, prop = reaistData.prop })
    end
end

function EnhanceOnePopView:level_Animation()
    Functions.printInfo(self.debug,"level_Animation")
    
    Functions.playSound("herolevelup.mp3")

--    self.sprite = Functions.createSprite({scale = 1, pos = {x = 100, y = 0 }, zorder = 0, spriteName = "lk/ui_res/EnhanceOnePopUI/qianghua_level_up.png" }) 
--    self._Button_card1_t:addChild(self.sprite)
--    
--    local fadein = cc.FadeIn:create(0.5)
--    local moveto = cc.MoveTo:create(1,cc.p(100, 300))
--    local fadeout = cc.FadeOut:create(0.1)
--    
--    local seq = cc.Sequence:create( fadein, moveto, fadeout)
--    self.sprite:runAction(seq)
    
    self._Particle_li_zi_guang_t:resetSystem()
    self._Particle_li_zi_guang_t:setDuration(2)

    --增加的生命
    local str = LanguageConfig.language_Enhance_7.."    "..tostring(self.HP).."\n"..LanguageConfig.language_Enhance_8.."    "..tostring(self.ATK).."\n"..
        LanguageConfig.ui_selectHero_4.."    "..tostring(self.FS).."\n"..LanguageConfig.ui_selectHero_5.."    "..tostring(self.FF)
    local text = Functions.createLabel({scale = 1, pos = {x = -10, y = 30}, zorder = 0, text = str })
    text:setSystemFontSize(20)
    text:setTextColor(display.COLOR_GREEN)
    self._Text_crad_chou_mou_num_t:addChild(text)
    
    --粒子
    local pMove = cc.MoveBy:create(1.5,cc.p(0,150))
    local fadeout = cc.FadeOut:create(0.1)
    local fly = cc.Sequence:create(pMove, fadeout)
    text:runAction(fly)
end

function EnhanceOnePopView:card_Fly()
    --武将飞出
    local card_data = EnhanceData.DeputyData
    --初使化动画所需
    self.sX = self._Panel_add_crad_t:getContentSize().width/2
    self.sY = self._Panel_add_crad_t:getContentSize().height/2

    local pppp = self.sY - ((2-1) / 3) * 180 + 142 
    for k, v in pairs(card_data) do
        local Sprite = Functions.createSprite({scale = 1, pos = {x = self.sX  + (k-1) % 3 * 150 +47, y = self.sY - math.floor((k-1) / 3) * 168 + 183 }, zorder = 0})
        Functions.loadImageWithSprite(Sprite, ConfigHandler:getHeroHeadImageOfId(v.m_id), 1)
        self._Panel_add_crad_t:addChild(Sprite,10)

        local scaleto = cc.ScaleTo:create(0.4, 0.00001)
        local moveTo = cc.MoveTo:create(0.4, cc.p(self.sX - 320, self.sY + 60))
        local spawn = cc.Spawn:create(scaleto, moveTo)
        Sprite:runAction(spawn)
    end
end

--副卡提升的等级
function EnhanceOnePopView:allCardExp()
    Functions.printInfo(self.debug,"allCardExp")
--          参数随等级区段改变：1 - 10级 - 参数 = 5；10 - 30级 - 参数 = 15；30 - 60级 - 参数 = 20；60 - 90级 - 参数 = 25；90级以上 - 参数 = 25
--//         常数 = 100
--//         LV(0-10 ) LVX= 0，lv(10-30)级 LVX= 1075，lv30级 = 10500，lv60级 = 51800,lv90级 = 160825.

    local i_exp = EnhanceData.MasterData[1].m_exp    --当前主卡的经验和等级
    local lv = EnhanceData.MasterData[1].m_level
    if lv <= 0 then
    	return false
    end
    local Constant = 0
    local LVX = 0
    local _iExp = 0 -- 本级所需经验

    local count = 0
    
    
    --    self:getCardExp() = self:getCardExp() + i_exp
--    for i = 1, 99 do
    --        if self:getCardExp() > g_roleCardUp[lv] then
    --        self:getCardExp() = self:getCardExp() - g_roleCardUp[lv]
--        	lv = lv + 1
--        else
--            lv = lv - 1
--            return lv
--
--        end
--    end
    
    repeat

        _iExp = _iExp + g_roleCardUp[lv]     --(LVX + 100 * (lv - 1) + Constant*(lv*lv - (lv + 1) / 2 * lv))
        if ((_iExp - i_exp) <= self:getCardExp()) then
            count = count + 1
            lv = lv + 1
        else
            lv = lv       --卡片为了获取下一级经验，等级多加了一，所以这里要减一
        end
        
    until ((_iExp - i_exp) > self:getCardExp() or lv > #g_roleCardUp)
    return lv
end

--副卡提供的经验
function EnhanceOnePopView:getCardExp()
    local card_fu = EnhanceData.DeputyData
--    if card_fu == nil then
--    	return false
--    end
    local allExp = 0
    for k, v in pairs(card_fu) do
        local fuEXP = g_csBaseCfg.CardExp[ConfigHandler:getHeroStarCountOfId(v.m_id)]
        allExp = allExp + fuEXP
    end
    --吃已经有经验的武将返还50％经验的功能
--    for k, v in pairs(card_fu) do
--        if v.m_level > 1 then
--            local level = v.m_level - 1
--            local exp = 0
--            for m = 1, level do
--                exp = exp + g_roleCardUp[m]
--            end
--            allExp = allExp + (exp + v.m_exp) * 0.5
--        end
--    end 
    return math.floor(allExp)
end

--发送升级接口
function EnhanceOnePopView:sendCardUPLevel()
    
    --发送升级
    local onSendChat = function(event)
        local _lv = event.amount
        local _exp = event.newExp
        local _mark = event.slot
        PlayerData.eventAttr.m_money = event.m_money
        
        local v = EnhanceData.MasterData[1]
        v.m_level = v.m_level + _lv
        v.m_exp = _exp
        
        local hero = HeroCardData:searchHeroOfMark(_mark)
        
        local param = EnhanceData:getParam(v)

        --card base data
--        local param = {heroInfo = { id = v.m_id, level = v.m_level, class = v.m_class, attackEx = v.m_attackEx,
--            hpEx = v.m_hpEx, fasEx = v.m_fasEx, fafEx = v.m_fafEx }}
        --升级所加的属性
        self.HP = math.floor(pm_GetCardHp(param) - v.m_baseHp)
        self.ATK = math.floor(pm_GetCardAttack(param) - v.m_baseAttack)
        self.FS = math.floor(pm_GetCardFas(param) - v.m_baseFas)
        self.FF = math.floor(pm_GetCardFaf(param) - v.m_baseFaf)

        EnhanceData:setHeroAttr(hero, param)
--        v.m_baseCombat  = math.floor(cs_GetCardFightValue(param)) --卡牌战斗力
--        v.m_baseAttack  = math.floor(pm_GetCardAttack(param)) --卡牌攻击力
--        v.m_baseHp      = math.floor(pm_GetCardHp(param)) -- 卡牌血量
--        v.m_baseFas     = math.floor(pm_GetCardFas(param)) -- 卡牌法术
--        v.m_baseFaf     = math.floor(pm_GetCardFaf(param)) -- 卡牌法防
        --删除绘制UI的副卡
        HeroCardData:getSellHeroData(EnhanceData.DeputyData)
        
        HeroCardData:card_sort()
        Functions.getHeroCrad(self._ProjectNode_head_card1_t, {mark = EnhanceData.MasterData[1].m_mark})
        local card_fu = EnhanceData.DeputyData
        for k, v in pairs(card_fu) do
            local str = ("_Button_card"..tostring(k+1).."_t")
            self[str]:getChildByName(("Text_card_name_"..tostring(k+1))):setVisible(false)
            self[str]:getChildByName(("ProjectNode_head_icon_"..tostring(k+1))):setVisible(false)
        end
        --飞卡
        self:card_Fly()
        --放动画
        if _lv > 0 then
            self:level_Animation()
        end
        EnhanceData.DeputyData = {}
        --升级成功后刷新数据
        self:showCardInfo_level_fu()
        self:showOneCard()

        --升级后钱数清零
        Functions.initLabelOfString( self._Text_cost_money_num_t, 0)

        --卡包数据变动监听
        HeroCardData:cardsDataChange(EnhanceData.MasterData[1].m_mark)

    end
    local met = EnhanceData.DeputyData
    local metMark = {}
    for k, v in pairs(met) do
        metMark[#metMark+1] = v.m_mark
    end
    NetWork:addNetWorkListener({ 5, 6 }, Functions.createNetworkListener(onSendChat,true,"ret"))
    NetWork:sendToServer({ idx = { 5, 6 }, reqtype = 1, slot = EnhanceData.MasterData[1].m_mark, metSlot = metMark })
end

--function EnhanceOnePopView:Parameterlist(mark) --卡片升级所需经验 
--    local LV = HeroCardData:getHeroInfo(mark).m_level
--    local LVX = 0
--    local NORM = 0
--    local constant = 100
--    LV = LV + 1
--
--    if LV < 11 then
--        LVX = 0
--    elseif  LV < 31 then
--        LVX = 1075
--    elseif LV < 61 then
--        LVX = 10500
--    elseif LV < 91 then
--        LVX = 51800
--    else
--        LVX = 160825
--    end
--
--    if LV < 11 then
--        NORM = 5
--    elseif LV < 31 then
--        NORM = 15
--    elseif LV < 61 then
--        NORM = 20
--    else
--        NORM = 25
--    end
--
--    --等级N卡片升级所需经验 = LVX + 常数*（等级N - 1） + 参数*[等级N*等级N - (等级N + 1) * 0.5f * 等级N]
--    return (LVX + 100 * (LV - 1) + NORM*(LV*LV - (LV + 1) * 0.5 * LV))
--end


return EnhanceOnePopView