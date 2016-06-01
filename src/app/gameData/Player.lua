local Player = {}

--事件
Player.PLAYER_LOGOUT_EVENT = "PLAYER_LOGOUT_EVENT"

Player.LogoutReason = 
{
        R_ENTERSERVERFAILED = 0,    -- 进入游戏失败
        R_LOGINATOTHERPLACE = 1,    -- 在其他地方登录
        R_TOKENINVALID = 2,         -- TOKEN无效
        R_ACCOUNTERROR = 3,         -- 账号验证失败
        R_ACCOUNTCHANGED = 4,       -- 账号已更改
        R_PLAYERINVALID = 5,        -- 玩家已失效
        R_PLAYERFULL = 6,           -- 玩家数量已满
        R_NOTINSERVER = 7,          -- 不在服务器中
        R_SYSTEMERROR = 8,          -- 系统其他错误
        R_ACCOUNTLOCK = 9,          -- 玩家被封禁
}

function Player:init()
	self.isOnline = false
end

-- function Player:sdkLoginHandler(userId)


--     self.loginType = LoginType.Sdk_Login

--     --开始登陆
--     local onLoginSuccess = function(event)
--         local data = event.data

--         if data then
--             if tonumber(data.error) ~= NetWork.WebErrCode.Success then
--                 Functions.openNetWorkTip(data.error)
--                 return
--             end
            
--             GameState.storeAttr.userName_s = userName
--             GameState.storeAttr.password_s = password
--             GameState.storeAttr.serverToken_s = data.token
    
--             GameCtlManager:goTo("app.ui.loginSystem.LoginViewController",
--              { server = data.server, loginType = LoginType.Sdk_Login })
--         else
--             PromptManager:openTipPrompt(LanguageConfig.language_Login_1)
--         end
--     end

--     NetWork:registUserServer(userId, userId, function(event)
    
--         local data = event.data
--         if data then
--             if tonumber(data.error) == NetWork.WebErrCode.Success then
--                 GameState.storeAttr.userName_s = data.post.username
--                 GameState.storeAttr.password_s = data.post.password
--                 NetWork:loginUserServer(data.post.username, data.post.password, onLoginSuccess)
--             elseif tonumber(data.error) == NetWork.WebErrCode.Register_User_already then
--                 NetWork:loginUserServer(userId, userId, onLoginSuccess)
--             else 
--                 Functions.openNetWorkTip(data.error)
--             end
--         else
--             PromptManager:openTipPrompt(LanguageConfig.language_Login_1)
--         end
        
--     end)

-- end

function Player:onLogin()
    self.isOnline = true

    local onDataTransmitFinish = function()
        Functions.printInfo(self.debug, "登陆成功，相关数据同步完成！")       
        NetWork.isLogined = false
        
        PromptManager:closeHttpLinkPrompt()
        -- GameCtlManager:goTo("app.ui.loadingSystem.LoadingViewController")
        -- GameCtlManager:goTo("app.ui.testSystem.TestViewController")
        Functions.setAdbrixTag("firstTimeExperience","cartoon_0_1_try")
        if Functions.isFirstLogin() and G_IsOpenGuide then

            --sdk           

            GameCtlManager:push("app.ui.imagePlayerSystem.ImagePlayerViewController",{ data = { jumpData = { levelId = 1, callBack = function()
                
                --sdk
                Functions.setAdbrixTag("firstTimeExperience","cartoon_0_4_complete")
                Functions.setAdbrixTag("firstTimeExperience","loading_1_try")
                if G_IsOpenFirstFight then
                    --sdk                    
                    GameCtlManager:getCurrentController().view_t:setVisible(false) --
                    GameCtlManager:push("app.ui.combatSystem.CombatViewController", { data = { combatType = CombatCenter.CombatType.RB_Guide } })
                else
                    Functions.setAdbrixTag("firstTimeExperience","loading_1_complete")
                    Functions.setAdbrixTag("firstTimeExperience","tutorial_combat_try")
                    Functions.setAdbrixTag("firstTimeExperience","tutorial_combat_complete")
                    Functions.setAdbrixTag("firstTimeExperience","cartoon_1_1_try")
                    Functions.setAdbrixTag("firstTimeExperience","cartoon_1_3_complete")

                    GameCtlManager:goTo("app.ui.newPlayerSystem.NewPlayerViewController")
                end
                end } }})
        else
            Functions.setAdbrixTag("firstTimeExperience","cartoon_0_4_complete")
            Functions.setAdbrixTag("firstTimeExperience","loading_1_try")
            Functions.setAdbrixTag("firstTimeExperience","tutorial_combat_try")
            Functions.setAdbrixTag("firstTimeExperience","tutorial_combat_complete")

            Functions.setAdbrixTag("firstTimeExperience","cartoon_1_1_try")
            Functions.setAdbrixTag("firstTimeExperience","cartoon_1_3_complete")
            Functions.setAdbrixTag("firstTimeExperience","nickname_create_try")

            Functions.setAdbrixTag("firstTimeExperience","nickname_create_complete")
            Functions.setAdbrixTag("firstTimeExperience","loading_2_try")

            GameCtlManager:goTo("app.ui.mainSystem.MainViewController")
        end  
        return true
    end

    NetWork:addNetWorkListener({ 2, 100 }, onDataTransmitFinish)
end

function Player:onLogout(code)

    Functions.clearGameData()

    if self.isOnline then
        GameEventCenter:dispatchEvent({ name = Player.PLAYER_LOGOUT_EVENT })
        self.isOnline = false
    end
    
    Functions.EnterGame({ loginType = self.loginType, errorCode = code })
end

function Player:logout(isClearUserData)
    	NetWork:logoutServer()
        Functions.clearGameData()
        GameCtlManager:clearNotificationLayer()
        GameEventCenter:dispatchEvent({ name = Player.PLAYER_LOGOUT_EVENT })
        Functions.callJavaFuc(function()

            -- GameState.storeAttr.isConfirmEula_b = false
            if isClearUserData ~= nil and isClearUserData == true then 
                GameState.storeAttr.isLoginNaver_b = false
                GameState.storeAttr.NaverUserId_s = ""
                GameState.storeAttr.NaverUserName_s = ""
            end
            PromptManager:openHttpLinkPrompt()
            NativeUtil:javaCallHanler({command = "loginOut"})
            -- PromptManager:closeSocketLinkPromp()
        end)
        Functions.EnterGame() 
end

function Player:reEnterGame()

    --缓存服务器列表

    NetWork:logoutServer()
    Functions.clearGameData()
    GameCtlManager:clearNotificationLayer()
    GameEventCenter:dispatchEvent({ name = Player.PLAYER_LOGOUT_EVENT })
    
    --相关配置初始化
    require("app.common.GameStaticInit")
    require("app.common.GameInit")
    require("app.configs.server.init")
    
    GameCtlManager:goTo("app.ui.loginSystem.LoginViewController",
             { server = g_ServerList, loginType = LoginType.Sdk_Login , isOpenServerList = true })
end

function Player:webLogin(userName, password, onLoginSuccess)
    self.loginType = LoginType.Local_Login

    PromptManager:openHttpLinkPrompt()
    NetWork:loginUserServer(userName, password, onLoginSuccess)
end

return Player