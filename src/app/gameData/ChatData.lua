local BaseModel = require("app.baseMVC.BaseModel")

local ChatData = class("ChatData", BaseModel)

ChatData.debug = false

ChatData.CHAT_DATA_MSG = "CHAT_DATA_MSG"

 
ChatData.chatDatas = {}
--ChatData.eventAttr.id = 0
--ChatData.eventAttr.level = 0
--ChatData.eventAttr.msg = 0
--ChatData.eventAttr.name = 0
--ChatData.eventAttr.pic = 0
--ChatData.eventAttr.tm = 0

function ChatData:init()
    self.super.init(self)
    --游戏聊天数据初始化命令：idx ＝ { 23， 2 }

    local onChat = function(event)

        local data = event.data
        self.chatDatas[#self.chatDatas+1] = data   
--        for k, v in pairs(data) do
--            
--            self.eventAttr[k] = v
--            
--        end
        --数据更新监听
        GameEventCenter:dispatchEvent({ name = ChatData.CHAT_DATA_MSG, data = data })
    end
    
    NetWork:addNetWorkListener({ 23, 2 }, onChat)
end

return ChatData