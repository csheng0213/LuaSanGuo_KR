--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionMsgPopView = class("UnionMsgPopView", BasePopView)

local Functions = require("app.common.Functions")

UnionMsgPopView.csbResPath = "lk/csb"
UnionMsgPopView.debug = true
UnionMsgPopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","UnionUI","CBO_union_dialogue_ban" }
--@auto code head end
--@Pre loading
UnionMsgPopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionMsgPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #UnionMsgPopView.studioSpriteFrames > 0 then
    UnionMsgPopView.spriteFrameNames = UnionMsgPopView.spriteFrameNames or {}
    table.insertto(UnionMsgPopView.spriteFrameNames, UnionMsgPopView.studioSpriteFrames)
end
function UnionMsgPopView:onInitUI()

    --output list
    self._TextField_msg_t = self.csbNode:getChildByName("Panel_msg_3"):getChildByName("TextField_msg")
	self._ListView_msg_t = self.csbNode:getChildByName("Panel_msg_3"):getChildByName("ListView_msg")
	
    --label list
    
    --button list
    self._Button_close_t = self.csbNode:getChildByName("Panel_msg_3"):getChildByName("Button_close")
	self._Button_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_closeClick), "zoom"))

	self._Button_Input_send_t = self.csbNode:getChildByName("Panel_msg_3"):getChildByName("Button_Input_send")
	self._Button_Input_send_t:onTouch(Functions.createClickListener(handler(self, self.onButton_input_sendClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_input_send btFunc
function UnionMsgPopView:onButton_input_sendClick()
    Functions.printInfo(self.debug,"Button_input_send button is click!")
    --发送公会留言
    self:sendMsgtText()
    self._TextField_msg_t:setText("")
end
--@auto code Button_input_send btFunc end

--@auto code Button_close btFunc
function UnionMsgPopView:onButton_closeClick()
    Functions.printInfo(self.debug,"Button_close button is click!")
    
    GameEventCenter:removeEventListenersByEvent(UnionData.ADD_UNION_LIUYAN_EVENT)
    --离开公会留言
    self:sendleave()
    
end
--@auto code Button_close btFunc end

--@auto button backcall end


--@auto code output func
function UnionMsgPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionMsgPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    self._TextField_msg_t:setPlaceHolder(LanguageConfig.ui_Union_36)
    self._TextField_msg_t:onEvent(Functions.createInputListener(self:getController(), 300))

	--查询公会留言
	self:sendMsg()
end

function UnionMsgPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

--查询公会留言
function UnionMsgPopView:sendMsg()
    Functions.printInfo(self.debug,"sendMsg")
    local onSendMsg = function(event)
        if event.reqtype == 13 then
            local msgList = event.data

            local listHandler = function(index, widget,data)
                local text = widget:getChildByName("Text_msg_string")
                text:setText(data.time.." "..data.sender.." "..data.msg)
                self._ListView_msg_t:scrollToBottom(0.001,false)
            end
            --绑定响应事件函数
            Functions.bindListWithData(self._ListView_msg_t, msgList, listHandler)
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onSendMsg,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 13 })
    
    local onAddLiuYan = function(event)
        self._ListView_msg_t:pushBackDefaultItem()
        local widget = self._ListView_msg_t:getItems()
        local text = widget[#widget]:getChildByName("Text_msg_string")
        local buf = TimerManager:formatTime("%m-%d %H:%M", event.data.time)
        text:setText( buf.." "..event.data.sender.." "..event.data.msg )
    end
    GameEventCenter:addEventListener(UnionData.ADD_UNION_LIUYAN_EVENT, onAddLiuYan)
    
end
--接收一条公会留言
function UnionMsgPopView:sendMsgtText()
    Functions.printInfo(self.debug,"sendMsgtText")
    local onSendMsgText = function(event)
		if event.reqtype == 14 then
			UnionData:addUnionLiuYan(event.data)
		end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onSendMsgText,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 14, data = { msg = self._TextField_msg_t:getString() } })
end

--离开公会留言
function UnionMsgPopView:sendleave()
    Functions.printInfo(self.debug,"sendMsgtText")
    local onsSendleave = function(event)
        if event.reqtype == 15 then
            self._controller_t:closeChildView(self)
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onsSendleave,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 15 })
end

return UnionMsgPopView