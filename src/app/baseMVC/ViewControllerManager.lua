local ViewControllerManager = {}

local Functions = require("app.common.Functions")
local ResManager = require("app.common.ResManager")

ViewControllerManager.debug_b = false
ViewControllerManager.currentController_t = nil
ViewControllerManager.controllers_t = {}

--@public func

function ViewControllerManager:goTo(controllerName, data)
    
    --模块开启条件检查
    if not ModelManager:isModelOpenOfController(controllerName) then
        PromptManager:openTipPrompt(string.format(LanguageConfig["language_Teach20"], ModelManager:getModelOpenLevel(controllerName)))
        return
    end

    if self.isViewLoading then return end
    self.isViewLoading = true
    
    --打开资源加载界面
    Functions.printInfo(self.debug_b,"打开资源加载界面.....")
    PromptManager:openResLoadPrompt()
    --PromptManager:openLoadingPrompt()
    --资源预加载
    --添加跳转后控制器资源
    local controller = require(controllerName).new() 
    controller:onReceiveGotoData(data)
    local onPreLoadFinish = function()
        
        PromptManager:closeResLoadPrompt()
        --PromptManager:closeLoadingPrompt()
        --移除前一个场景资源
        -- if self.currentController_t then
        --     ResManager:removeAnimations(self.currentController_t.animaNames)
        --     ResManager:removeSpriteFrames(self.currentController_t.spriteFrameNames)
        --     self.currentController_t:clearChildViewRes()     
        -- end 
        controller:LoadView_()
        
        --场景切换
        local rootScene_t = cc.Scene:create()

        local bottomLayer = ccui.Layout:create()
        bottomLayer:setName("bottomLayer")
        bottomLayer:addTo(rootScene_t)

        local topLayer = ccui.Layout:create()
        topLayer:setName("topLayer")
        topLayer:addTo(rootScene_t)

        controller.view_t:addTo(bottomLayer)
        controller.view_t:release()

        controller.rootScene_t = rootScene_t
        if cc.Director:getInstance():getRunningScene() then
            local notificationLayer = cc.Director:getInstance():getRunningScene():getChildByName("notificationLayer")
            if not notificationLayer then
                local notificationLayer = ccui.Layout:create()
                notificationLayer:setName("notificationLayer")
                notificationLayer:addTo(rootScene_t)
            else
                notificationLayer:retain()
                notificationLayer:removeFromParent(false)
                notificationLayer:addTo(rootScene_t)
                notificationLayer:release()
            end
            cc.Director:getInstance():replaceScene(rootScene_t)
        else
            cc.Director:getInstance():runWithScene(rootScene_t)
            local notificationLayer = ccui.Layout:create()
            notificationLayer:setName("notificationLayer")
            notificationLayer:addTo(rootScene_t)
        end

        if self.currentController_t then
            Functions.printInfo(self.debug_b,self.currentController_t.class.__cname .. " goTo ".. controller.class.__cname)
        else
            Functions.printInfo(self.debug_b," goTo ".. controller.class.__cname)
        end
        
        self:clearControllerSteak()
        self.controllers_t[#self.controllers_t+1] = controller
        self.currentController_t = controller
                
        --打开当前控制器背景音乐
        self.currentController_t:openBgMusic()
        self.isViewLoading = false
    end
    
    Functions.preLoadResHandler(controller, onPreLoadFinish)
end

function ViewControllerManager:addCurBottomLayer(view)
    self.currentController_t.rootScene_t:getChildByName("bottomLayer"):addChild(view)
end

function ViewControllerManager:addCurTopLayer(view)
    if not self.isViewLoading then
        self.currentController_t.rootScene_t:getChildByName("topLayer"):addChild(view)
    end
end

--通知层
function ViewControllerManager:addNotificationLayer(view)
    self.currentController_t.rootScene_t:getChildByName("notificationLayer"):addChild(view)
end

function ViewControllerManager:clearNotificationLayer()
    self.currentController_t.rootScene_t:getChildByName("notificationLayer"):removeSelf()
end

function ViewControllerManager:showNotificationLayer( ... )
    self.currentController_t.rootScene_t:getChildByName("notificationLayer"):setVisible(true)
end
function ViewControllerManager:hideNotificationLayer()
    self.currentController_t.rootScene_t:getChildByName("notificationLayer"):setVisible(false)
end

function ViewControllerManager:clear()
    --场景切换
    local rootScene_t = cc.Scene:create()
    cc.Director:getInstance():replaceScene(rootScene_t)
    cc.SpriteFrameCache:getInstance():removeSpriteFrames()
    cc.Director:getInstance():getTextureCache():removeAllTextures()
end

function ViewControllerManager:getCurrentController()
    if not self.currentController_t then return nil end
    
    if self.currentController_t.childController then
        return self.currentController_t.childController 
    else
        return self.currentController_t
    end
    
end

function ViewControllerManager:push(controllerName, param)
    --模块开启条件检查
    if not ModelManager:isModelOpenOfController(controllerName) then
        PromptManager:openTipPrompt(string.format(LanguageConfig["language_Teach20"], ModelManager:getModelOpenLevel(controllerName)))
        return
    end
    
    if self.isViewLoading then return end
    self.isViewLoading = true

    local data = nil
    if param and param.data then data = param.data end
    
    --打开资源加载界面
    Functions.printInfo(self.debug_b,"打开资源加载界面.....")
    PromptManager:openShieldLayer()
    --资源预加载
    --添加跳转后控制器资源
    local controller = require(controllerName).new() 
    controller:onReceivePushData(data)
    local onPreLoadFinish = function()

        PromptManager:closeShieldLayer()

        --显示压入的控制器视图
        local currentView = self.currentController_t.view_t
        controller.showView = function(controller)
            controller.isShow = true
            currentView:setVisible(false)
            controller.view_t:setVisible(true)
            controller:openBgMusic()
        end

        controller:LoadView_()
        controller.rootScene_t = self.currentController_t.rootScene_t

        self.controllers_t[#self.controllers_t+1] = controller
        self.currentController_t = controller
        controller.view_t:setVisible(false)

        --切换视图  
        controller:onChangeView()
        controller.rootScene_t:getChildByName("bottomLayer"):addChild(controller.view_t)
        controller.view_t:release()
        self.isViewLoading = false
    end

    Functions.preLoadResHandler(controller, onPreLoadFinish)
end

function ViewControllerManager:popToRoot(param)

    local data = nil
    if param and param.data then data = param.data end
    
    self:pop(self.controllers_t[2], param)
end

function ViewControllerManager:pop(controller, param)

    local data = nil
    if param and param.data then data = param.data end
     
	for i=1, #self.controllers_t do
	   if self.controllers_t[i] == controller then
	       for j=#self.controllers_t, i, -1 do
	           
                --清理资源
                self.controllers_t[j]:clearChildViewRes()
                ResManager:removeAnimations(self.controllers_t[j].animaNames)
                ResManager:removeSpriteFrames(self.controllers_t[j].spriteFrameNames) 
                
                --移除视图
                self.controllers_t[j].view_t:removeSelf()
                
                --移除控制器
                self.controllers_t[j] = nil
                
                end
                self.controllers_t[#self.controllers_t]:onReceivePopData(data)
                self.currentController_t = self.controllers_t[#self.controllers_t]
                self.currentController_t.view_t:setVisible(true)
                --打开当前控制器背景音乐
                self.currentController_t:openBgMusic()
                GuideManager:checkGuide()
	       return
	   end
	end
	
	assert(false, "pop controller error: not found push controller")
end

function ViewControllerManager:clearControllerSteak()
	for i=#self.controllers_t, 1, -1 do
        --清理资源
        self.controllers_t[i]:clearChildViewRes()
        ResManager:removeAnimations(self.controllers_t[i].animaNames)
        ResManager:removeSpriteFrames(self.controllers_t[i].spriteFrameNames) 
	end
	self.controllers_t = {}
end

return ViewControllerManager