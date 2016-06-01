local Functions = {}

local cjson = cjson.new()

--游戏进入后台调用
function enterBackground()
    print("游戏进入后台！")
    GameEventCenter:dispatchEvent({ name = GlobalEventCenter.GAME_ENTER_BACKGROUND })
end

--游戏进入前台调用
function enterForeground()
    print("游戏进入前台！")
    GameEventCenter:dispatchEvent({ name = GlobalEventCenter.GAME_ENTER_FOREGROUND })
end

--判断是否为number
function Functions.isNumber(data)
    if tonumber(data) then
        return true
    else
        return false
    end
end

function Functions.safeFunc(func,...)
    if func then
        func(...)
    end
end

function Functions.printInfo(isOpen, ...)

    if not isOpen then return end

    local param = {...}
    for i=1, #param do
        print(param[i])
    end
end

function Functions.dump(isOpen, ...)
    if not isOpen then return end
    dump(...)
end

function Functions.getDisHeadImagePathOfId(id)
    if id > 100 then
        local inNum = 60000 + id
        return "heroHead/" .. tostring(inNum) .. "_y.png"
    else
        local inNum = 50000 + id
        return "heroHead/" .. tostring(inNum) .. "_y.png"
    end
end

function Functions.getDisHeadFImagePathOfId(id)
    if id > 100 then
        local inNum = 60000 + id
        return "heroHead/" .. tostring(inNum) .. ".png"
    else
        local inNum = 50000 + id
        return "heroHead/" .. tostring(inNum) .. ".png"
    end
end

function Functions.playBtSound()
    Audio.playSound("sound/button_click.mp3")
end

--播放音效
--string为音效名
function Functions.playSound(string)
    assert(string ~= nil, "param is error")
    local str = "sound/ui_mp3/"..string
    Audio.playSound(str)
end

--生成一个触摸回调函数
function Functions.createTouchListener(listener)
    local onClickListener = function(event)

        if type(event) == "string" and event == "Guide" then
            listener()
            return
        end

        if event.name == "ended" then
            Functions.debugCall(function()
                listener(event)
            end)
        end
    end

    return onClickListener
end

function Functions.delayClickHandler(target, time)

    --点击时间限制
    target:setEnabled(false)
    target:setBright(false)
    local scheduler = require("app.common.scheduler")
    local handle = scheduler.performWithDelayGlobal(function()
                        target:setEnabled(true)
                        target:setBright(true)
                    end, time)
end

--生成一个按钮回调函数
function Functions.createClickListener(listener, btType)

    local onClickListener = nil
    local onClickFlag = false
    local defualtFunc = function(event)
        
        if not onClickFlag then 
            onClickFlag = true
            if type(event) == "string" and event == "Guide" then
                listener()
                onClickFlag = false
                return
            end

            if event.name == "ended" then
                Functions.debugCall(function()
                    Functions.playBtSound()
                    listener(event)
                end)
            end
            onClickFlag = false
        end       
    end

    local oldScale = nil
    if btType and btType == "zoom"then
        onClickListener = function(event)

            if not onClickFlag then
                
                onClickFlag = true
                if type(event) == "string" and event == "Guide" then
                    listener()
                    onClickFlag = false
                    return
                end

                if not oldScale then
                    oldScale = event.target:getScale()
                end

                if event.name == "began" then
                    event.target:setScale(oldScale * 0.9)
                elseif event.name == "cancelled" then
                    event.target:setScale(oldScale)
                    oldScale = nil
                elseif event.name == "ended" then
                    event.target:setScale(oldScale)
                    oldScale = nil
                    Functions.debugCall(function()
                        Functions.playBtSound()
                        listener(event)
                    end)
                end
                onClickFlag = false
            end

        end
    elseif btType == "movedis" then
        onClickListener = function(event)
            if not onClickFlag then
                onClickFlag = true
                if type(event) == "string" and event == "Guide" then
                    listener()
                    onClickFlag = false
                    return
                end

                if event.name == "began" then
                    local parent = event.target:getParent()
                    local old_pos = parent:convertToWorldSpace({ x = event.target:getPositionX(), y = event.target:getPositionY()})
                    event.target.old_pos = old_pos
                elseif event.name == "ended" then
                    local oldPosX = event.target.old_pos.x 
                    local oldPosY = event.target.old_pos.y
                    local pos = event.target:getParent():convertToWorldSpace({ x = event.target:getPositionX(), y = event.target:getPositionY()})
                    local moveDistanceX = math.abs(oldPosX - pos.x)
                    local moveDistanceY = math.abs(oldPosY - pos.y)
                    if moveDistanceX + moveDistanceY < 8 then
                        Functions.debugCall(function()
                            Functions.playBtSound()
                            listener(event)
                        end)
                    end
                end
                onClickFlag = false
            end
        end
    elseif btType == "select" then
        onClickListener = function(event)
            if not onClickFlag then
                onClickFlag = true
                if type(event) == "string" and event == "Guide" then
                    listener()
                    onClickFlag = false
                    return
                end

                if event.name == "began" then
                    Functions.playBtSound()
                    listener(event)
                elseif event.name == "ended" then
                    Functions.playBtSound()
                    listener(event)
                elseif event.name == "cancelled" then
                    listener(event)
                end
                onClickFlag = false
            end
        end
    else
        onClickListener = defualtFunc
    end

    return onClickListener
end
--生成一个按钮回调函数
function Functions.createTableViewClickListener(container,listener, btType)

    local onClickListener = nil
    local onClickFlag = false
    local defualtFunc = function(event)
        
        if not onClickFlag then 
            onClickFlag = true
            if type(event) == "string" and event == "Guide" then
                listener()
                onClickFlag = false
                return
            end

            if event.name == "ended" then
                Functions.debugCall(function()
                    Functions.playBtSound()
                    listener(event)
                end)
            end
            onClickFlag = false
        end       
    end

    local oldScale = nil
    if btType and btType == "zoom"then
        onClickListener = function(event)

            if not onClickFlag then
                
                onClickFlag = true
                if type(event) == "string" and event == "Guide" then
                    listener()
                    onClickFlag = false
                    return
                end

                if not oldScale then
                    oldScale = event.target:getScale()
                end

                if event.name == "began" then
                    event.target:setScale(oldScale * 0.9)
                elseif event.name == "cancelled" then
                    event.target:setScale(oldScale)
                    oldScale = nil
                elseif event.name == "ended" then
                    event.target:setScale(oldScale)
                    oldScale = nil
                    Functions.debugCall(function()
                        Functions.playBtSound()
                        listener(event)
                    end)
                end
                onClickFlag = false
            end

        end
    elseif btType == "movedis" then
        onClickListener = function(event)
            if not onClickFlag then
                onClickFlag = true
                if type(event) == "string" and event == "Guide" then
                    listener()
                    onClickFlag = false
                    return
                end

                if event.name == "began" then
                    local parent = event.target:getParent()
                    local old_pos = parent:convertToWorldSpace({ x = event.target:getPositionX(), y = event.target:getPositionY()})
                    event.target.old_pos = old_pos
                elseif event.name == "ended" then
                    local oldPosX = event.target.old_pos.x 
                    local oldPosY = event.target.old_pos.y
                    local pos = event.target:getParent():convertToWorldSpace({ x = event.target:getPositionX(), y = event.target:getPositionY()})
                    
                    local moveDistanceX = math.abs(oldPosX - pos.x)
                    local moveDistanceY = math.abs(oldPosY - pos.y)
                    if moveDistanceX + moveDistanceY < 8 then
                        Functions.debugCall(function()
                            Functions.playBtSound()                     
                            local containerSize = container:getContentSize()
                            local x = container:getPositionX()
                            local y = container:getPositionY()
                            local containerPos = container:getParent():convertToWorldSpace({ x =container:getPositionX(), y = container:getPositionY()})
                            local clickPos = event.target:getTouchBeganPosition()

--                            print("clickPosX = %d",clickPos.x)
--                            print("clickPosY = %d",clickPos.y)
                            if clickPos.x> containerPos.x and clickPos.x<  containerPos.x + containerSize.width and clickPos.y > containerPos.y and clickPos.y < containerPos.y + containerSize.height then 
                                listener(event)
                            end
                        end)
                    end
                end
                onClickFlag = false
            end
        end
    elseif btType == "select" then
        onClickListener = function(event)
            if not onClickFlag then
                onClickFlag = true
                if type(event) == "string" and event == "Guide" then
                    listener()
                    onClickFlag = false
                    return
                end

                if event.name == "began" then
                    Functions.playBtSound()
                    listener(event)
                elseif event.name == "ended" then
                    Functions.playBtSound()
                    listener(event)
                elseif event.name == "cancelled" then
                    listener(event)
                end
                onClickFlag = false
            end
        end
    else
        onClickListener = defualtFunc
    end

    return onClickListener
end
--生成一个input回调函数
function Functions.createInputListener(controller, height)

    local isClose = false
    local y = height or 150
    local onInputListener = function(event)
        -- if device.platform == "ios" then
            if event.name == "ATTACH_WITH_IME" then
                isClose = true
                controller.view_t:moveBy({ x = 0, y = y, time = 0.3 })
            end
            if event.name == "DETACH_WITH_IME" then
                if isClose then
                    controller.view_t:moveBy({ x = 0, y = -y, time = 0.3 })
                    isClose = false
                end
            end
        -- end
    end

    return onInputListener
end

--生成一个网络返回回调
--@param: listener function :监听函数
--@param: isRemove bool : 网络返回是否移除监听
--@param: errCodeStr string : 网络错误字段名
function Functions.createNetworkListener(listener, isRemove, errCodeStr, errBackCall)

    if isRemove == nil then
        isRemove = true
    end
    errCodeStr = errCodeStr or "err"

    local onNetworkCallBack = function(event)

        if event[errCodeStr] == 1 then
            Functions.debugCall(function()
                listener(event)
            end)
        else
            if errBackCall then
                errBackCall()
            end
            PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event[errCodeStr]))
        end

        return isRemove
    end

    return onNetworkCallBack
end


function Functions.bindNetWorkListener(node, idx, listener)

    local handler = NetWork:addNetWorkListener(idx, listener)

    local onUiClean = function()
        NetWork:removeNetWorkListener(handler)
    end
    Functions.addCleanFuncWithNode(node, onUiClean)
end



function Functions.createColorLayer(color)
    return display.newLayer(color)  
end

--让ui节点循环执行一个动画
--@param : target 执行动画的ui widget 
--@param : animaName 动画名称 string
--@param : delayTime 循环间隔时间 Number 
--@param : isHide 间隔时间中，是否隐藏动画节点 bool
function Functions.playAnimaOfUI(target, animaName, delayTime, isHide)

    assert(type(target) == "userdata" and type(animaName) == "string", "param is error")
    local action = cc.Animate:create(display.getAnimationCache(animaName))
    return Functions.playActionOfUI(target, action, delayTime, isHide)

end

function Functions.playAnimaWithCreateSprite(target,animaName,isForever,firstFrame,pos,scale)
    local action = nil
    if type(animaName) == "string" then
        action = cc.Animate:create(display.getAnimationCache(animaName))
    else
        action = animaName
    end
    local animationSprite = cc.Sprite:create()
    if firstFrame ~= nil then
        Functions.loadImageWithSprite(animationSprite, firstFrame)
    end
    if pos == nil then
        animationSprite:setPosition(cc.p(target:getContentSize().width/2,target:getContentSize().height/2))
    else
        animationSprite:setPosition(pos)
    end
    if scale ~= nil then
        animationSprite:setScale(scale)
    end
    target:addChild(animationSprite)
    if isForever then
        transition.execute(animationSprite, cc.RepeatForever:create(action))
    else
        transition.execute(animationSprite, action)
    end
end

--ui节点播放一个带回调的动画
function Functions.playActionWithBackCall(target, action, listener)

    local l_action = nil
    local actionType = type(action)
    if type(action) == "string" then
        l_action = cc.Animate:create(display.getAnimationCache(action))
    elseif type(action) == "userdata" then
        l_action = action
    else
        assert(false, "action type is error")
    end

    return transition.execute(target, l_action, {
        onComplete = listener
    })
end
--在一个节点上创建精灵播放一次动画，播放完毕删除动画精灵
function Functions.playAnimationWithRemove(target,animaName,addX,addY,handler)
    local animationSprite = cc.Sprite:create()
    animationSprite:setPosition(cc.p(target:getContentSize().width/2 + addX , target:getContentSize().height/2+ addY))
    animationSprite:setAnchorPoint(0.5,0.5)
    local  call = function()
        if animationSprite ~= nil then 
           animationSprite:removeFromParent()
        end
        if handler ~= nil then 
            handler()
        end
    end
    target:addChild(animationSprite)
    Functions.playActionWithBackCall(animationSprite,animaName, call)
end

--ui节点播放一组动作
function Functions.playActionsWithBackCall(target, actions, listener)

    assert(type(actions) == "table", "param is error")

    local l_actions = {}
    for k, v in ipairs(actions) do

        local l_action = nil
        local actionType = type(v)
        if actionType== "string" then
            l_action = cc.Animate:create(display.getAnimationCache(v))
        elseif actionType== "userdata" then
            l_action = v
        else
            assert(false, "action type is error")
        end

        l_actions[#l_actions+1] = l_action
    end

    if #l_actions > 0 then

        local actionSeq = cc.Sequence:create(l_actions)
        transition.execute(target, actionSeq, {
            onComplete = listener
        })
    end

end

--播放一个节点一个移动的动作
function Functions.playNodeMove(target,duration,deltaPosition)
    local move = cc.MoveBy:create(duration,deltaPosition)
    transition.execute(target, move)
end

--ui节点循环播放一个动作序列
--@param : target 执行动画的ui widget 
--@param : animaNameTable 动画名称表顺序存放 : { {actionName = “”,repeatNum = 0} } 在单词序列中动作执行的次数
--@param : delayTime 循环间隔时间 Number 
--@param : isHide 间隔时间中，是否隐藏动画节点 bool
--@param : count 序列播放次数 0 为永久播放
function Functions.playSequenceAction(target, animaNameTable, delayTime,count,isHide,handler)
    if delayTime == nil then delayTime = 0 end
    if count == nil then count = 0 end
    if isHide == nil then isHide = false end

    local sequenceAction = {}
    --    sequenceAction[#sequenceAction+1] = cc.CallFunc:create(function() target:show() end)

    for i = 1, #animaNameTable do 

        local action = nil
        if type(animaNameTable[i].actionName) == "string" then
            action = cc.Animate:create(display.getAnimationCache(animaNameTable[i].actionName))
        elseif type(animaNameTable[i].actionName) == "userdata" then
            action = animaNameTable[i].actionName
        end

        local repeatAction = action
        if animaNameTable[i].repeatNum > 1 then
            repeatAction = cc.Repeat:create(action, animaNameTable[i].repeatNum)
        end

        sequenceAction[#sequenceAction+1] = repeatAction
    end

    sequenceAction[#sequenceAction+1]= cc.CallFunc:create(function()
        if isHide then
            target:hide()
        end
        if handler ~= nil then 
            handler(target)
        end
    end)
    sequenceAction[#sequenceAction+1] = cc.DelayTime:create(delayTime)
    sequenceAction[#sequenceAction+1] = NULL
    local play = cc.Sequence:create(sequenceAction)
    target:setVisible(true)
    if count > 0 then
        transition.execute(target,cc.Repeat:create(play,count)) 
    else
        transition.execute(target, cc.RepeatForever:create(play))
    end
    -- body
end

--ui节点循环执行一个动作
--@param : target 执行动作的ui widget 
--@param : action 动作对象 Action
--@param : delayTime 循环间隔时间 Number 
--@param : isHide 间隔时间中，是否隐藏动画节点 bool
function Functions.playActionOfUI(target, action, delayTime, isHide)
    if isHide == nil then isHide = true end
    if delayTime == nil then delayTime = 0 end

    local drumAction = cc.Sequence:create(cc.CallFunc:create(function()
        target:show()
    end), action, cc.CallFunc:create(function()
        if isHide then
            target:hide()
        end
    end),
    cc.DelayTime:create(delayTime))
    return transition.execute(target, cc.RepeatForever:create(drumAction))
end
--根据士兵id加载士兵动画名称
function Functions.getSoldierAnimaOfid(SoldierId)
    local resId = ConfigHandler:getSoldierResIdOfId(SoldierId) 
    return ConfigHandler:loadSoldierAnimaInfo(resId)
        --      return ConfigHandler:getSoldierResIdOfId(SoldierId)   
end
--根据英雄id加载英雄动画名称
function Functions.getHeroAnimaOfid(heroId)
    local resId = ConfigHandler:getHeroResIdOfId(heroId) 
    return ConfigHandler:loadHeroAnimaInfo(resId)
        --    return ConfigHandler:getHeroResIdOfId(heroId)
end

--在模型对象注册属性事件监听
--@param : model 模型对象 BaseModel 
--@param : attrName 事件属性名称 string
--@param : listener 监听函数 fuction 
function Functions.registerAttrListener(model, attrName, listener)

    local eventName = string.upper(model.__cname) .. "_" .. string.upper(tostring(attrName)) .. "_" .. "CHANGE_EVENT"    
    model:addEventListener(eventName, listener)

end

--绑定ui显示数据
function Functions.bindUiWithModelAttr(target, model, attrName, listener)

    local onModelAttrChange = function(event)  --默认监听，直接修改ui显示数据
        target:setString(tostring(event.data))
    end
    if listener == nil then
        listener = onModelAttrChange 
    end

    --添加属性监听事件
    local eventName = string.upper(model.__cname) .. "_" .. string.upper(tostring(attrName)) .. "_" .. "CHANGE_EVENT"    
    Functions.bindEventListener(target, model, eventName, listener)
end

--移除ui属性监听
function Functions.removeModelAtrrEvent(model, attrName)
    --移除属性监听事件
    local eventName = string.upper(model.__cname) .. "_" .. string.upper(tostring(attrName)) .. "_" .. "CHANGE_EVENT"    
    model:removeEventListenersByEvent(eventName)
end

--绑定监听到一个数据模型的属性上
--@param: model : mvcModel
--@param: attrName : 属性名称
--@param: listener : 监听函数
function Functions.bindWithModelAttr(model, attrName, listener)

    --添加属性监听事件
    local eventName = string.upper(model.__cname) .. "_" .. string.upper(tostring(attrName)) .. "_" .. "CHANGE_EVENT"    
    local handler = model:addEventListener(eventName, listener)
    return handler

end

function Functions.bindEventListener(widget, eventSrc, eventName, listener)
    local handler = eventSrc:addEventListener(eventName, listener)

    if not widget.eventMap then
        widget.eventMap = {}
        widget.eventMap[eventSrc] = {}
        widget.eventMap[eventSrc][#widget.eventMap[eventSrc]+1] = handler

        --ui移除时，移除监听
        local onUiClean = function()
           Functions.removeEventBeforeUiClean(widget)
        end
        widget:onNodeEvent("cleanup", onUiClean)
    else
        if not widget.eventMap[eventSrc] then
            widget.eventMap[eventSrc] = {}
            widget.eventMap[eventSrc][#widget.eventMap[eventSrc]+1] = handler
        else
            widget.eventMap[eventSrc][#widget.eventMap[eventSrc]+1] = handler
        end
    end
    return handler
end

function Functions.removeEventListenerByView(widget, eventSrc, handler)
    if widget.eventMap and widget.eventMap[eventSrc] then
        for i=1, #widget.eventMap[eventSrc] do
            if widget.eventMap[eventSrc][i] == handler then
                eventSrc:removeEventListener(handler)
                widget.eventMap[eventSrc][i] = nil
            end
        end
    end
end

function Functions.removeEventBeforeUiClean(widget)
    if nil ~= widget.eventMap then 
        for eventSrc, handlers in pairs(widget.eventMap) do
            for k, handler in pairs(handlers) do
                eventSrc:removeEventListener(handler)
            end
        end
        widget.eventMap = nil
    end
end

--绑定list数据
--@param: listPanel list容器
--@param: listData  list绑定的数据，顺序存放数据
--@param: handler   处理单个节点和数据绑定:function(index, widget, data)
function Functions.bindListWithData(listPanel, listData, handler)

    if not listPanel:isVisible() then
        listPanel:setVisible(true)
    end

    if not listPanel.model then
        listPanel.model = listPanel:getChildByName("model")
        listPanel:setItemModel(listPanel.model)
    end

    listPanel:removeAllChildren()

    local temp = #listData
    for i=1, temp do

        listPanel:pushBackDefaultItem()
        local widget = listPanel:getItems()
        local child = widget[#widget]
        handler(i, child, listData[i], listPanel.model) 
    end
end
--绑定page数据
--@param: pagePanel page容器
--@param: pageData  page绑定的数据，顺序存放数据
--@param: handler   处理单个节点和数据绑定:function(index, widget, data)
function Functions.bindPageWithData(pagePanel, pageData, handler)

    if not pagePanel:isVisible() then
        pagePanel:setVisible(true)
    end

    if not pagePanel.model then
        pagePanel.model = pagePanel:getChildByName("model") 
        pagePanel.model:retain()

        Functions.addCleanFuncWithNode(pagePanel, function()
            pagePanel.model:release()
        end)
    end
    -- local coloeModel = pagePanel:getChildByName("model") 
    -- pagePanel:removeAllChildren()

    pagePanel:removeAllPages()
    local temp = #pageData
    for i= 0, temp do        
        local model = pagePanel.model:clone()
        pagePanel:addPage(model)
        local widget = pagePanel:getPage(i)
        handler(i, widget, pageData[i], pagePanel.model)

    end

end
--检查listpanel 是否有model
function Functions.checkModelOfList(listView)
    local oldWidgets = listView:getItems()
    listView:pushBackDefaultItem()
    local newWidgets = listView:getItems()

    if #newWidgets > #oldWidgets then
        return newWidgets[#newWidgets]
    end

end
--绑定table数据
--@param: listPanel list容器
--@param: listDataTable list绑定的数据，顺序存放数据 格式：{firstData = {},secondData = {}, thirdlyData = {}} 取最大值
--@param: handler   处理单个节点和数据绑定
--@param: pramTable 显示方式，格式{direction = true,col = 5,firstSegment = 10,segment = 10 } 方向，单列/行数量，首元素间距，元素间间距
function Functions.bindArryListWithData(listPanel,listDataTable,handler,pramTable)

    if not listPanel:isVisible() then
        listPanel:setVisible(true)
    end

    if pramTable == nil then
        pramTable = {direction = true, col = 5, firstSegment = 10 ,segment = 10 } 
    end
    if listDataTable["secondData"] == nil then
        listDataTable["secondData"] = {}
    end 
    if listDataTable["thirdlyData"] == nil then
        listDataTable["thirdlyData"] = {}
    end 

    if not listPanel.arryModel then
        listPanel.arryModel = listPanel:getChildByName("model")
        listPanel:setItemModel(listPanel.arryModel)
    end
    listPanel:removeAllChildren()

    local modelSize = listPanel.arryModel:getContentSize()
    local scale = listPanel.arryModel:getScale()
    modelSize = { width = modelSize.width * scale, height = modelSize.height * scale }

    local childModel = listPanel.arryModel:getChildByName("childModel"):getChildByName("model")
    childModel:setAnchorPoint(cc.p(0.5,0.5))
    local childModelSize = childModel:getContentSize()
    local scale = childModel:getScale()
    childModelSize = { width = childModelSize.width * scale, height = childModelSize.height * scale }

    local secondDataNum = 0 
    if type(listDataTable["secondData"]) == "table" then
        secondDataNum = #listDataTable["secondData"]
    else
        secondDataNum = listDataTable["secondData"]
    end 
    local cnt =  math.max(#listDataTable["firstData"],secondDataNum,#listDataTable["thirdlyData"])
    local tempx = Functions.subIntOfNum(cnt/pramTable["col"])
    local tempy = Functions.subIntOfNum(cnt%pramTable["col"])
    local index = 0
    local creatList = function (count)        
        listPanel:pushBackDefaultItem()
        local widget = listPanel:getItems()
        local listModel = widget[#widget]
        listModel:removeAllChildren()

        for j=1,count do
            local child = childModel:clone()
            child:setParent(nil)
            if pramTable["direction"] == true then
                local coord = pramTable["firstSegment"] + (childModelSize["width"]/2 + pramTable["segment"])+(childModelSize["width"] + pramTable["segment"])*(j-1)
                child:setPositionX(coord)

                child:setPositionY(modelSize.height/2)
            else
                local coord = listModel:getContentSize()["height"] - pramTable["firstSegment"] - (childModelSize["height"]/2 + pramTable["segment"]) - (childModelSize["height"] + pramTable["segment"])*(j-1)
                child:setPositionY(coord)

                child:setPositionX(modelSize.width/2)
            end
            listModel:addChild(child)    
            index = index + 1
            if index <= #listDataTable["firstData"] then
                handler(index,child,childModel,listDataTable["firstData"][index],listDataTable["secondData"],listDataTable["thirdlyData"][index])   
            end        
        end
    end
    if tempx > 0 then
        for i=1,tempx do
            creatList(pramTable["col"])
        end
    end
    if tempy > 0 then
        creatList(tempy)
    end
end
--绑定tableView
--@tableContainer:用于放置tableView,并且里面有一个可被克隆的widget
--@tableDataTable:绑定的数据，顺序存放数据 格式：{firstData = {},secondData = {}, thirdlyData = {}} 取最大值
--@param: tableDataTable   处理单个节点和数据绑定 { handler 绑定单个节点的处理，removeNodeHandler，节点移除前的回调,handler2,secondData绑定节点的回调}
--@param: pramTable 显示方式，格式{direction = true,col = 5,firstSegment = 10,segment = 10 } 方向，单列/行数量，首元素间距，元素间间距
function Functions.bindTableViewWithData(tableContainer,tableDataTable,handlerTable,pramTable) 
    if tableContainer:getChildByTag(100) ~= nil then 
        tableContainer:getChildByTag(100):removeFromParent()
    end
    if not tableContainer:isVisible() then
        tableContainer:setVisible(true)
    end
    if pramTable == nil then
        pramTable = {direction = true, col = 5, firstSegment = 10 ,segment = 10 ,segmentY= 10} 
    end
    if tableDataTable["secondData"] == nil then
        tableDataTable["secondData"] = {}
    end 
    if tableDataTable["thirdlyData"] == nil then
        tableDataTable["thirdlyData"] = {}
    end
    local secondDataNum = 0 
    if type(tableDataTable["secondData"]) == "table" then
        secondDataNum = #tableDataTable["secondData"]
    else
        secondDataNum = tableDataTable["secondData"]
    end 


    local size = tableContainer:getContentSize() 
    local heroTableView = cc.TableView:create(cc.size(size.width,size.height))
    heroTableView:setTag(100)    
    heroTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL) 
    heroTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    heroTableView:setAnchorPoint(cc.p(0,0)) 
    heroTableView:setPosition(cc.p(0,0))
    heroTableView:setDelegate()
    heroTableView:setTouchEnabled(true)
    tableContainer:addChild(heroTableView)

    local childModel =  tableContainer:getChildByName("childModel"):getChildByName("model")
    childModel:setAnchorPoint(cc.p(0,1))
    local childModelSize = childModel:getContentSize() 
    local scale = childModel:getScale()
    childModelSize = { width = childModelSize.width * scale, height = childModelSize.height * scale }
    
    local cnt =  math.max(#tableDataTable["firstData"],secondDataNum,#tableDataTable["thirdlyData"])
    local tempx = Functions.subIntOfNum(cnt/pramTable["col"])
    local tempy = Functions.subIntOfNum(cnt%pramTable["col"])
    
    local createSigleNode = function(row,col)
        local child = childModel:clone()
        child:setParent(nil)
        child:setVisible(true)
        child:setAnchorPoint(cc.p(0.5,0.5))
        local coord = pramTable["firstSegment"] + (childModelSize["width"]/2 + pramTable["segment"])+(childModelSize["width"] + pramTable["segment"])*(col-1)
        child:setPositionX(coord)
        child:setPositionY(childModelSize.height/2)
        if row*pramTable["col"] + col <= #tableDataTable["firstData"] then 
            handlerTable.handler(row*pramTable["col"] + col,child,childModel,tableDataTable["firstData"][row*pramTable["col"] + col],tableDataTable["secondData"],tableDataTable["thirdlyData"][(row+1)*col]) 
        else
            if handlerTable.handler2 ~= nil then
                handlerTable.handler2(child)
            end
        end
        return child
    end

    local creatRowNodes = function(count,row)
        local panel = cc.Layer:create()
            panel:setContentSize(cc.size(size.width,childModelSize.height))
        for col=1,count do            
            panel:addChild(createSigleNode(row,col))
        end   
        panel:setTag(200)
        return panel         
    end
    local updateRowNodes = function(_panel,count,row)
        local nodes = _panel:getChildren()
        if count <= #nodes then
            for col=1,#nodes do                
                if col <= count then 
                    if row*pramTable["col"] + col <= #tableDataTable["firstData"] then 
                        handlerTable.handler(row*pramTable["col"] + col,nodes[col],childModel,tableDataTable["firstData"][row*pramTable["col"] + col],tableDataTable["secondData"],tableDataTable["thirdlyData"][(row+1)*col]) 
                    else
                        if handlerTable.handler2 ~= nil then 
                            handlerTable.handler2(nodes[col])
                        end
                    end   
                else
                    if handlerTable.removeNodeHandler ~= nil then 
                        handlerTable.removeNodeHandler(nodes[col]) 
                    end
                    nodes[col]:removeFromParent()
                end
            end
        else
            for col=1,#nodes do 
                if row*pramTable["col"] + col <= #tableDataTable["firstData"] then
                    handlerTable.handler(row*pramTable["col"] + col,nodes[col],childModel,tableDataTable["firstData"][row*pramTable["col"] + col],tableDataTable["secondData"],tableDataTable["thirdlyData"][(row+1)*col])  
                else
                    if handlerTable.handler2 ~= nil then
                        handlerTable.handler2(nodes[col])
                    end
                end   
            end
            for col = #nodes + 1, count do 
                _panel:addChild(createSigleNode(row,col))
            end
        end
    end
    local tableCellAtIndex = function(view,row)
        local cell = view:dequeueCell()
        if nil == cell then 
            local panel = nil 
            if row < tempx then 
                panel = creatRowNodes(pramTable["col"],row) 
            else
                panel = creatRowNodes(tempy,row)
            end 
            cell = cc.TableViewCell:new() 
            cell:addChild(panel)
        else
            local panel = cell:getChildByTag(200)
            if row < tempx then 
                Functions.debugCall(function()
                    updateRowNodes(panel,pramTable["col"],row)  
                end)
                
            else
                Functions.debugCall(function()
                    updateRowNodes(panel,tempy,row)
                end)
               
            end 
            heroTableView:updateCellAtIndex(cell:getIdx())
        end        
        return cell
    end
    local cellSizeForTable = function(view,row)
        if nil ~= pramTable.segmentY then
            return childModelSize.height + pramTable.segmentY, childModelSize.width
        else
            return childModelSize.height, childModelSize.width
        end 
    end
    local numberOfCellsInTableView = function(view)    
        if tempx > 0 and tempy > 0 then             
            return tempx + 1
        elseif tempx > 0 then
            return tempx
        else
            if tempy > 0 then
                return 1 
            else
                return 0 
            end
        end
       
    end
    local tableCellTouched = function(view,cell)

    end
    local scrollViewDidScroll = function(view)

    end
    local scrollViewDidZoom = function(view)
        -- print("scrollViewDidZoom")
    end
    local tableCellWillRecycle = function(view,cell)
        -- print(tostring(cell:getIdx()))
        
    end
  
    heroTableView:registerScriptHandler(scrollViewDidScroll,cc.SCROLLVIEW_SCRIPT_SCROLL)
    heroTableView:registerScriptHandler(scrollViewDidZoom, cc.SCROLLVIEW_SCRIPT_ZOOM)
    heroTableView:registerScriptHandler(tableCellWillRecycle, cc.TABLECELL_WILL_RECYCLE)
    heroTableView:registerScriptHandler(tableCellTouched, cc.TABLECELL_TOUCHED)
    heroTableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
    heroTableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
    heroTableView:registerScriptHandler(numberOfCellsInTableView,cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
    heroTableView:reloadData()
end
--加载button图片
function Functions.loadButtonImage(button, imageName)

    if cc.SpriteFrameCache:getInstance():getSpriteFrame(imageName) then
        button:loadTextures(imageName, imageName, "", UI_TEX_TYPE_PLIST)
    else
        button:loadTextures(imageName, imageName)
        cc.Director:getInstance():getTextureCache():removeTextureForKey(imageName)
    end

end

function Functions:getGongHuiImageOfId(id) 
    local Image = string.format("lk/uiFonts_res/%d.png", id)
    return Image
end

--加载Image图片
function Functions.loadImageWithWidget(widget, imageName)
    if cc.SpriteFrameCache:getInstance():getSpriteFrame(imageName) then
        widget:loadTexture(imageName, UI_TEX_TYPE_PLIST)
    else
        widget:loadTexture(imageName)
        cc.Director:getInstance():getTextureCache():removeTextureForKey(imageName)
    end
end

--切换一个精灵图片
function Functions.loadImageWithSprite(sprite, imageName, scale)

    if cc.SpriteFrameCache:getInstance():getSpriteFrame(imageName) then
        sprite:setSpriteFrame(imageName)
    else
        sprite:setTexture(imageName)
        cc.Director:getInstance():getTextureCache():removeTextureForKey(imageName)
    end
    if scale ~= nil then
        sprite:setScale(scale)
    end
end

--根据纹理名，生成一个精灵（废弃的）
function Functions.createSpriteOfSfName(spriteName)
    --assert(display.newSpriteFrame(spriteFrameName), "输入精灵帧名无法找到")

    if not cc.SpriteFrameCache:getInstance():getSpriteFrame(spriteName) then
        local sprite = cc.Sprite:create(spriteName)

        return sprite
    else
        local sprite = cc.Sprite:create()
        sprite:setSpriteFrame(display.newSpriteFrame(spriteName))
        cc.Director:getInstance():getTextureCache():removeTextureForKey(spriteName)
        return sprite
    end
end

--居中一个node
function Functions.setCenterOfNode(target)
    target:setAnchorPoint(cc.p(0.5, 0.5))
    target:setPosition(cc.p(display.cx, display.cy))
end
--根据纹理名，生成一个精灵或精灵帧
function Functions.createSprite(param)
    local scale, pos, zorder, spriteName, copyNode
    scale = 1
    pos = { x = 0, y = 0 }
    zorder = 0 
    spriteName = nil

    if param then
        scale  = param.scale or scale
        pos    = param.pos or pos
        zorder = param.zorder or zorder
        spriteName = param.spriteName
        if param.copyNode then
            scale  = param.copyNode:getScale()
            pos    = { x = param.copyNode:getPositionX(), y = param.copyNode:getPositionY() }
            zorder = param.copyNode:getLocalZOrder()
        end
    end

    local sprite = nil
    if spriteName then
        if not cc.SpriteFrameCache:getInstance():getSpriteFrame(spriteName) then
            sprite = cc.Sprite:create(spriteName)
        else
            sprite = cc.Sprite:create()
            sprite:setSpriteFrame(display.newSpriteFrame(spriteName))
        end
    else
        sprite = cc.Sprite:create()
    end

    sprite:setScale(scale)
    sprite:setPosition(pos.x, pos.y)
    sprite:setLocalZOrder(zorder)

    return sprite
end
--创建一个label
--@param:{scale = ,pos = ,zorder = ,text = ,color = }
function Functions.createLabel(param,isShadow)
    local scale, pos, zorder,text, color
    scale = 1
    pos = { x = 0, y = 0 }
    zorder = 0 
    color = cc.c3b(255,255,255)
    if param then
        if param.scale then scale = param.scale end
        if param.pos then pos = param.pos end
        if param.zorder then zorder = param.zorder end
        if param.text then text = param.text end
        if param.color then color = param.color end
    end

    local label = cc.Label:create()
    label:setScale(scale)
    label:setPosition(pos.x, pos.y)
    label:setLocalZOrder(zorder)
    label:setString(text)
    label:setColor(color)
    -- label:enableGlow(cc.c3b(255,0,0))
--    label:enableOutline(cc.c4b(255,125,0,255),8)
    if isShadow ~= nil then
        label:enableShadow(cc.c4b(0,0,0,255),cc.size(1,-1),0.2)
    end
    return label
end
--创建一个label
--@param:{scale = ,pos =,filePath=,zorder = ,text = ,color=,}
function Functions.createBMFont(param)
    local scale, pos, zorder, filePath, text, color
    scale = 1
    pos = { x = 0, y = 0 }
    zorder = 0 
    filePath = ""
    color = cc.c3b(255,255,255) --白
    if param then
        if param.scale then scale = param.scale end
        if param.pos then pos = param.pos end
        if param.zorder then zorder = param.zorder end
        if param.text then text = param.text end
        if param.filePath then filePath = param.filePath end
        if param.color then color = param.color end
    end

    local label = cc.Label:createWithBMFont(filePath,text)

    label:setScale(scale)
    label:setPosition(pos.x, pos.y)
    label:setLocalZOrder(zorder)
    label:setColor(color)
    return label
end
function table.empty(t)
    if type(t) ~= 'table' then
        return false
    end

    for k, v in pairs(t) do
        return false
    end
    return true
end

function table.hasValue(t, value)
    for k, v in pairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

function table.removeOfValue(t, value)
    local rms = {}
    for k, v in pairs(t) do
        if v == value then
            rms[#rms+1] = k
        end
    end

    for k, v in ipairs(rms) do
        table.remove(t, k)
    end
end
--仅使用于table中value值不会存在相同的情况
function table.getKeyOfValue(t,value)
    local key = 1 
    for k, v in pairs(t) do
        if v == value then
            key = k
        end
    end
    return key
end

--暂停一个node 和 childNode 所有动作
function Functions.pauseNode(node)
    node:pause()
    local childNodes = node:getChildren()

    for _,v in pairs(childNodes) do
        Functions.pauseNode(v)
    end
end

--继续一个node 和 childNode 所有动作
function Functions.resumeNode(node)
    node:resume()
    local childNodes = node:getChildren()

    for _,v in pairs(childNodes) do
        Functions.resumeNode(v)
    end
end

--初始化星星组件,根据传入数量
function Functions.initStarComOfCount(starView, count)
    for i=1, 6 do
        local star = starView:getChildByName("Panel_head_star"):getChildByName("Sprite_star_" .. tostring(i))
        if i == count then
            star:setVisible(true)
        else
            star:setVisible(false)
        end
    end
end
--武将及选将中英雄头像显示相关函数start--
function Functions.setHeroHeadSelected(target,isSelected)
    if target ~= nil then 
        local choose = target:getChildByName("choose")
        if isSelected == nil then isSelected = false end
        if isSelected then
            choose:setVisible(true)
        else
            choose:setVisible(false)
        end
    end
end
--根据一个英雄的卡包信息显示一个英雄头像
function Functions.showHeroHead(target,heroData,isSelected)
    Functions.setHeroHeadSelected(target,isSelected)
    local posView = target:getChildByName("position")
    posView:ignoreContentAdaptWithSize(true)
    posView:setVisible(false)
    local bigClass,smallClass = Functions.formatHeroClass(heroData.m_class)
    local heroView = target:getChildByName("heroView")
    Functions.initHeroHeadWidget(heroView,heroData.m_id)
    local nameLabel = target:getChildByName("name")
    Functions.initHeroName(nameLabel,heroData.m_id,bigClass)
    Functions.initStarComOfCount(target, ConfigHandler:getHeroStarCountOfId(heroData.m_id))
    Functions.initHeroType(target,heroData.m_id)
    
    Functions.initHeroClass(target:getChildByName("class"),smallClass)
    local frame = target:getChildByName("kuang")    
    Functions.initheroHeadFrame(frame,heroData.m_id,bigClass)
    
    
    
    if heroData.m_atkFormFlagTemp > 0 and heroData.m_defFormFlagTemp > 0 then
        Functions.loadImageWithWidget(posView, "tyj/ui_res/HeroCardUI/at_de.png")
        posView:setVisible(true)
    elseif heroData.m_atkFormFlagTemp > 0 then
        Functions.loadImageWithWidget(posView, "tyj/ui_res/HeroCardUI/at.png")
        posView:setVisible(true)
    elseif heroData.m_defFormFlagTemp > 0 then
        Functions.loadImageWithWidget(posView, "tyj/ui_res/HeroCardUI/de.png")
        posView:setVisible(true)
    end
    local country = target:getChildByName("country")
    local countryResTable = {"card_shu.png","card_wu.png","card_wei.png","card_qun.png"}
    local countryId = ConfigHandler:getHeroCountryOfId(heroData.m_id)  
    Functions.loadImageWithWidget(country, "tyj/uiFonts_res/" .. countryResTable[countryId])
end

--根据图鉴信息显示一个英雄头像
function Functions.showPokedexHead(target,heroData,isSelected)
    local heroView = target:getChildByName("heroView")
    local Camp = target:getChildByName("Camp")
    if heroData.m_state == 0 or heroData.m_state == 2 then
        Functions.initPokedexHeadWidget(heroView,heroData.m_id,heroData.m_state)
        if ConfigHandler:getHeroCountryOfId(heroData.m_id) == 1 then
            Functions.loadImageWithWidget(Camp, "lk/uiFonts_res/card_shu_h.png")
        elseif ConfigHandler:getHeroCountryOfId(heroData.m_id) == 2 then
            Functions.loadImageWithWidget(Camp, "lk/uiFonts_res/card_wu_h.png")
        elseif ConfigHandler:getHeroCountryOfId(heroData.m_id) == 3 then
            Functions.loadImageWithWidget(Camp, "lk/uiFonts_res/card_wei_h.png")
        elseif ConfigHandler:getHeroCountryOfId(heroData.m_id) == 4 then
            Functions.loadImageWithWidget(Camp, "lk/uiFonts_res/card_qun_h.png")
        end
        Functions.initPokedexHeroType(target,heroData.m_id)
        
    else
        Functions.initHeroHeadWidget(heroView,heroData.m_id,heroData.m_state)
        if ConfigHandler:getHeroCountryOfId(heroData.m_id) == 1 then
            Functions.loadImageWithWidget(Camp, "tyj/uiFonts_res/card_shu.png")
        elseif ConfigHandler:getHeroCountryOfId(heroData.m_id) == 2 then
            Functions.loadImageWithWidget(Camp, "tyj/uiFonts_res/card_wu.png")
        elseif ConfigHandler:getHeroCountryOfId(heroData.m_id) == 3 then
            Functions.loadImageWithWidget(Camp, "tyj/uiFonts_res/card_wei.png")
        elseif ConfigHandler:getHeroCountryOfId(heroData.m_id) == 4 then
            Functions.loadImageWithWidget(Camp, "tyj/uiFonts_res/card_qun.png")
        end
        Functions.initHeroType(target,heroData.m_id)
    end

    local nameLabel = target:getChildByName("name")
    Functions.initHeroName(nameLabel,heroData.m_id)
    Functions.initStarComOfCount(target, ConfigHandler:getHeroStarCountOfId(heroData.m_id))
    

    

end

--更新星星显示
function Functions.updateStarDis(starView, count, maxCount)
    for i=1, maxCount do
        local star = starView:getChildByName("star" .. tostring(i))
        if i <= count then
            star:setVisible(true)
        else
            star:setVisible(false)
        end
    end
end
--根据传入id判断武将类型
function Functions.initHeroType(target, id)
    local type = target:getChildByName("type")
    local data = ConfigHandler:getHerTypeId(id)
    if data == 30001 then
        Functions.loadImageWithWidget(type,"tyj/uiFonts_res/" .. "li.png")
    elseif data == 30002 then
        Functions.loadImageWithWidget(type,"tyj/uiFonts_res/" .. "shu.png")
    elseif data == 30003 then
        Functions.loadImageWithWidget(type,"tyj/uiFonts_res/" .. "mou.png")
    elseif data == 30004 then
        Functions.loadImageWithWidget(type,"tyj/uiFonts_res/" .. "yi.png")
    end
end
--根据传入id判断武将类型
function Functions.initPokedexHeroType(target, id)
    local type = target:getChildByName("type")
    local data = ConfigHandler:getHerTypeId(id)
    if data == 30001 then
        Functions.loadImageWithWidget(type,"lk/uiFonts_res/" .. "li_h.png")
    elseif data == 30002 then
        Functions.loadImageWithWidget(type,"lk/uiFonts_res/" .. "shu_h.png")
    elseif data == 30003 then
        Functions.loadImageWithWidget(type,"lk/uiFonts_res/" .. "mou_h.png")
    elseif data == 30004 then
        Functions.loadImageWithWidget(type,"lk/uiFonts_res/" .. "yi_h.png")
    end
end
--根据传入class显示武将强化等级
function Functions.initHeroClass(target,classNum)
    if classNum > 0 then
        Functions.loadImageWithWidget(target,"head_" .. tostring(classNum) ..".png")
        target:setVisible(true)
    else
        target:setVisible(false)
    end
end
--根据出入武将的id显示武将头像框
function Functions.initheroHeadFrame(target,id,classNum)

    if classNum == nil then
        classNum = 1
    end
    local frameTable = {
        "head_bai_card.png",
        "head_lv_card.png",
        "head_lan_card.png",
        "head_zi_card.png",
        "head_cheng_card.png",
        "head_red_card.png",
        "head_cai_card.png",
    }
    Functions.loadImageWithWidget(target,frameTable[classNum])
    target:setVisible(true)
end
function Functions.setHeroNameOfMark(target,mark)
    local heroInfo = HeroCardData:searchHeroOfMark(mark) 
    local bigClass,smallClass  = Functions.formatHeroClass(heroInfo.m_class)
    Functions.initHeroName(target,heroInfo.m_id,bigClass,smallClass)
end
--根据武将ID显示武将姓名
function Functions.initHeroName(target,id,heroClass,smallClass)
    
    if heroClass == nil then
        heroClass = 1
    end
    local name = ConfigHandler:getHeroNameOfId(id,heroClass)
    local colorValue = {
        -- cc.c3b(255,255,255), --白
        -- cc.c3b(0,255,0),     --绿
        -- cc.c3b(0,0,255),     --蓝
        -- cc.c3b(128,0,128),   --紫
        -- cc.c3b(255,165,0),   --橙
        -- cc.c3b(255,0,0),     --红
        -- cc.c3b(255,0,0),     --红
        cc.c3b(255,255,255), --白
        cc.c3b(171,255,38),     --绿
        cc.c3b(26,209,255),     --蓝
        cc.c3b(255,64,237),   --紫
        cc.c3b(255,255,25),   --橙
        cc.c3b(255,63,37),     --红
        cc.c3b(255,63,37),     --红
    }
    target:setColor(colorValue[1])
    if smallClass ~= nil and smallClass > 0 then 
        target:setString(name .. "+" .. tostring(smallClass))
    else
        target:setString(name)
    end
    target:setColor(colorValue[heroClass])
    target:setVisible(true)
end
--根据武将ID显示武将头像Sprite
function Functions.initHeroHeadSprite(target,id)
    local heroHeadImg = ConfigHandler:getHeroHeadImageOfId(id)
    Functions.loadImageWithSprite(target,heroHeadImg,1)
end
--根据武将ID显示武将头像Widget
function Functions.initHeroHeadWidget(target,id)
local heroHeadImg = ConfigHandler:getHeroHeadImageOfId(id)
    Functions.loadImageWithWidget(target,heroHeadImg)
end

--根据武将ID显示武将头像Widget（图鉴专用）
function Functions.initPokedexHeadWidget(target,id,m_state)
    if m_state == 2 then
        Functions.loadImageWithWidget(target,"commonUI/res/icons/50003.png")
        return
    end
    local heroHeadImg = ConfigHandler:getHeroHeadImageOfId(id)--"heroHead/"..tostring(id).."_h.png"
    local ppppp = string.gsub (heroHeadImg, ".png", "_h.png")
    Functions.loadImageWithWidget(target,ppppp)
end
--武将及选将中英雄卡牌显示相关函数end------------------------

--@param : target 英雄头像 heroHead
--@param : id 英雄id
--该函数被废弃，请使用 getHeroHead()
function Functions.initHeadComOfId(headView, id, class)
    
    Functions.getHeroHead(headView, { id = id , class = class})
end

--初始化道具组件
function Functions.initItemComOfId(itemView, id)
    local bg = itemView:getChildByName("disImage")

    local img = ""
    if id > 0 then 
        bg:ignoreContentAdaptWithSize(true)
        img =  ConfigHandler:getPropImageOfId(id)
    elseif id < 0 then
        if id == -2 then
            img = "property_gold.png"
        elseif id == -3 then
            img = "property_money.png"
        elseif id == -5 then
            img = "tyj/dynamicUI_res/achievement_soul.png"   
        elseif id == -6 then
            img = "commonUI/res/image/hunjin.png"
        else
            assert(false, "特殊物品id没有找到，id = " .. tostring(id))
        end
    else
        assert(false, "道具id ＝ ".. tostring(id) .. " 配置错误")
    end
    Functions.loadImageWithWidget(bg, img)

end

--初始化标签页组件
--@param: param format: { { uiTab, listener, isfirst},...}
function Functions.initTabCom(param)
    assert(param and #param > 1 and type(param[1][1]) == "userdata" ,"param is error!")
    for k, v in pairs(param) do
        local button = v[1]
        local selected = button:getChildByName(1)
        local unSelected = button:getChildByName(2)


        if v[3] then
            selected:setVisible(true)
            unSelected:setVisible(false)
        else
            selected:setVisible(false)
            unSelected:setVisible(true)
        end

        local onButtonClick = function()

            for k1, v1 in pairs(param) do
                --关闭其他标签显示,打开当前表
                if button ~= v1[1] then
                    v1[1]:getChildByName(1):setVisible(false)
                    v1[1]:getChildByName(2):setVisible(true)
                else
                    v1[1]:getChildByName(1):setVisible(true)
                    v1[1]:getChildByName(2):setVisible(false)
                end
            end
            --调用监听函数
            v[2]()
        end
        button:onTouch(Functions.createClickListener(onButtonClick))

    end
end


function Functions.openTabs( tabs ,tab)

    for k, v in pairs(tabs) do
        if v ~= tab then
            v:getChildByName("1"):setVisible(false)
            local unSelectView = v:getChildByName("2")
            if unSelectView then
                unSelectView:setVisible(true)
            end
        else
            v:getChildByName("1"):setVisible(true)
            local unSelectView = v:getChildByName("2")
            if unSelectView then
                unSelectView:setVisible(false)
            end
        end
    end

end

--初始化标签页组件
--@param: param format: { widget = , listener = , firstName = , disTabDatas = }
function Functions.initTabComWithSimple(param)
    assert(param and type(param.widget) == "userdata" ,"param is error!")

    local tabs = param.widget:getChildren()
    local firstTab = param.widget:getChildByName(param.firstName) 

    --获取无法点击标签
    local disTabs = {}
    if param and param.disTabDatas then
        for k,v in pairs(param.disTabDatas) do
            disTabs[#disTabs+1] = param.widget:getChildByName(v.name)
            disTabs[#disTabs].listener = v.listener
        end
    end

    local openTabs = function(tab)
        for k, v in pairs(tabs) do
            if v ~= tab then
                v:getChildByName("1"):setVisible(false)
                local unSelectView = v:getChildByName("2")
                if unSelectView then
                    unSelectView:setVisible(true)
                end
            else
                v:getChildByName("1"):setVisible(true)
                local unSelectView = v:getChildByName("2")
                if unSelectView then
                    unSelectView:setVisible(false)
                end
            end
        end
    end

    openTabs(firstTab)
    param.listener(param.firstName)
    for k, v in pairs(tabs) do
        local button = v
        -- local selected = button:getChildByName(1)
        -- local unSelected = button:getChildByName(2)

        local onButtonClick = function()            
            --调用监听函数
            Functions.debugCall(function()
                openTabs(v)
                param.listener(button:getName())
            end)
        end

        if not table.hasValue(disTabs, v) then
            local tabSprite = v:getChildByName(2)
            Functions.setGraySprite(tabSprite, false)
            local text = tabSprite:getChildByName("text")
            if text then
                Functions.setGraySprite(text, false)
            end
            button:onTouch(Functions.createClickListener(onButtonClick))
        else
            local tabSprite = v:getChildByName(2)
            Functions.setGraySprite(tabSprite, true)
            local text = tabSprite:getChildByName("text")
            if text then
                Functions.setGraySprite(text, true)
            end
            button:onTouch(Functions.createClickListener(v.listener))
        end
    end
end

--point
function Functions.getAngle(pos)
    return math.atan2(pos.y, pos.x)
end

function Functions.getDistance(srcPos, targetPos)
    local tem = {}
    tem.x = targetPos.x - srcPos.x
    tem.y = targetPos.y - srcPos.y

    return math.sqrt(tem.x*tem.x + tem.y*tem.y)
end

function Functions.scalePos(pos, scale)
    return { x = pos.x*scale , y = pos.y*scale }
end

--res load
function Functions.preLoadResHandler(target, backCall)

    local onPreAnimas = function(progress)
        if progress == 1 then
            --关闭资源加载界面
            backCall()
        end
    end 
    local PreLoadAnimasFunc = function()
        if target.animaNames and #target.animaNames > 0 then
            ResManager:loadAnimations(target.animaNames, onPreAnimas)
        else
            --关闭资源加载界面
            backCall()
        end
    end

    local onPreLoadSpriteFrames = function(progress)
        if progress == 1 then
            PreLoadAnimasFunc()
        end
    end

    if target.spriteFrameNames and #target.spriteFrameNames > 0 then
        ResManager:loadSpriteFrames(target.spriteFrameNames, onPreLoadSpriteFrames)     
    else
        PreLoadAnimasFunc()
    end

end


function Functions.debugCall(func)
    local status, msg = xpcall(func, __G__TRACKBACK__)
    if not status then
        print(msg)

        if G_CurrentLanguage == "ch" and NoticeManager then
            local notice = NoticeManager:getErrorNotive(msg)
            notice:hideClose()
            notice:setPosition({ x = display.cx, y = display.cy })
            cc.Director:getInstance():setNotificationNode(notice)
        end
    end
end

--tyj start

function Functions.callJavaFuc(func)
    if G_IsUseSDK then
        func()
    end
end
function Functions.goToLoginView()
    if G_SDKType == 3 then 
        GameCtlManager:goTo("app.ui.cstoreLoginSystem.CstoreLoginViewController")
    elseif G_SDKType == 4 then 
        GameCtlManager:goTo("app.ui.gplayLoginSystem.GplayLoginViewController")
    elseif G_SDKType == 5 then 
        GameCtlManager:goTo("app.ui.astoreLoginSystem.AstoreLoginViewController")
    else
        GameCtlManager:goTo("app.ui.naverLoginSystem.NaverLoginViewController")
    end
end
function Functions.setAdbrixTag(tagType,tagName,secondParameter)

    if G_IsUseSDK then
        if secondParameter ~= nil then 
            NativeUtil:javaCallHanler({command = tagType,activityName = tagName,secondParameter = tostring(secondParameter)})
        else
             NativeUtil:javaCallHanler({command = tagType,activityName = tagName,secondParameter = "noParam"}) 
        end
    end
end
function Functions.setPopupKey(key)
    if G_IsUseSDK then  
        if key == "start" then 
           NativeUtil:javaCallHanler({command = "openPopUp",popUpKey = key})
        elseif PlayerData.eventAttr.m_guideStageId == 0 then
           NativeUtil:javaCallHanler({command = "openPopUp",popUpKey = key}) 
        end
    end
end
--c++风格取整
function Functions.subIntOfNum(num)
    if num <= 0 then
        return math.ceil(num)
    elseif math.ceil(num) == num then
        return math.ceil(num)
    else
        return math.ceil(num) - 1 
    end  
end

--初始化功能资源节点
--@param : { "hunjin" , "huoyue", "jifen", "jinbi", "jitui", "soul", "yuanbao" }
function Functions.initResNodeUI(resNode,param)

    --魂晶
    local onHunjun = function(text, textStr)
        text:setString(tostring(PlayerData.eventAttr.m_hunjing))
        Functions.bindUiWithModelAttr(text, PlayerData, "m_hunjing")
    end

    local onHuoyue = function(text, textStr)
        text:setString(tostring(UnionData.eventAttr.m_activity))
        Functions.bindUiWithModelAttr(text, UnionData, "m_activity")
    end

    local onJifen = function(text, textStr)
        text:setString(tostring(TianTiData.eventAttr.m_tianTiScore))
        Functions.bindUiWithModelAttr(text, TianTiData, "m_tianTiScore")
    end

    local onJinbi = function(text, textStr)
        text:setString(tostring(PlayerData.eventAttr.m_money))
        Functions.bindUiWithModelAttr(text, PlayerData, "m_money")
    end

    local onJitui = function(text, textStr)
        local onPowerChange = function(event)
            local powerStr = tostring(PlayerData.eventAttr.m_energy) .. "/" .. tostring(g_csBaseCfg.MaxBaseEnergy)
            text:setString(powerStr)
        end
        Functions.bindUiWithModelAttr(text, PlayerData, "m_energy", onPowerChange)

        --初始化体力显示
        onPowerChange()
    end

    local onSoul = function(text, textStr)
        text:setString(tostring(PlayerData.eventAttr.m_soul))
        Functions.bindUiWithModelAttr(text, PlayerData, "m_soul")
    end

    local onYuanbao = function(text, textStr)
        text:setString(tostring(PlayerData.eventAttr.m_gold))
        Functions.bindUiWithModelAttr(text , PlayerData, "m_gold")
    end

    local typeFuns = 
    {
        ["hunjin"]  = onHunjun,
        ["huoyue"]  = onHuoyue,
        ["jifen"]   = onJifen,
        ["jinbi"]   = onJinbi,
        ["jitui"]   = onJitui,
        ["soul"]    = onSoul,
        ["yuanbao"] = onYuanbao,
    }

    for i=1, 3 do
        local child = resNode:getChildByName("panel"):getChildByName("node" .. tostring(i))
        if param[i] then
            assert(typeFuns[param[i]], "param input error ")
            child:setVisible(true)
            local text = child:getChildByName("text")
            local image = child:getChildByName("image")
            typeFuns[param[i]](text)
            Functions.loadImageWithSprite(image, "commonUI/res/image/" .. param[i] .. ".png")
        else
            child:setVisible(false)
        end
    end
end

--绑定金币、元宝、武魂、体力、天梯积分、魂晶、公会活跃 数据显示
--{moneyObj = ,goldObj = ,soulObj = ,powerObj = , tiantScoreObj = , hunjingObj = , activityObj = }
function Functions.bindMGSDisplay(param)
    --    assert(type(param) == "table" ,"prame is error!")
    --初始化金币显示
    if param["moneyObj"] ~= nil then
        param["moneyObj"]:setString(tostring(PlayerData.eventAttr.m_money))
        Functions.bindUiWithModelAttr(param["moneyObj"], PlayerData, "m_money")
    end
    --初始化元宝显示
    if param["goldObj"] ~= nil then
        param["goldObj"] :setString(tostring(PlayerData.eventAttr.m_gold))
        Functions.bindUiWithModelAttr(param["goldObj"] , PlayerData, "m_gold")
    end
    --初始化武魂显示
    if param["soulObj"] ~= nil then
        param["soulObj"]:setString(tostring(PlayerData.eventAttr.m_soul))
        Functions.bindUiWithModelAttr(param["soulObj"], PlayerData, "m_soul")
    end
    --初始化体力显示
    if param["powerObj"] ~= nil then

        local onPowerChange = function(event)
            local powerStr = tostring(PlayerData.eventAttr.m_energy) .. "/" .. tostring(g_csBaseCfg.MaxBaseEnergy)
            param["powerObj"]:setString(powerStr)
        end
        Functions.bindUiWithModelAttr(param["powerObj"], PlayerData, "m_energy", onPowerChange)

        --初始化体力显示
        onPowerChange()

    end

    --初始化天梯积分显示
    if param["tiantScoreObj"] ~= nil then
        param["tiantScoreObj"]:setString(tostring(TianTiData.eventAttr.m_tianTiScore))
        Functions.bindUiWithModelAttr(param["tiantScoreObj"], TianTiData, "m_tianTiScore")
    end

    --初始化魂晶显示
    if param["hunjingObj"] ~= nil then
        param["hunjingObj"]:setString(tostring(PlayerData.eventAttr.m_hunjing))
        Functions.bindUiWithModelAttr(param["hunjingObj"], PlayerData, "m_hunjing")
    end

    --初始公会活跃
    if param["activityObj"] ~= nil then
        param["activityObj"]:setString(tostring(UnionData.eventAttr.m_activity))
        Functions.bindUiWithModelAttr(param["activityObj"], UnionData, "m_activity")
    end

end
--格式化英雄阶数
--@ClassNum:英雄总阶数
--return: 大阶数，小阶数
function Functions.formatHeroClass(classNum)
    local tempNum = 1 
    for i = 1,#g_cardClass do 
        if classNum <= tempNum + g_cardClass[i] then
            local smallClass = g_cardClass[i] - (tempNum + g_cardClass[i] - classNum)
            return i , smallClass
        end
        tempNum = tempNum + g_cardClass[i] + 1  
    end
    return tempNum , 0 
end
--根据英雄mark显示英雄卡牌 使用前配置"heroCardRes"资源
--@data格式：{mark = } or {id = ,class = } or {heroInf = {id = ,level = ,class = ,soldier = , attack = , mp = , hp = }}
function Functions.getHeroCrad(widget,data)
    local heroLevel = 1
    local heroId = 0
    local heroCombat = 0
    local heroClass = 1
    local heroStar = 1
    if data.mark ~= nil then
        local heroData = HeroCardData:searchHeroOfMark(data.mark) 
        heroLevel = heroData.m_level
        heroId = heroData.m_id
        heroCombat = heroData.m_baseCombat
        heroClass = heroData.m_class
    elseif data.id ~= nil then
        assert(data and data.class,"error")
        heroId = data.id
        heroCombat = cs_GetCardFightValue({ heroInfo = ConfigHandler:getHeroBaseInf(heroId)})
        heroClass = data.class
    elseif data.heroInf ~= nil then
        heroId = data.heroInf.id
        heroLevel = data.heroInf.level
        heroClass = data.heroInf.class
        heroCombat = cs_GetCardFightValue({ heroInfo = data.heroInf})
    end
    local bigClass,smallClass  = Functions.formatHeroClass(heroClass)
    heroStar = ConfigHandler:getHeroStarOfId(heroId)

    local heroCard = widget:getChildByName("cardPanel")
    local bg = heroCard:getChildByName("bg")
    local stage = heroCard:getChildByName("stage")
    local hero = heroCard:getChildByName("hero")
    local level = heroCard:getChildByName("level")
    local name = heroCard:getChildByName("name")
    local frame = heroCard:getChildByName("frame")
    local attack = heroCard:getChildByName("attack")
    local star = heroCard:getChildByName("star")
    local country = heroCard:getChildByName("country")
    local countryResTable = {"card_shu.png","card_wu.png","card_wei.png","card_qun.png"}
    local frameResTable = {"card_bai.png","card_lv.png", "card_lan.png","card_zi.png", "card_cheng.png","card_hong.png", "card_cai.png"}
    local sixStarFrameResTable = {"6xingcard_bai.png","6xingcard_lv.png", "6xingcard_lan.png","6xingcard_zi.png", "6xingcard_cheng.png","6xingcard_hong.png", "6xingcard_cai.png"}
    local stageResTable = {"card_pu.png", "card_zhen.png", "card_gui.png", "card_shen.png", "card_sheng.png", "card_wang.png","card_huang.png"}
    -- local bgResTable = {"card_bg1.png","card_bg1.png","card_bg2.png","card_bg3.png","card_bg4.png"}
    -- Functions.loadImageWithWidget(bg, bgResTable[heroStar])
    local bgResTable = {"card_bg1.png","card_bg2.png","card_bg3.png","card_bg4.png","card_bg4.png","card_bg4.png","card_bg4.png"}
    Functions.loadImageWithSprite(bg, "tyj/ui_res/HeroCardUI/" .. bgResTable[bigClass])
    Functions.loadImageWithWidget(stage, "tyj/uiFonts_res/" .. stageResTable[bigClass])
    if heroStar >= 6 then
        Functions.loadImageWithWidget(frame, "tyj/ui_res/HeroCardUI/" .. sixStarFrameResTable[bigClass])  
    else  
        Functions.loadImageWithWidget(frame, "tyj/ui_res/HeroCardUI/" .. frameResTable[bigClass])
    end
    local countryId = ConfigHandler:getHeroCountryOfId(heroId)  
    Functions.loadImageWithWidget(country, "tyj/uiFonts_res/" .. countryResTable[countryId])
    local heroCardImg = ConfigHandler:getHeroCardImageOfId(heroId,bigClass)
    Functions.loadImageWithSprite(hero, heroCardImg,0.6)
    Functions.initStarComOfCount( star, heroStar)
    level:setString(tostring(heroLevel))
    attack:setString(tostring(heroCombat))

    -- name:setString(tostring(ConfigHandler:getHeroNameOfId(heroId,bigClass)))
    Functions.initHeroName(name,heroId,bigClass)
    local classView = heroCard:getChildByName("class")
    Functions.initHeroClass(classView,smallClass)
end
--根据英雄mark显示头像 使用前配置"headPilistRes"资源
--@data格式：{mark = } or {id = ,class = }
--@showType:显示类型：1显示英雄名字类型,不显示名字类型‘
function Functions.getHeroHead(target,data,showType,isWidget)
    if showType == nil then showType = 1 end
    local heroLevel = 1
    local heroId = 0
    local heroClass = 1
    if data.mark ~= nil and data.mark > 0  then
        local heroData = HeroCardData:searchHeroOfMark(data.mark) 
        heroLevel = heroData.m_level
        heroId = heroData.m_id
        -- local jinHuaNum = ConfigHandler:getHeroJinHuaNumOfId(heroId)


        heroClass = heroData.m_class
    elseif data.id ~= nil then
        heroId = data.id
        if data.class ~= nil then
            heroClass = data.class
        end 
    end

    local bigClass,smallClass = Functions.formatHeroClass(heroClass)
    -- --显示阶数标示
    -- local classResTable = {
    --         "head_bai_j",
    --         "head_lv_j",
    --         "head_lan_j",
    --         "head_zi_j",
    --         "head_cheng_j",
    --         "head_hong_j",
    --         "head_hong_j",
    -- }
    -- if smallClass > 0 then 
    --     for i = 1,smallClass do
    --         local smallClassView = target:getChildByName("model"):getChildByName("jieJi_" .. tostring(i))
    --         Functions.loadImageWithWidget(smallClassView, classResTable[2] .. tostring(1) .. ".png")
    --         smallClassView:setVisible(true) 
    --     end
    -- end
    --头像框
    local frame = target:getChildByName("model"):getChildByName("frame")
    Functions.initheroHeadFrame(frame,heroId,bigClass)
    --头像
    local heroHead = target:getChildByName("model"):getChildByName("head")
    if isWidget then
        Functions.initHeroHeadWidget(heroHead,heroId)
    else
        Functions.initHeroHeadSprite(heroHead,heroId)
    end
    --星级
    local star = target:getChildByName("model"):getChildByName("star")
    Functions.initStarComOfCount(star, ConfigHandler:getHeroStarOfId(heroId))
    star:setVisible(true)
    --名称
    if showType == 2 then
        local name = target:getChildByName("model"):getChildByName("name")
        Functions.initHeroName(name,heroId,bigClass)
    end
end
--清除一个英雄头像框显示
--@showType:显示类型：1显示英雄名字类型,不显示名字类型
function Functions.cleanHeroHead(target,showType)
    if showType == nil then showType = 1 end
    local heroHeadImg = "commonUI/res/icons/adddd.png"--"tyj/ui_res/EmbattleUI/adddd.png"
    local HeroHead = target:getChildByName("model"):getChildByName("head")
    local star = target:getChildByName("model"):getChildByName("star")
    star:setVisible(false)
    Functions.loadImageWithSprite(HeroHead, heroHeadImg)
    for i=1,4 do
        for i = 1,4 do
            target:getChildByName("model"):getChildByName("jieJi_" .. tostring(i)):setVisible(false) 
        end
    end
    target:getChildByName("model"):getChildByName("frame"):setVisible(false)
    target:getChildByName("model"):getChildByName("name"):setVisible(false)
    if showType == 2 then
        target:getChildByName("model"):setTouchEnabled(false)
        target:getChildByName("model"):getChildByName("name"):setVisible(false)
        target:getChildByName("model"):getChildByName("lock"):setVisible(true) 
    end
end
--初始化 heroHead2 英雄头像组件
--@param : target 英雄头像 heroHead2
--@param : data format: { id = "英雄id" }
function Functions.loadHeroHead(target,data)
    if data ~= nil then
        local id = data["id"]
        local HeroHead = target:getChildByName("head")
        local heroHeadImg = ConfigHandler:getHeroHeadImageOfId(id)
        Functions.loadImageWithWidget(HeroHead, heroHeadImg)
        HeroHead:setScale(1.35)
        local name = target:getChildByName("name")
        name:setString(ConfigHandler:getHeroNameOfId(id))
        local star = target:getChildByName("star")
        Functions.initStarComOfCount(star, ConfigHandler:getHeroStarOfId(id))
        name:setVisible(true)
        star:setVisible(true)
    end
end
--获得装备图标
--@equipInf = {id =,mark = ,isName= }
--@target:
--@isHideBg:是否隐藏背景图
function Functions.getEquipNode(target,equipInf,isHideBg)
    local equipId = 0 
    local atkFormFlag = 0
    local defFormFlag = 0 
    local rdAttrType = 0
    local rdAttrPercent = 0 
    --穿戴状态
    
    if equipInf.id ~= nil then
        equipId = equipInf.id
    elseif equipInf.mark ~= nil and  equipInf.mark > 0 then
        local inf = EquipmentData:getEquipInf(equipInf.mark)
        equipId = inf.m_id
        atkFormFlag = inf.atkFormFlag
        defFormFlag = inf.defFormFlag
        rdAttrType = inf.rdAttrType
        rdAttrPercent = inf.rdAttrPercent
    elseif equipInf.equipInf ~= nil then 
        equipId = equipInf.equipInf.id
        if equipInf.equipInf.rdAttr ~= nil then 
            rdAttrType = equipInf.equipInf.rdAttr.type
            rdAttrPercent = equipInf.equipInf.rdAttr.value
        end
        atkFormFlag = equipInf.equipInf.atkFormFlag
        defFormFlag = equipInf.equipInf.defFormFlag
    end
    if equipId > 0 then
        local equipPanel = target:getChildByName("equipmentPanel")
        local atkTable = {"zg.png","fg.png", "fg.png"}
        local defTable = {"zf.png","ff.png", "ff.png"}
        local status = equipPanel:getChildByName("status")
        if tonumber(atkFormFlag) > 0 then
            status:setVisible(true)
            Functions.loadImageWithWidget(status,"tyj/uiFonts_res/" .. atkTable[atkFormFlag])
        end
        if tonumber(defFormFlag) > 0 then
            status:setVisible(true)
            Functions.loadImageWithWidget(status,"tyj/uiFonts_res/" .. defTable[defFormFlag])            
        end
        if tonumber(atkFormFlag) == 0 and defFormFlag == 0 then 
            status:setVisible(false)
        end
        --icon
        local equipView = equipPanel:getChildByName("equipment")
        equipView:setScale(0.8)
        equipView:setVisible(true)
        local equipImg = ConfigHandler:getEquipImageOfId(equipId)
        Functions.loadImageWithWidget(equipView,equipImg)

        local bgView = equipPanel:getChildByName("bg")
        --是否隐藏背景图片
        if isHideBg then
            bgView:setVisible(false)
        end

        --品质
        local quality = ConfigHandler:getQualityOfId(equipId)
        local kuangTable = {"baikuang.png","lukuang.png","lankuang.png","zikuang.png","hongkuang.png","chengkuang.png"}
        local kuangView = equipPanel:getChildByName("choose")
        kuangView:setVisible(true)
        local colorNum = Functions.subIntOfNum(quality/10)
        local stagNum =quality%10
        Functions.loadImageWithWidget(kuangView,kuangTable[colorNum])
        local class = equipPanel:getChildByName("class")

        if stagNum > 0 then
            class:setVisible(true)
            class:ignoreContentAdaptWithSize(true)
            Functions.loadImageWithWidget(class,"tyj/dynamicUI_res/head_" .. tostring(stagNum) .. ".png")
        else
            class:setVisible(false)
        end

        local stag = equipPanel:getChildByName("stag")

        -- if colorNum > 1  and  stagNum > 0 then
        --     for i = 1,stagNum do
        --         local dot = stag:getChildByName("dot_" .. tostring(i))
        --         dot:setVisible(true)
        --         Functions.loadImageWithWidget(dot,dotTable[Functions.subIntOfNum(colorNum - 1)])
        --     end
        -- end
        local dotTable = {"redDot.png","greenDot.png","blueDot.png","purpleDot.png"}
        if rdAttrType > 0 then
            for i=1,math.floor(rdAttrPercent/g_equip.rdAttrMult) do
                local dot = stag:getChildByName("dot_" .. tostring(i))
                dot:setVisible(true)
                Functions.loadImageWithWidget(dot,dotTable[rdAttrType])
            end
            for i=math.floor(rdAttrPercent/g_equip.rdAttrMult)+1,8 do
                local dot = stag:getChildByName("dot_" .. tostring(i))
                dot:setVisible(false)
            end
        end
    
        --是否显示名称
        if equipInf.isName then
            local nameView = equipPanel:getChildByName("name")
            nameView:setVisible(true)
            local name = ConfigHandler:getEquipNameOfId(equipId)
            local colorValue = {
                cc.c3b(255,255,255), --白
                cc.c3b(0,255,0),     --绿
                cc.c3b(0,0,255),     --蓝                
                cc.c3b(128,0,128),   --紫
                cc.c3b(255,0,0),     --红
                cc.c3b(255,165,0),     --红
            }
            nameView:setString(name)
            nameView:setColor(colorValue[colorNum])
        end
    end
end
--清空装备显示
function Functions.cleanEquipNode(target,isHideBg,isOpen)
    local equipPanel = target:getChildByName("equipmentPanel")
    --icon
    local equipView = equipPanel:getChildByName("equipment")
    equipView:setVisible(false)
    local bgView = equipPanel:getChildByName("bg")
    local lock = equipPanel:getChildByName("lock")
    if isHideBg ~= nil then
        bgView:setVisible(false)        
        lock:setVisible(true)
    else     
        lock:setVisible(false)
        bgView:setVisible(true)
    end
    local stag = equipPanel:getChildByName("stag")
    for i=1,8 do
        local dot = stag:getChildByName("dot_" .. tostring(i))
        dot:setVisible(false)
    end
    local kuangView = equipPanel:getChildByName("choose")
    kuangView:setVisible(false)
    local status = equipPanel:getChildByName("status")
    status:setVisible(false)
    local class = equipPanel:getChildByName("class")
    class:setVisible(false)
    if isOpen  then 
        local noOpen = equipPanel:getChildByName("noOpen")
        noOpen:setVisible(true)
    else
        local noOpen = equipPanel:getChildByName("noOpen")
        if noOpen ~= nil then 
            noOpen:setVisible(false)
        end
    end
end
---显示装备详情
--@target:
--@data:{mark= ...}
--@showType: 默认不显示Bt  1:出售  2 替换 
function Functions.displayEquipInf(target,data,showType)
    local equipNode = target:getChildByName("equipment")
    Functions.cleanEquipNode(equipNode)
    local attr = target:getChildByName("attr")
    local attrTypeTable = {LanguageConfig.ui_selectHero_2 .. ":",LanguageConfig.ui_selectHero_3 .. ":",
                            LanguageConfig.ui_selectHero_5 .. ":",LanguageConfig.ui_selectHero_4 ..":"}
    local extAttr = target:getChildByName("extAttr")
    local equipId = 0 
    if showType == 4 then
        Functions.getEquipNode(equipNode,{equipInf = data.equipInf})   
        equipId = data.equipInf.id
        --随机属性
        if data.equipInf.rdAttr.type > 0 then 
            extAttr:setString(LanguageConfig.language_prop_11 .. attrTypeTable[data.equipInf.rdAttr.type] .. "+" .. tostring(data.equipInf.rdAttr.value) .. "%")
        else
            extAttr:setString(LanguageConfig.language_prop_12)
        end
    else
        Functions.getEquipNode(equipNode,{mark = data.mark},true)
        local equipInf = EquipmentData:getEquipInf(data.mark)
        equipId = equipInf.m_id
        --随机属性
        
        if equipInf.rdAttrType > 0 then 
            extAttr:setString(LanguageConfig.language_prop_11 .. attrTypeTable[equipInf.rdAttrType] .. "+" .. tostring(equipInf.rdAttrPercent) .. "%")
        else
            extAttr:setString(LanguageConfig.language_prop_12)
        end
    end
    local name = target:getChildByName("name")
    name:setString(ConfigHandler:getEquipNameOfId(equipId))
    attr:setString(attrTypeTable[ConfigHandler:getEquipAttrTypeOfId(equipId)])
    local buff = target:getChildByName("buff")
    buff:setString(" +" .. tostring(ConfigHandler:getEquipAttrValueOfId(equipId)))
    local inf = target:getChildByName("inf")
    inf:setString(ConfigHandler:getEquipInfOfId(equipId))
    local price = target:getChildByName("price")
    price:setString(tostring(ConfigHandler:getEquipPriceOfId(equipId)))   

    local bt = target:getChildByName("bt")
    if showType ~= nil then
        if showType == 1 then
--            bt:getChildByName("btText"):setString(LanguageConfig.ui_equip_4)
            Functions.loadImageWithWidget(bt:getChildByName("btText"),"tyj/uiFonts_res/cs.png")
        elseif showType == 2 then
--            bt:getChildByName("btText"):setString(LanguageConfig.ui_equip_5)
            Functions.loadImageWithWidget(bt:getChildByName("btText"),"tyj/uiFonts_res/th.png")
        elseif showType == 3 then
--            bt:getChildByName("btText"):setString(LanguageConfig.ui_equip_6)
            Functions.loadImageWithWidget(bt:getChildByName("btText"),"tyj/uiFonts_res/zb.png")
        elseif showType == 4 then
            bt:setVisible(false)
        end
    end

end
--显示武将属性详情
function Functions.displayHeroInf(target,heroMark)
    local heroHead = target:getChildByName("heroHead")
    Functions.getHeroHead(heroHead,{mark = heroMark},2,false)
    local total,att,hp,fas,faf = cs_GetCardFightValue({heroInfo=Functions.formatHeroInfOfMark(heroMark)})
    local heroId = HeroCardData:getHeroID(heroMark)    
    local heroAttr = {total,att,hp,fas,faf,ConfigHandler:getHeroTongyuId(heroId),ConfigHandler:getHeroZxNameOfId(heroId)}
    for i=1,7 do
        local lab = target:getChildByTag(i)
        lab:setString(tostring(heroAttr[i]))
        lab:setVisible(true)
    end
end
--设置装备选中状态
function Functions.setEquipSelected(target,isSelected)
    local selectView = target:getChildByName("equipmentPanel"):getChildByName("selected")
    if isSelected == nil then isSelected = false end
    if isSelected then
        selectView:setVisible(true)
    else
        selectView:setVisible(false)
    end
end
--设置but为禁用状态，并置灰but以及but上面的控件
function Functions.setEnabledBt(target, isEnableBt)
    target:setEnabled(isEnableBt)
    target:setBright(isEnableBt)

    Functions.setGrayButton(target, not isEnableBt)
    local label = target:getChildByTag(1)
    if label then
        Functions.setGrayLabel(label, not isEnableBt)
    end
end

--设置widget触摸状态
function Functions.setEnabledWidget(target, isEnableBt)
    target:setTouchEnabled(isEnableBt)
end

function Functions.setEnabledImage(target, isEnableBt)
    target:setEnabled(isEnableBt)
    target:setBright(isEnableBt)

    Functions.setGrayImage(target, not isEnableBt)
    local label = target:getChildByTag(1)
    if label then
        Functions.setGrayLabel(label, not isEnableBt)
    end
end

--根据角色排行返回角色级别
function Functions.getPlayerRank(ranking)
    if ranking <= 100 then
        return LanguageConfig.language_Teach1
    elseif ranking <= 300 then
        return LanguageConfig.language_Teach2 
    elseif ranking <= 600 then
        return LanguageConfig.language_Teach3 
    else
        return LanguageConfig.language_Teach2 
    end 
end
--对一个Label中特定的字符设置颜色
--target
--attrConfig:{{"<",">",cc.3b(255,165,0),...}}
function Functions.setSubStrAttr(target,richText,attrConfig,size)
    local fontSize = size or 20
    local str = target:getString()
    local color = target:getTextColor()
    local strTable = Functions.stringToTable(str) 
    local attrTable = {} 
    local flag = false
    local colorValue = {}

    for i=1,#strTable do
        for j=1,#attrConfig do
            if attrConfig[j][1] == strTable[i] then
                colorValue  = attrConfig[j][3]
                flag = true   
            elseif attrConfig[j][2] == strTable[i] then 
                flag = false                   
            end
        end
        if flag then
            attrTable[#attrTable+1] = {str =  strTable[i],colorValue = colorValue}
        else
            attrTable[#attrTable+1] = {str = strTable[i]}
        end
    end     
    --删除标示符

    for j=1,#attrConfig do
        for k,v in pairs(attrTable)  do 
            if attrConfig[j][1] == attrTable[k].str then
                table.remove(attrTable,k)
            elseif attrConfig[j][2] == attrTable[k].str then 
                table.remove(attrTable,k)
            end
        end
    end
    --创建富文本
    local targetPosX = target:getPositionX()
    local targetPosY = target:getPositionY()
    richText:setPosition(cc.p(targetPosX,targetPosY))
    richText:setAnchorPoint(0.25,0.5)
    target:setVisible(false)
    for i =1,#attrTable do
        if attrTable[i].colorValue ~= nil then
            richText:pushBackElement(ccui.RichElementText:create(0, attrTable[i].colorValue, 255, attrTable[i].str, "黑体", fontSize))
            --            richText:addString(attrTable[i].str,"Black",attrTable[i].colorValue)
        else
            richText:pushBackElement(ccui.RichElementText:create(0, color, 255, attrTable[i].str, "黑体", fontSize)) 
            --            richText:addString(attrTable[i].str,"Black",color)
        end
    end      
end
--获得一个元素在顺序存放的table中的位置
function Functions.getElementPosOfTable(table,element)
    local pos = -1 
    for i = 1,#table do 
        if table[i] == element then
            return i 
        end
    end
end
--将一个字符串转行为Table
function Functions.stringToTable(str)
    local strTable = {}
    local i = 1
    while true do 
        local c = string.sub(str,i,i)
        local b = string.byte(c)
        if b > 128 then
            strTable[#strTable+1] = string.sub(str,i,i+2)
            i = i + 3
        else
            strTable[#strTable+1] = c
            i = i + 1
        end
        if i > #str then 
            break
        end
    end
    return strTable
end
--将一个类字符串table转成string
function Functions.tableToString(t,startIndex,endIndex)
    local startPos = startIndex or 1
    local endPos = endIndex or #t
    local s = ""
    for i=startPos,endPos do
        s = s .. t[i]
    end
    return s 
end
-- string.split()
function Functions.strSplit(str, flag)
    local tab = {}
    while true do
        local n = nil
        for i=1, #str do
            local temp = string.sub(str, i, i)
            if temp == flag then
                n = i
                break
            end
        end
        if n then
            local first = string.sub(str, 1, n-1) 
            str = string.sub(str, n+1, #str) 
            table.insert(tab, first)
        else
            table.insert(tab, str)
            break
        end
    end
    return tab
end
function Functions.strRtrim(input)
    function string.rtrim(input)
    return string.gsub(input, "[ \t\n\r\13]+$", "")
end
end

--创建动态礼包节点
--@target
--@prizedata:{{1,4,2},,,}
--@prizeNum:需要显示的礼包个数
function Functions.createPrizeNode(target,prizeData,prizeNum)
    local prizeNode1 = target:getChildByName("prize1")
    local prizeNode2 = target:getChildByName("prize2")
    local awardItemDistance = prizeNode2:getPositionX() - prizeNode1:getPositionX()
    local awardFirstPos = { x = prizeNode1:getPositionX(), y = prizeNode1:getPositionY() }
    local awardItemScale = prizeNode1:getScale()
    local num = prizeNum or #prizeData
    for i=1, num do           
        local disNode = Functions.createPartNode({ nodeId = prizeData[i][1], nodeType = prizeData[i][2], count = prizeData[i][3]})
        disNode:setTag(i)  
        disNode:setVisible(true)
        if disNode ~= nil then                      
            local pos = { x = awardFirstPos.x + awardItemDistance*(i-1), y = awardFirstPos.y }
            disNode:setScale(awardItemScale)
            disNode:setPosition(pos)
            target:addChild(disNode)
            -- local onDisNodeClick = function()
            --     PromptManager:openInfPrompt({type = g_VipCgf.VipLevelPrize[VipLevel][i][2],id =  g_VipCgf.VipLevelPrize[VipLevel][i][1],target = disNode})
            -- end
            local model = disNode:getChildByName("model")
            model:setTouchEnabled(false)
            -- Functions.setEnabledWidget(model, true)
            -- model:onTouch(Functions.createClickListener(onDisNodeClick, ""))
        end
        --disNode:onTouch(Functions.createClickListener(handler(disNode, onDisNodeClick), ""))
    end
end

--转换礼包配置表 
function Functions.packagePrizeConfig(configTable)
    local prizeData = {}
    if configTable.items ~= nil then
        prizeData = clone(configTable.items)
    end   
    if configTable.gold ~= nil then 
        prizeData[#prizeData+1] = {-2,4,configTable.gold}
    end
    if configTable.money ~= nil then 
        prizeData[#prizeData+1] = {-3,4,configTable.money}
    end
    if configTable.energy ~= nil then 
        prizeData[#prizeData+1] = {-4,4,configTable.energy}
    end
    if configTable.soul ~= nil then 
        prizeData[#prizeData+1] = {-5,4,configTable.soul}
    end
    if configTable.hunjing ~= nil then 
        prizeData[#prizeData+1] = {-6,4,configTable.hunjing}
    end
    return prizeData
end
--显示倒计时
function Functions.diplayLeftTime(widget,totaltime,initTime,formatStr,handler)
    --任务倒记时
    local onTime = function(event)

        local m_newtime = TimerManager:getCurrentSecond()
        local tm = m_newtime - initTime
        if tm < 0 then
            tm = 0
        end
        m_newtime = totaltime - initTime
        if m_newtime == 0 then 
            handler()
        else
            local time = TimerManager:formatTime(formatStr, m_newtime)
            Functions.initLabelOfString(widget, time)
        end        
    end
    Functions.bindEventListener(widget, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
end
--检查一个时间是否在一个时间区间中
function Functions.checkTime(checkedTime,startTime,endTime)
    local sTime = os.time(startTime)
    local eTime = os.time(endTime)
    if checkedTime >= sTime and checkedTime <= eTime then
        return true
    else
        return false
    end
end
--获得天梯当天添加Buff的阵型名称
function Functions.getTianTiBuffZX()
    local time = TimerManager:getCurrentSecond()
    local date = os.date("*t",time)
    if date ~= nil then
        return LanguageConfig[g_tiantibuf[date.wday].formationName], g_tiantibuf[date.wday].formationName
    else
        return LanguageConfig[g_tiantibuf[1].formationName], g_tiantibuf[1].formationName
    end
end
--tyj end

--获取相关数据
--获取卡牌生命值

--精英，团队战斗属性增益辅助函数
local fbAddHandler_ = function(combatType, value)
    if combatType == CombatCenter.CombatType.RB_ElitePVE then
        value = value + value*g_pveElite.addAttribute
    elseif combatType == CombatCenter.CombatType.RB_Tandui then
        value = value + value*g_pvetuandui.addAttribute
    end
    return math.floor(value)
end

--获取npc 战斗力
function Functions.getNPCFightValue(param)
    assert(param and param.id and param.level, "param is error")
    
    local class = param.class or 1
    local power = cs_GetCardFightValue({ heroInfo = { id = param.id, level = param.level, class = class }})

    return fbAddHandler_(param.combatType, power)
end

--获取副本npc 血量
function Functions.getNPCHp(param)
    assert(param and param.id and param.level and param.combatType, "param is error")

    local class = param.class or 1
    local hp = pm_GetCardHp({ heroInfo = { id = param.id, level = param.level, class = class }} )
    return fbAddHandler_(param.combatType, hp)
end

--获取副本npc攻击力
function Functions.getNPCAttackValue(param)
    assert(param and param.id and param.level and param.combatType, "param is error")    
    
    local class = param.class or 1
    local atk = pm_GetCardAttack({ heroInfo = { id = param.id, level = param.level, class = class }})
    return fbAddHandler_(param.combatType, atk)
end

--获取副本npc法术
function Functions.getNPCFas(param)
    assert(param and param.id and param.level and param.combatType, "param is error")
    
    local class = param.class or 1
    local fas = pm_GetCardFas({ heroInfo = { id = param.id, level = param.level, class = class}})
    return fbAddHandler_(param.combatType, fas)
end

--获取副本npc法防
function Functions.getNPCFaf(param)
    assert(param and param.id and param.level and param.combatType, "param is error")
    
    local class = param.class or 1
    local faf = pm_GetCardFaf({ heroInfo = { id = param.id, level = param.level, class = class}})
    return fbAddHandler_(param.combatType, faf)
end

-- --------------------偏将加成-----------------
function Functions.getPartHeroAddAttrs(partHerosMark)
    local partHeros = {}
    for i=1,#partHerosMark do
        if partHerosMark[i]> 0 then
            partHeros[#partHeros+1] = Functions.formatHeroInfOfMark(partHerosMark[i])
        end
    end
    local attack = pm_GetCardAttackEx(partHeros)
    local hp = pm_GetCardHpEx(partHeros)
    local fas = pm_GetCardFasEx(partHeros)
    local faf = pm_GetCardFafEx(partHeros)
    -- if #partHeros > 0 then
    --     attack = math.floor(pm_GetCardAttackEx(unpack(attrs)))
    --     mp = math.floor(pm_GetCardMpEx(unpack(attrs)))
    --     hp = math.floor(pm_GetCardHpEx(unpack(attrs)))
    --     soldier = math.floor(pm_GetLeadSoldierNumEx(unpack(attrs)))
    -- end

    --return attack, mp, hp, soldier

    return attack,hp,fas,faf
end

function Functions.formatHeroInfOfMark(heroMark)
    local heroInf = HeroCardData:searchHeroOfMark(heroMark)
    return {id = heroInf.m_id,level = heroInf.m_level,class = heroInf.m_class,  attackEx = heroInf.m_attackEx, hpEx =heroInf.m_hpEx , fasEx = heroInf.m_fasEx, fafEx = heroInf.m_fafEx}
end
-- -----------------战斗总属性-----------------------------
-- local getHeroAttrsHandler_ = function(mark)

--     local heroInfo = {}
--     local cardInfo = HeroCardData:searchHeroOfMark(mark)

--     if cardInfo then
--         heroInfo.id      = cardInfo.m_id
--         heroInfo.level   = cardInfo.m_level
--         heroInfo.class   = cardInfo.m_class
--         heroInfo.soldier = cardInfo.m_soldier
--         heroInfo.attack  = cardInfo.m_attack
--         heroInfo.mp      = cardInfo.m_mp
--         heroInfo.hp      = cardInfo.m_hp
--         return heroInfo
--     end 
-- end
--获取上阵英雄总战斗力
--@param: heros format {embattleType, mainHeroMark , viceHeroMarks, partHeroMarks}
function Functions.getFinalFightAttrs(inf)
    local mainHeroFightValue = 0
    local viceHero1FightValue = 0
    local viceHero2FightValue = 0

    if inf.mainHeroMark > 0 then
        local equipMarks = EquipmentData:getEquipMarks(inf.embattleType,1)
        mainHeroFightValue = Functions.getHeroFightAttrs({heroMark=inf.mainHeroMark,partHeroMarks = inf.partHeroMarks, equipMarks = equipMarks})
    end
    if inf.viceHeroMarks[1] > 0 then
        local equipMarks = EquipmentData:getEquipMarks(inf.embattleType,2)
        viceHero1FightValue = Functions.getHeroFightAttrs({heroMark=inf.viceHeroMarks[1],partHeroMarks = inf.partHeroMarks, equipMarks = equipMarks})
    end
    if inf.viceHeroMarks[2] > 0 then
        local equipMarks = EquipmentData:getEquipMarks(inf.embattleType,3)
        viceHero2FightValue = Functions.getHeroFightAttrs({heroMark=inf.viceHeroMarks[2],partHeroMarks = inf.partHeroMarks, equipMarks = equipMarks})
    end
    return mainHeroFightValue + viceHero1FightValue + viceHero2FightValue
end
--获取上阵英雄总领兵
--@param: heros format {mainHeroMark , viceHeroMarks}
function Functions.getFinalSoldiersNum(inf)
    local mainHeroSoldiersValue = 0
    local viceHero1SoldiersValue = 0
    local viceHero2SoldiersValue = 0

    if inf.mainHeroMark > 0 then  
        mainHeroSoldiersValue = ConfigHandler:getHeroTongyuId(HeroCardData:getHeroID(inf.mainHeroMark))
    end
    if inf.viceHeroMarks[1] > 0 then
        viceHero1SoldiersValue = ConfigHandler:getHeroTongyuId(HeroCardData:getHeroID(inf.viceHeroMarks[1]))
    end
    if inf.viceHeroMarks[2] > 0 then
        viceHero2SoldiersValue = ConfigHandler:getHeroTongyuId( HeroCardData:getHeroID(inf.viceHeroMarks[2]))
    end
    return mainHeroSoldiersValue + viceHero1SoldiersValue + viceHero2SoldiersValue
end
--获取某个上阵英雄的最终属性
--@inf = {heroMark,partHeroMarks,equipMarks}
function Functions.getHeroFightAttrs(inf)
    local partHerosInf = {}
    for k,v in pairs(inf.partHeroMarks) do
        if v > 0 then
            partHerosInf[#partHerosInf+1] =  HeroCardData:packageHeroAttr(v)
        end
    end
    local equipPackageAttr = EquipmentData:packageGroupEquipAttr(inf.equipMarks)
    return cs_GetCardFightValue({heroInfo = HeroCardData:packageHeroAttr(inf.heroMark),partHeros = partHerosInf,equipInfos = equipPackageAttr})
end
--绑定checkBox监听
--@param : { target = , listener = }
function Functions.bindCheckBoxListener(param)
    assert(param.target and param.listener , " param is error")

    local onCheckBoxClick = function(event)
        param.listener(event.name)
    end

    param.target:onEvent(onCheckBoxClick)
end

--将字符widget初始化为相应字符串
--param : widget,string 可变长度
function Functions.initLabelOfString(...)
    local param = {...}
    for i=1, #param do
        if param[i] == nil or param[i] == 0 then
            local oo = i
            local ppp = i
        end
    end
    assert(#param%2 == 0,"参数无法成功配对")
    for i=1, #param, 2 do
        assert(type(param[i]) == "userdata", "参数配置错误！")
        param[i]:setString(tostring(param[i+1]))
    end
end

--将 src 表中数据，依次插入 dest 表
function Functions.insertTable(dest, src, begin)
    table.insertto(dest, src, begin)
end





--lk--start---

--旋转  sprite 动作载体, Scale 缩放大小（可以为浮点值）, scaleTime 缩放所需时间，rotate 旋转角度, 
--rotateTime 旋转所需时间，waitTime 动作等待一定时间后执行，Continued 是否持续(true,false)
function Functions.setRotateBy(sprite, scale, scaleTime, rotate, rotateTime, waitTime, Continued)--(从小向大缩放)
    --assert(sprite. , "is error")
    if scale == nil then
        scaleTime = nil
end
if rotate == nil then
    rotateTime = nil
end
if waitTime == nil then
    waitTime = 0
end
if Continued == nil then
    Continued = false
end

sprite:setScale(0.001)
local scaleTo = cc.ScaleTo:create(checknumber(scaleTime), scale, scale)
local rotateBy = cc.RotateBy:create(rotateTime, rotate)
--CCActionInterval * fadeinCard = CCFadeIn::create(0.3f);
local rep = cc.Repeat:create(rotateBy, 1)--永久播放 （次数设为负数可以一直播放）
--transition.execute(target, cc.RepeatForever:create(play))
local play = cc.Sequence:create(cc.DelayTime:create(waitTime),scaleTo, rep)
--    sprite:runAction(play)
transition.execute(sprite, cc.RepeatForever:create(play))
end

--缩放  sprite 动作载体, Scale 缩放大小（可以为浮点值）, time 缩放所需时间，waitTime 动作等待一定时间后执行
function Functions.setScaleTo(sprite, scale, time, waitTime)--(从小向大缩放)
    --assert(sprite. , "is error")
    if scale == nil then
        time = nil
end
if waitTime == nil then
    waitTime = 0
end

sprite:setScale(0.001)
local scaleTo = cc.ScaleTo:create(checknumber(time), scale, scale)

--CCActionInterval * fadeinCard = CCFadeIn::create(0.3f);
local play = cc.Sequence:create(cc.DelayTime:create(waitTime),scaleTo, NULL);
sprite:runAction(play);

end

--显示阵营
function Functions.initHeroFaction(widget, id)

    if id == nil then
        return false
    end
    --阵营（1蜀国，2吴国， 3魏国， 4群雄）
    if ConfigHandler:getHeroCountryOfId(id) == 1 then
        Functions.loadImageWithWidget(widget, "tyj/uiFonts_res/card_shu.png")
    elseif ConfigHandler:getHeroCountryOfId(id) == 2 then
        Functions.loadImageWithWidget(widget, "tyj/uiFonts_res/card_wu.png")
    elseif ConfigHandler:getHeroCountryOfId(id) == 3 then
        Functions.loadImageWithWidget(widget, "tyj/uiFonts_res/card_wei.png")
    elseif ConfigHandler:getHeroCountryOfId(id) == 4 then
        Functions.loadImageWithWidget(widget, "tyj/uiFonts_res/card_qun.png")
    end

end

--显示武将星级
function Functions.HeroStar(widget, id)
    if id == nil then
        return false
    end

    if ConfigHandler:getHeroStarCountOfId(id) == 3 then
        Functions.loadImageWithWidget(widget, "commonUI/res/icons/star_3.png")
    elseif ConfigHandler:getHeroStarCountOfId(id) == 4 then
        Functions.loadImageWithWidget(widget, "commonUI/res/icons/star_4.png")
    elseif ConfigHandler:getHeroStarCountOfId(id) == 5 then
        Functions.loadImageWithWidget(widget, "commonUI/res/icons/star_5.png")
    elseif ConfigHandler:getHeroStarCountOfId(id) == 6 then
        Functions.loadImageWithWidget(widget, "commonUI/res/icons/6star.png")
    end

end

--移动一个容器
--widget- 容器, time－移动所需时间, DropNumX－X位移多少像素, DropNumY－Y位移多少像素 duration－等待多长时间后执行, Handler－回调函数
function Functions.movePanel(widget, time, DropNumX, DropNumY, duration, Handler)
    if widget == nil then
        return false
    end

    local width = widget:getPositionX()
    local height = widget:getPositionY()

    --打开控件的显示
    local Visible = function()
        widget:setVisible(true)
    end 
    local funcall = cc.CallFunc:create(Visible)
    local MoveBy = cc.MoveBy:create(0.001, cc.p(DropNumX, DropNumY))
    local Move = cc.Sequence:create(MoveBy, funcall)
    widget:runAction(Move)

    local fadein = cc.FadeIn:create(0.3)
    local moveTo = cc.MoveTo:create(time, cc.p( width, height))
    local spawn = cc.Spawn:create(fadein, moveTo)
    local seq = cc.Sequence:create(cc.DelayTime:create(duration), spawn,cc.CallFunc:create(function()
        if Handler ~= nil then
            Handler()
        end
    end
    ))

    widget:runAction(seq)
   

end


function Functions:getSoldierhHp( id, lv )
    local SoldiersData = ConfigHandler:getSoldierInfosOfId(id)
    local hp = 0   --初始化小兵血量
    hp = SoldiersData.origHP + SoldiersData.growHp*( lv - 1 )
    return hp
end

function Functions:getSoldierhAtk( id, lv )
    local SoldiersData = ConfigHandler:getSoldierInfosOfId(id)
    local atk = 0  --初始化小兵攻击
    atk = SoldiersData.origAttack + SoldiersData.growAttack*( lv - 1 )
    return atk
end

function Functions:getSoldierhFas( id, lv )
    local SoldiersData = ConfigHandler:getSoldierInfosOfId(id)
    local fas = 0  --初始化小兵法术
    fas = SoldiersData.origFas + SoldiersData.growFas*( lv - 1 )
    return fas
end

function Functions:getSoldierhFaf( id, lv )
    local SoldiersData = ConfigHandler:getSoldierInfosOfId(id)
    local faf = 0  --初始化小兵法防
    faf = SoldiersData.origFaf + SoldiersData.growFaf*( lv - 1 )
    return faf
end

--添加物品
--参数data = {id, type, count, slot}
function Functions:addItemResources( data )
    
    if data.type == 1 then --1-武将
        local card = {id = data.id, slot = data.slot}
        HeroCardData:addCard(card)
    elseif data.type == 4 then --4-道具
        PropData:addProp({m_id =  data.id, m_count =  data.count})
    elseif data.type == 5 then --5-武将卡碎片
        CompoundData:addCompoundData({ id = data.id, mark = data.slot, num = data.count})
    elseif data.type == 8 then --8-道具碎片

    end

end

--lk--end---


--cs--start--
--函数式常用函数
--@tb 需要顺序调用的值表
--@seqFunc 顺序函数： function(value, EndCallBack) end
--@finishCallBack 执行完成回调 
function Functions.tableSeqFunc(tb, seqFunc, finishCallBack)

    function loopFunc()
        if #tb > 0 then
            seqFunc(tb[1],function()
                    table.remove(tb, 1)
                    loopFunc()
                end)
        else
            if finishCallBack then
                finishCallBack()
            end
        end
    end

    loopFunc()
end

function Functions.clearOldVerData()
    --清除老版本缓存数据
    Functions.removePath(cc.FileUtils:getInstance():getWritablePath() .. "up")
end

function Functions.removePath(path)
    if device.platform == "windows" then
        os.execute("rd /s /q ".. string.gsub(path, '/', '\\'))
    else
        os.execute("rm -rf " .. path)
    end
end

function Functions.getPosOfIndex(index, allIndex, offset, basePos)
    return (offset*(index - 1) - (allIndex - 1)*offset/2) + basePos
end

--successCB = function(state, data)
--end
--获取当前服务器玩家排名数据
function Functions.getPlayerRankList(successCB,failCB)
    assert(successCB,"param is error")
    
    local url = ServerConfig.currentURL .. "sanguoGMSomeFunc/GetPlayerPaiming"
    -- local url = "http://192.168.0.251:8085/sanguoGM/sanguoGMSomeFunc/GetPlayerPaiming"
    local param = "tableName=playerlist&sid=" .. tostring(NetWork.serverId)
        .. "&orderField=allfight&order=Desc&pageSize=250"

    PromptManager:openHttpLinkPrompt()
    HttpClient:sendHttpRequest(url, param, function(state, data)
                    PromptManager:closeHttpLinkPrompt()
                    if state == 0 then
                        local urlTable = cjson.decode(data)
                        successCB(urlTable.state, urlTable.Info)
                    else
                        if failCB then
                            failCB()
                        end
                    end
                end)
end

--successCB = function(state, data)
--end
--获取当前服务器公会排名数据
function Functions.getGuildRankList(successCB,failCB)

    local url = ServerConfig.currentURL .. "sanguoGMSomeFunc/GetPlayerPaiming"
    local param = "tableName=guildlist&sid=" .. tostring(NetWork.serverId)
        .. "&orderField=allfight&order=Desc&pageSize=250"

    PromptManager:openHttpLinkPrompt()
    HttpClient:sendHttpRequest(url, param, function(state, data)
        PromptManager:closeHttpLinkPrompt()
        if state == 0 then
            local urlTable = json.decode(data)
            successCB(urlTable.state, urlTable.Info)
        else
            if failCB then
                failCB()
            end
        end
    end)
end

--初始化主公头像节点
function Functions.initLordHeadOfId(widget, id)

    local image = Functions.getDisHeadImagePathOfId(id)
    local class = math.floor(id/10000)
    if class == 6 then
        widget:getChildByName("headgg"):setVisible(true)
    else
        widget:getChildByName("headgg"):setVisible(false)
    end
    Functions.loadImageWithWidget(widget:getChildByName("head"), image)
end
--判断文件是否存在
function Functions.file_exists(path)
  local file = io.open(path, "rb")
  if file then file:close() end
  return file ~= nil
end
--获取当前游戏版本号
function Functions.getCurVersion()
    local disStr = "v " .. CurrentBigVersion .. "." .. CurrentMidVersion .. "." .. CurrentMinVersion

    local versionStr = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath().. "version.ini")
    
    local version = Functions.getFileVersion()
    if version then
        if version.big > CurrentBigVersion or (version.big == CurrentBigVersion 
            and version.mid > CurrentMidVersion) or (version.big == CurrentBigVersion and 
            version.mid == CurrentMidVersion and version.min > CurrentMinVersion) then
            disStr = "v " .. version.big .. "." .. version.mid .. "." .. version.min

            FileMidVersion = version.mid
            FileMinVersion = version.min
        end
    end

    return disStr
end

--获取文件记录版本号
function Functions.getFileVersion()
    local versionStr = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath().. "version.ini")
    local version = nil
    if versionStr and #versionStr >=5 and #versionStr < 30 then
         local verStrs = Functions.strSplit(versionStr, ".")
         version = {}
         version.big = tonumber(verStrs[1])
         version.mid = tonumber(verStrs[2])
         version.min = tonumber(verStrs[3])
     end
     return version
end
function Functions.loadSpriteFramesAnsy(plistFilename, image, handler)
    local async = type(handler) == "function"
    local asyncHandler = nil
    if async then
        asyncHandler = function()
            local texture = cc.Director:getInstance():getTextureCache():getTextureForKey(image)
            assert(texture, string.format("The texture %s, %s is unavailable.", plistFilename, image))
            cc.SpriteFrameCache:getInstance():addSpriteFrames(plistFilename, texture)
            handler(plistFilename, image)
        end
    end

    if display.TEXTURES_PIXEL_FORMAT[image] then
        cc.Texture2D:setDefaultAlphaPixelFormat(display.TEXTURES_PIXEL_FORMAT[image])
        if async then
            cc.Director:getInstance():getTextureCache():addImageAsync(image, asyncHandler)
        else
            cc.SpriteFrameCache:getInstance():addSpriteFrames(plistFilename, image)
        end
        cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_BGR_A8888)
    else
        if async then
            cc.Director:getInstance():getTextureCache():addImageAsync(image, asyncHandler)
        else
            cc.SpriteFrameCache:getInstance():addSpriteFrames(plistFilename, image)
        end
    end
end

function Functions.handGuideOfFeild(feild, id)
    if not GuideManager.curGuideData[feild] then  --血战额外属性提示
        GuideManager:handOpenGuideOfid(id)
        GuideManager.curGuideData[feild] = true
        GuideManager:storeGuideData()
    end
end

--装备数据处理函数
--对装备属性打包以便计算加成
function Functions:packageEquipAttr(info)
    local attrType = info.attrType
    local attrValue = info.attrValue
    local rdAttrType = info.rdAttrType
    local rdAttrValue = info.rdAttrValue
    return { attr = {type = attrType , value = attrValue}, rdAttr = { type = rdAttrType, value = rdAttrValue/100}}   
end

--更新之后进入游戏
function Functions.EnterGame(data)
    --相关配置初始化
    require("app.common.GameStaticInit")
    require("app.common.GameInit")
    require("app.configs.server.init")
    
    if G_IsUseSDK then
        GameCtlManager:goTo("app.ui.startupSceneSystem.StartupSceneViewController", data)
    else
        GameCtlManager:goTo("app.ui.loginSystem.LoginViewController", data)
    end

    -- ResManager:loadCommonRes(function()
    --         if G_IsUseSDK then
    --             GameCtlManager:goTo("app.ui.startupSceneSystem.StartupSceneViewController", data)
    --         else
    --             GameCtlManager:goTo("app.ui.loginSystem.LoginViewController", data)
    --         end
    --     end)

end

function Functions.sdkLoginHandler(userId)

    --添加平台区分
    if tonumber(G_SDKType) ~= 1 then
        userId = userId .. "_" .. G_SDKType
    end
    
    --开始登陆
    Functions.setAdbrixTag("firstTimeExperience","login_try")
    local onLoginSuccess = function(event)

        local data = event.data

        if data then
            if tonumber(data.error) ~= NetWork.WebErrCode.Success then
                Functions.openNetWorkTip(data.error, data.reason)
                return
            end

            GameState.storeAttr.serverToken_s = data.token
            Functions.setAdbrixTag("firstTimeExperience","login_complete")

            g_ServerList = data.server
            GameCtlManager:goTo("app.ui.loginSystem.LoginViewController",
             { server = g_ServerList, loginType = LoginType.Sdk_Login })
        else
            PromptManager:openTipPrompt(LanguageConfig.language_Login_1)
        end
    end

    NetWork:registUserServer(userId, userId, function(event)
    
        local data = event.data
        if data then
            if tonumber(data.error) == NetWork.WebErrCode.Success then
                GameState.storeAttr.userName_s = data.post.username
                GameState.storeAttr.password_s = data.post.password
                NetWork:loginUserServer(data.post.username, data.post.password, onLoginSuccess)
            elseif tonumber(data.error) == NetWork.WebErrCode.Register_User_already then
                NetWork:loginUserServer(userId, userId, onLoginSuccess)
            else 
                Functions.openNetWorkTip(data.error)
            end
        else
            PromptManager:openTipPrompt(LanguageConfig.language_Login_1)
        end
        
    end)

end
--打开web网络提示
function Functions.openNetWorkTip(errorCode, msg)
    errorCode = tonumber(errorCode)
    if errorCode == NetWork.WebErrCode.Register_User_already then
        PromptManager:openTipPrompt(LanguageConfig.login_User_already)
    elseif errorCode == NetWork.WebErrCode.None_Error then
        PromptManager:openTipPrompt(LanguageConfig.None_Error)
    elseif errorCode == NetWork.WebErrCode.User_Not_Found then
        PromptManager:openTipPrompt(LanguageConfig.User_Not_Found)
    elseif errorCode == NetWork.WebErrCode.User_Password_Error then
        PromptManager:openTipPrompt(LanguageConfig.User_Password_Error)
    elseif errorCode == NetWork.WebErrCode.User_Inhibited then
        msg = msg or "-_-!!!"
        PromptManager:openTipPrompt(msg)
    end
end

--获取网络状态代码
-- server state code : 正常，关闭，爆满，维护，即将开放
function Functions.getServerStateCode(code)
    assert(LanguageConfig["Server_State_" .. tostring(code)], "server state code is error")
    return LanguageConfig["Server_State_" .. tostring(code)]
end

function Functions.getTipOfServerStatus(code)
    assert(LanguageConfig["Server_State_Tip_" .. tostring(code)], "server state code is error")
    return LanguageConfig["Server_State_Tip_" .. tostring(code)]
end

--打开游戏服登陆错误提示
function Functions.openGateWayTip(errorCode)
    errorCode = tonumber(errorCode)
    if errorCode == Player.LogoutReason.R_ENTERSERVERFAILED then
        PromptManager:openTipPrompt(LanguageConfig.Game_Logout_Error_0)
    elseif errorCode == Player.LogoutReason.R_LOGINATOTHERPLACE then
        PromptManager:openTipPrompt(LanguageConfig.Game_Logout_Error_1)
    elseif errorCode == Player.LogoutReason.R_TOKENINVALID then
        PromptManager:openTipPrompt(LanguageConfig.Game_Logout_Error_2)
    elseif errorCode == Player.LogoutReason.R_ACCOUNTERROR then
        PromptManager:openTipPrompt(LanguageConfig.Game_Logout_Error_3)
    elseif errorCode == Player.LogoutReason.R_ACCOUNTCHANGED then
        PromptManager:openTipPrompt(LanguageConfig.Game_Logout_Error_4)
    elseif errorCode == Player.LogoutReason.R_PLAYERINVALID then
        PromptManager:openTipPrompt(LanguageConfig.Game_Logout_Error_5)
    elseif errorCode == Player.LogoutReason.R_PLAYERFULL then
        PromptManager:openTipPrompt(LanguageConfig.Game_Logout_Error_6)
    elseif errorCode == Player.LogoutReason.R_NOTINSERVER then
        PromptManager:openTipPrompt(LanguageConfig.Game_Logout_Error_7)
    elseif errorCode == Player.LogoutReason.R_SYSTEMERROR then
        PromptManager:openTipPrompt(LanguageConfig.Game_Logout_Error_8)
    elseif errorCode == Player.LogoutReason.R_ACCOUNTLOCK then
        PromptManager:openTipPrompt(LanguageConfig.Game_Logout_Error_9)
    end
end

--init游戏模块
function Functions.clearGameData()

    --清楚当前控制器所有资源
    GameCtlManager:clearControllerSteak()
    for k,v in pairs(package.loaded) do
        if not PRELOAD_INIT_MODEL[k] then
            package.loaded[k] = nil
        end
    end
end

--生成掉落物节点
function Functions.createDropItem(data, numColor)

    --生成掉落节点
    local dropNode = cc.CSLoader:createNode("cs/csb/common/DropNode.csb")
    local node = Functions.createPartNode({ nodeType = data.type, nodeId = data.id })

    Functions.copyParam(dropNode:getChildByName("panel"):getChildByName("parts"), node)
    dropNode:getChildByName("panel"):addChild(node)

    local numView = dropNode:getChildByName("panel"):getChildByName("num")
    Functions.initLabelOfString(numView, "x" .. tostring(data.count))

    if numColor then
        numView:setColor(numColor)
    end

    return dropNode
end

--初始化显示掉落物品
--@view 掉落物显示节点
--@datas 掉落物数据
--@numColor 掉落物数量显示颜色。默认为ccs设置颜色
function Functions.initDropAward(view, datas, numColor)

    if #datas > 0 then
        view:getChildByName("notItem_text"):setVisible(false)

        local pos = { x = view:getChildByName("item1"):getPositionX(), y = view:getChildByName("item1"):getPositionY() }
        local distance = view:getChildByName("item2"):getPositionX() - view:getChildByName("item1"):getPositionX()

        for i=1, #datas do
            local dropNode = Functions.createDropItem(datas[i], numColor)
            dropNode:setPosition({ x = pos.x + ( i - 1 )*distance, y = pos.y })
            view:addChild(dropNode)
        end

    else
        view:getChildByName("notItem_text"):setVisible(true)
    end
end

--自动调整子节点坐标
function Functions.autoFixChildPos(parent, isAutoScale)
    assert(parent and type(parent) == "userdata", "param need Node, input error")

    local autoScale = CC_DESIGN_RESOLUTION.callback(cc.Director:getInstance():getOpenGLView():getFrameSize())
    if not autoScale then

        local childs = parent:getChildren()
        for k,v in pairs(childs) do

            --更新坐标
            local x = v:getPositionX()
            local y = v:getPositionY()

            local newX = x/CC_DESIGN_RESOLUTION.width*display.width
            local newY = y/CC_DESIGN_RESOLUTION.height*display.height

            v:setPosition(cc.p(newX, newY))

            --更新ui尺寸
            if isAutoScale then
                local oldScale = v:getScale()
                local newScale = display.width/CC_DESIGN_RESOLUTION.width*oldScale
                v:setScale(newScale)
            end
        end

        parent:setPositionX(parent:getPositionX() + ( CC_DESIGN_RESOLUTION.width - display.width)/2)
    end
end

--给button添加提醒标志
function Functions.registerStateListenerOfBt(bt, dataModel, attrName)

    local onStateChange = function(event)
        local data = event.data
        if data == 1 then
            data = true 
        else
            data = false
        end
        bt:getChildByName("bz"):setVisible(data)
    end
    Functions.bindUiWithModelAttr(bt, dataModel, attrName, onStateChange)

    onStateChange({ data = dataModel.eventAttr[attrName] })
end

--设置系统更新状态
--@param model 系统模型 table
--@param isUpdate 更细状态 bool
function Functions.setSystemUpdateState(model, isUpdate)
    assert(model, "input param is error")
    model.eventAttr.m_isUpdate = isUpdate
end

function Functions.isFirstLogin()
    local name = string.sub(PlayerData.eventAttr.m_name, 1, 4)  
    if name == "Hero" then
        return true
    else
        return false
    end
end

--pageview 绑定监听
--@param listener : function(event) end  --event.target 为被绑定的pageview, event.index 为当前索引
function Functions.bindPageViewListener(pageView, listener)

    local event = {}
    local onPageView = function(data)
        event.target = pageView
        event.index = pageView:getCurPageIndex()
        event.name = data.name         
        listener(event)
    end
    pageView:onEvent(onPageView)
end

--生成掉落物widget
--@param param: { nodeType = , nodeId = , count = }
function Functions.createPartNode(param)
    local node = nil
    if param.nodeType == ItemType.HeroCard then
        node = cc.CSLoader:createNode("commonUI/csb/heroHead.csb")
        if param.count then
            node:getChildByName("num"):setString("x" .. param.count)
            node:getChildByName("num"):setVisible(true)
        end
        Functions.getHeroHead(node,{ id = param.nodeId})
    elseif param.nodeType == ItemType.Prop then
        node = cc.CSLoader:createNode("commonUI/csb/parts.csb")
        if param.count then
            node:getChildByName("num"):setString("x" .. param.count)
            node:getChildByName("num"):setVisible(true)
        end
        Functions.initItemComOfId(node, param.nodeId)
    elseif param.nodeType == ItemType.CardFragment then
        node = cc.CSLoader:createNode("commonUI/csb/heroHead.csb")
        local piece = node:getChildByName("piece")
        piece:setVisible(true)
        if param.count then
            node:getChildByName("num"):setString("x" .. param.count)
            node:getChildByName("num"):setVisible(true)
        end
        Functions.getHeroHead(node,{ id = param.nodeId})
    end
    return node
end

--生成一个头像widget
function Functions.createHeadCom(image)
    node = cc.CSLoader:createNode("cs/csb/common/headCom.csb")
    Functions.loadButtonImage(node:getChildByName("Panel_1"):getChildByName("headBt"), image)
    return node
end

--获取物品属性
--@param param: { type = , id = } type 物品类型， id 物品id
function Functions.getPartAttrs(param)
    assert(param and param.type and param.id, "参数配置错误")

    if param.type == ItemType.HeroCard or param.type == ItemType.CardFragment then
        return ConfigHandler:getHeroInfosOfId(param.id)
    elseif param.type == ItemType.Prop then
        return ConfigHandler:getPropInforsOfId(param.id)
    else
        assert(false, "错误的类型")
    end
end

--清空子节点
function Functions.clearAllChildren(node)
    node:removeAllChildren()
end

--初始化text尺寸
--@param: textView: widget
--@param: size : { width = , height = }
function Functions.initTextSize(textView, size)
    textView:setTextAreaSize(size)
end

--顺序执行带完成回调的函数
function Functions.excuteFuncs(...)

    local param = { ... }
    local onFuncFinish = nil
    onFuncFinish = function()
        table.remove(param, 1)
        if #param > 0 then
            param[1](onFuncFinish)
        end
    end

    param[1](onFuncFinish)
end

--根据英雄等级获取带兵数
function Functions.getSoldierCountOfLevel(heroLevel)
    local leadCount = 1 
    if (heroLevel <= 10) then
        leadCount = 2
    elseif (heroLevel <= 20) then
        leadCount = 3
    elseif (heroLevel <= 30) then
        leadCount = 4
    else
        leadCount = 4
    end
    return leadCount
end

----------------------------置灰函数---------------------
--label 设置成灰色，针对白色字体
--@param label : widget
--@param isGray : true 设置成灰度值 
function Functions.setGrayLabel(label, isGray)
    if isGray then
        label:setColor(cc.c3b(60,60,60))
    else
        label:setColor(cc.c3b(255,255,255))
    end
end

--Sprite 设置成灰色，针对白色字体
--@param sprite : Sprite
--@param isGray : true 设置成灰度色
function Functions.setGraySprite(sprite, isGray)
    GraySprite(sprite, isGray)
end

--ImageView 设置成灰色
--@param imageView : ImageView
--@param isGray : true 设置成灰色 
function Functions.setGrayImage(imageView, isGray)
    local sprite = imageView:getVirtualRenderer():getSprite()
    GraySprite(sprite, isGray)
end

--Button 设置成灰色
--@param imageView : ImageView
--@param isGray : true 设置成灰色
function Functions.setGrayButton(button, isGray)
    local sprite = button:getVirtualRenderer():getSprite()
    GraySprite(sprite, isGray)
    --Functions.setGraySprite( sprite, isGray)
end

--将一个精灵置灰lua版
--function Functions.setGraySprite( sprite, isGray)
--    if isGray then
--        if sprite then
--            local p =  cc.GLProgram.new(self)
--            p:initWithFilenames("res/shader/gray.vsh", "res/shader/gray.fsh")
--            p:initWithFilenames("res/shader/gray.vsh", "res/shader/gray.fsh")
--            
--            p:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
--            p:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
--            p:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_TEX_COORDS)
--            p:link()
--            
--            p:updateUniforms()
--            sprite:setGLProgram(p)
--        end
--    else
--        if sprite then
--            sprite:setGLProgramState(cc.GLProgramState:getOrCreateWithGLProgramName(cc.GLProgram.SHADER_NAME_POSITION_TEXTURE_COLOR_NO_MVP))
--        end
--    end
--end

function Functions.map(t, handler)
    for k, v in pairs(t) do
        handler(k,v)
    end
end

--初始化Text颜色
--@param src : 源 widget
--@param target : 目标 widget
function Functions.initTextColor(src, target)
    target:setTextColor(src:getTextColor())
end

--初始化widget颜色
--@param: color 目标颜色 c3b
--@param: widgets 设置对象 table
function Functions.initWidgetWithColor(param)
    assert(param and param.color and param.widgets, "param is error")

    for k, v in ipairs(param.widgets) do
        v:setColor(param.color)
    end

end

--复制参数
function Functions.copyParam(src, tar)
    tar:setScale(src:getScale())
    tar:setPosition({ x = src:getPositionX(), y = src:getPositionY() })
end

--复制一个table
function Functions.copyTab(st)  
    local tab = {}  
    for k, v in pairs(st or {}) do  
        if type(v) ~= "table" then  
            tab[k] = v  
        else  
            tab[k] = Functions.copyTab(v)  
        end  
    end  
    return tab  
end

--添加掉落物
function Functions.rewardDataHandler(datas)
    local items = {}
    for i=1, #datas do
        local item = {}
        item.id = datas[i][1]
        item.type = datas[i][2]
        item.count = datas[i][3]
        item.mark_id = datas[i][4]
        items[#items+1] = item
    end
    return items
end

function Functions.addItemsToData(items)
    for k, v in ipairs(items) do
        Functions:addItemResources( { id = v.id, type = v.type, count = v.count, slot = v.mark_id } )
    end
end

function Functions.setEnabledPages(target, isEnableBt)
    target:setEnabled(isEnableBt)
    target:setBright(isEnableBt)
end

--进入指定关卡
--@param: param : { fbType = , fbId = , gkId = }
--@ fbType 副本类型，分精英和普通 普通:CombatCenter.CombatType.RB_PVE 精英:CombatCenter.CombatType.RB_ElitePVE
--@ 团队: CombatCenter.CombatType.RB_Tandui
--@ fbId 大关卡编号
--@ gkId 小关卡编号
function Functions.jumpFbSeleckOfData(param)
    assert( param and param.fbId and param.fbType, "输入参数错误")

    BiographyData.eventAttr.curSelectIndex = param.gkId or 0
    BiographyData.eventAttr.curFbType = param.fbType
    BiographyData.eventAttr.curSelectFbId = param.fbId

    if param.fbType == CombatCenter.CombatType.RB_Tandui then
        BiographyData.isAutoUpdateGk = true
    else
        BiographyData.isAutoUpdateGk = false
    end
    GameCtlManager:push("app.ui.minFbSelectSystem.MinFbSelectViewController")
end


function Functions.buyPowerHandler(controller)
    if PlayerData.eventAttr.m_buyEnergyCount < #g_csBaseCfg.BuyEnergy and PlayerData.eventAttr.m_buyEnergyCount < g_VipCgf.BugEnergy[VipData.eventAttr.m_vipLevel] then
        if PlayerData.eventAttr.m_gold < PlayerData.eventAttr.energyPrice then
            local buyGoldHandler = function()
                -- local payView = require("app.ui.popViews.PayPopView"):new() --cs
                GameCtlManager:getCurrentController():openChildView("app.ui.popViews.PayPopView",{isRemove = false})  
            end
            NoticeManager:openTips(controller, {title = LanguageConfig.language_Functions_1,handler = buyGoldHandler})
        else
            local handler = function()
                PlayerData:RequestBuyPowerInf(function()
                    -- Functions.setAdbrixTag("retention","energy_buy")
                    if PlayerData.eventAttr.m_buyEnergyCount <= 14 then 
                        Functions.setAdbrixTag("retention","energy_buy_" .. tostring(PlayerData.eventAttr.m_buyEnergyCount),tostring(PlayerData.eventAttr.m_level))
                    end
                    PromptManager:openTipPrompt(LanguageConfig.language_Functions_2)
                end)
            end
            NoticeManager:openTips(GameCtlManager:getCurrentController(), {title = string.format(LanguageConfig.language_7_1,PlayerData.eventAttr.energyPrice,g_csBaseCfg.BuyEnergyCount),handler = handler})
        end

    else
        PromptManager:openTipPrompt(LanguageConfig.language_Functions_3)
    end
end

function Functions.buyMoneyHandler(controller)
    -- Functions.setAdbrixTag("retention","silver_inter")
    if PlayerData.eventAttr.m_buyMoneyCount < #g_csBaseCfg.BuyMoneyConfig.cost and PlayerData.eventAttr.m_buyMoneyCount < g_VipCgf.BuyMoney[VipData.eventAttr.m_vipLevel] then        
        if PlayerData.eventAttr.m_gold <  g_csBaseCfg.BuyMoneyConfig.cost[PlayerData.eventAttr.m_buyMoneyCount+1] then
            local buyGoldHandler = function()
                -- local payView = require("app.ui.popViews.PayPopView"):new() --cs
                controller:openChildView("app.ui.popViews.PayPopView",{isRemove = false})  
            end
            NoticeManager:openTips(controller, {title = LanguageConfig.language_Functions_1,handler = buyGoldHandler})
        else
            local handler = function()
                PlayerData:RequestBuyMoneyInf(function(money,burst)
                    if PlayerData.eventAttr.m_buyMoneyCount <= 30 then 
                        Functions.setAdbrixTag("retention","silver_buy_" .. tostring(PlayerData.eventAttr.m_buyMoneyCount),tostring(PlayerData.eventAttr.m_level))
                    end
                    NoticeManager:openRewardTips(controller, {type = NoticeManager.REWARD_COIN_TIPS,data ={money = money,burst = burst}})
                end)    
            end        
            local cost = g_csBaseCfg.BuyMoneyConfig.cost[PlayerData.eventAttr.m_buyMoneyCount + 1]
            local moneyCount =math.floor(g_csBaseCfg.BuyMoneyConfig.money[PlayerData.eventAttr.m_level]*g_csBaseCfg.BuyMoneyConfig.baoji[PlayerData.eventAttr.m_buyMoneyCount+1])   

            local str = string.format(LanguageConfig.language_9_77,cost,moneyCount)
            NoticeManager:openTips(controller, {title = str,handler = handler})
        end
    else 
        PromptManager:openTipPrompt(LanguageConfig.language_Functions_4)
    end
end

function Functions.addCleanFuncWithNode(target, func)
    local onUiClean = function()
        Functions.debugCall(func)
    end
    target:onNodeEvent("cleanup", onUiClean)
end

--过滤函数
--@param : datas : 数据对象
--@param : filterHandler :过滤函数

function Functions.filterDatas(datas, filterHandler)

    local newDatas = {}
    for k, v in ipairs(datas) do
        if not filterHandler(v) then
            newDatas[#newDatas+1] = v
        end
    end

    return newDatas
end
--将lua table序列化字符串文本
function Functions.serialize(obj)  
    local lua = ""  
    local t = type(obj)  
    if t == "number" then  
        lua = lua .. obj  
    elseif t == "boolean" then  
        lua = lua .. tostring(obj)  
    elseif t == "string" then  
        lua = lua .. string.format("%q", obj)  
    elseif t == "table" then  
        lua = lua .. "{\n"  
    for k, v in pairs(obj) do  
        lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"  
    end  
    local metatable = getmetatable(obj)  
        if metatable ~= nil and type(metatable.__index) == "table" then  
        for k, v in pairs(metatable.__index) do  
            lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"  
        end  
    end  
        lua = lua .. "}"  
    elseif t == "nil" then  
        return nil  
    else  
        error("can not serialize a " .. t .. " type.")  
    end  
    return lua  
end  
--lua写字符串到文件
function Functions.writeStringtoFile(str,filePath)
    local f=io.open(filePath,"w+")
    f:write(str)
    f:flush()
    f:close()
end

--
function Functions.transLanguage(srcLanguageTable,tranFilePath)
    local translateTable = CsvReader.parserFile(tranFilePath,1)
    local translatedTable = {}
    local unTranslatedTable = {}
    local translatedFlag = false
    for k1,v1 in pairs(srcLanguageTable) do 
        for k2, v2 in pairs(translateTable) do 
            if v1 == k2 then
                translatedTable[#translatedTable+1] = { k1, v2["翻译\13"]}
                translatedFlag = true
                srcLanguageTable[k1] = v2["翻译\13"]
            end
        end
        if not translatedFlag then
             unTranslatedTable[#unTranslatedTable+1] = {k1,v1}
        end
        translatedFlag = false
    end
    return Functions.serialize(srcLanguageTable),Functions.serialize(translatedTable),Functions.serialize(unTranslatedTable)
end
--cj__end--

--武将升级动画
--mark, 武将mark 
--level,武将这次升了几级
-- lizi,粒子控件 
--widget, 播放升级所加属性的控件
--handler 回调
function Functions.level_Animation(mark, level, lizi, widget, handler)

    Functions.playSound("herolevelup.mp3")

    lizi:resetSystem()
    lizi:setDuration(2)
    local heroInf = HeroCardData:getHeroInfo(mark)
    local hero = clone(heroInf)
    heroInf.m_level = heroInf.m_level + level   
    
    --设置武将属性
    EnhanceData:setHeroAttr(heroInf, EnhanceData:getParam(heroInf))

    local param = EnhanceData:getParam(heroInf)
    --升级所加的属性
    local HP = math.floor(pm_GetCardHp(param) - hero.m_baseHp)
    local ATK = math.floor(pm_GetCardAttack(param) - hero.m_baseAttack)
    local FS = math.floor(pm_GetCardFas(param) - hero.m_baseFas)
    local FF = math.floor(pm_GetCardFaf(param) - hero.m_baseFaf)


    --增加的生命
    local str = LanguageConfig.language_Enhance_7.."    "..tostring(HP).."\n"..LanguageConfig.language_Enhance_8.."    "..tostring(ATK).."\n"..
        LanguageConfig.ui_selectHero_4.."    "..tostring(FS).."\n"..LanguageConfig.ui_selectHero_5.."    "..tostring(FF)
    local text = Functions.createLabel({scale = 1, pos = {x = -10, y = 30}, zorder = 0, text = str })
    text:setSystemFontSize(20)
    text:setTextColor(display.COLOR_GREEN)
    widget:addChild(text)

    --粒子
    local pMove = cc.MoveBy:create(1.5,cc.p(0,150))
    local fadeout = cc.FadeOut:create(0.1)
    local fly = cc.Sequence:create(pMove, fadeout)
    text:runAction(fly)
    --动画播放完毕再回调
    handler()
end

--武将提升的等级
--mark  武将mark  allExp  总经验  Bar_1, 原有进度 Bar_2，升级后的进度
function Functions.allCardExp( mark, allExp, Bar_1, Bar_2)
    
    local hero = HeroCardData:getHeroInfo(mark)
    
    --升级进度条
    local bar1 = math.floor(hero.m_exp) / math.floor(g_roleCardUp[hero.m_level]) * 100 --self:Parameterlist(EnhanceData.MasterData[1].m_mark)
    Bar_1:setPercent(bar1)
    local bar2 = math.floor(allExp + hero.m_exp) / math.floor(g_roleCardUp[hero.m_level]) * 100
    if bar2 > 100 then
        bar2 = 100
    end
    Bar_2:setPercent(bar2)

    local i_exp = hero.m_exp    --当前主卡的经验和等级
    local lv = hero.m_level
    if lv <= 0 then
        return false
    end

    local _iExp = 0 -- 本级所需经验

    repeat

        _iExp = _iExp + g_roleCardUp[lv]     
        if ((_iExp - i_exp) <= allExp) then
            lv = lv + 1
        else
            lv = lv       --卡片为了获取下一级经验，等级多加了一，所以这里要减一
        end

    until ((_iExp - i_exp) > allExp or lv > #g_roleCardUp)
    return lv
end


return Functions
