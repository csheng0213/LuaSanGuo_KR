--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local CombatBeforePopView = class("CombatBeforePopView", BasePopView)

local Functions = require("app.common.Functions")

CombatBeforePopView.csbResPath = "cs/csb"
CombatBeforePopView.debug = true
CombatBeforePopView.studioSpriteFrames = {"CombatBeforeUI","CombatBeforePopUI" }
--@auto code head end

--@Pre loading
CombatBeforePopView.spriteFrameNames = 
    {
        "headPilistRes"
    }

CombatBeforePopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #CombatBeforePopView.studioSpriteFrames > 0 then
    CombatBeforePopView.spriteFrameNames = CombatBeforePopView.spriteFrameNames or {}
    table.insertto(CombatBeforePopView.spriteFrameNames, CombatBeforePopView.studioSpriteFrames)
end
function CombatBeforePopView:onInitUI()

    --output list
    self._vsImage_t = self.csbNode:getChildByName("beforPanel"):getChildByName("vsImage")
	self._heroPanel_t = self.csbNode:getChildByName("heroPanel")
	self._enemyPanel_t = self.csbNode:getChildByName("enemyPanel")
	
    --label list
    
    --button list
    self._backBt_t = self.csbNode:getChildByName("beforPanel"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), "zoom"))

	self._bzBt_t = self.csbNode:getChildByName("beforPanel"):getChildByName("bzBt")
	self._bzBt_t:onTouch(Functions.createClickListener(handler(self, self.onBzbtClick), "zoom"))

	self._startBt_t = self.csbNode:getChildByName("startBt")
	self._startBt_t:onTouch(Functions.createClickListener(handler(self, self.onStartbtClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt btFunc
function CombatBeforePopView:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    local controller = self._controller_t
    controller:closeChildView(self)
    controller:quitCombat()
end
--@auto code Backbt btFunc end

--@auto code Bzbt btFunc
function CombatBeforePopView:onBzbtClick()
    Functions.printInfo(self.debug,"Bzbt button is click!")

    GameCtlManager:push("app.ui.embattleSystem.EmbattleViewController", { data = { jumpData = { embattleType = EmbattleData.EmbattleTypeEnum.attack } } } )
end
--@auto code Bzbt btFunc end

--@auto code Startbt btFunc
function CombatBeforePopView:onStartbtClick()
    Functions.printInfo(self.debug,"Startbt button is click!")
    
    self.fightStartListener()
    self._controller_t:closeChildView(self)
end
--@auto code Startbt btFunc end

--@auto button backcall end


--@auto code output func
function CombatBeforePopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	
    self:initHeroDis(self._heroPanel_t, data.heroInfo, true)
    self:initHeroDis(self._enemyPanel_t, data.enemyInfo, false)
    
    self.fightStartListener = data.fightCall

    self._startBt_t:runAction(UIActionTool:createScaleAction({ time = 0.4, minScale = 1, maxScale = 1.2 }))
end

function CombatBeforePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

--@private
function CombatBeforePopView:initHeroDis(infoView, info, isfrdly)

    --设置总战力显示文字
    local fightPower_text = infoView:getChildByName("Text_5")
    fightPower_text:setString(LanguageConfig.ui_combatBefore_1)
    local fightPower = infoView:getChildByName("fightPower")
    if fightPower then
        fightPower:setString(info.power)
    end
    
    local name = infoView:getChildByName("name")
    if name then
        name:setString(info.name)
    end

     
    if info.heros and #info.heros > 0 then
        local zxImage     = infoView:getChildByName("zxImage")
        local zxImageName = ConfigHandler:getHeroZxResOfId(info.heros[1])
        Functions.loadImageWithWidget(zxImage, "cs/ui_res/CombatUI/" .. zxImageName)
        if not isfrdly then
            zxImage:setFlippedX(true)
            zxImage:setFlippedY(true)
        end

        local zxNameView = infoView:getChildByName("zxName")
        local zxName     = ConfigHandler:getHeroZxNameOfId(info.heros[1])
        zxNameView:setString(zxName)

        local zxDisc = infoView:getChildByName("miaoshu_zx")
        local zxDiscString = ConfigHandler:getZxDescriptionOfHeroId(info.heros[1])
        zxDisc:setString(zxDiscString)

        for i=1, 3 do

            local headHead     = infoView:getChildByName("headNode" .. tostring(i))
            local id           = tonumber(info.heros[i])

            if id and id > 0 then
                headHead:setVisible(true)
                Functions.getHeroHead(headHead, { id = id }, 2)
            else
                headHead:setVisible(false)
            end
        end
    else
        for i=1, 3 do
            local headHead     = infoView:getChildByName("headNode" .. tostring(i))
            local headBg       = infoView:getChildByName("herobg" .. tostring(i))
            
            headHead:setVisible(false)
            headBg:setVisible(true)
            headBg:getChildByName("bg"):setVisible(true)
        end
        infoView:getChildByName("zxName"):setVisible(false)
        infoView:getChildByName("miaoshu_zx"):setVisible(false)
    end
    
end

function CombatBeforePopView:updateHeroInfo(heroInfo)
    self:initHeroDis(self._heroPanel_t, heroInfo, true)
end

return CombatBeforePopView