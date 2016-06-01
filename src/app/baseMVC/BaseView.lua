local BaseView = class("BaseView", cc.Node)

local Functions = require("app.common.Functions")

BaseView.csbResPath = ""

--@public func

function BaseView:setController(controller)
    self._controller_t = controller
end

function BaseView:getController()
    return self._controller_t
end

--根据路径加在csbNode,公共处理方法，统一加在csbNode
function BaseView:loadCsbNode(csbFilePath)

    DebugHoldTime("BaseView:loadCsbNode: " .. tostring(csbFilePath))
    local csbNode = cc.CSLoader:createNode(csbFilePath)
    DebugDelayTime("BaseView:loadCsbNode: " .. tostring(csbFilePath))
    
    --如果有背景，背景居中
    local bg = csbNode:getChildByName("bg")
    if bg then
        bg:move(cc.p(display.cx, display.cy))
    end
    
    --对 mainLayer 下的子节点，初始化他们的相对为止

    Functions.autoFixChildPos(csbNode:getChildByName("main"))

    --控制器的csbnode居中
     csbNode:setAnchorPoint(cc.p(0.5, 0.5))
     csbNode:setPosition(cc.p(display.cx, display.cy))

    return csbNode
end

--@virtual func

--获取csb node回调，子类重写，改变csb文件获取方式
function BaseView:onGetCsbNode()
    local csbResName = self.csbResPath .. "/" .. self.class.__cname
    local csbResPath = string.sub(csbResName,1,#csbResName - 4) .. "UI.csb"
    
    return self:loadCsbNode(csbResPath)
end

--在视图csbNode 加载完成之后回调，子类重写，完成相关ui调整
function BaseView:onInitUI()
end

--@private func

function BaseView:ctor()
    self:enableNodeEvents()
    self:create_()
    self:onInitUI()
    self:onCreate()
end

function BaseView:create_() 
    self.csbNode = self:onGetCsbNode()
    self:addChild(self.csbNode)
end

function BaseView:onCreate()
end

function BaseView:onEnter()
    Functions.debugCall(function()
        if self._controller_t then
            Functions.safeFunc(self._controller_t.onDisplayView, self._controller_t)
            if GuideManager then
                GuideManager:checkGuide()
            end
        end
    end)
end

function BaseView:onExit()
    Functions.debugCall(function()
        if self._controller_t then
            Functions.safeFunc(self._controller_t.onRemoveView, self._controller_t)
    	end
    end)
end

function BaseView:onCleanup()
    Functions.debugCall(function()
    	if self._controller_t then
           Functions.safeFunc(self._controller_t.onCleanView, self._controller_t)
        end
    end)
end




return BaseView