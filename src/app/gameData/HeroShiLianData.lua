local BaseModel = require("app.baseMVC.BaseModel")

local HeroShiLianData = class("HeroShiLianData", BaseModel)

HeroShiLianData.debug = false
HeroShiLianData.isDone = false
HeroShiLianData.JumpTypeEnum = 
{
    li = 1,
    shu = 2,
    mou = 3
}
HeroShiLianData.heroShiLianInfo = {}
HeroShiLianData.shiLianType = 0
function HeroShiLianData:init()
    self.super.init(self)
    --注册网络监听，游戏开始初始化数据
    --游戏布阵数据初始化命令：idx ＝ { 1, 3 }
end
--加载服务器布阵信息
function HeroShiLianData:loadHeroShiLianData(hander)
    local onServerRequest = function(event)
        local data = event.data
        HeroShiLianData.shiLianType = event.type
        for k, v in pairs(data) do
            self.heroShiLianInfo[k] = v
        end
        if hander ~= nil then   
           hander()
        end
    end
    NetWork:addNetWorkListener({ 1, 1}, Functions.createNetworkListener(onServerRequest, true, "err"))

    local msg = {idx = {1, 1},btype = CombatType.RB_HeroTrial ,data = { query = true }}
    NetWork:sendToServer(msg)
    
end
--发送抽卡请求
function HeroShiLianData:RequestGetCard(type,btype,handler,shiLianType)
     --监听服务器数据
    local onServerRequest = function (event)
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({9,5}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local mag = {}
    if shiLianType ~= nil then
        msg = {idx = {9, 5},type = type,btype = btype,shiLianType = shiLianType}
    else
        msg = {idx = {9, 5},type = type,btype = btype}
    end
     NetWork:sendToServer(msg)
end
function HeroShiLianData:getShiLianInfo()
	return self.heroShiLianInfo
end

return HeroShiLianData