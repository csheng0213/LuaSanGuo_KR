local HttpClient = {}

local scheduler = require("app.common.scheduler")

if HttpClientUpdate then
	HttpClient.isEnable = true 
else
	HttpClient.isEnable = false
	HttpClientUpdate = function()end
end

function HttpClient:init()
	self.loophanler = scheduler.scheduleUpdateGlobal(HttpClientUpdate)
	HttpBackCall = handler(self, self.httpDataFinish)
	self.urlListenerMap = {}
end

function HttpClient:destory()
	if self.loophanler then
        scheduler.unscheduleGlobal(self.loophanler)
        self.loophanler = nil
    end
    if not HttpClient.isEnable then
    	HttpClientUpdate = nil
    end
end

function HttpClient:sendHttpRequest(url, param, listener)
	if self.isEnable then
		SendHttpRequest(url, param)
		self.urlListenerMap[url] = listener
	else
		listener(0, "")
	end
end

function HttpClient:httpDataFinish(url, state, data)
	if self.urlListenerMap[url] then
	    Functions.debugCall(function()
            self.urlListenerMap[url](state, data)
	    end)
	end
end


return HttpClient