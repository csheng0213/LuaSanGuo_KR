local NativeUtil = {}
require("cocos.cocos2d.json")
local drmCallBack = nil
local deepLinkIntent = require("app.sdk.IGAWorksDeepLinkIntent")

local NoticeManager = require("app.ui.noticeSystem.NoticeManager")
local scheduler = require("app.common.scheduler")  
local isOpenPopup = true
local isHavePopup = false
function NativeUtil:init()
    cc.exports.JniBackCall = NativeUtil._JniBackCall

    GameEventCenter:addEventListener("ENTER_MAINVIEW_EVENT_NAME", function ( ) 
       VipData:needToConsumProduct()
       if isOpenPopup then  
            isOpenPopup = false
            Functions.callJavaFuc(function( )
               self:javaCallHanler({command = "initNaverIAP"})
               self:javaCallHanler({command = "initNaverCafe",playerName = PlayerData.eventAttr.m_name})
                if PlayerData.eventAttr.m_guideStageId == 0 then
                   -- for i = 1,#SDKConfig.popUpKey do 
                        self:javaCallHanler({command = "openPopUp",popUpKey = "lobby"})
                   -- end
               end
            end)
        end
    end)
end

local luaNative = nil 

if device.platform == "android" then
    luaNative = require("cocos.cocos2d.luaj")
elseif device.platform == "ios" then
    luaNative = require("cocos.cocos2d.luaoc")
end

function NativeUtil:javaCallHanler(msg)
    
    if luaNative then
        local msgStr = json.encode(msg)
        luaNative.callStaticMethod("org.cocos2dx.lua.NativeUtils", "LuaCallFunc", {msgStr})
        return true
    else
        return false
    end
end

function NativeUtil:sdkLogin()
    PromptManager:openHttpLinkPrompt()
    self:javaCallHanler({ command = "login" })
end
function NativeUtil:sdkLogin_Cstore()
    PromptManager:openHttpLinkPrompt()
    self:javaCallHanler({ command = "login_Cstore" })
end

function NativeUtil:startDrmCheck(callBack)
    drmCallBack = callBack
    self:javaCallHanler({command = "drmCheck",checkType = "startDRM"})
end
function NativeUtil._JniBackCall(msg)

    print("sdfsdfs-----_JniBackCall")

    local msgTable = json.decode(msg)
    for k,v in pairs(msgTable) do
        print(" _JniBackCall k " .. tostring(k) .. " v " .. tostring(v))
        if k == "LoginGame" then
            local data = string.split(v,"|")
            local usrId = data[1]
            local usrName = data[2]
            GameState.storeAttr.isLoginNaver_b = true
            GameState.storeAttr.NaverUserId_s = usrId
            GameState.storeAttr.NaverUserName_s = usrName
            
            if msgTable["SetAdId"] then
                GameState.storeAttr.advertisingId_s = msgTable["SetAdId"]
            end

            Functions.sdkLoginHandler(usrId)
        elseif k == "SetAdId" then             
            GameState.storeAttr.advertisingId_s = v
            print("advertisingId:" .. GameState.storeAttr.advertisingId_s)
        elseif k == "fastLoginGame" then
            PromptManager:openHttpLinkPrompt()

            if msgTable["SetAdId"] then
                GameState.storeAttr.advertisingId_s = msgTable["SetAdId"]
            end
            Functions.sdkLoginHandler(GameState.storeAttr.NaverUserId_s) 

        elseif k == "id" then --为了兼容2.2.9 base apk
            GameState.storeAttr.isLoginNaver_b = true
            GameState.storeAttr.NaverUserId_s = v
            Functions.sdkLoginHandler(v)
        elseif k == "productCode" then
            VipData:RequestVipPay(v)
        elseif k == "igaworks" then
            deepLinkIntent[v]()         
        elseif k == "API_Gateway" then
            local data = string.split(v,"|")      
            GameState.storeAttr.curProductCode_s = data[1]
            GameState.storeAttr.paymentSeq_s = data[2]
            VipData:RequestVipPay(0,data[2],data[1])
        elseif k == "isStartupGame" then--启动游戏
            GameCtlManager:goTo("app.ui.loadingSystem.LoadingViewController")
        elseif k == "openShieldLayer" then --打开屏蔽层
            PromptManager:openHttpLinkPrompt()
        elseif k == "closeShieldLayer" then--关闭屏蔽层
            PromptManager:closeSocketLinkPromp()
            if v == "loginFail" then --登陆失败提示
                PromptManager:openTipPrompt(LanguageConfig.language_0_39)
            end
        elseif k == "openTips" then
            PromptManager:closeHttpLinkPrompt()   
            if v == "deviceNaverDeleted" then--检测到设备账号没有登陆的naver账号是提示。 
                local loginOutHandler = function()
                    Player:logout(true)
                end 
                 scheduler.performWithDelayGlobal(function ( )
                    NoticeManager:openTips(GameCtlManager.currentController_t, {title = LanguageConfig.language_0_49,handler = loginOutHandler}) 
                end, 0.3)
            
            elseif v == "drmCheckFail" then--支付时，drm检测失败提示。
                local loginOutHandler = function()
                    Player:logout(true)
                end 
                scheduler.performWithDelayGlobal(function ( )
                    NoticeManager:openTips(GameCtlManager.currentController_t, {title = LanguageConfig.language_0_50,handler = loginOutHandler}) 
                end, 0.3)          
           
            elseif v == "iapNotWork" then -- 支付时，appStore账号在设备中删除错误提示
                local loginOutHandler = function()
                    Player:logout(false)
                end 
                scheduler.performWithDelayGlobal(function ( )
                    NoticeManager:openTips(GameCtlManager.currentController_t, {title = LanguageConfig.language_0_41,handler = loginOutHandler}) 
                end, 0.3)              
            
            elseif v == "getPurchasesAsyncFailed" then -- appStore账号在设备中删除错误提示
                local loginOutHandler = function()
                    Player:logout(false)
                end    
                scheduler.performWithDelayGlobal(function ( )
                    NoticeManager:openTips(GameCtlManager.currentController_t, {title = LanguageConfig.language_0_40,handler = loginOutHandler}) 
                end, 0.3)
            
            elseif v == "productAlreadyOwned" then --产品未消耗提示
                local loginOutHandler = function()
                    Player:logout(false)
                end         
                scheduler.performWithDelayGlobal(function ( )
                    NoticeManager:openTips(GameCtlManager.currentController_t, {title = LanguageConfig.language_0_43,handler = loginOutHandler}) 
                end, 0.3)
            
            elseif v == "notLoginAppStore" then--未登陆APPstore提示
                local loginOutHandler = function()
                    -- Player:logout(false)
                    NativeUtil:javaCallHanler({command = "needToLoginAppStore"})
                end        
                scheduler.performWithDelayGlobal(function ( )
                   PromptManager:openTipPrompt(LanguageConfig.language_0_39)
                end, 0.3)
            
            elseif v == "exitApp" then
                if not GameCtlManager.isViewLoading then
                    local handler = function()
                        -- NativeUtil:javaCallHanler({command = "exitApp"})
                        cc.Director:getInstance():endToLua() 
                    end 
                    local handler1 = function()
                        isHavePopup = false
                    end
                    if not isHavePopup then
                        isHavePopup = true
                        Functions.setPopupKey("appclosing_end")
                        scheduler.performWithDelayGlobal(function ( )
                            NoticeManager:openExitTips({title = LanguageConfig.language_0_45,handler = handler,handler1 = handler1,isShowNpc = "npc/NPC_sy_exit.png"}) 
                        end, 0.3)
                    end
                end
            elseif v == "needToLoginAppStore" then 
                local handler = function()
                    NativeUtil:javaCallHanler({command = "needToLoginAppStore"})
                end 
                scheduler.performWithDelayGlobal(function ( )
                    NoticeManager:openTips(GameCtlManager.currentController_t, {title = LanguageConfig.language_0_46,handler = handler}) 
                end, 0.3)
            elseif v == "needToInstallNaverAppStore" then --引导玩家登陆AppStroe
                local handler = function()
                    NativeUtil:javaCallHanler({command = "needToInstallNaverAppStore"})
                end 
                scheduler.performWithDelayGlobal(function ( )
                    NoticeManager:openTips(GameCtlManager.currentController_t, {title = LanguageConfig.language_0_47,handler = handler}) 
                end, 0.3)  
            elseif v == "paySuceess" then -- 提示玩家支付成功
                scheduler.performWithDelayGlobal(function ( )
                    NoticeManager:openTips(GameCtlManager.currentController_t, {title = LanguageConfig.language_0_48 ,type = 5,isShowNpc = "npc/NPC_lb_gold.png"}) 
                end, 0.6)
            elseif v == "userExit" then -- 提示玩家退出登录Cstroe
                scheduler.performWithDelayGlobal(function ( )
                    PromptManager:openTipPrompt(LanguageConfig.language_0_51)
                end, 0.6)   
            elseif v == "cancelPay" then -- 提示玩家取消了支付
                scheduler.performWithDelayGlobal(function ( )
                    PromptManager:openTipPrompt(LanguageConfig.language_9_79)
                end, 0.6)    
            elseif v == "noGoogleServices" then --没有google Services
                local loginOutHandler = function()
                    cc.Director:getInstance():endToLua() 
                end 
                if GameCtlManager.currentController_t ~= nil then 
                    scheduler.performWithDelayGlobal(function ( )
                        NoticeManager:openTips(GameCtlManager.currentController_t, {title = LanguageConfig.language_0_52 ,type = 5,handler = loginOutHandler}) 
                    end, 0.3)
                end       
            else --启动游戏时，drm检测失败提示。
                local loginOutHandler = function()
                    cc.Director:getInstance():endToLua() 
                end 
                if GameCtlManager.currentController_t ~= nil then 
                    scheduler.performWithDelayGlobal(function ( )
                        NoticeManager:openTips(GameCtlManager.currentController_t, {title = v ,type = 5,handler = loginOutHandler}) 
                    end, 0.3)
                end
            end

        elseif k == "startUpdate" then --启动游戏更新。
            if drmCallBack ~= nil then
                drmCallBack()
            end
        end
    end
    print("NativeUtil _JniBackCall msg " .. msg)
end

return NativeUtil