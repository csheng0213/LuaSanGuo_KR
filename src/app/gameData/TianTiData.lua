local BaseModel = require("app.baseMVC.BaseModel")

local TianTiData = class("TianTiData", BaseModel)

TianTiData.debug = false

TianTiData.eventAttr = {}
TianTiData.eventAttr.m_tianTiScore = 0
TianTiData.eventAttr.m_tianTiCountTime = 0
TianTiData.eventAttr.m_tianTiTime = 0
TianTiData.eventAttr.m_tianTiCount = 0    --天梯剩余挑战次数
TianTiData.myPlayerData = {}
TianTiData.myPlayerData.m_tianTiBuyCount = 0  --天梯购买次数
TianTiData.myPlayerData.m_tianTiCount = 0      --天梯剩余挑战次数
TianTiData.myPlayerData.m_tianTiCountTime = 0
TianTiData.myPlayerData.m_tianTiRank = 0
TianTiData.myPlayerData.m_tianTiScore = 0
TianTiData.myPlayerData.m_tianTiTime = 0
TianTiData.myPlayerData.price = 0           --当前购买天梯挑战次数的价格

function TianTiData:init()
    self.super.init(self)
    --注册网络监听，游戏开始初始化数据
    --游戏天梯数据初始化命令：idx ＝ { 2, 7 }
    local onTianTiInit = function(event)
        local data = event.data

        for k, v in pairs(data) do
            self.myPlayerData[k] = v
        end
        self.eventAttr.m_tianTiScore = self.myPlayerData.m_tianTiScore
        self.eventAttr.m_tianTiCount = self.myPlayerData.m_tianTiCount
        self.eventAttr.m_tianTiRank = TianTiData.myPlayerData.m_tianTiRank
    end
    NetWork:addNetWorkListener({ 2, 7 }, onTianTiInit)
end
--发送购买挑战次数请求
function TianTiData:RequestBuyCountInf(handler)
     --监听服务器数据
    local onServerRequest = function (event)
        TianTiData.eventAttr.m_tianTiCount = event.ttcount
        TianTiData.myPlayerData.m_tianTiBuyCount = event.ttbuy
        TianTiData.myPlayerData.price = event.price
        PlayerData.eventAttr.m_gold = event.gold
        if handler ~= nil then
            handler()
        end      
    end
    NetWork:addNetWorkListener({11,9}, Functions.createNetworkListener(onServerRequest, true, "ret"))
    local msg = {idx = {11, 9} }
    NetWork:sendToServer(msg)
end
--发送挑战请求
function TianTiData:RequestTiaoZhan(tag,id,handler)
    local onServerRequest = function (event)
        if handler ~= nil then
            handler()
        end
    end
    NetWork:addNetWorkListener({1, 5}, Functions.createNetworkListener(onServerRequest, true, "ret"))
    local msg = {idx = {1,5},tag = tag, index = id}
    NetWork:sendToServer(msg)
end
--获得定时加积分数
-----------
function TianTiData:getAddIntegral()
    local rank = TianTiData.eventAttr.m_tianTiRank
    -- if ranking == 1 then
    --   return 2500
    -- elseif ranking >= 2 and ranking <= 5 then
    --   return 2490
    -- end 
    -- return 2490 -  Functions.subIntOfNum(ranking / 5) * 10
    local score = 0
    if rank <= #g_pvpScore then
      score = g_pvpScore[rank]
    else
      for k,v in ipairs(g_pvpScoreOther)do
        if rank>=v[1] and rank<=v[2] then
          score = v[3]
        end
      end
    end
    return score
end

function TianTiData:geTianTiScore()
    return TianTiData.eventAttr.m_tianTiScore
end
-- --接收名将榜玩家数据
-- function TianTiData:RequestStarPlayerInf(handler)
--      --监听服务器数据
--     local starPlayerData = {}
--     local onServerRequest = function (event)
--         local data = event.data
--         for k, v in pairs(data) do 
--             starPlayerData[k] = v
--         end
--         if handler ~= nil then 
--             handler(starPlayerData) 
--         end
--         return true
--     end
--     NetWork:addNetWorkListener({11,15}, onServerRequest)
--     local msg = {idx = {11,15}}
--     NetWork:sendToServer(msg)
-- end
---------------------------------------------------------------------------
return TianTiData