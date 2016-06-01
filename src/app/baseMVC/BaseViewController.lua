local BaseViewController = class("BaseViewController")

local Functions = require("app.common.Functions")

BaseViewController.debug_b = true
BaseViewController.modulePath = ...

local scheduler = require("app.common.scheduler")

--@预加载资源

BaseViewController.spriteFrameNames =
    {
    }

BaseViewController.animaNames =
    {
    }



--@pulice func

function BaseViewController:openChildView(childView, param)
    if GameCtlManager.isViewLoading then
        if type(childView) == "userdata" then
            childView:retain()
        end
        self._popViewQueue[#self._popViewQueue+1] = { childView = childView, param = param}
        return 
    end
    PromptManager:openShieldLayer()
    GameCtlManager.isViewLoading = true
    local isRemove, data, name
    if param and type(param) == "table" then
        isRemove = param.isRemove
        data = param.data
        name = param.name
    end

    -- if name and self._childViews[name] then
    --     return
    -- end

    local view, isUserdata
    if type(childView) == "string" then
        view = require(childView).new()
    elseif type(childView) == "userdata" then
        view = childView
    else
        assert(false, "child view type is error")
    end
    view:retain()

    --用名称管理子视图
    if name then
        self._childViews[name] = view
    else
        self._childViews[self._childIndex] = view
        self._childIndex = self._childIndex + 1
    end

    if isRemove == nil then isRemove = true end

    --添加遮挡层
    self.blackColorLayers_t[view] = CommonWidgets:getBlackColorLayer()
    self.blackColorLayers_t[view]:move(display.cx, display.cy)
    self.view_t:addChild(self.blackColorLayers_t[view])
    
    self.blackColorLayers_t[view]:setVisible(false)
    local loadResFinish = function()
        PromptManager:closeShieldLayer()
        -- self.blackColorLayers_t[view]:fadeIn({ time = 0.1 })
        self.blackColorLayers_t[view]:setVisible(true)
        --添加移除子视图监听
        if isRemove then
            local onRemoveChildView = function()
                self:closeChildView(view)
            end
            self.blackColorLayers_t[view]:onTouch(Functions.createTouchListener(onRemoveChildView))
        end

        --添加childview
        view:setController(self)
        view:move(display.cx, display.cy)
        view:LoadSelfView()
        self.view_t:addChild(view)
        view:setVisible(false)
        self.curChildView = view
        view:release()

        view.showView = function()
            view.isShow = true
            view:setVisible(true)
            --如果有弹出动作，执行弹出动作
            local popAction = view:getPopAction()
            if popAction then
                transition.execute(view, popAction)
            end
        end

        --子界面初始化
        Functions.safeFunc(view.onDisplayView, view, data)

        --切换视图
        view:onChangeView()
        GameCtlManager.isViewLoading = false

        if #self._popViewQueue > 0 then
            local popData = self._popViewQueue[1]
            table.remove(self._popViewQueue, 1)
            if type(popData.childView) == "userdata" then
                popData.childView:release()
            end
            self:openChildView(popData.childView, popData.param)
        end
    end

    Functions.preLoadResHandler(view, loadResFinish)

    return view
end

function BaseViewController:removeChildHandler(childView)
    ResManager:removeAnimations(childView.animaNames)
    ResManager:removeSpriteFrames(childView.spriteFrameNames)

    self.blackColorLayers_t[childView]:removeSelf()
    childView:removeSelf()
end

function BaseViewController:closeChildView(childView)
    assert(type(childView) == "userdata" or type(childView) == "string", "param input is error")

    if type(childView) == "string" then
        assert(self._childViews[childView], "not found child view " .. childView)
        childView = self._childViews[childView]
        self._childViews[childView] = nil
    else
        for k, v in pairs(self._childViews) do
            if v == childView then
                self._childViews[k] = nil
            end
        end
    end
    self:removeChildHandler(childView)

    if GuideManager then
        GuideManager:checkGuide()
    end
end

function BaseViewController:clearChildViewRes()
    for k, v in pairs(self._childViews) do
        ResManager:removeAnimations(v.animaNames)
        ResManager:removeSpriteFrames(v.spriteFrameNames)
    end
end

--@virtual func

function BaseViewController:onPreLoadAnima(progress)
    Functions.printInfo(self.debug,"anima load progress : " .. progress)
end

function BaseViewController:onPreLoadSpriteFrameRes(progress)
    Functions.printInfo(self.debug,"SpriteFrameRes load progress :" .. progress)
end

function BaseViewController:openBgMusic()
    Audio.playMusic(GameState.storeAttr.CurGameBgMusic_s)
end

function BaseViewController:onDidLoadView()
end

function BaseViewController:onCreate()
end

function BaseViewController:onChangeView()
    if not self.isShow then
        self:showView()
    end
end

function BaseViewController:onReceiveChildCtlData(data)
end

function BaseViewController:onReceiveParentCtlData(data)

end

--接受goto数据
function BaseViewController:onReceiveGotoData(data)
end

--接受push数据
function BaseViewController:onReceivePushData(data)
end

--接受pop数据
function BaseViewController:onReceivePopData(data)
end

function BaseViewController:setParentCtl(controller)
    self.parentController = controller
end

--获取button
function BaseViewController:getButtonOfName(name, callBack)

    local getButtonFunc = function()
        if self["_" .. name .. "_t"] then
            callBack(self["_" .. name .. "_t"])

            if self._getButtonHandler then
                scheduler.unscheduleGlobal(self._getButtonHandler)
            end
            return true
        elseif self.curChildView and self.curChildView["_" .. name .. "_t"] then
            callBack(self.curChildView["_" .. name .. "_t"])

            if self._getButtonHandler then
                scheduler.unscheduleGlobal(self._getButtonHandler)
            end
            return true
        else
            return false
        end
    end

    if not getButtonFunc() then
        self._getButtonHandler = scheduler.scheduleUpdateGlobal(getButtonFunc)
    end
end


function BaseViewController:onDisplayView()
    Functions.printInfo(self.debug_b, self.class.__cname .. " view 开始显示回调")
end

function BaseViewController:onRemoveView()
    Functions.printInfo(self.debug_b, self.class.__cname .. " view 移除回调")
end

function BaseViewController:onCleanView()
    Functions.printInfo(self.debug_b, self.class.__cname .. " view 清除回调")
end


--@private func

--构造函数
function BaseViewController:ctor()
    self.blackColorLayers_t = {}
    self.parentController = nil
    self.childController = nil
    self._childViews = {}
    self._childIndex = 1
    self._popViewQueue = {}
    self.isShow = false
    --回调子类方法
    self:onCreate()
end

--供控制器管理器起调用
function BaseViewController:LoadView_()

    --获取对应视图名称
    local viewName = string.sub(self.modulePath, 1, #self.class - 11)
    Functions.printInfo(self.debug,"控制器 " .. self.class.__cname .. " 视图为: " .. viewName)

    --初始化控制器中视图
    self.view_t = require(viewName).new()
    self.view_t:setController(self)

    -- self:onGetRootScene()
    self.view_t:retain()

    --加载完成回调子类方法
    self:onDidLoadView()
end

return BaseViewController