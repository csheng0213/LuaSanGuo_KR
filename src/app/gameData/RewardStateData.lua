local BaseModel = require("app.baseMVC.BaseModel")

local RewardStateData = class("RewardStateData", BaseModel)

RewardStateData.debug = false

--事件属性
RewardStateData.eventAttr = {}

RewardStateData.eventAttr.loginRewardFlag = 0 --登陆领奖：是否有奖可领 1/0
RewardStateData.eventAttr.signRewardFlag = 0   --签到领奖：是否有奖可领 1/0

RewardStateData.rewardState = {}


RewardStateData.rewardState.m_keepLoginDay = 0         --签到领奖：连续登陆天数 
RewardStateData.rewardState.m_loginReward = 0          --登陆领奖：是否有奖可领 1/0
      
RewardStateData.rewardState.m_lgAccumu = 0             --登陆领奖：连续登陆天数
RewardStateData.rewardState.m_lgAccumuAward = 0        --签到领奖：是否有奖可领 1/0
RewardStateData.rewardState.m_lgAccumuRd = {}          --登陆领奖：30天每天的领奖状态

RewardStateData.rewardState.m_sampleFCount = 0         --免费抽卡：已抽卡次数
RewardStateData.rewardState.m_sampleFNum = 0           --免费抽卡：抽卡次数
RewardStateData.rewardState.m_sampleFTime = 0          --免费抽卡：次数回复时间

RewardStateData.rewardState.m_sampleLNum = 0           --幸运抽卡：抽卡次数
RewardStateData.rewardState.m_sampleLuck= 0            --免费抽卡：幸运数

function RewardStateData:init()
    self.super.init(self)
    --注册网络监听，游戏开始初始化数据
    --游戏领奖状态数据初始化命令：idx ＝ { 2, 9 }
    local onRewardInit = function(event)

        local data = event.data

        for k, v in pairs(data) do
            self.rewardState[k] = v
        end
        if RewardStateData.rewardState.m_lgAccumuAward == 1 then
            RewardStateData.eventAttr.loginRewardFlag   = 0
        else
            RewardStateData.eventAttr.loginRewardFlag  = 1    
        end
        
        if RewardStateData.rewardState.m_loginReward == 1 then
            RewardStateData.eventAttr.signRewardFlag  = 0
        else
            RewardStateData.eventAttr.signRewardFlag = 1    
        end
--            RewardStateData.eventAttr.loginRewardFlag = RewardStateData.rewardState.m_loginReward  --登陆领奖：30天每天的领奖状态
--            RewardStateData.eventAttr.signRewardFlag = RewardStateData.rewardState.m_lgAccumuAward    --签到领奖：是否有奖可领 1/0

--        RewardStateData:updateLoginRewardFlag(RewardData.rewardInf.Accumulate)
--        RewardStateData:updateSignRewardFlag(RewardData.rewardInf.NewReward)

    end
    NetWork:addNetWorkListener({ 2, 9 }, onRewardInit)
end
----更新登陆领奖标示
--function RewardStateData:updateLoginRewardFlag(data)
--    RewardStateData.eventAttr.loginRewardFlag = 0
--    for k, v in pairs(data) do
--        if k == prizeStateData.m_lgAccumu and data.m_lgAccumuRd[k] == false then --当前可领取状态
--            RewardStateData.eventAttr.loginRewardFlag = 1
--        end
--    end
--end
----更新签到领奖标示
--function RewardStateData:updateSignRewardFlag(data)
--    RewardStateData.eventAttr.signRewardFlag = 0
--    for k, v in pairs(data) do
--        if k == prizeStateData.m_keepLoginDay and prizeStateData.m_loginReward ~= 1 then --当前可领取状态
--            RewardStateData.eventAttr.loginRewardFlag = 1
--        end
--    end
--end
return RewardStateData