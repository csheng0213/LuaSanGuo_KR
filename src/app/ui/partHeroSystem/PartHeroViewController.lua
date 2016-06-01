--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local PartHeroViewController = class("PartHeroViewController", BaseViewController)

local Functions = require("app.common.Functions")

PartHeroViewController.debug = true
PartHeroViewController.modulePath = ...
PartHeroViewController.studioSpriteFrames = {"PartHeroUI_Text","CB_blackbg","PartHeroUI" }
--@auto code head end
--Enum
local HeroType = 
    {
        MainHero = 0,
        ViceHero1 = 1,
        ViceHero2 = 2,
        PartHero1 = 4,
        PartHero2 = 5,
        PartHero3 = 6,
        PartHero4 = 7,
        PartHero5 = 8,
        PartHero6 = 9,
    }
local JumpType = 
    {
        EmbattleToSelectHero = 0,
        PartHeroToSelectHero = 1,
        EmbattleToPartHero = 2
    }
--
--@Pre loading
PartHeroViewController.spriteFrameNames = 
    {
    }

PartHeroViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #PartHeroViewController.studioSpriteFrames > 0 then
    PartHeroViewController.spriteFrameNames = PartHeroViewController.spriteFrameNames or {}
    table.insertto(PartHeroViewController.spriteFrameNames, PartHeroViewController.studioSpriteFrames)
end
function PartHeroViewController:onDidLoadView()

    --output list
    self._topNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("topNode")
	self._infBg_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("infBg")
	self._mainFatePanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("infBg"):getChildByName("mainFatePanel")
	self._vice1FatePanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("infBg"):getChildByName("vice1FatePanel")
	self._vice2FatePanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("infBg"):getChildByName("vice2FatePanel")
	self._attack_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("infFrame"):getChildByName("attack")
	self._wisdom_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("infFrame"):getChildByName("wisdom")
	self._soldiers_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("infFrame"):getChildByName("soldiers")
	self._life_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("infFrame"):getChildByName("life")
	self._partHeroPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("partHeroPanel")
	self._partHero1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("partHeroPanel"):getChildByName("partHero1")
	self._partHero2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("partHeroPanel"):getChildByName("partHero2")
	self._partHero3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("partHeroPanel"):getChildByName("partHero3")
	self._partHero4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("partHeroPanel"):getChildByName("partHero4")
	self._partHero5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("partHeroPanel"):getChildByName("partHero5")
	self._partHero6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_19"):getChildByName("partHeroPanel"):getChildByName("partHero6")
	
    --label list
    
    --button list
    self._backBt_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("backBt_2")
	self._backBt_2_t:onTouch(Functions.createClickListener(handler(self, self.onBackbt_2Click), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt_2 btFunc
function PartHeroViewController:onBackbt_2Click()
    Functions.printInfo(self.debug,"Backbt_2 button is click!")
    GameCtlManager:pop(self,{jumpType = JumpType.PartHeroToSelectHero})
end
--@auto code Backbt_2 btFunc end

--@auto code Parthero1 btFunc
function PartHeroViewController:onParthero1Click()
    Functions.printInfo(self.debug,"Parthero1 button is click!")
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data = {jumpType = JumpType.PartHeroToSelectHero,jumpData ={embattleType = self.jumpData.embattleType,heroType = HeroType.PartHero1}}})
end
--@auto code Parthero1 btFunc end

--@auto code Parthero2 btFunc
function PartHeroViewController:onParthero2Click()
    Functions.printInfo(self.debug,"Parthero2 button is click!")
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data = {jumpType = JumpType.PartHeroToSelectHero,jumpData ={embattleType = self.jumpData.embattleType,heroType = HeroType.PartHero2}}})
end
--@auto code Parthero2 btFunc end

--@auto code Parthero3 btFunc
function PartHeroViewController:onParthero3Click()
    Functions.printInfo(self.debug,"Parthero3 button is click!")
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data = {jumpType = JumpType.PartHeroToSelectHero,jumpData ={embattleType = self.jumpData.embattleType,heroType = HeroType.PartHero3}}})
end
--@auto code Parthero3 btFunc end

--@auto code Parthero4 btFunc
function PartHeroViewController:onParthero4Click()
    Functions.printInfo(self.debug,"Parthero4 button is click!")
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data ={jumpType = JumpType.PartHeroToSelectHero,jumpData ={embattleType = self.jumpData.embattleType,heroType = HeroType.PartHero4}}})
end
--@auto code Parthero4 btFunc end

--@auto code Parthero5 btFunc
function PartHeroViewController:onParthero5Click()
    Functions.printInfo(self.debug,"Parthero5 button is click!")
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data ={jumpType = JumpType.PartHeroToSelectHero,jumpData ={embattleType = self.jumpData.embattleType,heroType = HeroType.PartHero5}}})
end
--@auto code Parthero5 btFunc end

--@auto code Parthero6 btFunc
function PartHeroViewController:onParthero6Click()
    Functions.printInfo(self.debug,"Parthero6 button is click!")
    GameCtlManager:push("app.ui.selectHeroSystem.SelectHeroViewController",{data ={jumpType = JumpType.PartHeroToSelectHero,jumpData ={embattleType = self.jumpData.embattleType,heroType = HeroType.PartHero6}}})
end
--@auto code Parthero6 btFunc end

--@auto button backcall end


--@auto code view display func
function PartHeroViewController:onCreate()
    Functions.printInfo(self.debug_b," PartHeroViewController controller create!")
end
function PartHeroViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
function PartHeroViewController:onDisplayView()
	Functions.printInfo(self.debug_b," PartHeroViewController view enter display!")

    --新手引导
        self._partHero1Bt_t = self._partHero1_t:getChildByName("model")
    --end
    self._partHero1_t:getChildByName("model"):onTouch(Functions.createClickListener(handler(self, self.onParthero1Click), ""))
    self._partHero2_t:getChildByName("model"):onTouch(Functions.createClickListener(handler(self, self.onParthero2Click), ""))
    self._partHero3_t:getChildByName("model"):onTouch(Functions.createClickListener(handler(self, self.onParthero3Click), ""))
    self._partHero4_t:getChildByName("model"):onTouch(Functions.createClickListener(handler(self, self.onParthero4Click), ""))
    self._partHero5_t:getChildByName("model"):onTouch(Functions.createClickListener(handler(self, self.onParthero5Click), ""))
    self._partHero6_t:getChildByName("model"):onTouch(Functions.createClickListener(handler(self, self.onParthero6Click), ""))
    Functions.cleanHeroHead(self._partHero1_t,2)
    Functions.cleanHeroHead(self._partHero2_t,2)
    Functions.cleanHeroHead(self._partHero3_t,2)
    Functions.cleanHeroHead(self._partHero4_t,2)
    Functions.cleanHeroHead(self._partHero5_t,2)
    Functions.cleanHeroHead(self._partHero6_t,2)
    self:initUiDisplay_() 
end
--@auto code view display func end
function PartHeroViewController:initUiDisplay_()	
	-- Functions.bindMGSDisplay({moneyObj = self._coinText_t,goldObj =self._goldText_t,soulObj =self._soulText_t})
    Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})
    self:setPartHeroLock()
    self:showPartHead()
    self:showFateInf()
    self:showPartAddAtrr( )
end
--设置偏将锁状态，lockLevel暂不用
function PartHeroViewController:setPartHeroLock()
    local partHeroTable = {self._partHero1_t,self._partHero2_t,self._partHero3_t,self._partHero4_t,self._partHero5_t,self._partHero6_t}
    for i=1,6 do
        local partHeroLock = partHeroTable[i]:getChildByName("model"):getChildByName("lock")
        partHeroTable[i]:getChildByName("model"):getChildByName("lock"):getChildByName("text"):setString("Lv" .. tostring(g_partHero.lockLevel[i]))
        if PlayerData.eventAttr.m_level >= g_partHero.lockLevel[i] then
            partHeroLock:setVisible(false)
            partHeroTable[i]:getChildByName("model"):setTouchEnabled(true)
        end

    end
end

--显示偏将头像
function PartHeroViewController:showPartHead()
    local partHeroTable = {self._partHero1_t,self._partHero2_t,self._partHero3_t,self._partHero4_t,self._partHero5_t,self._partHero6_t}
    for k,v in pairs(EmbattleData.PartHeroMark) do
        Functions.cleanHeroHead(partHeroTable[k],1)
        if v > 0 then
            Functions.getHeroHead(partHeroTable[k],{mark = v},2)
        end
    end
end
--显示偏将加成
function PartHeroViewController:showPartAddAtrr( )
    local  attack, hp, fas, faf = Functions.getPartHeroAddAttrs(EmbattleData.PartHeroMark)
    self._attack_t:setString(LanguageConfig.language_sevenStar_5 .. "+ " .. tostring(attack))
    self._wisdom_t:setString(LanguageConfig.language_sevenStar_6 .. "+ " .. tostring(hp))
    self._life_t:setString(LanguageConfig.language_sevenStar_7 .. "+ " .. tostring(fas))
    self._soldiers_t:setString(LanguageConfig.language_sevenStar_4 .. "+ " .. tostring(faf))
end
function PartHeroViewController:showFateInf()
    if EmbattleData.EmbattleInf.MainHero ~= nil and EmbattleData.EmbattleInf.MainHero[1].id > 0 then
        local heroId = EmbattleData.EmbattleInf.MainHero[1].id 
        if self:isShowFateHero(heroId) then
            self:showHeroFate(self._mainFatePanel_t,heroId)
        end
    else
        self._mainFatePanel_t:setVisible(false)
    end
    if EmbattleData.EmbattleInf.ViceHeros[1] ~= nil and EmbattleData.EmbattleInf.ViceHeros[1].id  > 0 then
        local heroId = EmbattleData.EmbattleInf.ViceHeros[1].id 
        if self:isShowFateHero(heroId) then
            self:showHeroFate(self._vice1FatePanel_t,heroId)
        end
    else
        self._vice1FatePanel_t:setVisible(false)
    end
    if EmbattleData.EmbattleInf.ViceHeros[2] ~= nil and EmbattleData.EmbattleInf.ViceHeros[2].id > 0 then
        local heroId = EmbattleData.EmbattleInf.ViceHeros[2].id 
        if self:isShowFateHero(heroId) then
            self:showHeroFate(self._vice2FatePanel_t,heroId)
        end
    else
        self._vice2FatePanel_t:setVisible(false)
    end
end
function PartHeroViewController:showHeroFate(target,heroId)
    target:setVisible(true)
    local heroName = target:getChildByName("heroName")
    heroName:setString(ConfigHandler:getHeroNameOfId(heroId))


    

    local fate1Name = ConfigHandler:getFateName1OfId(heroId)
    local fateInf1 = ConfigHandler:getFateInf1OfId(heroId)
    local fate1InfObj = target:getChildByName("fateInf1")
    fate1InfObj:setString(fate1Name .. "," ..  fateInf1)
    
    local fate1HeroId = ConfigHandler:getFateHero1IdOfId(heroId) 
    if self:isHaveFateHero(fate1HeroId) then 
        fate1InfObj:setTextColor(cc.c3b(0,255,0))
    else
        fate1InfObj:setTextColor(cc.c3b(0,0,0))
    end

    local fate2Name = ConfigHandler:getFateName2OfId(heroId)    
    local fateInf2 = ConfigHandler:getFateInf2OfId(heroId)
    local fate2InfObj = target:getChildByName("fateInf2")
    fate2InfObj:setString(fate2Name .. "," ..  fateInf2)

    local fate2HeroId = ConfigHandler:getFateHero2IdOfId(heroId) 
    if self:isHaveFateHero(fate2HeroId) then 
        fate2InfObj:setTextColor(cc.c3b(0,255,0))
    else
        fate2InfObj:setTextColor(cc.c3b(0,0,0))
    end
end
function PartHeroViewController:onReceivePushData(jump)
    self.jumpType = jump.jumpType
    self.jumpData = jump.jumpData 
end
--接受选将子场景数据
function PartHeroViewController:onReceivePopData(jump)
     self:initUiDisplay_()
end
--判断一个武将是否有缘分武将
function PartHeroViewController:isShowFateHero(heroId )
    local relation = ConfigHandler:getHeroFateInfosOfId(heroId)
    if relation ~= nil  then 
        return true
    else
        return false
    end
end
--是否有缘分偏将将上阵
function PartHeroViewController:isHaveFateHero(fateHeroId)
    for k,v in pairs(EmbattleData.EmbattleInf.PartHero) do 
        if fateHeroId == v.id then
            return true
        end
    end
    return false
end
return PartHeroViewController