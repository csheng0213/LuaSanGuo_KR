--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local TryConnectPopView = class("TryConnectPopView", BasePopView)

local Functions = require("app.common.Functions")

TryConnectPopView.csbResPath = "cs/csb"
TryConnectPopView.debug = true
TryConnectPopView.studioSpriteFrames = {"InfoPopUI","CBO_diban","PopUI" }
--@auto code head end

--@Pre loading
TryConnectPopView.spriteFrameNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #TryConnectPopView.studioSpriteFrames > 0 then
    TryConnectPopView.spriteFrameNames = TryConnectPopView.spriteFrameNames or {}
    table.insertto(TryConnectPopView.spriteFrameNames, TryConnectPopView.studioSpriteFrames)
end
function TryConnectPopView:onInitUI()

    --output list
    self._disTextPanel_t = self.csbNode:getChildByName("disTextPanel")
	self._point_t = self.csbNode:getChildByName("disTextPanel"):getChildByName("point")
	self._conFailText_t = self.csbNode:getChildByName("conFailText")
	
    --label list
    
    --button list
    self._receiveBt_t = self.csbNode:getChildByName("receiveBt")
	self._receiveBt_t:onTouch(Functions.createClickListener(handler(self, self.onReceivebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Receivebt btFunc
function TryConnectPopView:onReceivebtClick()
    Functions.printInfo(self.debug,"Receivebt button is click!")
    
    self:openReConnectView()
    NetWork:reSendToServer()
end
--@auto code Receivebt btFunc end

--@auto button backcall end


--@auto code output func
function TryConnectPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function TryConnectPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    self.animaCount = 1
    local action = UIActionTool:createLoopFunc(0.3, function()
        if self.animaCount > 3 then 
            self.animaCount = 1
        end
        
        Functions.loadImageWithSprite(self._point_t, string.format("cs/ui_res/PopUI/dian%d.png", self.animaCount))
        self.animaCount = self.animaCount + 1
    end)
    self._point_t:runAction(action)
    
    -- self:openReConnectView()
    self:closeReAnima()
end

function TryConnectPopView:closeReAnima()
    self._receiveBt_t:setVisible(true)
    self._conFailText_t:setVisible(true)
    self._disTextPanel_t:setVisible(false)
end

function TryConnectPopView:openReConnectView()
    self._receiveBt_t:setVisible(false)
    self._conFailText_t:setVisible(false)
    self._disTextPanel_t:setVisible(true)
end

function TryConnectPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return TryConnectPopView