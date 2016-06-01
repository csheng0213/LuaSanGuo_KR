local BaseView = require("app.baseMVC.BaseView")
local BasePopView = class("BasePopView", BaseView)

BasePopView.csbResPath = ""

function BasePopView:getPopAction()
    self:setScale(0.6)
    local scaleTo1 = cc.ScaleTo:create(0.1, 1.3, 1.3)
    local scaleTo2 = cc.ScaleTo:create(0.1, 1, 1)
    return cc.Sequence:create(scaleTo1, scaleTo2)
end

function  BasePopView:onChangeView()
    if not self.isShow then
        self:showView()
    end
end

function BasePopView:onGetCsbNode()
    local csbResName = self.csbResPath .. "/" .. self.class.__cname
    local csbResPath = string.sub(csbResName,1,#csbResName - 4) .. "UI.csb"

    return self:loadCsbNode(csbResPath)
end

--根据路径加在csbNode,公共处理方法，统一加在csbNode
function BasePopView:loadCsbNode(csbFilePath)
    DebugHoldTime("BasePopView:loadCsbNode: " .. tostring(csbFilePath))
    local csbNode = cc.CSLoader:createNode(csbFilePath)
    DebugDelayTime("BasePopView:loadCsbNode: " .. tostring(csbFilePath))
    --对csb Node 进行统一处理
    return csbNode
end

function BasePopView:close()
    self._controller_t:closeChildView(self)
end

function BasePopView:LoadSelfView()
    self:create_()
    self:onInitUI()
    self:onCreate()
end

--@private func

function BasePopView:ctor()
    self.isShow = false
end

function BasePopView:onCreate()
end

return BasePopView