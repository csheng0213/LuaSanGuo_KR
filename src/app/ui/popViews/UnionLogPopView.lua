--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionLogPopView = class("UnionLogPopView", BasePopView)

local Functions = require("app.common.Functions")

UnionLogPopView.csbResPath = "lk/csb"
UnionLogPopView.debug = true
UnionLogPopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","UnionUI" }
--@auto code head end
--@Pre loading
UnionLogPopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionLogPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #UnionLogPopView.studioSpriteFrames > 0 then
    UnionLogPopView.spriteFrameNames = UnionLogPopView.spriteFrameNames or {}
    table.insertto(UnionLogPopView.spriteFrameNames, UnionLogPopView.studioSpriteFrames)
end
function UnionLogPopView:onInitUI()

    --output list
    self._ListView_log_t = self.csbNode:getChildByName("Panel_log_1"):getChildByName("ListView_log")
	self._Text_log_msg_t = self.csbNode:getChildByName("Panel_log_1"):getChildByName("ListView_log"):getChildByName("model"):getChildByName("Text_log_msg")
	
    --label list
    
    --button list
    self._Button_log_close_t = self.csbNode:getChildByName("Panel_log_1"):getChildByName("Button_log_close")
	self._Button_log_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_log_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_log_close btFunc
function UnionLogPopView:onButton_log_closeClick()
    Functions.printInfo(self.debug,"Button_log_close button is click!")
    --关闭公会日志
    self._controller_t:closeChildView(self)
end
--@auto code Button_log_close btFunc end

--@auto button backcall end


--@auto code output func
function UnionLogPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionLogPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	self:sendLog()
end

function UnionLogPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

--查看日志
function UnionLogPopView:sendLog()
    Functions.printInfo(self.debug,"sendGodInfo ")

    local onLog= function(event)
            if event.reqtype == 12 then
                local listHandler = function(index, widget,data)
                    local text = widget:getChildByName("Text_log_msg")
                    text:setText(TimerManager:formatTime("%m-%d %H:%M", data.time).." "..data.msg)
                    self._ListView_log_t:scrollToBottom(0.001,false)
                end
                --绑定响应事件函数
                Functions.bindListWithData(self._ListView_log_t, event.data, listHandler)
            end

    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onLog,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 12})

end

return UnionLogPopView