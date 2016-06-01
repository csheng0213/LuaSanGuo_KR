local TimerManager = {}
local sharedScheduler = cc.Director:getInstance():getScheduler()

TimerManager.SECOND_CHANGE_EVENT = "SECOND_CHANGE_EVENT"
TimerManager.GAME_RUN_PAUSE = "GAME_RUN_PAUSE"

TimerManager.currentTime = 0
TimerManager.currentWday = 1

function TimerManager:init()

    self.oldBackTime = os.time()

    local secondChangeFunc = function()

        --进入后台判断
        if os.time() - self.oldBackTime >= 3 and Player.isOnline then
            GameEventCenter:dispatchEvent({ name = TimerManager.GAME_RUN_PAUSE , time = os.time() - self.oldBackTime })
            self:sendServerTimeRequest()
            self.oldBackTime = os.time()
        else
            self.oldBackTime = os.time()
        end
        
        TimerManager.currentTime = TimerManager.currentTime + 1
        GameEventCenter:dispatchEvent({ name = TimerManager.SECOND_CHANGE_EVENT })
    end
    
    self.timeHanler = sharedScheduler:scheduleScriptFunc(secondChangeFunc, 1, false)
    
    --服务器时间更新监听
    local onServerTime = function(event)
        TimerManager.currentTime = event.st
        TimerManager.currentWday = event.wday
    end
    NetWork:addNetWorkListener({ 2, 0 },onServerTime)
end

function TimerManager:destory()
    if self.timeHanler then
        sharedScheduler:unscheduleScriptEntry(self.timeHanler)
        self.timeHanler = nil
    end
end

function TimerManager:sendServerTimeRequest()
    local msg = {idx = {2, 0}}
    NetWork:sendToServerAsny(msg)
end

function TimerManager:getCurrentSecond()
	return TimerManager.currentTime
end
function TimerManager:getCurrentWday()
    return TimerManager.currentWday
end
--同步时间
function TimerManager:setCurrentSecond(time)
    TimerManager.currentTime = time
end

--格式化时间
--@param : formatStr 格式字符串 : "%x" 11/28/08,"%X" 10:28:37, "%c" 10/10/13 10:28:37, "%Y-%m-%d %H:%M:%S" 2013-10-10 10:28:37,
--@param : second 当前时间秒数
function TimerManager:formatTime(formatStr, second)
	return os.date(formatStr, second)
end

function TimerManager:format_time(secs, format)
    local format = string.split(format, ":")
    local radix = {24, 60, 60}
    local time_str = "";
    local base_value, base_name, value
    local i = #radix
    while i > 0 do
        base_value = radix[i]
        base_name = format[i + 1]
        
        value = secs % base_value
        
        if value > 0 then
            if base_name then
                time_str = value .. base_name .. time_str
            end
        end
        
        secs = math.floor(secs / base_value)
        
        i = i - 1
    end
    
    if secs > 0 then
        time_str = secs .. format[i + 1] .. time_str
    end
    
    return time_str 
end
--剩余秒数格式化函数
function TimerManager:formatOverTime(formatStr, overSecond)
    local second = overSecond%60
    local minute = ((overSecond - second)%3600)/60
    local hour = overSecond/3600
    if #formatStr > 10 then
        formatStr = string.format(formatStr, hour, minute, second)
    elseif #formatStr > 4 then
        formatStr = string.format(formatStr, minute, second)
    else
        formatStr = string.format(formatStr, second)
        
    end
    
    return formatStr
end

return TimerManager