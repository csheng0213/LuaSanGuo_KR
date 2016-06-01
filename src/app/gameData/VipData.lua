local BaseModel = require("app.baseMVC.BaseModel")

local VipData = class("VipData", BaseModel)

VipData.debug = false
VipData.eventAttr = {}
VipData.eventAttr.m_vipLevel = 0 --当前玩家Vip等级
VipData.eventAttr.m_recharge = 0 --当前玩家Vip累计充值金额
VipData.eventAttr.m_vipReward = {} --当前玩家Vip等级礼包领取状态 0--未领取，1--已领取
VipData.eventAttr.m_monthday = 0  --当前月卡剩余天数
VipData.eventAttr.vipRewardFlag = 0   --vip领奖：是否有奖可领 1/0
VipData.eventAttr.m_vipFirstFlag = 0   --vip首充标示：是否有奖可领 1/0
VipData.eventAttr.firstRaward = {}   --vip首充奖品配置
VipData.eventAttr.payMoney = 0   --vip首充奖品价值

--测试数据 千万记得各平台同步
VipData.eventAttr.payActivity = nil
-- VipData.eventAttr.payActivity.flags = {true,true,true,true,true,true}    
-- VipData.eventAttr.payActivity.rewards={ [1]={{40,4,10},{120,1,10}},
--                                         [2]={{42,4,10},{119,1,10}},
--                                         [3]={{43,4,10},{117,1,10}},
--                                         [4]={{44,4,10},{123,1,10}},
--                                         [5]={{45,4,10},{124,1,10}},
--                                         [6]={{46,4,10},{125,1,10}},
--                                       }
-- VipData.eventAttr.payActivity.infs={[1]= "hello",
--                                         [2]= "sex",
--                                         [3]= "girl"     
--                                     }
---

function VipData:init()
    self.super.init(self)
    local onVipInit = function(event)
        local data = event.data
        for k, v in pairs(data) do
            self.eventAttr[k] = v
        end 
        self:updateVipRewardFlag()   
        GameEventCenter:dispatchEvent({ name = "PAY_ACTIVITY"})
    end
    NetWork:addNetWorkListener({ 2, 16 }, onVipInit)

    -- local adbrixHandler = function (event)
    --     if event.rmb ~= nil then            
    --         Functions.setAdbrixTag("buy",tostring(g_payShowRMB[event.rmb]))
    --     end 
    -- end
    -- NetWork:addNetWorkListener({ 25, 7 }, adbrixHandler)
end
--发送vip等级领奖请求
function VipData:RequestVipLevelReward(curVipLevel,handler)
    --监听服务器数据
    local onServerRequest = function (event)
        VipData.eventAttr.m_vipReward[curVipLevel+1] = false
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({25,1}, Functions.createNetworkListener(onServerRequest, true, "ret"))
    local msg = {idx = {25, 1},curVipLevel = curVipLevel}
    NetWork:sendToServer(msg)
end

--发送充值请求
function VipData:RequestVipPay(nonce,paymentSeq,productCode,handler,isResend)
    --监听服务器数据
    local onServerRequest = function (event)
        for i = VipData.eventAttr.m_vipLevel+1, event.vipLevel do
            VipData.eventAttr.m_vipReward[i+1] = true
        end
        VipData.eventAttr.m_vipLevel = event.vipLevel
        VipData.eventAttr.m_recharge = event.recharge
        PlayerData.eventAttr.m_gold = event.gold    
        PlayerData.eventAttr.m_vipFirstFlag = event.firstFlag
        VipData:updateVipRewardFlag()     


        for i = 1,#g_payProductConfig_Nstore do 
            if event.productCode == g_payProductConfig_Nstore[i].productCode then
                Functions.setAdbrixTag("buy",tostring(g_payProductConfig_Nstore[i].money),tostring(PlayerData.eventAttr.m_level))  
            end
        end 
        GameState.storeAttr.curNonce_s = ""
        GameState.storeAttr.paymentSeq_s = ""
        GameState.storeAttr.curProductCode_s = ""
        
        local tipsStr = string.format(LanguageConfig.language_task_speaker_12,event.curPayGold)
        PromptManager:openSpeakerPrompt(tipsStr,nil,LanguageConfig.language_task_15)

        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({25,2}, Functions.createNetworkListener(onServerRequest, true, "ret")) 

    local msg = {idx = {25, 2},payType = G_SDKType,nonce = nonce,paymentSeq = paymentSeq,productCode = productCode,isResend = isResend}
    NetWork:sendToServer(msg)
  
end

function VipData:needToConsumProduct()
    Functions.callJavaFuc(function( )
        if GameState.storeAttr.curProductCode_s ~= "" then 
            VipData:RequestVipPay(GameState.storeAttr.curNonce_s ,GameState.storeAttr.paymentSeq_s ,GameState.storeAttr.curProductCode_s,nil,true)
        end 
    end)    
end


--更新可领取礼包状态
function VipData:updateVipRewardFlag()
    for i = 0,VipData.eventAttr.m_vipLevel do
        if VipData.eventAttr.m_vipReward[i+1] then
            VipData.eventAttr.vipRewardFlag = 1
            return
        end 
    end
    VipData.eventAttr.vipRewardFlag = 0
end
return VipData