local NetWork = {}

local scheduler = require("app.common.scheduler")

NetWork.HTTP_REQUST_BEGIN_EVENT = "HTTP_REQUST_BEGIN_EVENT"
NetWork.HTTP_REQUST_RETURN_EVENT = "HTTP_REQUST_FINISH_EVENT"
NetWork.HTTP_REQUST_FAIL_EVENT = "HTTP_REQUST_FAIL_EVENT"

NetWork.SOCKET_REQUST_BEGIN_EVENT = "SOCKET_REQUST_BEGIN_EVENT"
NetWork.SOCKET_REQUST_RETURN_EVENT = "SOCKET_REQUST_RETURN_EVENT"

NetWork.debug_b = true

local maplisteners_ = {}
local mapHandlers_ = {}
local mapListenerHandler_ = {}

local nextListenerHandleIndex_ = 0

NetWork.WebErrCode =
{
    Register_User_already = 1, --已存在
    Success = 2, --成功
    None_Error = 3, --未知错误
    User_Not_Found = 4, --账号不存在
    User_Password_Error = 6,--账户或者密码错误
    User_Inhibited = 8, --用户限制
}

NetWork.ServerStatusCode =
{
    online = 1,
    shutdown = 2,
    busy = 3,
    maintain = 4,
    wait = 5,
}

function NetWork:init()

    --网络模块，全局函数初始化
    cc.exports.OnLogin = NetWork._onLoginServer
    cc.exports.OnLogout = NetWork._onLogoutServer
    cc.exports.DispatchLuaMsg = NetWork._onDispatchLuaMsg
    cc.exports.OnConnected = NetWork._OnConnected
    cc.exports.OnConnectFailed = NetWork._OnConnectFailed
    cc.exports.OnDisconnected = NetWork._OnDisconnected
    
    self.sendTime = 0
    self.isReconnect = false
    
    --初始化网络参数，ip ，端口
--    NetWork:setServerInfo(serverIp,serverId)
    
    
    --网络模块，数据收发循环开始
	self.loophanler = scheduler.scheduleUpdateGlobal(ServerMainLoop)
	
end

function NetWork:destory()
    if self.loophanler then
        scheduler.unscheduleGlobal(self.loophanler)
        self.loophanler = nil
    end
end

--网络相关回调
function NetWork:_OnConnected()
    print("Lua _OnConnected is Call")
    
    Functions.debugCall(function()
        if NetWork.reConnectView then
            NetWork.reConnectView:close()
            NetWork.reConnectView = nil
        end
    end)
end

function NetWork:_OnConnectFailed()
    print("Lua _OnConnectFailed is Call")
    NetWork.isLogined = false
    Functions.debugCall(function()
        if not NetWork.reConnectView then
            PromptManager:closeSocketLinkPromp()
            NetWork.reConnectView = GameCtlManager:getCurrentController():openChildView("app.ui.popViews.TryConnectPopView",{isRemove = false})
        else
            scheduler.performWithDelayGlobal(function()
                                    NetWork.reConnectView:closeReAnima()
                                    end, 2)
        end
    end)
end

function NetWork:_OnDisconnected()
    print("Lua _OnDisconnected is Call")
    NetWork.isLogined = false

    Functions.debugCall(function()
        if Player.isOnline then
            if not NetWork.reConnectView then
                PromptManager:closeSocketLinkPromp()
                NetWork.reConnectView = GameCtlManager:getCurrentController():openChildView("app.ui.popViews.TryConnectPopView",{isRemove = false})
            else
                scheduler.performWithDelayGlobal(function()
                                    NetWork.reConnectView:closeReAnima()
                                    end, 2)
            end
        end
    end)

end

--登陆逻辑服务器成功回调
function NetWork._onLoginServer(...)
    -- dump({...}, "server return data")
    Functions.printInfo(NetWork.debug_b, "逻辑服务器登陆成功")

    Functions.debugCall(function()
        Player:onLogin()
    end)
end

--数据派发函数
function NetWork._onDispatchLuaMsg(netData)

    local dispatchFun = function()
        --    printInfo("数据派发开始")
        -- dump(netData, "server return data", 10)
        if NetWork._currentNoAsnyMsg_t and NetWork._currentNoAsnyMsg_t.idx and NetWork._currentNoAsnyMsg_t.idx[1] == netData.idx[1] and
            NetWork._currentNoAsnyMsg_t.idx[2] == netData.idx[2] then
            NetWork:finishSend()
        end

        if maplisteners_[netData.idx[1]] and maplisteners_[netData.idx[1]][netData.idx[2]] then

            local listeners = maplisteners_[netData.idx[1]][netData.idx[2]]

            for handle, listener in pairs(listeners) do
                local isRemove = listener(netData)
                if isRemove then
                    NetWork:removeNetWorkListener(handle)
                end
            end
        end

        print("数据派发结束")
    end

    Functions.debugCall(dispatchFun)

end

--退出逻辑服务器回调
function NetWork._onLogoutServer(code)
    Functions.printInfo(NetWork.debug_b, "逻辑服务器退出成功" .. tostring(code))
    NetWork.isLogined = false

    Functions.debugCall(function()
        Player:onLogout(code)
    end)
    
end


function NetWork:logoutServer()
    Player.isOnline = false
	Logout()
end

--网络交互
function NetWork:setServerInfo(serverIp, serverId)
    self.serverId = serverId
    SetServerIp(serverIp, serverId)
end

--登陆逻辑服务器
--@param:
-- accountId : string
-- token : string
-- subareaId : number
function NetWork:loginServer(accountId, token, subareaId)
    Login(accountId, token, subareaId)
    NetWork.isLogined = true
    scheduler.performWithDelayGlobal(function()
        if NetWork.isLogined then
            PromptManager:closeSocketLinkPromp()
            PromptManager:openTipPrompt(LanguageConfig.language_9_56)
            NetWork:logoutServer()
        end
    end, 10)

end

--发送数据到逻辑服务器
-- msg : table
--format :  { idx = { idx1, idx2} ,data = {} }
function NetWork:sendToServerAsny(msg)
    SendToServer(msg)
end

function NetWork:sendToServer(msg)
    self._currentNoAsnyMsg_t = clone(msg)
    SendToServer(msg)
    self:beginSendDelay()
end

function NetWork:beginSendDelay()
    --dump(self._currentNoAsnyMsg_t,"MSG SEND:")
    if not self.reConnectView then  --重连界面，不显示转圈
        PromptManager:openSocketLinkPromp()
    end
    
    -- local delayFunc = function()
    --     print(" send time : " .. tostring(self.sendTime))
    --     if self.sendTime > 5 then
    --         self:finishSend(false)
    --     else
    --         self.sendTime = self.sendTime + 1
    --     end
    -- end
    -- self._currSendTimeFunc = GameEventCenter:addEventListener(TimerManager.SECOND_CHANGE_EVENT, delayFunc)
end

function NetWork:finishSend(isRemove)
    self.sendTime = 0
    GameEventCenter:removeEventListener(self._currSendTimeFunc)
    self._currSendTimeFunc = nil

    if isRemove then
        if self._currentNoAsnyMsg_t and self._currentNoAsnyMsg_t.idx then

            local listeners = maplisteners_[self._currentNoAsnyMsg_t.idx[1]][self._currentNoAsnyMsg_t.idx[2]]

            for handle, listener in pairs(listeners) do
                NetWork:removeNetWorkListener(handle)
            end
        end
    end
    self._currentNoAsnyMsg_t = nil
    PromptManager:closeSocketLinkPromp()

    -- if not isSuccess then  --发送不成功
    --     if not self.reConnectView then --是否在有重连界面
    --         self.reConnectView = GameCtlManager:getCurrentController():openChildView("app.ui.popViews.TryConnectPopView",{isRemove = false})
    --     else   --有重连界面
    --         self.reConnectView:closeReAnima()
    --     end
    -- else
    --     self._currentNoAsnyMsg_t = nil
    --     if self.reConnectView then
    --         self.reConnectView:close()
    --         self.reConnectView = nil
    --     end
    -- end
end

function NetWork:reSendToServer()
    SendReconnect()
end

--登陆账户服务器
function NetWork:loginUserServer(userName, userPassword, onSuccess)

    -- 创建一个请求，并以 GET 方式发送数据到服务端
    local url = ServerConfig.currentURL    
    
    local xhr = cc.XMLHttpRequest:new() -- http请求  
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING -- 响应类型  
    xhr:open("POST", url .. "sanguoGMSomeFunc/login")

    -- 状态改变时调用  
    local function onReadyStateChange()  
        -- 显示状态文本  
        local statusString = "Http Status Code:  "..xhr.statusText  
        Functions.printInfo(self.debug_b, statusString)
        
        Functions.printInfo(self.debug_b, "return {"..  xhr.response .. " }")  
        local reposeData = loadstring("return {"..  xhr.response .. " }")
        onSuccess(reposeData())
    end  

    -- 注册脚本回调方法  
    xhr:registerScriptHandler(onReadyStateChange)  
    local questStr = "username=" .. userName .. "&password=" .. userPassword .. "&gaid=" .. GameState.storeAttr.advertisingId_s
        .. "&isDebug=" .. tostring(G_IsDebugClient)
    xhr:send(questStr) -- 发送请求
   
end

--用户注册
function NetWork:registUserServer(userName, userPassword, onSuccess)
	
    GameEventCenter:dispatchEvent({ name = NetWork.HTTP_REQUST_BEGIN_EVENT })

    -- 创建一个请求，并以 GET 方式发送数据到服务端
    local url = ServerConfig.currentURL    

    local xhr = cc.XMLHttpRequest:new() -- http请求  
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING -- 响应类型  
    xhr:open("POST", url .. "sanguoGMSomeFunc/AddUserService")

    -- 状态改变时调用  
    local function onReadyStateChange()
        -- 显示状态文本  
        local statusString = "Http Status Code:  "..xhr.statusText  
        Functions.printInfo(self.debug_b, statusString)

        GameEventCenter:dispatchEvent({ name = NetWork.HTTP_REQUST_RETURN_EVENT })

        Functions.printInfo(self.debug_b, "return {"..  xhr.response .. " }")  
        local reposeData = loadstring("return {"..  xhr.response .. " }")
        onSuccess(reposeData())
    end  

    -- 注册脚本回调方法  
    xhr:registerScriptHandler(onReadyStateChange)  
    xhr:send("username=" .. userName .. "&password=" .. userPassword .. "&gaid=" .. GameState.storeAttr.advertisingId_s) -- 发送请求
    
end

--HTTP requst
--@rewquestType : GET, POST
--@onSuccess :成功回调
function NetWork:sendHttpRequst(url, requestType, onSuccess)
	
    PromptManager:openCircelPrompt()
    
    self.currentHttpUrl = url
    self.currentHttpBackCall = onSuccess
    self.currentHttpXhr = cc.XMLHttpRequest:new() -- http请求  
    self.currentHttpXhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING -- 响应类型  
    self.currentHttpXhr:open(requestType, self.currentHttpUrl)

    -- 状态改变时调用  
    local function onReadyStateChange()  
        -- 显示状态文本  
        local statusString = "Http Status Code:  ".. self.currentHttpXhr.status
        Functions.printInfo(self.debug_b, statusString)
        Functions.printInfo(self.debug_b, "return {"..  self.currentHttpXhr.response .. " }")  
        
        if self.currentHttpXhr.status == 200 then
            PromptManager:closeCircelPrompt()
            self.currentHttpBackCall(self.currentHttpXhr.response)
        else
            PromptManager:closeCircelPrompt()
            GameEventCenter:dispatchEvent({ name = NetWork.HTTP_REQUST_FAIL_EVENT })
        end
        
    end  

    -- 注册脚本回调方法  
    self.currentHttpXhr:registerScriptHandler(onReadyStateChange)
    self.currentHttpXhr:send() -- 发送请求
    
end

--请求失败，重新链接
function NetWork:reSendHttp()

    self.currentHttpXhr = cc.XMLHttpRequest:new() -- http请求  
    self.currentHttpXhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING -- 响应类型  
    self.currentHttpXhr:open("GET", self.currentHttpUrl)

    -- 状态改变时调用  
    local function onReadyStateChange()  
        -- 显示状态文本  
        local statusString = "Http Status Code:  ".. self.currentHttpXhr.status
        Functions.printInfo(self.debug_b, statusString)

        if self.currentHttpXhr.status == 200 then
            GameEventCenter:dispatchEvent({ name = NetWork.HTTP_REQUST_RETURN_EVENT })
            self.currentHttpBackCall(self.currentHttpXhr.response)
        else
            GameEventCenter:dispatchEvent({ name = NetWork.HTTP_REQUST_FAIL_EVENT })
        end

    end  

    -- 注册脚本回调方法  
    self.currentHttpXhr:registerScriptHandler(onReadyStateChange)
    self.currentHttpXhr:send() -- 发送请求
end

--添加网络监听
--@para "idx" = { index1, index2 }
function NetWork:addNetWorkListener(paramIndex, listener)

    nextListenerHandleIndex_ = nextListenerHandleIndex_ + 1
    local handler = tostring(nextListenerHandleIndex_)
    if not maplisteners_[paramIndex[1]] then
    	maplisteners_[paramIndex[1]] = {}
    end
    
    local listeners = maplisteners_[paramIndex[1]][paramIndex[2]]
    if listeners and type(listeners) == "table" then
        listeners[handler] = listener
    else
        maplisteners_[paramIndex[1]][paramIndex[2]] = {}
        maplisteners_[paramIndex[1]][paramIndex[2]][handler] = listener    
    end
    
    mapHandlers_[handler] = { paramIndex[1], paramIndex[2] }
    
    return handler
    
end

function NetWork:removeNetWorkListener(handler)
    
    local index = mapHandlers_[handler]
    maplisteners_[index[1]][index[2]][handler] = nil
    mapHandlers_[handler] = nil
    
end


return NetWork

