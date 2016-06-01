local GlobalEventCenter = {}

GlobalEventCenter.GAME_ENTER_BACKGROUND = "GAME_ENTER_BACKGROUND"
GlobalEventCenter.GAME_ENTER_FOREGROUND = "GAME_ENTER_FOREGROUND"

local eventCenter_ = {}

--@public func 
function GlobalEventCenter:dispatchEvent(event)
    eventCenter_:dispatchEvent(event)
end

function GlobalEventCenter:addEventListener(eventName, listener, tag)
    local _, handler_ = eventCenter_:addEventListener(eventName, listener, tag)
    return handler_
end

function GlobalEventCenter:removeEventListener(handleToRemove)
    eventCenter_:removeEventListener(handleToRemove)
end

function GlobalEventCenter:removeEventListenersByTag(tagToRemove)
    eventCenter_:removeEventListenersByTag(tagToRemove)
end

function GlobalEventCenter:removeEventListenersByEvent(eventName)
    eventCenter_:removeEventListenersByEvent(eventName)
end

function GlobalEventCenter:removeAllEventListeners(eventName)
    eventCenter_:removeAllEventListeners(eventName)
end

--@private func
function GlobalEventCenter:init()
    cc.bind(eventCenter_, "event")
end

return GlobalEventCenter