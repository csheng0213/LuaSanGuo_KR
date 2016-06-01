--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local StartupSceneViewController = class("StartupSceneViewController", BaseViewController)

local Functions = require("app.common.Functions")

StartupSceneViewController.debug = true
StartupSceneViewController.modulePath = ...
StartupSceneViewController.studioSpriteFrames = {"StartupSceneUI","CB_zbsnsg","CBO_bgjianbian" }
--@auto code head end

--@Pre loading
StartupSceneViewController.spriteFrameNames = 
    {
    }

StartupSceneViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #StartupSceneViewController.studioSpriteFrames > 0 then
    StartupSceneViewController.spriteFrameNames = StartupSceneViewController.spriteFrameNames or {}
    table.insertto(StartupSceneViewController.spriteFrameNames, StartupSceneViewController.studioSpriteFrames)
end
function StartupSceneViewController:onDidLoadView()

    --output list
    self._gh_t = self.view_t.csbNode:getChildByName("main"):getChildByName("gh")
	
    --label list
    
    --button list
    self._startBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("startBt")
	self._startBt_t:onTouch(Functions.createClickListener(handler(self, self.onStartbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Startbt btFunc
function StartupSceneViewController:onStartbtClick()
    Functions.printInfo(self.debug,"Startbt button is click!")
    Functions.setAdbrixTag("firstTimeExperience","touch_screen_complete")
    
    -- GameCtlManager:goTo("app.ui.eulaSceneSystem.EulaSceneViewController")
    if not GameState.storeAttr.isConfirmEula_b then 
        GameCtlManager:goTo("app.ui.eulaSceneSystem.EulaSceneViewController")
    else
        if not GameState.storeAttr.isLoginNaver_b then
            Functions.goToLoginView()
        else            
            if GameState.storeAttr.NaverUserId_s ~= "" and G_SDKType ~= 4 then
                if GameState.storeAttr.NaverUserName_s ~= "" then   
                    if G_SDKType == 5 and G_isFirstStartApp then         
                        G_isFirstStartApp = false
                        Functions.callJavaFuc(function()             
                                NativeUtil:GameCenterLogin()
                        end)
                    else 
                        Functions.callJavaFuc(function()  
                            PromptManager:openHttpLinkPrompt()        
                            NativeUtil:javaCallHanler({command = "setUsrName",usrName = GameState.storeAttr.NaverUserName_s,usrId = GameState.storeAttr.NaverUserId_s})
                        end)
                    end
                end
                -- Functions.sdkLoginHandler(GameState.storeAttr.NaverUserId_s)
            else
                Functions.callJavaFuc(function()             
                        NativeUtil:sdkLogin()
                end)
            end
        end
    end
end
--@auto code Startbt btFunc end

--@auto button backcall end


--@auto code view display func
function StartupSceneViewController:onCreate()
    Functions.printInfo(self.debug_b," StartupSceneViewController controller create!")
end
function StartupSceneViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
function StartupSceneViewController:onDisplayView()
	Functions.printInfo(self.debug_b," StartupSceneViewController view enter display!")
    Functions.setAdbrixTag("firstTimeExperience","touch_screen_try")
    Functions.setPopupKey("touch_to_start")
    Functions.callJavaFuc(function()            
        NativeUtil:javaCallHanler({command = "setTargetData",customUserDataKey = "version", customUserData = Functions.getCurVersion()})
    end)
--    Functions.playActionWithBackCall(self._gh_t, UIActionTool:createBlinkAction(1))
    Functions.playActionWithBackCall(self._gh_t, UIActionTool:createBlinkNoGradientAction(0.4))
end
--@auto code view display func end

return StartupSceneViewController