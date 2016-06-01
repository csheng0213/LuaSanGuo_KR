local UIActionTool = {}

function UIActionTool:createBlinkAction(time)
	local fadeAction = cc.FadeOut:create(time)
    return cc.RepeatForever:create(cc.Sequence:create(fadeAction, fadeAction:reverse()))
end
function UIActionTool:createBlinkNoGradientAction(time)
    local hideAction = cc.Hide:create()
    local showAction = cc.Show:create()
    return cc.RepeatForever:create(cc.Sequence:create(showAction,cc.DelayTime:create(time), hideAction,cc.DelayTime:create(time)))
end

function UIActionTool:createAddHpAction()
    local pAddMove = cc.MoveBy:create(0.3, cc.p(0, 50))
    local pAddEaseOut = cc.EaseElasticOut:create(pAddMove)
    return pAddEaseOut
end

--战斗动作
function UIActionTool:createHpPTAction()

    local speedScale = cc.EaseOut:create(cc.ScaleBy:create(0.5, 1.5), 0.5)
    local speedMove = cc.EaseOut:create(cc.MoveBy:create(0.5, cc.p(0, 30)), 0.5)
    local fadein = cc.FadeIn:create(0.5)
    local move_scale = cc.Spawn:create(speedScale, speedMove, fadein)
    

    local afterMove = cc.EaseOut:create(cc.MoveBy:create(0.5, cc.p(0, 50)), 1)
    local fade     = cc.FadeOut:create(0.5)
    local move_fade = cc.Spawn:create(afterMove, fade)

    local setScaleFunc = function(target)
        target:setVisible(true)
        target:setOpacity(0)
    end
    local sequence = cc.Sequence:create(cc.CallFunc:create(setScaleFunc), move_scale, move_fade)
    return sequence
end

function UIActionTool:createHpBaojiAction()
    return self:hpActionHandler(2)
end

function UIActionTool:hpActionHandler(scale)
    local speedScale = cc.EaseElasticOut:create(cc.ScaleBy:create(0.8, scale))
    local speedMove = cc.EaseElasticOut:create(cc.MoveBy:create(0.8, cc.p(0, 60)))
    local move_scale = cc.Spawn:create(speedScale, speedMove)
    
    local afterMove = cc.EaseOut:create(cc.MoveBy:create(0.5, cc.p(0, 90)), 0.5)
    local fade     = cc.FadeOut:create(0.5)
    local move_fade = cc.Spawn:create(afterMove, fade)

    local setScaleFunc = function(target)
        target:setVisible(true)
    end
    
    local sequence = cc.Sequence:create(cc.CallFunc:create(setScaleFunc), move_scale, move_fade)
    return sequence
end

function UIActionTool:createUpFateAction()

    local pAddMove = cc.MoveBy:create(0.3, cc.p(0, 50))
    local pAddEaseOut = cc.EaseElasticOut:create(pAddMove)
    return pAddEaseOut

end

function UIActionTool:createCritAction()

	local scale = cc.ScaleBy:create(0.3, 1.5)
    local easeOut = cc.EaseElasticOut:create(scale)
    local move = cc.MoveBy:create(0.3, cc.p(0, 50))
    local move_scale = cc.Spawn:create(easeOut, move)
	local delay = cc.DelayTime:create(0.1)

    local bjMove = cc.MoveBy:create(0.3, cc.p(0, 30))
    local bjMoveEaseOut = cc.EaseElasticOut:create(bjMove)

	local critAction = cc.Sequence:create({ move_scale, delay })
	return critAction 
end

function UIActionTool:createLoopFunc(delay, loopFunc)

    --循环执行函数
    local action = nil
    local loopFunc_ = function(target)
        if loopFunc then
            if loopFunc() then
                target:stopAction(action)
            end
        end
    end

    local delayAction = cc.DelayTime:create(delay)
    local actionSe = cc.Sequence:create(delayAction, cc.CallFunc:create(loopFunc_))
    action = cc.RepeatForever:create(actionSe)
    return action
    
end

--让节点播放一个弹出动画
--@param: format { target = , beginScale = , endScale = , maxScale = , time = , onComplete = }
function UIActionTool:playPopAction(param)
    assert(param and param.target and type(param.target) == "userdata", "param is error")
    
    param.target:setScale(param.beginScale)
    local scaleTo1 = cc.ScaleTo:create(param.time, param.maxScale)
    local scaleTo2 = cc.ScaleTo:create(param.time, param.endScale) 
    local seq = cc.Sequence:create(scaleTo1, scaleTo2 )

    transition.execute(param.target, seq, { onComplete = param.onComplete })
end

function UIActionTool:createScaleAction(param)
    assert(param and param.minScale and param.maxScale and param.time, "param is error")
    local actionSe = cc.Sequence:create(cc.ScaleTo:create(param.time, param.minScale), cc.ScaleTo:create(param.time, param.maxScale))
    return cc.RepeatForever:create(actionSe)
end


return UIActionTool