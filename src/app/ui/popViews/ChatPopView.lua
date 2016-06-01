--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local ChatPopView = class("ChatPopView", BasePopView)

local Functions = require("app.common.Functions")

ChatPopView.csbResPath = "lk/csb"
ChatPopView.debug = true
ChatPopView.studioSpriteFrames = {"ChatPopUI_Text","ChatBgUI","ChatUI" }
--@auto code head end
--@Pre loading
ChatPopView.spriteFrameNames = 
    {
    }

ChatPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #ChatPopView.studioSpriteFrames > 0 then
    ChatPopView.spriteFrameNames = ChatPopView.spriteFrameNames or {}
    table.insertto(ChatPopView.spriteFrameNames, ChatPopView.studioSpriteFrames)
end
function ChatPopView:onInitUI()

    --output list
    self._game_chat_bg_1_t = self.csbNode:getChildByName("Panel_1"):getChildByName("game_chat_bg_1")
	self._TextField_chat_string_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_input_bg"):getChildByName("TextField_chat_string")
	self._Panel_free_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_free")
	self._Text_free_count_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_free"):getChildByName("Text_free_count")
	self._Text_send_money_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Text_send_money")
	self._ListView_chat_t = self.csbNode:getChildByName("Panel_1"):getChildByName("ListView_chat")
	self._Panel_info_text_t = self.csbNode:getChildByName("Panel_1"):getChildByName("ListView_chat"):getChildByName("model"):getChildByName("Panel_info_text")
	self._Text_level_t = self.csbNode:getChildByName("Panel_1"):getChildByName("ListView_chat"):getChildByName("model"):getChildByName("Panel_info_text"):getChildByName("Text_level")
	self._Text_name_t = self.csbNode:getChildByName("Panel_1"):getChildByName("ListView_chat"):getChildByName("model"):getChildByName("Panel_info_text"):getChildByName("Text_name")
	self._Text_time_t = self.csbNode:getChildByName("Panel_1"):getChildByName("ListView_chat"):getChildByName("model"):getChildByName("Panel_info_text"):getChildByName("Text_time")
	self._Image_head_t = self.csbNode:getChildByName("Panel_1"):getChildByName("ListView_chat"):getChildByName("model"):getChildByName("Panel_info_text"):getChildByName("Panel_head"):getChildByName("Image_head")
	self._Text_msg_t = self.csbNode:getChildByName("Panel_1"):getChildByName("ListView_chat"):getChildByName("model"):getChildByName("Panel_info_text"):getChildByName("Text_msg")
	
    --label list
    
    --button list
    self._Button_send_chat_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Button_send_chat")
	self._Button_send_chat_t:onTouch(Functions.createClickListener(handler(self, self.onButton_send_chatClick), "zoom"))

	self._Button_hide_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Button_hide")
	self._Button_hide_t:onTouch(Functions.createClickListener(handler(self, self.onButton_hideClick), ""))

	self._Button_up_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Button_up")
	self._Button_up_t:onTouch(Functions.createClickListener(handler(self, self.onButton_upClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_send_chat btFunc
function ChatPopView:onButton_send_chatClick()
    Functions.printInfo(self.debug,"Button_send_chat button is click!")
    local strList = string.split(self._TextField_chat_string_t:getString(),":")
    if strList[1] == "version" and strList[2] ~= nil then
         self._TextField_chat_string_t:setText("")
         local gamePath = cc.FileUtils:getInstance():getWritablePath()
         Functions.writeStringtoFile(strList[2],gamePath .. "/version.ini")
         PromptManager:openTipPrompt("modify version nummber:" .. strList[2] .. " is success! ")
    else
        --发送世界消息
        local onSendChat = function(event)
            local data = event.data
            --免费次数
            local count = data.free_count
            PlayerData.eventAttr.m_freeChatCnt = count
            
            PlayerData.eventAttr.m_gold = data.gold
            self._TextField_chat_string_t:setText("")

        end

        NetWork:addNetWorkListener({ 23, 1 }, Functions.createNetworkListener(onSendChat,true,"ret"))
        NetWork:sendToServer({ idx = { 23, 1 }, reqtype = 1, data = {msg = self._TextField_chat_string_t:getString() }})
    end
end
--@auto code Button_send_chat btFunc end

--@auto code Button_hide btFunc
function ChatPopView:onButton_hideClick()
    Functions.printInfo(self.debug,"Button_hide button is click!")
    self._Button_hide_t:setVisible(false)
    self._Button_up_t:setVisible(true)
    --弹回动作
    local num = 0 - self._game_chat_bg_1_t:getContentSize().width
    local moveTo = cc.MoveTo:create(checknumber(0.5), cc.p(num,display.cy))
    self:runAction(moveTo)
end
--@auto code Button_hide btFunc end

--@auto code Button_up btFunc
function ChatPopView:onButton_upClick()
    Functions.printInfo(self.debug,"Button_up button is click!")
    self._Button_hide_t:setVisible(true)
    self._Button_up_t:setVisible(false)
    --弹出动作
    local moveTo = cc.MoveTo:create(checknumber(0.5), cc.p(0,display.cy))
    self:runAction(moveTo)
    if PlayerData.eventAttr.m_freeChatCnt > 0 then
        self._Text_send_money_t:setVisible(false)
        self._Text_free_count_t:setText("("..tostring(PlayerData.eventAttr.m_freeChatCnt)..")")
    else
        self._Panel_free_t:setVisible(false)
        self._Text_send_money_t:setVisible(true)
    end
    --数据更新监听
    GameEventCenter:dispatchEvent({ name = ChatData.CHAT_DATA_MSG })
end
--@auto code Button_up btFunc end

--@auto button backcall end


--@auto code output func
function ChatPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function ChatPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    
end

function ChatPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
	
    --    self:setAnchorPoint(1,0.5)
    --self:setPosition(display.cx, display.cy)

    --监听函数
    local onChat = function(event)
        local data = ChatData.chatDatas
        self:chatShow(data)
    end
    Functions.bindEventListener(self.csbNode, GameEventCenter, ChatData.CHAT_DATA_MSG, onChat)
	local num = 0 - self._game_chat_bg_1_t:getContentSize().width
    self:setPosition(num, display.cy)
    self._TextField_chat_string_t:setPlaceHolder(LanguageConfig.ui_language_Chat_2)
end
--@auto code output func end

function ChatPopView:chatShow(_data)
    Functions.printInfo(self.debug,"chatShow")
    
    local listHandler = function(index, widget, data, model)

        local Panel = widget:getChildByName("Panel_info_text")
        local banModel = model:getChildByName("Panel_info_text")
        Functions.initTextColor(banModel:getChildByName("Text_level"),Panel:getChildByName("Text_level"))
        Functions.initTextColor(banModel:getChildByName("Text_name"),Panel:getChildByName("Text_name"))
        Functions.initTextColor(banModel:getChildByName("Text_time"),Panel:getChildByName("Text_time"))
        Panel:setVisible(true)

        if data.pic == 1 then
            Functions.loadImageWithWidget(Panel:getChildByName("Panel_head"):getChildByName("Image_head"), "commonUI.res.mainhead1.png")
        elseif data.pic == 2 then
            Functions.loadImageWithWidget(Panel:getChildByName("Panel_head"):getChildByName("Image_head"), "commonUI.res.mainhead1.png")
        end
        

        Panel:getChildByName("Text_level"):setText(tostring(data.level)..LanguageConfig.language_Chat_1)
        Panel:getChildByName("Text_name"):setText(data.name)
        Panel:getChildByName("Text_time"):setText(TimerManager:formatTime("%H:%M", data.tm))

        Panel:getChildByName("Text_msg"):setText(data.msg)
        self._Text_free_count_t:setText("("..tostring(PlayerData.eventAttr.m_freeChatCnt)..")")
        if PlayerData.eventAttr.m_freeChatCnt == 0 then
            self._Text_send_money_t:setVisible(true)
            self._Panel_free_t:setVisible(false)
        end
        
        self._ListView_chat_t:scrollToBottom(0.001,false)

    end
    --绑定响应事件函数
    if #_data > 0 then
        Functions.bindListWithData(self._ListView_chat_t, _data, listHandler)
    end
    
    
end

return ChatPopView