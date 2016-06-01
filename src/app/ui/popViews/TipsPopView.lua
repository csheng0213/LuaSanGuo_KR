--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local TipsPopView = class("TipsPopView", BasePopView)

local Functions = require("app.common.Functions")

TipsPopView.csbResPath = "tyj/csb"
TipsPopView.debug = true
TipsPopView.studioSpriteFrames = {"CBO_tipsOnw" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #TipsPopView.studioSpriteFrames > 0 then
    TipsPopView.spriteFrameNames = TipsPopView.spriteFrameNames or {}
    table.insertto(TipsPopView.spriteFrameNames, TipsPopView.studioSpriteFrames)
end
function TipsPopView:onInitUI()

    --output list
    self._npc_t = self.csbNode:getChildByName("Panel_1"):getChildByName("npc")
	self._inf_t = self.csbNode:getChildByName("Panel_1"):getChildByName("inf")
	
    --label list
    
    --button list
    self._cancelBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("cancelBt")
	self._cancelBt_t:onTouch(Functions.createClickListener(handler(self, self.onCancelbtClick), ""))

	self._affirmBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("affirmBt")
	self._affirmBt_t:onTouch(Functions.createClickListener(handler(self, self.onAffirmbtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Cancelbt btFunc
function TipsPopView:onCancelbtClick()
    Functions.printInfo(self.debug,"Cancelbt button is click!")
    if self.handler1 ~= nil then
        self.handler1()
    end

    if self.close ~= nil then
        self:close()
    end
end
--@auto code Cancelbt btFunc end

--@auto code Affirmbt btFunc
function TipsPopView:onAffirmbtClick()
    Functions.printInfo(self.debug,"Affirmbt button is click!")
    if self.handler ~= nil then
        self.handler()
    end
    if self.close ~= nil then
        self:close()
    end
end
--@auto code Affirmbt btFunc end

--@auto button backcall end

--@auto code output func
function TipsPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    
    --初始化npc
    Functions.loadImageWithSprite(self._npc_t, "npc/NPC_lb_gold.png")

    if self._curInf then
        self._inf_t:setString(self._curInf)
    end

    if self._curCancelText then
        self._cancelBt_t:setTitleText(self._curCancelText)
    end

    if self._curAffirmText then
        self._affirmBt_t:getChildByName("affirmText"):ignoreContentAdaptWithSize(true)
        Functions.loadImageWithWidget(self._affirmBt_t:getChildByName("affirmText"), self._curAffirmText)
    end

    if self.isChangeStyle then
        self._cancelBt_t:setVisible(false)
        local  temp = self._affirmBt_t:getParent():getContentSize().width/2
        self._affirmBt_t:setPositionX(temp)
    end
    if self.npcRes ~= nil then
        self._npc_t:setVisible(true)
        Functions.loadImageWithSprite(self._npc_t,self.npcRes)
    end
end

function TipsPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function TipsPopView:setTipsInf(inf)
    self._curInf = inf
end
function TipsPopView:setHandler(handler)
	self.handler = handler
end
function TipsPopView:setHandler1(handler1)
    self.handler1 = handler1
end
function TipsPopView:cancelBtText(text)
    self._curCancelText = text
end
function TipsPopView:affirmBtText(text)
    self._curAffirmText = text
end
function TipsPopView:changeStyle( )
    self.isChangeStyle = true
end
function TipsPopView:isShowNpc(npcRes)
    self.npcRes = npcRes
end
return TipsPopView