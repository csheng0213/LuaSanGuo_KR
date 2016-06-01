--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local ShiLianViewController = class("ShiLianViewController", BaseViewController)

local Functions = require("app.common.Functions")

ShiLianViewController.debug = true
ShiLianViewController.modulePath = ...
ShiLianViewController.studioSpriteFrames = {"CB_blackbg","ShiLianUI_Text" }
--@auto code head end

--@Pre loading
ShiLianViewController.spriteFrameNames = 
    {
    }

ShiLianViewController.animaNames = 
    {
    }

ShiLianViewController.WeekDayEnum = 
    {
        Sunday = 1,
        Monday = 2,
        Tuesday = 3,
        Wednesday = 4,
        Thursday = 5,
        Friday = 6,
        Saturday = 7
    }
--@auto code uiInit
--add spriteFrames
if #ShiLianViewController.studioSpriteFrames > 0 then
    ShiLianViewController.spriteFrameNames = ShiLianViewController.spriteFrameNames or {}
    table.insertto(ShiLianViewController.spriteFrameNames, ShiLianViewController.studioSpriteFrames)
end
function ShiLianViewController:onDidLoadView()

    --output list
    
    --label list
    
    --button list
    self._backBt_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel_3"):getChildByName("topbarBg_10"):getChildByName("Panel_3"):getChildByName("backBt_2")
	self._backBt_2_t:onTouch(Functions.createClickListener(handler(self, self.onBackbt_2Click), ""))

	self._helpBt_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel_3"):getChildByName("topbarBg_10"):getChildByName("Panel_3"):getChildByName("helpBt_4")
	self._helpBt_4_t:onTouch(Functions.createClickListener(handler(self, self.onHelpbt_4Click), ""))

	self._liBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("liBt")
	self._liBt_t:onTouch(Functions.createClickListener(handler(self, self.onLibtClick), "zoom"))

	self._shuBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("shuBt")
	self._shuBt_t:onTouch(Functions.createClickListener(handler(self, self.onShubtClick), "zoom"))

	self._mouBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("mouBt")
	self._mouBt_t:onTouch(Functions.createClickListener(handler(self, self.onMoubtClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt_2 btFunc
function ShiLianViewController:onBackbt_2Click()
    Functions.printInfo(self.debug,"Backbt_2 button is click!")
    GameCtlManager:pop(self)
end
--@auto code Backbt_2 btFunc end

--@auto code Helpbt_4 btFunc
function ShiLianViewController:onHelpbt_4Click()
    Functions.printInfo(self.debug,"Helpbt_4 button is click!")
    NoticeManager:openNotice(self, {type = NoticeManager.SHILIAN_INFO})
end
--@auto code Helpbt_4 btFunc end

--@auto code Libt btFunc
function ShiLianViewController:onLibtClick()
    Functions.printInfo(self.debug,"Libt button is click!")
    if self:isAvailable() then
        GameCtlManager:push("app.ui.heroShiLianSystem.HeroShiLianViewController",{data={jumpType = HeroShiLianData.JumpTypeEnum.li,jumpData ={}}})
    end
end
--@auto code Libt btFunc end

--@auto code Shubt btFunc
function ShiLianViewController:onShubtClick()
    Functions.printInfo(self.debug,"Shubt button is click!")
    if self:isAvailable() then
        GameCtlManager:push("app.ui.heroShiLianSystem.HeroShiLianViewController",{data={jumpType = HeroShiLianData.JumpTypeEnum.shu,jumpData ={}}})
    end
end
--@auto code Shubt btFunc end

--@auto code Moubt btFunc
function ShiLianViewController:onMoubtClick()
    Functions.printInfo(self.debug,"Moubt button is click!")
    if self:isAvailable() then
        GameCtlManager:push("app.ui.heroShiLianSystem.HeroShiLianViewController",{data={jumpType = HeroShiLianData.JumpTypeEnum.mou,jumpData ={}}})
    end
end
--@auto code Moubt btFunc end

--@auto button backcall end


--@auto code view display func
function ShiLianViewController:onCreate()
    Functions.printInfo(self.debug_b," ShiLianViewController controller create!")
end
function ShiLianViewController:openBgMusic()
    Audio.playMusic("sound/combat.mp3",true)
end
function ShiLianViewController:onDisplayView()
	Functions.printInfo(self.debug_b," ShiLianViewController view enter display!")
    -- HeroShiLianData:loadHeroShiLianData(handler(self,self.initDisplayUi))
    Functions.setPopupKey("hero_train")
    self:initDisplayUi()
end
--@auto code view display func end
function ShiLianViewController:initDisplayUi()
    -- body
    local time = TimerManager:getCurrentSecond()
    local date = os.date("*t",time)

    if TimerManager:getCurrentWday() == self.WeekDayEnum.Monday or TimerManager:getCurrentWday() == self.WeekDayEnum.Thursday then
        Functions.setEnabledBt( self._liBt_t ,true)
        Functions.setEnabledBt( self._mouBt_t ,false)
        Functions.setEnabledBt( self._shuBt_t ,false)
        self._shilianBt_t = self._liBt_t
    elseif TimerManager:getCurrentWday() == self.WeekDayEnum.Tuesday or TimerManager:getCurrentWday() == self.WeekDayEnum.Friday then
        Functions.setEnabledBt( self._liBt_t ,false)
        Functions.setEnabledBt( self._mouBt_t ,false)
        Functions.setEnabledBt( self._shuBt_t ,true)
        self._shilianBt_t = self._shuBt_t
    elseif TimerManager:getCurrentWday() == self.WeekDayEnum.Wednesday or TimerManager:getCurrentWday() == self.WeekDayEnum.Saturday then
        Functions.setEnabledBt( self._liBt_t ,false)
        Functions.setEnabledBt( self._mouBt_t ,true)
        Functions.setEnabledBt( self._shuBt_t ,false)
        self._shilianBt_t = self._mouBt_t
    else
        Functions.setEnabledBt( self._liBt_t ,true)
        Functions.setEnabledBt( self._mouBt_t ,true)
        Functions.setEnabledBt( self._shuBt_t ,true)
        self._shilianBt_t = self._liBt_t
    end
end
function ShiLianViewController:isAvailable()
  if HeroShiLianData.isDone then
      PromptManager:openTipPrompt(LanguageConfig.language_heroShiLian_1)
      return false
  end
  return true
end
return ShiLianViewController