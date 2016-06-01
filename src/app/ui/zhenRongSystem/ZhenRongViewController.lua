--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local ZhenRongViewController = class("ZhenRongViewController", BaseViewController)

local Functions = require("app.common.Functions")

ZhenRongViewController.debug = true
ZhenRongViewController.modulePath = ...
ZhenRongViewController.studioSpriteFrames = {"CBO_ban","SelectHeroUI_Text","EquipmentUI_Text","CB_blackbg" }
--@auto code head end

--@Pre loading
ZhenRongViewController.spriteFrameNames = 
    {
        "equipmentRes",
    }

ZhenRongViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #ZhenRongViewController.studioSpriteFrames > 0 then
    ZhenRongViewController.spriteFrameNames = ZhenRongViewController.spriteFrameNames or {}
    table.insertto(ZhenRongViewController.spriteFrameNames, ZhenRongViewController.studioSpriteFrames)
end
function ZhenRongViewController:onDidLoadView()

    --output list
    self._hero_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("hero_1")
	self._hero_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("hero_2")
	self._hero_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("hero_3")
	
    --label list
    
    --button list
    self._backBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel_3_3"):getChildByName("topbarBg_10_4"):getChildByName("Panel_3"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt btFunc
function ZhenRongViewController:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    GameCtlManager:pop(self)
end
--@auto code Backbt btFunc end

--@auto button backcall end


--@auto code view display func
function ZhenRongViewController:onCreate()
    Functions.printInfo(self.debug_b," ZhenRongViewController controller create!")
end

function ZhenRongViewController:onDisplayView()
	Functions.printInfo(self.debug_b," ZhenRongViewController view enter display!")
    self:initUiDisplay_()
end
--@auto code view display func end
function ZhenRongViewController:initUiDisplay_()
    -- if self.jumpType == 1 then
    --     if not table.empty(self.jumpData[1]) then
    --         self:displayHeroInfOfRank(self._hero_1_t,self.jumpData[1],true)
    --     end
    --     if not table.empty(self.jumpData[2]) then
    --         self:displayHeroInfOfRank(self._hero_2_t,self.jumpData[2],false)
    --     end
    --     if not table.empty(self.jumpData[3]) then
    --         self:displayHeroInfOfRank(self._hero_3_t,self.jumpData[3],false)
    --     end
    -- elseif self.jumpType == 2 then
    --     if self.jumpData[1] ~= nil then
    --         self:displayHeroInfOfTianTi(self._hero_1_t,self.jumpData[1],true)
    --     end
    --     if self.jumpData[2] ~= nil then
    --         self:displayHeroInfOfTianTi(self._hero_2_t,self.jumpData[2],false)
    --     end
    --     if self.jumpData[3] ~= nil then
    --         self:displayHeroInfOfTianTi(self._hero_3_t,self.jumpData[3],false)
    --     end
    -- end
    if self.jumpData[1] ~= nil then
        self:displayHeroInf(self._hero_1_t,self.jumpData[1],1,self.jumpType)
    end
    if self.jumpData[2] ~= nil then
        self:displayHeroInf(self._hero_2_t,self.jumpData[2],2,self.jumpType)
    end
    if self.jumpData[3] ~= nil then
        self:displayHeroInf(self._hero_3_t,self.jumpData[3],3,self.jumpType)
    end

end
function ZhenRongViewController:displayHeroInf(target,heroInf,pos,embattleType)
    local chakanBt = target:getChildByName("chakanBt")
    if heroInf.id ~= nil and  heroInf.id > 0  then
        local nameView = target:getChildByName("name")
        local bigClass, smallClass = Functions.formatHeroClass(heroInf.class)
        local nameString = "LV." .. heroInf.level .. ConfigHandler:getHeroNameOfId(heroInf.id,bigClass)
        if smallClass > 0 then 
            nameString = nameString .. "+" .. tostring(smallClass)
        end

        local colorValue = {
            cc.c3b(255,255,255), --白
            cc.c3b(0,255,0),     --绿
            cc.c3b(0,0,255),     --蓝
            cc.c3b(255,115,215),   --紫
            cc.c3b(255,195,25),   --橙
            cc.c3b(145,15,0),     --红
            cc.c3b(0,0,0),     --黑
        }

        nameView:setColor(colorValue[bigClass])
        nameView:setString(nameString)
        nameView:setVisible(true)

        local heroView = target:getChildByName("heroView") 
        local star = ConfigHandler:getHeroStarOfId(heroInf.id) 
        local heroImg = ""
        if star > 5 then
            heroImg = ConfigHandler:getHeroCardImageOfId(heroInf.id,bigClass)
            heroImg = string.split(heroImg,".png")
            heroImg = heroImg[1] .. "_N.png"
            Functions.loadImageWithSprite(heroView,heroImg,0.6)
        else  
            heroImg = ConfigHandler:getHeroCardImageOfId(heroInf.id)         
            Functions.loadImageWithSprite(heroView,heroImg,0.5)
        end
        heroView:setVisible(true)
        local total = math.floor(heroInf.fight)
        local wuli = ConfigHandler:getHeroWuliId(heroInf.id)
        local zhili = ConfigHandler:getHeroZhiliId(heroInf.id)
        local tongyu = ConfigHandler:getHeroTongyuId(heroInf.id)
        local heroAttr = {total,wuli,zhili,tongyu,ConfigHandler:getHeroZxNameOfId(heroInf.id)}
        for i=1,5 do
            local lab = target:getChildByTag(i)
            lab:setString(tostring(heroAttr[i]))
            lab:setVisible(true)
        end
        local chakanBtClickHander = function( )
            self:openChildView("app.ui.popViews.ZhenRongEquipPopView", { isRemove = false, data = {equipInf = heroInf.equip,pos = pos,embattleType = embattleType,heroInf= {nameString = nameString ,heroImg = heroImg,star = star}} })   
        end
        chakanBt:setVisible(true)
        chakanBt:onTouch(Functions.createClickListener(chakanBtClickHander, ""))
    else
        chakanBt:setVisible(false)
    end
end

function ZhenRongViewController:onReceivePushData(jump)
    self.jumpType = jump.jumpType
    self.jumpData = jump.jumpData
end
return ZhenRongViewController