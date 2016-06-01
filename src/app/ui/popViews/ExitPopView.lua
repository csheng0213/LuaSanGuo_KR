local ExitPopView = class("ExitPopView", function()
    return ccui.Layout:create()
end)

local Functions = require("app.common.Functions")

function ExitPopView:ctor()
    self:init()
end

function ExitPopView:init()
    ResManager:loadSpriteFrames({ "CBO_tipsOnw" }, handler(self, self.initUI))

    Functions.addCleanFuncWithNode(self, function()
        ResManager:removeSpriteFrames({ "CBO_tipsOnw" })
    end)
end

function ExitPopView:initUI()


    --添加遮挡层
    self.blackColorLayers_t = CommonWidgets:getBlackColorLayer()
    self.blackColorLayers_t:move(display.cx, display.cy)
    self:addChild(self.blackColorLayers_t)

    self.blackColorLayers_t:onTouch(Functions.createTouchListener(function()
        if self.handler1 ~= nil then 
            self.handler1()
        end
        self:removeSelf()
    end))

    self.csbNode = cc.CSLoader:createNode("tyj/csb/TipsPopUI.csb")
    self.csbNode:move(display.cx, display.cy)
    self:addChild(self.csbNode)

    --output list
    self._npc_t = self.csbNode:getChildByName("Panel_1"):getChildByName("npc")
	self._inf_t = self.csbNode:getChildByName("Panel_1"):getChildByName("inf")
	
    --label list
    
    --button list
    self._cancelBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("cancelBt")
	self._cancelBt_t:onTouch(Functions.createClickListener(handler(self, self.onCancelbtClick), ""))

	self._affirmBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("affirmBt")
	self._affirmBt_t:onTouch(Functions.createClickListener(handler(self, self.onAffirmbtClick), ""))

    self:onDisplayView()
end

function ExitPopView:onCancelbtClick()
    Functions.printInfo(self.debug,"Cancelbt button is click!")
    if self.handler1 ~= nil then 
        self.handler1()
    end
    self:removeSelf()
end

function ExitPopView:onAffirmbtClick()
    Functions.printInfo(self.debug,"Affirmbt button is click!")
    if self.handler ~= nil then 
        self.handler()
    end
    self:removeSelf()
end

function ExitPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    
    -- --初始化npc
    -- Functions.loadImageWithSprite(self._npc_t, "npc/NPC_lb_gold.png")

    if self._curInf then
        self._inf_t:setString(self._curInf)
    end

    -- if self._curCancelText then
    --     self._cancelBt_t:setTitleText(self._curCancelText)
    -- end

    -- if self._curAffirmText then
    --     self._affirmBt_t:getChildByName("affirmText"):ignoreContentAdaptWithSize(true)
    --     Functions.loadImageWithWidget(self._affirmBt_t:getChildByName("affirmText"), self._curAffirmText)
    -- end

    -- if self.isChangeStyle then
    --     self._cancelBt_t:setVisible(false)
    --     local  temp = self._affirmBt_t:getParent():getContentSize().width/2
    --     self._affirmBt_t:setPositionX(temp)
    -- end
    if self.npcRes ~= nil then
        self._npc_t:setVisible(true)
        Functions.loadImageWithSprite(self._npc_t,self.npcRes)
    end

    self.csbNode:getChildByName("Panel_1"):setScale(0.6)
    local scaleTo1 = cc.ScaleTo:create(0.1, 1.2, 1.2)
    local scaleTo2 = cc.ScaleTo:create(0.1, 1, 1)
    local seq = cc.Sequence:create(scaleTo1, scaleTo2,NULL);
    self.csbNode:getChildByName("Panel_1"):runAction(seq)
end

function ExitPopView:setTipsInf(inf)
    self._curInf = inf
end
function ExitPopView:setHandler(handler)
	self.handler = handler
end
function ExitPopView:setHandler1(handler1)
    self.handler1 = handler1
end
function ExitPopView:cancelBtText(text)
    self._curCancelText = text
end
function ExitPopView:affirmBtText(text)
    self._curAffirmText = text
end
function ExitPopView:changeStyle()
    self.isChangeStyle = true
end
function ExitPopView:isShowNpc(npcRes)
    self.npcRes = npcRes
end

return ExitPopView