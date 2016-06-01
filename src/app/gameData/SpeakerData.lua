local BaseModel = require("app.baseMVC.BaseModel")

local SpeakerData = class("SpeakerData", BaseModel)

SpeakerData.debug = false

SpeakerData.speakerData = {}
SpeakerData.count = 1

function SpeakerData:init()
    self.super.init(self)

    self.isSending = false
    --注册网络监听，游戏开始初始化数据
    --游戏任务数据初始化命令：idx ＝ { 10, 1 }

    local handler = function(event)
        if event.data[2] == 1 then -- data[2]为优先级， 1为普通，2为优先
            self.speakerData[#self.speakerData+1] = event.data
        elseif event.data[2] == 2 then
            table.insert(self.speakerData, 1, event.data)
        end
        if not self.isSending then
            self.isSending = true
            self:speakerCall()
        end
    end
    NetWork:addNetWorkListener({ 10, 1 }, handler)
    
end

function SpeakerData:speakerCall()

    if #self.speakerData > 0 then
        local data = self.speakerData[1]
        table.remove(self.speakerData,1)
        if data[3] and GameState.storeAttr.isCloseSystemSpeaker_b then 
            self:speakerCall()
        else
            PromptManager:openSpeakerPrompt(data[1], handler(self,self.speakerCall))
        end
    else
        self.isSending = false
    end
end

return SpeakerData