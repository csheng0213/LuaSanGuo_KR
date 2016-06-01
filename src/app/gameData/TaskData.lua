local BaseModel = require("app.baseMVC.BaseModel")

local TaskData = class("TaskData", BaseModel)

TaskData.debug = false

--事件属性
TaskData.eventAttr = {}
TaskData.eventAttr.chengJiuRewardFalg = 0 --成就是否可领奖标示
TaskData.eventAttr.taskRewardFalg = 0     --任务是否可领奖标示

TaskData.TaskInf = {}
TaskData.TaskInf.m_dailyMission= {}       --日常任务完成量  
TaskData.TaskInf.m_dmReward = {}          --任务奖励领取状态/暂时未使用
TaskData.TaskInf.m_fiveStarCnt = 0
TaskData.TaskInf.m_major = {}
TaskData.eventAttr.activeValue = 0 --任务活跃度
function TaskData:init()
    self.super.init(self)
    --注册网络监听，游戏开始初始化数据
    --游戏任务数据初始化命令：idx ＝ { 2, 11 }
    
    local onTaskInit = function(event)

       local data = event.data
       for k, v in pairs(data) do
            self.TaskInf[k] = v
       end
       self:updateCJRewardFlag(TaskData.TaskInf.m_major)
       self:updateTaskActiveValue()
    end
    NetWork:addNetWorkListener({ 2, 11 }, onTaskInit)

    local onTaskStatuseHandler = function(event)
        if event.index ~= nil then 
            PromptManager:openSpeakerPrompt(LanguageConfig["language_task_speaker_" .. tostring(event.index)] ,nil,LanguageConfig.language_task_14)
        end
    end
    NetWork:addNetWorkListener({ 2, 25 }, onTaskStatuseHandler)
    local abbrixHandler = function()
        Functions.callJavaFuc(function()
            NativeUtil:javaCallHanler({command = "customCohort1",activityName = "level_" .. tostring(PlayerData.eventAttr.m_level)})
            NativeUtil:javaCallHanler({command = "setTargetData",customUserDataKey = "level", customUserData = tostring(PlayerData.eventAttr.m_level)}) 
        end)
        if PlayerData.eventAttr.m_level == 2 then
            Functions.setAdbrixTag("firstTimeExperience","level_2")
        elseif PlayerData.eventAttr.m_level == 3 then
            if not GameState.storeAttr.adbrixLevel2_b then
                Functions.setAdbrixTag("firstTimeExperience","level_2")
            end
            Functions.setAdbrixTag("firstTimeExperience","level_3")
        elseif PlayerData.eventAttr.m_level == 4 then
            if not GameState.storeAttr.adbrixLevel2_b then 
                Functions.setAdbrixTag("firstTimeExperience","level_2")
            end
            if not GameState.storeAttr.adbrixLevel3_b then 
                Functions.setAdbrixTag("firstTimeExperience","level_3")
            end
            Functions.setAdbrixTag("firstTimeExperience","level_4")
        elseif PlayerData.eventAttr.m_level == 5 then  
            if not GameState.storeAttr.adbrixLevel2_b then 
                Functions.setAdbrixTag("firstTimeExperience","level_2")
            end
            if not GameState.storeAttr.adbrixLevel3_b then 
                Functions.setAdbrixTag("firstTimeExperience","level_3")
            end
            if not GameState.storeAttr.adbrixLevel4_b then 
                Functions.setAdbrixTag("firstTimeExperience","level_4")
            end
            Functions.setAdbrixTag("firstTimeExperience","level_5") 
        elseif PlayerData.eventAttr.m_level == 6 then  
            if not GameState.storeAttr.adbrixLevel2_b then 
                Functions.setAdbrixTag("firstTimeExperience","level_2")
            end
            if not GameState.storeAttr.adbrixLevel3_b then 
                Functions.setAdbrixTag("firstTimeExperience","level_3")
            end
            if not GameState.storeAttr.adbrixLevel4_b then 
                Functions.setAdbrixTag("firstTimeExperience","level_4")
            end
            if not GameState.storeAttr.adbrixLevel5_b then 
                Functions.setAdbrixTag("firstTimeExperience","level_5")
            end
            Functions.setAdbrixTag("firstTimeExperience","level_6") 
        end
    end
    PlayerData:addEventListener(string.upper(PlayerData.__cname) .. "_" .. string.upper("m_level") .. "_" .. "CHANGE_EVENT", abbrixHandler)
end
--发送成就领奖请求
function TaskData:RequestChengJiu(tag,handler)
     --监听服务器数据
    local onServerRequest = function (event)
        local m_money = event.m_money 
        local m_gold = event.m_gold
        local m_soul = event.m_soul

        local id = 0
        local num = 0
        if m_money - PlayerData.eventAttr.m_money > 0 then
            id = -3
            num = m_money - PlayerData.eventAttr.m_money
        elseif m_soul - PlayerData.eventAttr.m_soul > 0 then
            id = -5
            num = m_soul - PlayerData.eventAttr.m_soul
        elseif m_gold - PlayerData.eventAttr.m_gold > 0 then
            id = -2 
            num = m_gold - PlayerData.eventAttr.m_gold
        end
        PlayerData.eventAttr.m_money = m_money
        PlayerData.eventAttr.m_gold = m_gold
        PlayerData.eventAttr.m_soul = m_soul
        TaskData.TaskInf.m_major[tag].m_get = TaskData.TaskInf.m_major[tag].m_get + 1
        if handler ~= nil then
            handler(id,num)
        end
        self:updateCJRewardFlag(TaskData.TaskInf.m_major)
    end
    NetWork:addNetWorkListener({22,2}, Functions.createNetworkListener(onServerRequest, true, "ret"))
    local msg = {idx = {22, 2},index = tag}
    NetWork:sendToServer(msg)
end
--更新成就领奖标示
function TaskData:updateCJRewardFlag(data)
    TaskData.eventAttr.chengJiuRewardFalg = 0
    for k, v in pairs(data) do
        if v.m_get + 1 <= v.m_flag and v.m_get + 1 <= #g_csMainMsn[k][1] then
            TaskData.eventAttr.chengJiuRewardFalg = 1
        end
    end
end
--发送任务领奖请求
function TaskData:RequestTaskReward(flag,handler)
     --监听服务器数据
    local onServerRequest = function (event)
        PlayerData.eventAttr.m_money = event.m_money
        PlayerData.eventAttr.m_gold = event.m_gold
        PlayerData.eventAttr.m_soul = event.m_soul
        PlayerData.eventAttr.m_hunjing = event.m_hunjing 
        if event.items ~= nil then
            for k, v in ipairs(event.items) do
                Functions:addItemResources( { id = v.id, type = v.itype, count = v.num, slot = v.solt } )
            end
        end
        TaskData.TaskInf.m_dmReward[flag] = true
        if handler ~= nil then
            handler()
        end
    end
    NetWork:addNetWorkListener({ 22, 1 }, Functions.createNetworkListener(onServerRequest, true, "ret"))
    local msg = {idx = {22, 1},index = flag}
    NetWork:sendToServer(msg)
end
--更新任务活跃度
function TaskData:updateTaskActiveValue()
    local taskListData = ConfigHandler:getTaskInfos()
    TaskData.eventAttr.activeValue = 0
    for i=1,#taskListData do  
        if TaskData.TaskInf.m_dailyMission[i] == taskListData[i]["完成次数"] then
            TaskData.eventAttr.activeValue = TaskData.eventAttr.activeValue + taskListData[i]["奖励点数"]
        end
    end
    TaskData.eventAttr.taskRewardFalg = 0     --任务是否可领奖标示
    if TaskData.eventAttr.activeValue >=g_csMsnRewardBox[1][1] and  TaskData.eventAttr.activeValue < g_csMsnRewardBox[2][1] and TaskData.TaskInf.m_dmReward[1] == false then
        TaskData.eventAttr.taskRewardFalg = 1    --任务是否可领奖标示
    end
    if TaskData.eventAttr.activeValue >=g_csMsnRewardBox[2][1] and  TaskData.eventAttr.activeValue < g_csMsnRewardBox[3][1] and TaskData.TaskInf.m_dmReward[2] == false then
        TaskData.eventAttr.taskRewardFalg = 1    --任务是否可领奖标示
    end
    if TaskData.eventAttr.activeValue >=g_csMsnRewardBox[3][1] and  TaskData.eventAttr.activeValue < g_csMsnRewardBox[4][1] and TaskData.TaskInf.m_dmReward[3] == false then
        TaskData.eventAttr.taskRewardFalg = 1    --任务是否可领奖标示
    end
    if TaskData.eventAttr.activeValue >=g_csMsnRewardBox[4][1] and TaskData.TaskInf.m_dmReward[4] == false then
        TaskData.eventAttr.taskRewardFalg = 1    --任务是否可领奖标示
    end
end
return TaskData