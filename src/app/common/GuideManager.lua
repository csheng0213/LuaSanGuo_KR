local GuideManager = {}

GuideManager.ForcedGuideState = 1
GuideManager.StageGuideState  = 2


local GuideConfig = require("app.configs.GuideConfig")
for k, v in pairs(GuideConfig) do
	for i=1, #v.guideDatas do
		v.guideDatas[i]["index"] = i
	end
end

local scheduler = require("app.common.scheduler")


function GuideManager:init()
	self.isExcuteGuide = false
	self.curIndex = 0
	self.isSpellGuide = false
	self.guideLevel = 0
	
	--注册新手引导监听
    local onGuideFunc = function(event)

    	PlayerData.eventAttr.m_guideStageId = event.guideStageId
        PlayerData.eventAttr.m_guideIndex = event.newGuildIndex

    	if g_guideConfig.guideStage[PlayerData.eventAttr.m_guideStageId] then
			PlayerData.eventAttr.m_guideId = g_guideConfig.guideStage[PlayerData.eventAttr.m_guideStageId][PlayerData.eventAttr.m_guideIndex] or 0
       	else
           	PlayerData.eventAttr.m_guideId = 0
       	end
    end

    if G_IsOpenGuide then
    	NetWork:addNetWorkListener({ 6, 3 }, onGuideFunc)
    end
    
    --等级提升解锁提示
    local onPlayerLevelUpFunc = function(event)
    	while self.guideLevel < event.data do
    		self.guideLevel = self.guideLevel + 1
    		if g_guideConfig.guideStage[self.guideLevel] then
        		PlayerData.eventAttr.m_guideStageId = self.guideLevel
            	PlayerData.eventAttr.m_guideIndex = 1
            	
            	if g_guideConfig.guideStage[PlayerData.eventAttr.m_guideStageId] then
					PlayerData.eventAttr.m_guideId = g_guideConfig.guideStage[PlayerData.eventAttr.m_guideStageId][PlayerData.eventAttr.m_guideIndex] or 0
		       	else
		           	PlayerData.eventAttr.m_guideId = 0
		       	end
        	-- elseif g_uplevelConfig[self.guideLevel] then  注：所有等级解锁，都有引导，所以不需要弹出提示。
        	-- 	PromptManager:openTipPrompt(g_uplevelConfig[event.data])  
        	end
    	end
    end

    local onGuideDataInit = function(event)
    	self.curGuideData = event.data or {}
    end

    NetWork:addNetWorkListener({ 2, 26 }, onGuideDataInit)

    if G_IsOpenGuide then
    	Functions.registerAttrListener(PlayerData, "m_level", onPlayerLevelUpFunc)
    end
    
end

function GuideManager:checkGuide()

	if not self.isExcuteGuide then
        if not PlayerData or PlayerData.eventAttr.m_guideId == 0 or GuideConfig[PlayerData.eventAttr.m_guideId] == nil then return end
		
	    local curCtlName = GameCtlManager:getCurrentController().class.__cname
	    local guideCtlName = GuideConfig[PlayerData.eventAttr.m_guideId].startCtlName
	    
        local name = string.sub(PlayerData.eventAttr.m_name, 1, 4)
        if curCtlName == guideCtlName and name ~= "Hero" then  --正常引导
	    	self.curGuideId = PlayerData.eventAttr.m_guideId
			self.guideDatas = GuideConfig[self.curGuideId].guideDatas
			self:startGuide()
			return
		end

		local guideCtlName = GuideConfig[PlayerData.eventAttr.m_guideId].startCtlName_def
		if curCtlName == guideCtlName and name ~= "Hero" then --失败继续
			self.curGuideId = PlayerData.eventAttr.m_guideId

			self.guideDatas = {}
            table.insertto(self.guideDatas, GuideConfig[self.curGuideId].guideDatas_def)
			table.insertto(self.guideDatas, GuideConfig[self.curGuideId].guideDatas)

			for i=1, #self.guideDatas do
				self.guideDatas[i]["index"] = i
			end
			self:startGuide()
			return
		end
	else
		self:nextGuideFunc()
	end
end

function GuideManager:handOpenGuideOfid(id)
	self.guideDatas = GuideConfig[id].guideDatas
	self:startGuide()
end

function GuideManager:startGuide()

	self.isExcuteGuide = true
	self.curIndex = 1
    self:nextGuideFunc()
end

function GuideManager:nextGuideFunc()
	if #self.guideDatas > 0 then

		local guideData = self.guideDatas[1]  --获取当前引导数据
		local curCtlName = GameCtlManager:getCurrentController().class.__cname
        local guideCtlName = guideData.ctlName

		local onGeneralFunc = function()
			self.curIndex = self.curIndex + 1
			self:nextGuideFunc()
		end

		local onGuideFinish = function()
			self:finishGuide()
			onGeneralFunc()
		end

    	if curCtlName == guideCtlName and self.curIndex == guideData.index then
			if guideData.type == "button" then

				local afterButtonFunc = function(button)
					if guideCtlName == "MainViewController" then   --主界面会移动面板
						GameCtlManager:getCurrentController():moveBtCenter(button)
					end

					if guideData.isFinish then
						if guideData.delay then
							PromptManager:openShieldLayer()
							scheduler.performWithDelayGlobal(function()
								PromptManager:closeShieldLayer()
								PromptManager:openNewGuide(button, guideData.guideData, onGuideFinish, guideData.isRemove, guideData.pos)
								end, guideData.delay)
						else
							PromptManager:openNewGuide(button, guideData.guideData, onGuideFinish, guideData.isRemove, guideData.pos)
						end
					else
						if guideData.delay then
							PromptManager:openShieldLayer()
							scheduler.performWithDelayGlobal(function()
								PromptManager:closeShieldLayer()
								PromptManager:openNewGuide(button, guideData.guideData, onGeneralFunc, guideData.isRemove, guideData.pos)
								end, guideData.delay)
						else
							PromptManager:openNewGuide(button, guideData.guideData, onGeneralFunc, guideData.isRemove, guideData.pos)
						end
					end
					
				end
                GameCtlManager:getCurrentController():getButtonOfName(guideData.btName, afterButtonFunc)
                table.remove(self.guideDatas,1)
			elseif guideData.type == "text" then

				if guideData.isFinish then
					if guideData.delay then
						scheduler.performWithDelayGlobal(function()
							PromptManager:openDialoguePrompt(tonumber(guideData.guideData), onGuideFinish)
							end, guideData.delay)
					else
						PromptManager:openDialoguePrompt(tonumber(guideData.guideData), onGuideFinish)
					end
				else
					if guideData.delay then
						scheduler.performWithDelayGlobal(function()
							PromptManager:openDialoguePrompt(tonumber(guideData.guideData), onGeneralFunc)
							end, guideData.delay)
					else
						PromptManager:openDialoguePrompt(tonumber(guideData.guideData), onGeneralFunc)
					end
				end
				table.remove(self.guideDatas,1)

			end

		end
	else
		self.isExcuteGuide = false
		self.curGuideId = 0
		self.curIndex = 0
	end
end

--手动停止当前引导
function GuideManager:handlerStopCurGuide()
	self.guideDatas = {}
	self.isExcuteGuide = false
	self.curGuideId = 0
	self.curIndex = 0
end

function GuideManager:finishGuide()
    print("guide state: " .. PlayerData.eventAttr.m_guideStageId .. " guide id: " .. PlayerData.eventAttr.m_guideId .. " if finish")

    local msg = {idx = {6, 3}, ret = true , stageId = PlayerData.eventAttr.m_guideStageId ,index = PlayerData.eventAttr.m_guideIndex }
    PlayerData.eventAttr.m_guideStageId = 0
    PlayerData.eventAttr.m_newGuildIndex = 0
    PlayerData.eventAttr.m_guideId = 0
	NetWork:sendToServerAsny(msg)
end

function GuideManager:storeGuideData()
	local onStoreFinish = function(event)
		print("storeGuideData finish")
    end
    NetWork:addNetWorkListener({ 6, 7 }, Functions.createNetworkListener(onStoreFinish, true, "ret"))

    local msg = {idx = { 6, 7 }, data = self.curGuideData }
    NetWork:sendToServer(msg)
end



return GuideManager