--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local LoginViewController = class("LoginViewController", BaseViewController)

local Functions = require("app.common.Functions")

LoginViewController.debug = true
LoginViewController.modulePath = ...
LoginViewController.studioSpriteFrames = {"CB_beij","LoginUI","LoginUIBg","LoginUI_Text" }
--@auto code head end

local scheduler = require("app.common.scheduler")
--初始化信息管理组件
NoticeManager = require("app.ui.noticeSystem.NoticeManager")


--服务器代码初始化
require("app.configs.server.init")

--@Pre loading
LoginViewController.spriteFrameNames = 
    {
    }

LoginViewController.animaNames = 
    {
    }



--@auto code uiInit
--add spriteFrames
if #LoginViewController.studioSpriteFrames > 0 then
    LoginViewController.spriteFrameNames = LoginViewController.spriteFrameNames or {}
    table.insertto(LoginViewController.spriteFrameNames, LoginViewController.studioSpriteFrames)
end
function LoginViewController:onDidLoadView()

    --output list
    self._login_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("login_panel")
	self._loginUserName_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("login_panel"):getChildByName("loginUserName_text")
	self._loginUserPassword_text_0_t = self.view_t.csbNode:getChildByName("main"):getChildByName("login_panel"):getChildByName("loginUserPassword_text_0")
	self._regist_panel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("regist_panel")
	self._registUserName_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("regist_panel"):getChildByName("registUserName_text")
	self._registUserPassword_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("regist_panel"):getChildByName("registUserPassword_text")
	self._registUserRePassword_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("regist_panel"):getChildByName("registUserRePassword_text")
	self._selectServerPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectServerPanel")
	self._serverText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectServerPanel"):getChildByName("box_login_7"):getChildByName("serverText")
	self._serverStateText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectServerPanel"):getChildByName("box_login_7"):getChildByName("serverStateText")
	self._serverList_t = self.view_t.csbNode:getChildByName("main"):getChildByName("serverList")
	self._lastLoginServer_t = self.view_t.csbNode:getChildByName("main"):getChildByName("serverList"):getChildByName("box_login_2"):getChildByName("lastLoginServer")
	self._oldServerText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("serverList"):getChildByName("box_login_2"):getChildByName("oldServerText")
	self._moreServer_t = self.view_t.csbNode:getChildByName("main"):getChildByName("serverList"):getChildByName("box3_login_3"):getChildByName("moreServer")
	self._serverListPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("serverList"):getChildByName("serverListPanel")
	self._model_t = self.view_t.csbNode:getChildByName("main"):getChildByName("serverList"):getChildByName("serverListPanel"):getChildByName("model")
	self._childServerState_t = self.view_t.csbNode:getChildByName("main"):getChildByName("serverList"):getChildByName("serverListPanel"):getChildByName("model"):getChildByName("childServerState")
	self._version_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("version_text")
	
    --label list
    
    --button list
    self._test_button_t = self.view_t.csbNode:getChildByName("main"):getChildByName("login_panel"):getChildByName("test_button")
	self._test_button_t:onTouch(Functions.createClickListener(handler(self, self.onTest_buttonClick), ""))

	self._newRegistBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("login_panel"):getChildByName("newRegistBt")
	self._newRegistBt_t:onTouch(Functions.createClickListener(handler(self, self.onNewregistbtClick), ""))

	self._registBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("regist_panel"):getChildByName("registBt")
	self._registBt_t:onTouch(Functions.createClickListener(handler(self, self.onRegistbtClick), ""))

	self._goLoginBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("regist_panel"):getChildByName("goLoginBt")
	self._goLoginBt_t:onTouch(Functions.createClickListener(handler(self, self.onGologinbtClick), ""))

	self._selectBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectServerPanel"):getChildByName("box_login_7"):getChildByName("selectBt")
	self._selectBt_t:onTouch(Functions.createClickListener(handler(self, self.onSelectbtClick), "zoom"))

	self._startGameBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("selectServerPanel"):getChildByName("startGameBt")
	self._startGameBt_t:onTouch(Functions.createClickListener(handler(self, self.onStartgamebtClick), ""))

	self._serverButton_0_t = self.view_t.csbNode:getChildByName("main"):getChildByName("serverList"):getChildByName("box_login_2"):getChildByName("serverButton_0")
	self._serverButton_0_t:onTouch(Functions.createClickListener(handler(self, self.onServerbutton_0Click), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Test_button btFunc
function LoginViewController:onTest_buttonClick()
    Functions.printInfo(self.debug,"Test_button button is click!")
    
    -- Functions.sdkLoginHandler("sdfssdfsdfe")

    local userName = self._loginUserName_text_t:getString()
    local password = self._loginUserPassword_text_0_t:getString()

    if #userName == 0 then
        PromptManager:openTipPrompt(LanguageConfig.language_0_7)
        return
    end

    if #password == 0 then
        PromptManager:openTipPrompt(LanguageConfig.language_0_8)
        return
    end
-- --
--     userName = "NaverSdk_84156557_2"
--     password = "NaverSdk_84156557_2"


    --开始登陆
    local onLoginSuccess = function(event)
        PromptManager:closeHttpLinkPrompt()
        local data = event.data

        if data then
            if tonumber(data.error) ~= NetWork.WebErrCode.Success then
                Functions.openNetWorkTip(data.error, data.reason)
                return
            end
            
            Functions.printInfo(self.debug, "用户web登陆成功！")
            -- PromptManager:openTipPrompt(LanguageConfig.login_User_Success) --弹出登陆成功提示

            GameState.storeAttr.userName_s = userName
            GameState.storeAttr.password_s = password
            GameState.storeAttr.serverToken_s = data.token
            
            --清理关闭的服务器
            self._server = {}
            for i=1, #data.server do
                self._server[#self._server+1] = data.server[i]
            end

            if #self._server ~= 0 then
                self:initServerList_()
                self:openSelectServerPanel_()

                if self.isFirstLogin then
                    self:closeAllPanel()
                    self._serverList_t:show()
                end
            else
                PromptManager:openTipPrompt(LanguageConfig.Server_Not_Fount_Tip)
            end

            g_ServerList = self._server
        else
            PromptManager:openTipPrompt(LanguageConfig.language_Login_1)
        end
    end

    Player:webLogin(userName, password, onLoginSuccess)
end
--@auto code Test_button btFunc end

--@auto code Newregistbt btFunc
function LoginViewController:onNewregistbtClick()
    Functions.printInfo(self.debug,"Newregistbt button is click!")
    
    self._regist_panel_t:show()
    self._login_panel_t:hide()
    
end
--@auto code Newregistbt btFunc end

--@auto code Registbt btFunc
function LoginViewController:onRegistbtClick()
    Functions.printInfo(self.debug,"Registbt button is click!")
    
    local registUserName = self._registUserName_text_t:getString()
    local registPassword = self._registUserPassword_text_t:getString()
    local registPasswordRe = self._registUserRePassword_text_t:getString()

    if #registUserName == 0 then
        PromptManager:openTipPrompt(LanguageConfig.language_0_7)
        return
    end

    if #registPassword == 0 or #registPasswordRe == 0 then
        PromptManager:openTipPrompt(LanguageConfig.language_0_8)
        return
    end

    if registPassword ~= registPasswordRe then
        PromptManager:openTipPrompt(LanguageConfig.language_0_10)
        return
    end

    NetWork:registUserServer(registUserName, registPassword, function(event)
        Functions.printInfo(self.debug, "注册返回")

        local data = event.data
        if data then
            if tonumber(data.error) ~= NetWork.WebErrCode.Success then
                Functions.openNetWorkTip(data.error)
                return
            end

            PromptManager:openTipPrompt(LanguageConfig.Register_User_Success)
            GameState.storeAttr.userName_s = data.post.username
            GameState.storeAttr.password_s = data.post.password
            self:openLoginView_()
        else
            PromptManager:openTipPrompt(LanguageConfig.language_Login_1)
        end
        
    end)
    
end
--@auto code Registbt btFunc end

--@auto code Gologinbt btFunc
function LoginViewController:onGologinbtClick()
    Functions.printInfo(self.debug,"Gologinbt button is click!")
    
    self._regist_panel_t:hide()
    self._login_panel_t:show()
    
end
--@auto code Gologinbt btFunc end

--@auto code Selectbt btFunc
function LoginViewController:onSelectbtClick()
    Functions.printInfo(self.debug,"Selectbt button is click!")

    self:closeAllPanel()
    self._serverList_t:show()
    
end
--@auto code Selectbt btFunc end

--@auto code Startgamebt btFunc
function LoginViewController:onStartgamebtClick()
    Functions.printInfo(self.debug,"Startgamebt button is click!")
    
    if self._server[GameState.storeAttr.serverOldIndex_f].status == tostring(NetWork.ServerStatusCode.shutdown) then
        PromptManager:openTipPrompt(Functions.getTipOfServerStatus(self._server[GameState.storeAttr.serverOldIndex_f].status))
        return
    end
    if self._server[GameState.storeAttr.serverOldIndex_f].status == tostring(NetWork.ServerStatusCode.busy) then
        PromptManager:openTipPrompt(Functions.getTipOfServerStatus(self._server[GameState.storeAttr.serverOldIndex_f].status))
        return
    end
    if self._server[GameState.storeAttr.serverOldIndex_f].status == tostring(NetWork.ServerStatusCode.maintain) and not G_IsDebugClient then
        PromptManager:openTipPrompt(Functions.getTipOfServerStatus(self._server[GameState.storeAttr.serverOldIndex_f].status))
        return
    end
    if self._server[GameState.storeAttr.serverOldIndex_f].status == tostring(NetWork.ServerStatusCode.wait) and not G_IsDebugClient then
        PromptManager:openTipPrompt(Functions.getTipOfServerStatus(self._server[GameState.storeAttr.serverOldIndex_f].status))
        return
    end

    --sdk
    Functions.setAdbrixTag("firstTimeExperience","btn_gamestart_complete")
    Functions.callJavaFuc(function()
            NativeUtil:javaCallHanler({command = "customCohort2",activityName = "serverId_" ..  tostring(self._server[GameState.storeAttr.serverOldIndex_f].id)})
        end)
       
    
    PromptManager:openHttpLinkPrompt()
    NetWork:loginServer(GameState.storeAttr.userName_s, GameState.storeAttr.serverToken_s, self._logicServerId)
    
end
--@auto code Startgamebt btFunc end

--@auto code Serverbutton_0 btFunc
function LoginViewController:onServerbutton_0Click()
    Functions.printInfo(self.debug,"Serverbutton_0 button is click!")
    self:openSelectServerPanel_(GameState.storeAttr.serverOldIndex_f)
end
--@auto code Serverbutton_0 btFunc end

--@auto button backcall end

function LoginViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end

--@auto code view display func
function LoginViewController:onDisplayView()
	Functions.printInfo(self.debug_b," LoginViewController view enter display!")
	
    --sdk
    Functions.setAdbrixTag("firstTimeExperience","btn_gamestart_try")
    Functions.setPopupKey("select_server")
    self._lastLoginServer_t:setString(LanguageConfig.ui_LoginView_2)
    self._moreServer_t:setString(LanguageConfig.ui_LoginView_3)

    --维护包允许玩家输入长于15个字符的用户名
    if G_IsDebugClient then
        self._loginUserName_text_t:setMaxLength(200)
        self._loginUserPassword_text_0_t:setMaxLength(200)
    end
    
	--注册输入监听`
    self._loginUserName_text_t:setPlaceHolder(LanguageConfig.ui_LoginView_4)
    self._loginUserName_text_t:onEvent(Functions.createInputListener(self))
    
    self._loginUserPassword_text_0_t:setPlaceHolder(LanguageConfig.ui_LoginView_4)
    self._loginUserPassword_text_0_t:onEvent(Functions.createInputListener(self))

    self._registUserName_text_t:setPlaceHolder(LanguageConfig.ui_LoginView_4)
    self._registUserName_text_t:onEvent(Functions.createInputListener(self))

    self._registUserPassword_text_t:setPlaceHolder(LanguageConfig.ui_LoginView_4)
    self._registUserPassword_text_t:onEvent(Functions.createInputListener(self))

    self._registUserRePassword_text_t:setPlaceHolder(LanguageConfig.ui_LoginView_4)
    self._registUserRePassword_text_t:onEvent(Functions.createInputListener(self))
    
    --初始化版本号
    self._version_text_t:setString(Functions.getCurVersion())

    if GameState.storeAttr.serverOldIndex_f == 0 then
        GameState.storeAttr.serverOldIndex_f = 1 
        self.isFirstLogin = true
    end
    
    if self.data then
        if self.data.errorCode then
            scheduler.performWithDelayGlobal(function()
                Functions.openGateWayTip(self.data.errorCode)
            end, 0.2)
        end

        if self.data.loginType == LoginType.Sdk_Login then
            self._server = self.data.server
            self:initServerList_()
            self:openSelectServerPanel_()

            if self.isFirstLogin or self.data.isOpenServerList then
                self:closeAllPanel()
                self._serverList_t:show()
            end
                
        else
            self:openLoginView_()
        end
    else
        scheduler.performWithDelayGlobal(function()
            NoticeManager:openNotice(self, { type = NoticeManager.SYSTEM_INFO } )
        end, 0.1)
        self:openLoginView_()
    end
 
end
--@auto code view display func end

function LoginViewController:onReceiveGotoData(data)
    self.data = data
end

function LoginViewController:openLoginView_()

    if #GameState.storeAttr.userName_s > 0 then
        self._loginUserName_text_t:setText(GameState.storeAttr.userName_s)  
    end

    if #GameState.storeAttr.password_s > 0 then    
        self._loginUserPassword_text_0_t:setString(GameState.storeAttr.password_s)
    end

    self:closeAllPanel()
    self._login_panel_t:show()

end

function LoginViewController:initServerList_()
    
    local listHandler = function(index, listChild, data, model)
        function onServerSelectClick()
            if data.status == tostring(NetWork.ServerStatusCode.online) 
                or (data.status ~= tostring(NetWork.ServerStatusCode.online) and G_IsDebugClient) then
                GameState.storeAttr.serverOldIndex_f = index
                self:openSelectServerPanel_(index)
            else
                PromptManager:openTipPrompt(Functions.getTipOfServerStatus(data.status))
            end
        end

        local text = listChild:getChildByTag(2)
        local stateText = listChild:getChildByTag(3)

        Functions.initTextColor(model:getChildByTag(2), text)
        Functions.initTextColor(model:getChildByTag(3), stateText)
        Functions.initLabelOfString(text, data.name, stateText, Functions.getServerStateCode(data.status))
        
        listChild:getChildByTag(1):onTouch(Functions.createClickListener(onServerSelectClick)) 
    end
    
    Functions.bindListWithData(self._serverListPanel_t, self._server, listHandler)
    
    local serverText = ""
    if GameState.storeAttr.serverOldIndex_f > #self._server then
        serverText = self._server[#self._server].name
    else
        serverText = self._server[GameState.storeAttr.serverOldIndex_f].name
    end
    self._oldServerText_t:setString(serverText)
    
    self._serverListPanel_t:jumpToBottom()
end


function LoginViewController:openSelectServerPanel_()

    local index = GameState.storeAttr.serverOldIndex_f
    
    if index > #self._server then
         index = #self._server
         GameState.storeAttr.serverOldIndex_f = index
    end

    local serverText = self._server[index].name
    self._serverText_t:setString(serverText)
    self._serverStateText_t:setString(Functions.getServerStateCode(self._server[index].status))

    self._logicServerId = tonumber(self._server[index].id)
    NetWork:setServerInfo(self._server[index].ip, self._logicServerId)

    self:closeAllPanel()
    self._selectServerPanel_t:show()

end

function LoginViewController:closeAllPanel()
    self._login_panel_t:hide()
    self._serverList_t:hide()
    self._regist_panel_t:hide()
    self._selectServerPanel_t:hide()
end


return LoginViewController