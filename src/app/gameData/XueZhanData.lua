local BaseModel = require("app.baseMVC.BaseModel")

local XueZhanData = class("XueZhanData", BaseModel)

XueZhanData.debug = false
XueZhanData.eventAttr = {}
XueZhanData.eventAttr.m_xzAttack = 0
XueZhanData.eventAttr.m_xzHp = 0
XueZhanData.eventAttr.m_xzMp = 0
XueZhanData.eventAttr.m_xzlyStar = 0
XueZhanData.eventAttr.startTime = 0            --血战开启时间
XueZhanData.eventAttr.endTime = 0            --血战开启时间

XueZhanData.xueZhanData = {}
XueZhanData.xueZhanData.m_xzAttack = 0
XueZhanData.xueZhanData.m_xzGetBuff = 0
XueZhanData.xueZhanData.m_xzHp = 0
XueZhanData.xueZhanData.m_xzMp = 0
XueZhanData.xueZhanData.m_xzlyCount = 0           --挑战次数
XueZhanData.xueZhanData.m_xzlyFStar = 0            --角色级别
XueZhanData.xueZhanData.m_xzlyPass = 0            --当前关卡
XueZhanData.xueZhanData.m_xzlyPassBest = 0        --最佳战绩
XueZhanData.xueZhanData.m_xzlyRank = 0            --排名
XueZhanData.xueZhanData.m_xzlyReward = 0
XueZhanData.xueZhanData.m_xzlyStar = 0            --剩余星数
XueZhanData.xueZhanData.startTime = 0            --血战开启时间
XueZhanData.xueZhanData.endTime = 0            --血战开启时间
XueZhanData.xueZhanData.buffFlag = 0              --血战Buff
XueZhanData.xueZhanData.buff = {}                 --当buffFlag=1时有效 
--发送
function XueZhanData:loadXueZhanData(hander)
    --监听服务器数据
    local onServerRequest = function (event)
        Functions.printInfo(self.debug,"Refrashbt button is click!") 
        local data = event.data.m_bloodyBattle
        for k, v in pairs(data) do 
            self.xueZhanData[k] = v
        end
        XueZhanData.eventAttr.m_xzAttack = XueZhanData.xueZhanData.m_xzAttack 
        XueZhanData.eventAttr.m_xzHp = XueZhanData.xueZhanData.m_xzHp
        XueZhanData.eventAttr.m_xzMp = XueZhanData.xueZhanData.m_xzMp
        XueZhanData.eventAttr.m_xzlyStar = XueZhanData.xueZhanData.m_xzlyStar
        XueZhanData.eventAttr.startTime = event.data.startTime
        XueZhanData.eventAttr.endTime = event.data.endTime
        hander() --刷新信息
        return true
    end
    NetWork:addNetWorkListener({16, 3}, onServerRequest)
    local msg = {idx = {16,3}}
    NetWork:sendToServer(msg)
end   
function XueZhanData:RequestAddAttr(tag,handler)
     --监听服务器数据
    local onServerRequest = function (event)
        XueZhanData.eventAttr.m_xzAttack = event.m_xzAttack 
        XueZhanData.eventAttr.m_xzHp = event.m_xzHp
        XueZhanData.eventAttr.m_xzMp = event.m_xzMp
        XueZhanData.eventAttr.m_xzlyStar = event.m_xzlyStar
        XueZhanData.xueZhanData.m_xzAttack = event.m_xzAttack 
        XueZhanData.xueZhanData.m_xzHp = event.m_xzHp
        XueZhanData.xueZhanData.m_xzMp = event.m_xzMp
        XueZhanData.xueZhanData.m_xzlyStar = event.m_xzlyStar
        if handler ~= nil then
            handler()
        end
        return true
    end
    NetWork:addNetWorkListener({16,4}, onServerRequest)
    local msg = {idx = {16, 4},index = tag}
    NetWork:sendToServer(msg)
end
return XueZhanData