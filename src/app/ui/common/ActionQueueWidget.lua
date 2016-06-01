local ActionQueueWidget = class("ActionQueueWidget", ccui.Widget)

local Scheduler = require("app.common.scheduler")

function ActionQueueWidget:ctor()

	self:enableNodeEvents()
	self.actionQueue = {}
	self.isPlay = false
	self:setVisible(false)

end

function ActionQueueWidget:pushActionNode(actionNodeData)
	assert(actionNodeData and type(actionNodeData.target) == "userdata", "param is error")

	actionNodeData.target:retain()
	self.actionQueue[#self.actionQueue+1] = actionNodeData
	
    local actions = self.actionQueue

	self:play()

end

function ActionQueueWidget:play()
	if not self.isPlay then
		self.isPlay = true
		self:setVisible(true)
		self.playHandle = Scheduler.scheduleGlobal(handler(self, self.playHandler_), 0.2) 
	end
end

function ActionQueueWidget:removeData(index)
	self.actionQueue[index].target:release()
	table.remove(self.actionQueue, index)
end

function ActionQueueWidget:playHandler_()
	if #self.actionQueue > 0 then
		local actionNode = self.actionQueue[1].target
		local actionFunc = self.actionQueue[1].createFunc
		local data       = self.actionQueue[1].data

        local seqence = cc.Sequence:create(actionFunc(data), cc.CallFunc:create(function()
            actionNode:removeSelf()
        end))
        actionNode:runAction(seqence)
        actionNode:setVisible(false)
		self:addChild(actionNode)
		self:removeData(1)
	end
end


function ActionQueueWidget:onCleanup()
	for k, v in pairs(self.actionQueue) do
		self:removeData(k)
	end
	
	if self.playHandle then
	   Scheduler.unscheduleGlobal(self.playHandle)
    end
end


return ActionQueueWidget