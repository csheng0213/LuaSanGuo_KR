local BaseModel = require("app.baseMVC.BaseModel")

local DiscountData = class("ChatData", BaseModel)

DiscountData.debug = false

DiscountData.eventAttr = {}
DiscountData.DiscountDatas = {}

DiscountData.eventAttr.remainTimeStr = ""
DiscountData.remainTime = 0
DiscountData.fre = 0
DiscountData.next = 0
DiscountData.curCount = 0
DiscountData.description = 0
DiscountData.eventAttr.DiscountDataBZ = 0

function DiscountData:init()
    self.super.init(self)
    self.addListener = false
    --游戏聊天数据初始化命令：idx ＝ { 23， 2 }
    self:SendDiscount()
end

function DiscountData:SendDiscount()

    --    remainTime： 本次活动剩余时间
    --    fre:         前次充值应该拿到的奖励
    --    next:        下次充值应该拿到的奖励
    --    curCount:    当前次数
    --    description: 描述
    local onDiscount = function(event)
        self.eventAttr.DiscountDataBZ = event.active
        if self.eventAttr.DiscountDataBZ == 0 then
            GameEventCenter:removeEventListener(self.onTime)
            self.addListener = false
        	return
        end
        local data = event.data
        self.remainTime = data.remainTime
        self.fre = data.fre
        self.next = data.next
        self.curCount = data.curCount
        self.description = data.description
        
        --GameEventCenter:removeEventListener(self.onTime)
        
        --倒记时
        local onTime = function(event)

            self.remainTime = self.remainTime - 1
            
            self.eventAttr.remainTimeStr = string.format("%02d:%02d:%02d", math.floor(self.remainTime/3600), 
            (math.floor((self.remainTime%3600)/60)), math.floor(self.remainTime%60))
            if self.remainTime < 0 then
                self.remainTime = 0
                return
            end
        end
        if self.eventAttr.DiscountDataBZ == 1 then
            --数据更新监听
            if not self.addListener then
                self.onTime = GameEventCenter:addEventListener(TimerManager.SECOND_CHANGE_EVENT, onTime)
                self.addListener = true
            else
                --GameEventCenter:removeEventListener(self.onTime)
            end
            
        else
            GameEventCenter:removeEventListener(self.onTime)
        end
    end

    NetWork:addNetWorkListener({ 20, 31 }, onDiscount)
end

function DiscountData:GetDiscountDataBZ()
    return self.eventAttr.DiscountDataBZ
end

function DiscountData:GetRemainTime()
	return self.remainTime
end

function DiscountData:GetFre()
    return self.fre
end

function DiscountData:GetNext()
    return self.next
end

function DiscountData:GetCurCount()
    return self.curCount
end

function DiscountData:GetDescription()
    return self.description
end

return DiscountData