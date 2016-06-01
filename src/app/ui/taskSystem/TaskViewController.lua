--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local TaskViewController = class("TaskViewController", BaseViewController)

local Functions = require("app.common.Functions")

TaskViewController.debug = true
TaskViewController.modulePath = ...
TaskViewController.studioSpriteFrames = {"TaskUI_Text","CBO_taskFrame","CB_blackbg","CBO_taskNewBg","TaskUI" }
--@auto code head end

--@Pre loading
TaskViewController.spriteFrameNames = 
    {
    }

TaskViewController.animaNames = 
    {
        "An_taskReward"
    }


--@auto code uiInit
--add spriteFrames
if #TaskViewController.studioSpriteFrames > 0 then
    TaskViewController.spriteFrameNames = TaskViewController.spriteFrameNames or {}
    table.insertto(TaskViewController.spriteFrameNames, TaskViewController.studioSpriteFrames)
end
function TaskViewController:onDidLoadView()

    --output list
    self._TaskListView_t = self.view_t.csbNode:getChildByName("main"):getChildByName("taskListPanel"):getChildByName("taskListBox"):getChildByName("childTaskListBox"):getChildByName("TaskListView")
	self._taskBar_t = self.view_t.csbNode:getChildByName("main"):getChildByName("taskListPanel"):getChildByName("taskListBox"):getChildByName("podiumBox"):getChildByName("taskBar")
	self._activeText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("taskListPanel"):getChildByName("taskListBox"):getChildByName("podiumBox"):getChildByName("activeText")
	self._topNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("topNode")
	
    --label list
    
    --button list
    self._stageBt_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("taskListPanel"):getChildByName("taskListBox"):getChildByName("podiumBox"):getChildByName("stage1"):getChildByName("stageBt_1")
	self._stageBt_1_t:onTouch(Functions.createClickListener(handler(self, self.onStagebt_1Click), ""))

	self._stageBt_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("taskListPanel"):getChildByName("taskListBox"):getChildByName("podiumBox"):getChildByName("stage2"):getChildByName("stageBt_2")
	self._stageBt_2_t:onTouch(Functions.createClickListener(handler(self, self.onStagebt_2Click), ""))

	self._stageBt_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("taskListPanel"):getChildByName("taskListBox"):getChildByName("podiumBox"):getChildByName("stage3"):getChildByName("stageBt_3")
	self._stageBt_3_t:onTouch(Functions.createClickListener(handler(self, self.onStagebt_3Click), ""))

	self._stageBt_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("taskListPanel"):getChildByName("taskListBox"):getChildByName("podiumBox"):getChildByName("stage4"):getChildByName("stageBt_4")
	self._stageBt_4_t:onTouch(Functions.createClickListener(handler(self, self.onStagebt_4Click), ""))

	self._backBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), ""))

	self._helpBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("helpBt")
	self._helpBt_t:onTouch(Functions.createClickListener(handler(self, self.onHelpbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Taskbt btFunc
function TaskViewController:onTaskbtClick()
    Functions.printInfo(self.debug,"Taskbt button is click!")

end
--@auto code Taskbt btFunc end

--@auto code Stagebt_1 btFunc
function TaskViewController:onStagebt_1Click()
    Functions.printInfo(self.debug,"Stagebt_1 button is click!")
    -- local rewardView = require("app.ui.popViews.RewardPopView"):new()--cs
    self:openChildView("app.ui.popViews.RewardPopView", {isRemove = false,data = {1,TaskData.eventAttr.activeValue,TaskData.TaskInf.m_dmReward} })
end
--@auto code Stagebt_1 btFunc end

--@auto code Stagebt_2 btFunc
function TaskViewController:onStagebt_2Click()
    Functions.printInfo(self.debug,"Stagebt_2 button is click!")
    -- local rewardView = require("app.ui.popViews.RewardPopView"):new()--cs
    self:openChildView("app.ui.popViews.RewardPopView", { isRemove = false, data = {2,TaskData.eventAttr.activeValue,TaskData.TaskInf.m_dmReward} })
end
--@auto code Stagebt_2 btFunc end

--@auto code Stagebt_3 btFunc
function TaskViewController:onStagebt_3Click()
    Functions.printInfo(self.debug,"Stagebt_3 button is click!")
    -- local rewardView = require("app.ui.popViews.RewardPopView"):new()--cs
    self:openChildView("app.ui.popViews.RewardPopView", { isRemove = false, data = {3,TaskData.eventAttr.activeValue,TaskData.TaskInf.m_dmReward} })
end
--@auto code Stagebt_3 btFunc end

--@auto code Stagebt_4 btFunc
function TaskViewController:onStagebt_4Click()
    Functions.printInfo(self.debug,"Stagebt_4 button is click!")
    -- local rewardView = require("app.ui.popViews.RewardPopView"):new()--cs
    self:openChildView("app.ui.popViews.RewardPopView", { isRemove = false, data = {4,TaskData.eventAttr.activeValue,TaskData.TaskInf.m_dmReward} })
end
--@auto code Stagebt_4 btFunc end

--@auto code Backbt btFunc
function TaskViewController:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    GameCtlManager:pop(self)
end
--@auto code Backbt btFunc end

--@auto code Helpbt btFunc
function TaskViewController:onHelpbtClick()
    Functions.printInfo(self.debug,"Helpbt button is click!")
    NoticeManager:openNotice(self, {type = NoticeManager.TASK_INFO})
end
--@auto code Helpbt btFunc end

--@auto button backcall end


--@auto code view display func
function TaskViewController:onCreate()
    Functions.printInfo(self.debug_b," TaskViewController controller create!")
end
function TaskViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
function TaskViewController:onDisplayView()
    Functions.printInfo(self.debug_b," TaskViewController view enter display!")
    Functions.setPopupKey("task")
    self.bg1 = self._stageBt_1_t:getChildByName("bg")
    self.bg2 = self._stageBt_2_t:getChildByName("bg")
    self.bg3 = self._stageBt_3_t:getChildByName("bg")
    self.bg4 = self._stageBt_4_t:getChildByName("bg")

    -- Functions.playActionWithBackCall(self.bg1, UIActionTool:createBlinkAction(0.5))
    -- Functions.playActionWithBackCall(self.bg2, UIActionTool:createBlinkAction(0.5))
    -- Functions.playActionWithBackCall(self.bg3, UIActionTool:createBlinkAction(0.5))
    -- Functions.playActionWithBackCall(self.bg4, UIActionTool:createBlinkAction(0.5))

    -- Functions.playAnimationWithRemove(chengJiuBox,"An_chengJiu")
    self.bg1:setScale(1.2)    
    self.bg2:setScale(1.2)
    self.bg3:setScale(1.2)
    self.bg4:setScale(1.2)
    --初始化界面显示数据
    self:initUiDisplay_()
----    local mainLayer = self.view_t.csbNode:getChildByName("main")
--
--
--
--        local key_listener = cc.EventListenerKeyboard:create() 
--        local keyFunc = function ()            
----        	 GameCtlManager:pop(TaskViewController)
--             print("back")
--        end   
--        
--        key_listener:registerScriptHandler(keyFunc,cc.Handler.EVENT_KEYBOARD_PRESSED)
--    
--        local eventDispatch = mainLayer:getEventDispatcher()
--        eventDispatch:addEventListenerWithSceneGraphPriority(key_listener,mainLayer)
end
--@auto code view display func end

--custom code start
function TaskViewController:initUiDisplay_()

    -- Functions.bindMGSDisplay({moneyObj = self._coinText_t,goldObj = self._goldText_t,soulObj = self._soulText_t})
    Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})

    --读取任务表
    TaskData.eventAttr.activeValue = 0
    local taskListData = clone(ConfigHandler:getTaskInfos())
    local taskInf = clone(TaskData.TaskInf.m_dailyMission)
    -- for k,v in pairs(taskListData) do
    --     if taskInf[k] >= taskListData[k]["完成次数"] then
    --         table.remove(taskListData,k)
    --         table.remove(taskInf,k)
    --     end    
    -- end
    for i=1,#taskListData do
        taskListData[i].pos = i 
    end
   -- table.sort(taskListData,function(a,b)
   --      return (taskInf[a.pos] - a["完成次数"]) < (taskInf[b.pos] - b["完成次数"])    
   --  end)
    local listHandler = function(index, widget,data,model)   
        local taskBox = widget:getChildByName("taskBox")
        local textLabel = taskBox:getChildByName("taskInfText")
        local taskBt = taskBox:getChildByName("taskBt")
        local wancView = taskBox:getChildByName("wancView")
        if taskInf[data.pos] >= data["完成次数"] then
            wancView:setVisible(true)
            taskBt:setVisible(false)
        else
            wancView:setVisible(false)
            taskBt:setVisible(true)
        end

        Functions.initTextColor(model:getChildByName("taskBox"):getChildByName("taskInfText"),widget:getChildByName("taskBox"):getChildByName("taskInfText"))
        Functions.initTextColor(model:getChildByName("taskBox"):getChildByName("taskGoalText"),widget:getChildByName("taskBox"):getChildByName("taskGoalText"))
        Functions.initTextColor(model:getChildByName("taskBox"):getChildByName("taskRewardText"),widget:getChildByName("taskBox"):getChildByName("taskRewardText")) 
        local taskIcon = taskBox:getChildByName("taskIcon")
        Functions.loadImageWithWidget(taskIcon, data["资源路径"])

        local onTaskBt = function()
            if data["跳转类型"] == 1 then
                GameCtlManager:push("app.ui.citySystem.CityViewController")
            elseif data["跳转类型"] == 2 then
                GameCtlManager:push("app.ui.enhanceSystem.EnhanceViewController")
            elseif data["跳转类型"] == 3 then
                GameCtlManager:push("app.ui.enhanceSystem.EnhanceViewController")
            elseif data["跳转类型"] == 4 then
                Functions.jumpFbSeleckOfData({ fbType =CombatCenter.CombatType.RB_PVE , fbId =1 , gkId =1 })
            elseif data["跳转类型"] == 5 then
                GameCtlManager:push("app.ui.tianTiSystem.TianTiViewController")
            elseif data["跳转类型"] == 6 then
                GameCtlManager:push("app.ui.xueZhanSystem.XueZhanViewController")
            elseif data["跳转类型"] == 7 then
                if BiographyData:getFbOpenState().isOpen_jy then
                    Functions.jumpFbSeleckOfData({ fbType =CombatCenter.CombatType.RB_ElitePVE , fbId =1 , gkId =1 })
                else
                    PromptManager:openTipPrompt(LanguageConfig.language_tyj_task_2)
                end
            elseif data["跳转类型"] == 8 then
                if BiographyData:getFbOpenState().isOpen_td then
                    Functions.jumpFbSeleckOfData({ fbType =CombatCenter.CombatType.RB_Tandui , fbId =7 , gkId =1 })
                else
                    PromptManager:openTipPrompt(LanguageConfig.language_tyj_task_3)
                end
            elseif data["跳转类型"] == 9 then
                GameCtlManager:push("app.ui.sevenStarSystem.SevenStarViewController") 
            elseif data["跳转类型"] == 10 then
                GameCtlManager:push("app.ui.enlistSystem.EnlistViewController")
            elseif data["跳转类型"] == 11 then
                GameCtlManager:push("app.ui.shiLianSystem.ShiLianViewController")
            end
        end 
        taskBt:onTouch(Functions.createClickListener(handler(taskBt,onTaskBt), ""))
        
        textLabel:setString(data["任务描述"])
        textLabel:setColor(cc.c3b(255,255,255))
        
        local taskRewardLabel = taskBox:getChildByName("taskRewardText")
        taskRewardLabel:setString(data["文字"])
        taskRewardLabel:setColor(cc.c3b(0,255,0))

        local taskGoalLabel = taskBox:getChildByName("taskGoalText")
        taskGoalLabel:setString(tostring(taskInf[data.pos]) .. "/" .. data["完成次数"])
        -- if taskInf[index] == data["任务描述"] then
        --     local taskBt = taskBox:getChildByName("taskBt")
        --     taskBt:setVisible(false)
        --     local filishView = taskBox:getChildByName("filishView")
        --     filishView:setVisible(true)
        -- end        

        if index == 1 then
            self._taskBt_t = taskBt
        end  
    end
    Functions.bindListWithData(self._TaskListView_t, taskListData, listHandler)
    --更新活跃度
    TaskData:updateTaskActiveValue()
    self._activeText_t:setString(tostring(TaskData.eventAttr.activeValue)) 
    self._taskBar_t:setPercent(TaskData.eventAttr.activeValue)  
    Functions.bindUiWithModelAttr(self._activeText_t, TaskData, "activeValue",function(event)
        self._activeText_t:setString(tostring(event.data)) 
        self._taskBar_t:setPercent(event.data)  
    end)
    --播放宝箱动画
    

    if TaskData.eventAttr.activeValue >=g_csMsnRewardBox[1][1] and TaskData.TaskInf.m_dmReward[1] == false then
        self.bg1:stopAllActions()
        self.bg1:setVisible(true)
        Functions.playAnimaOfUI(self.bg1, "An_taskReward", 0)
    else
        self.bg1:setVisible(false)
        self.bg1:stopAllActions()
        if PlayerData.eventAttr.m_guideId == 15 then   
            GuideManager:finishGuide()    
            GuideManager:handlerStopCurGuide()    
            PromptManager:openShieldLayer()         
            local scheduler = require("app.common.scheduler") 
            scheduler.performWithDelayGlobal(function ( )
                GuideManager:checkGuide()
                PromptManager:closeShieldLayer()
            end, 0.6)
        end
    end
    if TaskData.eventAttr.activeValue >=g_csMsnRewardBox[2][1] and TaskData.TaskInf.m_dmReward[2] == false then
        self.bg2:stopAllActions()
        self.bg2:setVisible(true)
        Functions.playAnimaOfUI(self.bg2, "An_taskReward", 0)
    else
        self.bg2:setVisible(false)
        self.bg2:stopAllActions()
    end
    if TaskData.eventAttr.activeValue >=g_csMsnRewardBox[3][1] and TaskData.TaskInf.m_dmReward[3] == false then
        self.bg3:stopAllActions()
        self.bg3:setVisible(true)
        Functions.playAnimaOfUI(self.bg3, "An_taskReward", 0)
    else
        self.bg3:setVisible(false)
        self.bg3:stopAllActions()
    end
    if TaskData.eventAttr.activeValue >=g_csMsnRewardBox[4][1] and TaskData.TaskInf.m_dmReward[4] == false then
        self.bg4:stopAllActions()
        self.bg4:setVisible(true)
        Functions.playAnimaOfUI(self.bg4, "An_taskReward", 0)
    else
        self.bg4:setVisible(false)
        self.bg4:stopAllActions()
    end
end

function TaskViewController:onReceivePopData(jump) 
    self:initUiDisplay_()
end
--custom code end
return TaskViewController