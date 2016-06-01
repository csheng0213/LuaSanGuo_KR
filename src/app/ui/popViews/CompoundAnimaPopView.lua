--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local CompoundAnimaPopView = class("CompoundAnimaPopView", BasePopView)

local Functions = require("app.common.Functions")

CompoundAnimaPopView.csbResPath = "lk/csb"
CompoundAnimaPopView.debug = true
CompoundAnimaPopView.studioSpriteFrames = {"CC_comCard" }
--@auto code head end

--@Pre loading
CompoundAnimaPopView.spriteFrameNames = 
{
        "headPilistRes", "heroCardRes"
}

CompoundAnimaPopView.animaNames = 
{
        "Compound_card"
}

--@auto code uiInit
--add spriteFrames
if #CompoundAnimaPopView.studioSpriteFrames > 0 then
    CompoundAnimaPopView.spriteFrameNames = CompoundAnimaPopView.spriteFrameNames or {}
    table.insertto(CompoundAnimaPopView.spriteFrameNames, CompoundAnimaPopView.studioSpriteFrames)
end
function CompoundAnimaPopView:onInitUI()

    --output list
    self._Sprite_bao_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Sprite_bao")
	self._Sprite_kuang_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Sprite_kuang")
	self._Sprite_guang_1_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Sprite_guang_1")
	self._Sprite_guang_2_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Sprite_guang_2")
	self._ProjectNode_card_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("ProjectNode_card")
	
    --label list
    
    --button list
    self._Panel_card_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_card")
	self._Panel_card_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_cardClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Panel_card btFunc
function CompoundAnimaPopView:onPanel_cardClick()
    Functions.printInfo(self.debug,"Panel_card button is click!")
end
--@auto code Panel_card btFunc end

--@auto button backcall end


--@auto code output func
function CompoundAnimaPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function CompoundAnimaPopView:onClose()
    Functions.printInfo(self.debug,"onClose")
    self.close(self)
end

function CompoundAnimaPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
    Functions.playSound("get_hero.mp3")
	local mark = data.mark
    self._Sprite_bao_t:setScale(2)
    Functions.playSequenceAction(self._Sprite_bao_t, { { actionName = "Compound_card",repeatNum = 1} }) 
    
    self._Sprite_kuang_t:setScale(0.0001)
    self._Sprite_kuang_t:setVisible(true)
    local pScale_kuang = cc.ScaleTo:create(0.3,1.3)
    local seq_kuang = cc.Sequence:create(cc.DelayTime:create(1.0), pScale_kuang ) --顺序执行
    self._Sprite_kuang_t:runAction(seq_kuang)
    
    --self._Sprite_guang_1_t:setScale(0.0001)
    Functions.loadImageWithSprite(self._Sprite_guang_1_t, "lk/uiFonts_res/soldier_shengji_guang.png", 0.0001)
    self._Sprite_guang_1_t:setVisible(true)
    local scaleto = cc.ScaleTo:create(0.3,1.5)
    local rotateto_guang = cc.RotateTo:create(10.0, 1800)
    local spawn_guang = cc.Spawn:create(scaleto, rotateto_guang)--同步
    local seq_guang = cc.Sequence:create(cc.DelayTime:create(1.0), spawn_guang)--顺序执行
    self._Sprite_guang_1_t:runAction(seq_guang)
    
    Functions.loadImageWithSprite(self._Sprite_guang_2_t, "lk/uiFonts_res/soldier_shengji_guang.png", 0.0001)
    --self._Sprite_guang_2_t:setScale(0.0001)
    self._Sprite_guang_2_t:setVisible(true)
    local scaleto2 = cc.ScaleTo:create(0.3,1.5)
    local rotateto_guang2 = cc.RotateTo:create(10.0, -1800)
    local spawn_guang2 = cc.Spawn:create(scaleto2, rotateto_guang2)--同步
    local seq_guang2 = cc.Sequence:create(cc.DelayTime:create(1.0), spawn_guang2)--顺序执行
    self._Sprite_guang_2_t:runAction(seq_guang2)
    
    Functions.getHeroCrad(self._ProjectNode_card_t, {mark = mark})
    self._ProjectNode_card_t:setScale(0.0001)
    self._ProjectNode_card_t:setVisible(true)
    local pScale = cc.ScaleTo:create(0.1,1.3)
    local seq = cc.Sequence:create(cc.DelayTime:create(1.0), pScale, cc.DelayTime:create(2.5), cc.CallFunc:create(function() self:onClose() end)) --顺序执行
    self._ProjectNode_card_t:runAction(seq)
    
end

function CompoundAnimaPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return CompoundAnimaPopView