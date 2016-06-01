--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local EnhanceViewController = class("EnhanceViewController", BaseViewController)

local Functions = require("app.common.Functions")

EnhanceViewController.debug = true
EnhanceViewController.modulePath = ...
EnhanceViewController.studioSpriteFrames = {"CB_blackbg","EnhanceUI_Text" }
--@auto code head end

--@Pre loading
EnhanceViewController.spriteFrameNames = 
    {
        "heroCardRes","headPilistRes"
    }

EnhanceViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #EnhanceViewController.studioSpriteFrames > 0 then
    EnhanceViewController.spriteFrameNames = EnhanceViewController.spriteFrameNames or {}
    table.insertto(EnhanceViewController.spriteFrameNames, EnhanceViewController.studioSpriteFrames)
end
function EnhanceViewController:onDidLoadView()

    --output list
    self._resNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("resNode")
	self._bz_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Button_Soldiers"):getChildByName("bz")
	
    --label list
    
    --button list
    self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

	self._Button_shengji_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Button_shengji_1")
	self._Button_shengji_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_shengji_1Click), "zoom"))

	self._Button_jinjie_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Button_jinjie_2")
	self._Button_jinjie_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_jinjie_2Click), "zoom"))

	self._Button_Soldiers_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Button_Soldiers")
	self._Button_Soldiers_t:onTouch(Functions.createClickListener(handler(self, self.onButton_soldiersClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function EnhanceViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")

    GameCtlManager:pop(self)
end
--@auto code Button_back btFunc end

--@auto code Text_soul btFunc
function EnhanceViewController:onText_soulClick()
    Functions.printInfo(self.debug,"Text_soul button is click!")
end
--@auto code Text_soul btFunc end

--@auto code Button_shengji_1 btFunc
function EnhanceViewController:onButton_shengji_1Click()
    Functions.printInfo(self.debug,"Button_shengji_1 button is click!")
    --打开升级
    self:openChildView("app.ui.popViews.EnhanceOnePopView",{data = {type = 0}, isRemove = false})
end
--@auto code Button_shengji_1 btFunc end

--@auto code Button_jinjie_2 btFunc
function EnhanceViewController:onButton_jinjie_2Click()
    Functions.printInfo(self.debug,"Button_jinjie_2 button is click!")
    --打开进阶
    self:openChildView("app.ui.popViews.EnhanceTwoPopView",{data = {type = 0}, isRemove = false})
end
--@auto code Button_jinjie_2 btFunc end

--@auto code Button_soldiers btFunc
function EnhanceViewController:onButton_soldiersClick()
    Functions.printInfo(self.debug,"Button_soldiers button is click!")
    --打开士兵培养
    if PlayerData.eventAttr.m_level >= g_csOpen.StrengthenOpen.level then
        self:openChildView("app.ui.popViews.SoldiersPopView",{ data = {1, 1}, isRemove = false})
    else
        PromptManager:openTipPrompt(LanguageConfig.language_Enhance_1)
    end

end
--@auto code Button_soldiers btFunc end

--@auto button backcall end


--@auto code view display func
function EnhanceViewController:onCreate()
    Functions.printInfo(self.debug_b," EnhanceViewController controller create!")
end

function EnhanceViewController:onDisplayView(...)
    Functions.printInfo(self.debug_b," EnhanceViewController view enter display!")
    --  if SoldiersData.eventAttr.SoldiersBZ == 1 then
    --        self._bz_t:setVisible(true)
    --    elseif SoldiersData.eventAttr.SoldiersBZ == 0 then
    --        self._bz_t:setVisible(false)
    --  end
    Functions.registerStateListenerOfBt(self._Button_Soldiers_t, SoldiersData, "SoldiersBZ") --士兵升级标志
    --    if self.pushData ~= nil then
    --        if self.pushData.type == 1 then
    --            --打开升级
    --            self:openChildView("app.ui.popViews.EnhanceOnePopView",{data = {type = self.pushData.type}, isRemove = false})
    --        elseif self.pushData.type == 2 then 
    --            --打开进阶
    --            self:openChildView("app.ui.popViews.EnhanceTwoPopView",{data = {type = self.pushData.type}, isRemove = false})
    --        end
    --  end
    Functions.setPopupKey("upgrade")
    --钱币显示
    Functions.initResNodeUI(self._resNode_t,{ "jinbi" , "yuanbao", "soul" })
end
--@auto code view display func end

--接受pop数据
function EnhanceViewController:onReceivePopData(data)  
    --数据更新监听
    if EnhanceData.HeroShowType == 1 then
        GameEventCenter:dispatchEvent({ name = EnhanceData.ENHANCE_SHENG_JI_ZHU, data = data })
    elseif EnhanceData.HeroShowType == 2 then
        GameEventCenter:dispatchEvent({ name = EnhanceData.ENHANCE_SHENG_JI_FU, data = data })
    elseif EnhanceData.HeroShowType == 3 then
        GameEventCenter:dispatchEvent({ name = EnhanceData.ENHANCE_JIN_JIE_ZHU, data = data })
    elseif EnhanceData.HeroShowType == 4 then
        GameEventCenter:dispatchEvent({ name = EnhanceData.ENHANCE_JIN_JIE_FU, data = data })
    end
end

--接受push数据
function EnhanceViewController:onReceivePushData(data)  
    self.pushData = data
end

function EnhanceViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end

return EnhanceViewController