--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local HeroShiLianViewController = class("HeroShiLianViewController", BaseViewController)

local Functions = require("app.common.Functions")

HeroShiLianViewController.debug = true
HeroShiLianViewController.modulePath = ...
HeroShiLianViewController.studioSpriteFrames = {"ShiLianUI","HeroShiLianUI","CB_blackbg" }
--@auto code head end

--@Pre loading
HeroShiLianViewController.spriteFrameNames = 
    {
        "heroCardRes"
    }

HeroShiLianViewController.animaNames = 
    {
      "An_shiLian"
    }


--@auto code uiInit
--add spriteFrames
if #HeroShiLianViewController.studioSpriteFrames > 0 then
    HeroShiLianViewController.spriteFrameNames = HeroShiLianViewController.spriteFrameNames or {}
    table.insertto(HeroShiLianViewController.spriteFrameNames, HeroShiLianViewController.studioSpriteFrames)
end
function HeroShiLianViewController:onDidLoadView()

    --output list
    self._lfView_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("lfView")
	self._smLabel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("smLabel")
	self._aniNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("aniNode")
	self._zhanGongBar_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("Image_23"):getChildByName("zhanGongBar")
	self._zhanGongText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("zhanGongText")
	self._shiLianPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel")
	self._power1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel"):getChildByName("simpleBt"):getChildByName("power1")
	self._simpleLevel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel"):getChildByName("simpleBt"):getChildByName("simpleLevel")
	self._power3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel"):getChildByName("diffultyBt"):getChildByName("power3")
	self._diffultyLevel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel"):getChildByName("diffultyBt"):getChildByName("diffultyLevel")
	self._power2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel"):getChildByName("easyBt"):getChildByName("power2")
	self._easyLevel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel"):getChildByName("easyBt"):getChildByName("easyLevel")
	self._tips_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel"):getChildByName("tips")
	self._describe_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel"):getChildByName("tips"):getChildByName("describe")
	self._tipsPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("tipsPanel")
	
    --label list
    
    --button list
    self._backBt_2_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel_3_3"):getChildByName("topbarBg_10_4"):getChildByName("Panel_3"):getChildByName("backBt_2_2")
	self._backBt_2_2_t:onTouch(Functions.createClickListener(handler(self, self.onBackbt_2_2Click), ""))

	self._helpBt_4_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel_3_3"):getChildByName("topbarBg_10_4"):getChildByName("Panel_3"):getChildByName("helpBt_4_4")
	self._helpBt_4_4_t:onTouch(Functions.createClickListener(handler(self, self.onHelpbt_4_4Click), ""))

	self._heroCardBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("heroCardBt")
	self._heroCardBt_t:onTouch(Functions.createClickListener(handler(self, self.onHerocardbtClick), "zoom"))

	self._smCardBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("smCardBt")
	self._smCardBt_t:onTouch(Functions.createClickListener(handler(self, self.onSmcardbtClick), "zoom"))

	self._simpleBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel"):getChildByName("simpleBt")
	self._simpleBt_t:onTouch(Functions.createClickListener(handler(self, self.onSimplebtClick), "zoom"))

	self._diffultyBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel"):getChildByName("diffultyBt")
	self._diffultyBt_t:onTouch(Functions.createClickListener(handler(self, self.onDiffultybtClick), "zoom"))

	self._easyBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_3"):getChildByName("shiLianPanel"):getChildByName("easyBt")
	self._easyBt_t:onTouch(Functions.createClickListener(handler(self, self.onEasybtClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt_2_2 btFunc
function HeroShiLianViewController:onBackbt_2_2Click()
    Functions.printInfo(self.debug,"Backbt_2_2 button is click!")
    GameCtlManager:pop(self)
end
--@auto code Backbt_2_2 btFunc end

--@auto code Helpbt_4_4 btFunc
function HeroShiLianViewController:onHelpbt_4_4Click()
    Functions.printInfo(self.debug,"Helpbt_4_4 button is click!")
    NoticeManager:openNotice(self, {type = NoticeManager.SHILIAN_INFO})
end
--@auto code Helpbt_4_4 btFunc end

--@auto code Simplebt btFunc
function HeroShiLianViewController:onSimplebtClick()
    Functions.printInfo(self.debug,"Simplebt button is click!")
    Functions.setAdbrixTag("retension","hero_traing_try")
    if self:isAvailable() then
        self:gotoShiLian(1)
    end
end
--@auto code Simplebt btFunc end

--@auto code Diffultybt btFunc
function HeroShiLianViewController:onDiffultybtClick()
    Functions.printInfo(self.debug,"Diffultybt button is click!")
    Functions.setAdbrixTag("retension","hero_traing_try")
    if self:isAvailable() then
        self:gotoShiLian(3)
    end
end
--@auto code Diffultybt btFunc end

--@auto code Easybt btFunc
function HeroShiLianViewController:onEasybtClick()
    Functions.printInfo(self.debug,"Easybt button is click!")
    Functions.setAdbrixTag("retension","hero_traing_try")
    if self:isAvailable() then
        self:gotoShiLian(2)
    end
end
--@auto code Easybt btFunc end

--@auto code Herocardbt btFunc
function HeroShiLianViewController:onHerocardbtClick()
    Functions.printInfo(self.debug,"Herocardbt button is click!")
    if self.heroInf.progress >= 100 and self.heroInf.awarded ~= 1 then
        self:getHeroCrad()
    else
        self:openChildView("app.ui.popViews.CardInfoPopView", { data = { self.heroInf.id, 3}})
    end
end
--@auto code Herocardbt btFunc end

--@auto code Smcardbt btFunc
function HeroShiLianViewController:onSmcardbtClick()
    Functions.printInfo(self.debug,"Smcardbt button is click!")
    if self.heroInf.progress >= 100 and self.heroInf.awarded ~= 1 then
        self:getHeroCrad()
    else
        self:openChildView("app.ui.popViews.CardInfoPopView", { data = { self.heroInf.showheroid, 3}})
    end
end
--@auto code Smcardbt btFunc end

--@auto button backcall end


--@auto code view display func
function HeroShiLianViewController:onCreate()
    Functions.printInfo(self.debug_b," HeroShiLianViewController controller create!")
end

function HeroShiLianViewController:onChangeView()
end
function HeroShiLianViewController:openBgMusic()
    Audio.playMusic("sound/combat.mp3",true)
end
function HeroShiLianViewController:onDisplayView()
	  Functions.printInfo(self.debug_b," HeroShiLianViewController view enter display!")
    Functions.setAdbrixTag("retension","hero_traing_inter") 
    HeroShiLianData:loadHeroShiLianData(handler(self, self.initUidisplay))
end
--@auto code view display func end

function HeroShiLianViewController:initUidisplay()
    self:showView()
    Functions.initLabelOfString(self._power1_t, "-" .. HeroShiLianData.heroShiLianInfo.needMoney,self._power2_t, "-" .. HeroShiLianData.heroShiLianInfo.needMoney,self._power3_t, "-" .. HeroShiLianData.heroShiLianInfo.needMoney)
     self._easyLevel_t:setString(tostring(PlayerData.eventAttr.m_level))
     self._simpleLevel_t:setString(tostring(PlayerData.eventAttr.m_level - math.random(5)))
     self._diffultyLevel_t:setString(tostring(PlayerData.eventAttr.m_level + math.random(5)))
     local temp = HeroShiLianData.heroShiLianInfo[self.jumpType]
     self.heroInf = temp
     self:setZhanGong(self.heroInf.progress)
      if HeroShiLianData.shiLianType == 0 then
          self._smCardBt_t:setVisible(true)
          self._heroCardBt_t:setVisible(false)
          self._lfView_t:setVisible(false)
          self._smLabel_t:setVisible(true)
          self._describe_t:setString(LanguageConfig.language_heroShiLian_5)
          if self.heroInf.awarded == 1 then
              local heroCard = self._smCardBt_t:getChildByName("heroCard")
              heroCard:setVisible(true)
              Functions.getHeroCrad(heroCard,{id = self.heroInf.showheroid,class = 1})
              self._tipsPanel_t:setVisible(true)
              self._tipsPanel_t:getChildByName("text"):setString(LanguageConfig.language_heroShiLian_1)
              self._shiLianPanel_t:setVisible(false)
              -- Functions.setEnabledBt(self._smCardBt_t,false)
          else
              self:updateDisplay(self.heroInf.progress)
          end
      elseif HeroShiLianData.shiLianType == 1 then
          self._lfView_t:setVisible(true)
          self._smLabel_t:setVisible(false)
          self._smCardBt_t:setVisible(false)
          self._heroCardBt_t:setVisible(true)
          self._describe_t:setString(LanguageConfig.language_heroShiLian_4)
          local heroCard = self._heroCardBt_t:getChildByName("heroCard")
          heroCard:setVisible(true)
          Functions.getHeroCrad(heroCard,{id = self.heroInf.id,class = 1})
          if self.heroInf.awarded == 1 then
            local heroCard = self._smCardBt_t:getChildByName("heroCard")
            heroCard:setVisible(true)
            Functions.getHeroCrad(heroCard,{id = self.heroInf.showheroid,class = 1})
            self._tipsPanel_t:setVisible(true)
            self._tipsPanel_t:getChildByName("text"):setString(LanguageConfig.language_heroShiLian_1)
            self._shiLianPanel_t:setVisible(false)
          else
             self:updateDisplay(self.heroInf.progress)
          end
      end      
end
function HeroShiLianViewController:updateDisplay(progress)
     --更新战功
     if progress >= 100 then
        self._aniNode_t:setVisible(true)
        Functions.playAnimaOfUI(self._aniNode_t,"An_shiLian",0)

        Functions.setEnabledBt(self._smCardBt_t, true)
        self._tipsPanel_t:setVisible(true)
        
        if HeroShiLianData.shiLianType == 0 then
            self._tipsPanel_t:getChildByName("text"):setString(LanguageConfig.language_heroShiLian_2)
        else
            self._tipsPanel_t:getChildByName("text"):setString(LanguageConfig.language_heroShiLian_3)
        end
        self._shiLianPanel_t:setVisible(false)
     else
        Functions.setEnabledBt(self._smCardBt_t, false)
        self._tipsPanel_t:setVisible(false)
        self._shiLianPanel_t:setVisible(true)
     end
end
--设置战功
function HeroShiLianViewController:setZhanGong(percent)
      self._zhanGongText_t:setString(tostring(percent) .. "%")
      self._zhanGongBar_t:setPercent(percent) 
end
function HeroShiLianViewController:isAvailable()
  if PlayerData.eventAttr.m_money  < g_heroShilian.power then
      PromptManager:openTipPrompt(LanguageConfig.language_Enlist_10)
      return false
  end
  if self.heroInf.progress >= 100 then
      PromptManager:openTipPrompt(LanguageConfig.language_Teach32)
      return false
  end
  return true
end
function HeroShiLianViewController:gotoShiLian(chooseType)

    if HeroShiLianData.heroShiLianInfo[self.jumpType].progress >= 100 then
        PromptManager:openTipPrompt(LanguageConfig.language_Teach32) 
        return    
    end
    
    if PlayerData.eventAttr.m_money < g_heroShilian.money then
       PromptManager:openTipPrompt(LanguageConfig.language_Enlist_10) 
       return 
    end
    
    --这里调用战斗场景
    GameCtlManager:push("app.ui.combatSystem.CombatViewController", { data = { combatType = CombatCenter.CombatType.RB_HeroTrial, majorHurdles = self.jumpType, littleLevels = chooseType ,enemyHeroIDs = HeroShiLianData.heroShiLianInfo.heroInfo } })
    
end

function HeroShiLianViewController:onReceivePushData(jump)
    self.jumpType = jump.jumpType
    self.jumpData = jump.jumpData 
end

--接受pop数据
function HeroShiLianViewController:onReceivePopData(data)
    -- if data.result == CombatCenter.FightResult.WIN then
    --     HeroShiLianData:loadHeroShiLianData(handler(self, self.initUidisplay)) 
    -- elseif data.result == CombatCenter.FightResult.FAILE then
    --     HeroShiLianData:loadHeroShiLianData(handler(self, self.initUidisplay))
    -- end
    HeroShiLianData:loadHeroShiLianData(handler(self, self.initUidisplay))
end
--获取卡牌
function HeroShiLianViewController:getHeroCrad()
   local handler = function(event)
          self._tipsPanel_t:setVisible(true)
          self._shiLianPanel_t:setVisible(false)
          self._tipsPanel_t:getChildByName("text"):setString(LanguageConfig.language_heroShiLian_1)
          self.heroInf.awarded = 1
          if HeroShiLianData.shiLianType == 0 then
              local heroCard = self._smCardBt_t:getChildByName("heroCard")
              heroCard:setVisible(true)
              Functions.getHeroCrad(heroCard,{id = event.gid,class = 1})
              self.heroInf.showheroid = event.gid
              -- Functions.setEnabledBt(self._smCardBt_t,false)              
          end
          self._aniNode_t:setVisible(false)
          self._aniNode_t:stopAllActions()
          HeroCardData:addCard({slot = event.gslot,id = event.gid}) 
          self:openChildView("app.ui.popViews.EnlistThreePopView", {isRemove = true,data = {slot = event.gslot,id = event.gid,type = 5} })
  end
    HeroShiLianData:RequestGetCard(HeroShiLianData.shiLianType,self.jumpType,handler,self.jumpType)
end
return HeroShiLianViewController