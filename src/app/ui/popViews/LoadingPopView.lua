--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local LoadingPopView = class("LoadingPopView", BasePopView)

local Functions = require("app.common.Functions")

LoadingPopView.csbResPath = "cs/csb"
LoadingPopView.debug = true
LoadingPopView.studioSpriteFrames = {"LoadingPopUI" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #LoadingPopView.studioSpriteFrames > 0 then
    LoadingPopView.spriteFrameNames = LoadingPopView.spriteFrameNames or {}
    table.insertto(LoadingPopView.spriteFrameNames, LoadingPopView.studioSpriteFrames)
end
function LoadingPopView:onInitUI()

    --output list
    self._Text_1_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Text_1")
	
    --label list
    
    --button list
    self._Panel_1_t = self.csbNode:getChildByName("Panel_1")
	self._Panel_1_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_1Click), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Panel_1 btFunc
function LoadingPopView:onPanel_1Click()
    Functions.printInfo(self.debug,"Panel_1 button is click!")
end
--@auto code Panel_1 btFunc end

--@auto button backcall end


--@auto code output func
function LoadingPopView:getPopAction()
    Functions.printInfo(self.debug,"pop actionFunc is call")    
end

function LoadingPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
end

function LoadingPopView:onCreate()
    Functions.printInfo(self.debug,"child class create call ")

    self:setPosition(cc.p(display.cx, display.cy))
  

end
--@auto code output func end

--@public func
function LoadingPopView:setInfo(info)
    self._Text_1_t:setString(info)
end

function LoadingPopView:openHttpLindedDis()
    self._Text_1_t:setString("网络链接中")
--    local animationSprite = cc.Sprite:create()
--    animationSprite:setPosition(cc.p(self:getContentSize().width/2, self:getContentSize().height/2))
--    self:addChild(animationSprite)
-- 
--    local animation = cc.Animation:create()
--    animation:addSpriteFrameWithFile("")
--    local action = cc.Animate:create()
--    action:setAnimation(animation)
--    transition.execute(animationSprite, cc.RepeatForever:create(action))
end

function LoadingPopView:openResLoadDis()
    self._Text_1_t:setString("资源加载中")
    
end

function LoadingPopView:openHttpFailDis(parameters)
    self._Text_1_t:setString("网络加载失败")
end


return LoadingPopView