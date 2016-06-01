--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local EnhanceActionPopView = class("EnhanceActionPopView", BasePopView)

local Functions = require("app.common.Functions")

EnhanceActionPopView.csbResPath = "lk/csb"
EnhanceActionPopView.debug = true
EnhanceActionPopView.studioSpriteFrames = { }
--@auto code head end

--@Pre loading
EnhanceActionPopView.spriteFrameNames = 
    {
        "heroCardRes"
    }

EnhanceActionPopView.animaNames = 
    {
        "intensify_bao", "intensify_card"
    }
    
--@auto code uiInit
--add spriteFrames
if #EnhanceActionPopView.studioSpriteFrames > 0 then
    EnhanceActionPopView.spriteFrameNames = EnhanceActionPopView.spriteFrameNames or {}
    table.insertto(EnhanceActionPopView.spriteFrameNames, EnhanceActionPopView.studioSpriteFrames)
end
function EnhanceActionPopView:onInitUI()

    --output list
    self._Sprite_1_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_1")
	self._Sprite_2_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_2")
	self._Sprite_3_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_3")
	self._Sprite_4_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_4")
	self._ProjectNode_card_t = self.csbNode:getChildByName("ProjectNode_card")
	
    --label list
    
    --button list
    
end
--@auto code uiInit end


--@auto code output func
function EnhanceActionPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function EnhanceActionPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    
    
    --第一个动画
    local animationSprite = cc.Sprite:create()
    animationSprite:setPosition(self._Sprite_1_t:getPosition())
    animationSprite:setScale(self._Sprite_1_t:getScale())
    self._Sprite_1_t:getParent():addChild(animationSprite)
    local callBack = function(target)
        target:removeFromParent()
    end
    Functions.playSequenceAction(animationSprite, { { actionName = "intensify_card",repeatNum = 6} }, 0, 1,true, callBack ) 
    --self._Sprite_1_t:setVisible(true)

    local pMoveToOne = cc.MoveTo:create(0.2, cc.p( display.width/2, display.cy ))
    local scaletoOne = cc.ScaleTo:create(0.2,0.4)
    local SequenceOne = cc.Sequence:create(cc.DelayTime:create(0.3), pMoveToOne)
    local SequenceOne2 = cc.Sequence:create(cc.DelayTime:create(0.3), scaletoOne)
    local seq_actio_One = cc.Spawn:create(SequenceOne, SequenceOne2)
    animationSprite:runAction(seq_actio_One)
    
    --第二个图片
    local animationSprite2 = cc.Sprite:create()
    animationSprite2:setPosition(self._Sprite_2_t:getPosition())
    animationSprite2:setScale(self._Sprite_2_t:getScale())
    self._Sprite_2_t:getParent():addChild(animationSprite2)
    
    Functions.playSequenceAction(animationSprite2, {{actionName = "intensify_card",repeatNum = 6}},0,1,true) 
    

    local pMoveToTwo = cc.MoveTo:create(0.2, cc.p( display.width/2, display.height/2 ))
    local scaletoTwo = cc.ScaleTo:create(0.2,0.4)
    local SequenceTwo = cc.Sequence:create(cc.DelayTime:create(0.3), pMoveToTwo)
    local SequenceTwo2 = cc.Sequence:create(cc.DelayTime:create(0.3), scaletoTwo,cc.DelayTime:create(0.3),cc.CallFunc:create(function() self:onTwoDongHua() end))
    local seq_actio_Two = cc.Spawn:create(SequenceTwo, SequenceTwo2)
    animationSprite2:runAction(seq_actio_Two)
    
end
--function EnhanceActionPopView:callBack(target)
--    target:removeFromParent()
--end

function EnhanceActionPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function EnhanceActionPopView:onClose()
    Functions.printInfo(self.debug,"onClose")
    self.close(self)
end

function EnhanceActionPopView:onTwoDongHua()
    Functions.printInfo(self.debug,"onTwoDongHua")
    Functions.playSound("heroupgrade.mp3")
        --卡片动作
    self._Sprite_4_t:setVisible(true)
    Functions.playSequenceAction(self._Sprite_4_t, {{actionName = "intensify_bao",repeatNum = 2}},0,1,true) 
    local scaletoBao = cc.ScaleTo:create(0.2, 1.88)
    local seq_actio_Bao = cc.Sequence:create(scaletoBao)
    self._Sprite_4_t:runAction(seq_actio_Bao)
   
    
    Functions.getHeroCrad(self._ProjectNode_card_t, {mark = EnhanceData.MasterData[1].m_mark})
    self._ProjectNode_card_t:setVisible(true)
    self._ProjectNode_card_t:setScale(0.0001)
    local scaleto = cc.ScaleTo:create(0.12,1.2)
    local seq_actio_Bao = cc.Sequence:create(scaleto, cc.DelayTime:create(2.3),cc.CallFunc:create(function() self:onClose() end))
    self._ProjectNode_card_t:runAction(seq_actio_Bao)
    
end

return EnhanceActionPopView