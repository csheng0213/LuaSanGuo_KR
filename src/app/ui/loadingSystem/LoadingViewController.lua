--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local LoadingViewController = class("LoadingViewController", BaseViewController)

local Functions = require("app.common.Functions")

LoadingViewController.debug = true
LoadingViewController.modulePath = ...
LoadingViewController.studioSpriteFrames = {"CBO_tipsOnw","LodingUI","CB_loginBg" }
--@auto code head end

local scheduler = require("app.common.scheduler")
require("cocos.cocos2d.json")

--@Pre loading
LoadingViewController.spriteFrameNames = 
    {
    }

LoadingViewController.animaNames = 
    {
        "loading_plist"
    }


--@auto code uiInit
--add spriteFrames
if #LoadingViewController.studioSpriteFrames > 0 then
    LoadingViewController.spriteFrameNames = LoadingViewController.spriteFrameNames or {}
    table.insertto(LoadingViewController.spriteFrameNames, LoadingViewController.studioSpriteFrames)
end
function LoadingViewController:onDidLoadView()

    --output list
    self._npc_t = self.view_t.csbNode:getChildByName("main"):getChildByName("npc")
	self._LoadingPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("LoadingPanel")
	self._LoadingBar_t = self.view_t.csbNode:getChildByName("main"):getChildByName("LoadingPanel"):getChildByName("LoadingBar")
	self._StateText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("StateText")
	self._loadAnimaText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("loadAnimaText")
	self._ProgressText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ProgressText")
	self._loadText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("loadText")
	self._version_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("version_text")
	self._updateColorPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("updateColorPanel")
	self._updateVersionPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("updateVersionPanel")
	self._updateTitile_t = self.view_t.csbNode:getChildByName("main"):getChildByName("updateVersionPanel"):getChildByName("updateTitile")
	self._updateContext_t = self.view_t.csbNode:getChildByName("main"):getChildByName("updateVersionPanel"):getChildByName("updateContext")
	
    --label list
    
    --button list
    self._downLoadBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("updateVersionPanel"):getChildByName("downLoadBt")
	self._downLoadBt_t:onTouch(Functions.createClickListener(handler(self, self.onDownloadbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Downloadbt btFunc
function LoadingViewController:onDownloadbtClick()
    Functions.printInfo(self.debug,"Downloadbt button is click!")

    --前往store下载最新版本
    if GameState.storeAttr.CurGameDownLoadUrl_s and GameState.storeAttr.CurGameDownLoadUrl_s ~= "" then
        Functions.callJavaFuc(function ( )
            NativeUtil:javaCallHanler({command = "nanoo",url = GameState.storeAttr.CurGameDownLoadUrl_s, isAddParameter = false})
        end)        
    end
end
--@auto code Downloadbt btFunc end

--@auto button backcall end


function LoadingViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end


--@auto code view display func
function LoadingViewController:onCreate()
    Functions.printInfo(self.debug_b," LoadingViewController controller create!")
end

function LoadingViewController:onDisplayView()
	Functions.printInfo(self.debug_b," LoadingViewController view enter display!")
    
    -- scheduler.performWithDelayGlobal(function ( )
    --                 --打开加载层    
    --                 PromptManager:openLoadingPrompt("",true)
    --         end, 0.06)
    --sdk
    Functions.setAdbrixTag("firstTimeExperience","update_try")

    --更新提示面板
    self._updateVersionPanel_t:setVisible(false)
    self._updateColorPanel_t:setVisible(false)

    --平台包名
    Functions.callJavaFuc(function()            
        NativeUtil:javaCallHanler({command = "setTargetData",customUserDataKey = "store", customUserData = SDKConfig.packageName[G_SDKType]})
    end)

    self._loadText_t:setVisible(false)
    self._ProgressText_t:setVisible(false)
    self._version_text_t:setString(Functions.getCurVersion())

    GameState.storeAttr.LoadingNpcImage_s = string.format("npc/login_%d.png", math.random(7)) 
    Functions.loadImageWithSprite(self._npc_t, GameState.storeAttr.LoadingNpcImage_s)

    self.animaSprite = Functions.createSprite()

    -- sprite:setPosition(display.cx, display.cx)
    self.loadingWidth = self._LoadingPanel_t:getSize().width
    self.animaSprite:runAction(cc.RepeatForever:create(cc.Animate:create(display.getAnimationCache("loading_plist"))))
    self.animaSprite:setPosition(15, self._LoadingPanel_t:getSize().height/2-3)
    self._LoadingPanel_t:addChild(self.animaSprite)
    --获取当前使用的url,更新url
    if G_IsAutoGetUrl then
        local param = "deviceType=" .. tostring(G_DeviceType) .. "&platformType=" .. tostring(G_PlatformType)
        .. "&gameVer_big=" .. tostring(CurrentBigVersion) .. "&gameVer_mid=" .. tostring(CurrentMidVersion) 
        .. "&gameVer_min=" .. tostring(CurrentMinVersion)
        HttpClient:sendHttpRequest(G_AutoPatchUrl, param, function(state, data)
                    if state == 0 then
                        local urlTable = json.decode(data)
                        if urlTable.error == 0 then
                            GameState.storeAttr.CurGameLoginUrl_s = urlTable.url
                            GameState.storeAttr.CurGameUpdateUrl_s = urlTable.updateUrl
                            GameState.storeAttr.CurGameDownLoadUrl_s = urlTable.downLoadUrl
                            ServerConfig:setURL(GameState.storeAttr.CurGameLoginUrl_s, GameState.storeAttr.CurGameUpdateUrl_s)
                            if urlTable.forceUpdate == "true" then
                                GameState.storeAttr.forceUpdate_b = true
                            else
                                GameState.storeAttr.forceUpdate_b = false
                            end
                            self:sdkUpdateCall()
                        end
                    end
                end)
    else
        self:sdkUpdateCall()
    end

    self:initTextAnima()
end
--@auto code view display func end


function LoadingViewController:initTextAnima()
    --初始化文字加载动画
    local index = 0
    local handle = scheduler.scheduleGlobal(function()
        if self.curStateText and #self.curStateText > 3 then
            local ch = string.sub(self.curStateText, #self.curStateText, #self.curStateText)
            if ch == "!" or ch == "." then
                local str = string.sub(self.curStateText, 1, #self.curStateText-1)
                for i = 1, index do
                    str = str .. "."
                end
                self._loadAnimaText_t:setString(str)
                index = index + 1
                if index == 4 then
                    index = 0
                end
            else
                local str = self.curStateText
                for i = 1, index do
                    str = str .. "."
                end
                self._loadAnimaText_t:setString(str)
                index = index + 1
                if index == 4 then
                    index = 0
                end
            end
        end
    end, 0.3)
    self:updateStateText(LanguageConfig.language_Teach25, true)
    Functions.addCleanFuncWithNode(self.view_t, function()
        scheduler.unscheduleGlobal(handle)
    end)
end

function LoadingViewController:updateStateText(text, isUpdate)

    if isUpdate then
        if self.curStateText ~= text then
            self.curStateText = text
            local ch = string.sub(self.curStateText, #self.curStateText, #self.curStateText)
            if ch == "!" or ch == "." then
                self._loadAnimaText_t:setString(string.sub(self.curStateText, 1, #self.curStateText-1))
            else
                self._loadAnimaText_t:setString(self.curStateText)
            end
            self._loadAnimaText_t:setVisible(true)
            self._StateText_t:setVisible(false)
        end
    else
        self.curStateText = nil
        self._StateText_t:setString(text)
        self._loadAnimaText_t:setVisible(false)
        self._StateText_t:setVisible(true)
    end
end

function LoadingViewController:update(dt)
    
    -- local test = string.format(LanguageConfig.ui_LoadingView_7, 12, 13)
    -- self._loadText_t:setString(test)
    self._loadText_t:setVisible(true)
    local Updater = require("app.common.Updater")
    local updateState = Updater.getUpdateState()

    if updateState == Updater.RLS_UNCOMPRESS_FAILED then
        self:updateStateText(LanguageConfig.ui_LoadingView_1, false)
    elseif updateState == Updater.RLS_GETFILELISTFAILED then
        self:updateStateText(LanguageConfig.ui_LoadingView_2, false)
    elseif updateState == Updater.RLS_CHECKVERSIONFAILED then
        self:updateStateText(LanguageConfig.ui_LoadingView_3, false)
    elseif updateState == Updater.RLS_DOWNLOADFILEFAILED then
        self:updateStateText(LanguageConfig.ui_LoadingView_4, false)
    elseif updateState == Updater.RLS_BIG_UPDATE then
        self:versionUpdateInit()
    elseif updateState == Updater.RLS_RESTART_CLIENT then

        --移除帧更新监听
        if self._updateHandler then
            scheduler.unscheduleGlobal(self._updateHandler)
            self._updateHandler = nil
        end
        
        self:updateStateText(LanguageConfig.ui_LoadingView_6, false)
        if not NativeUtil:javaCallHanler({command = "restartApp"}) then
            self:startGame_()
        end

    elseif updateState == Updater.RLS_DOWNLOADFILE then
        --更新进度显示
        local updateInfo = Updater.getUpdateInfo()

        self._loadText_t:setVisible(true)
        self._ProgressText_t:setVisible(true)

        self._ProgressText_t:setString("loading " .. updateInfo.progress .."%")
        self._LoadingBar_t:setPercent(updateInfo.progress)
        self._loadText_t:setString(string.format(LanguageConfig.ui_LoadingView_7, updateInfo.nowDownloaded, updateInfo.total))

    elseif updateState == Updater.RLS_COMPLETED then
        self._ProgressText_t:setString("loading 100%")
        self._LoadingBar_t:setPercent(100)
        self:startGame_()
    end
    self._version_text_t:setString(Functions.getCurVersion())

    local percent = self._LoadingBar_t:getPercent()
    self.animaSprite:setPositionX(((self.loadingWidth - 75)/100)*percent + 15)
end

function LoadingViewController:sdkUpdateCall() 
    if G_IsUseSDK then
        local scheduler = require("app.common.scheduler")
        Functions.setPopupKey("start")
        if G_SDKType == 1 then 
            scheduler.performWithDelayGlobal(function ( )
                NativeUtil:startDrmCheck(handler(self,self.startUpdate))
            end, 0.1)
        elseif G_SDKType == 4 then
            if Functions.file_exists(cc.FileUtils:getInstance():getWritablePath() .. "/up/res/heroCard/13860.png") == nil then
                scheduler.performWithDelayGlobal(function ( )
                     NativeUtil:startCheckExpansionFile(function( )
                       Functions.getCurVersion() 
                       self:startUpdate()
                    end)
                end, 0.1)
            else
                self:startUpdate()
            end
        else  
           self:startUpdate()
        end
    else
        self:startUpdate()
    end
end

function LoadingViewController:startUpdate()

    local Updater = require("app.common.Updater")

    if not G_IsUpdate then
        self:startGame_() 
    else
        if not GameState.storeAttr.forceUpdate_b then --版本强制性更新
            scheduler.performWithDelayGlobal(function()
                HttpClient:sendHttpRequest(Updater.updateManagerUrl, "", function(state, data)

                    local code = tonumber(data)
                    if state == 0 then
                        if code == 1 or (code == 2 and G_IsDebugClient) then

                            Updater.beginUpdate()
                            --打开帧更新
                            self._updateHandler = scheduler.scheduleUpdateGlobal(handler(self,self.update))
                        end
                    end
                end)
            end, 0.1)
        else
            self:versionUpdateInit()
        end
    end
end

function LoadingViewController:versionUpdateInit()
    -- PromptManager:closeLoadingPrompt()
    --初始化相关文字
    self._updateTitile_t:setString(LanguageConfig.ui_LoadingView_9)
    self._updateContext_t:setString(LanguageConfig.ui_LoadingView_10)
    self._downLoadBt_t:setTitleText(LanguageConfig.ui_LoadingView_11)

    -- self._StateText_t:setString(LanguageConfig.ui_LoadingView_5)
    self._StateText_t:setVisible(false)
    self._ProgressText_t:setVisible(false)
    self._updateVersionPanel_t:setVisible(true)
    self._updateColorPanel_t:setVisible(true)
    Functions.clearOldVerData()
end

function LoadingViewController:startGame_()
    Functions.printInfo(self.debug, "游戏更新完成，初始化资源，跳转到主界面！")

    --移除帧更新监听
    if self._updateHandler then
        scheduler.unscheduleGlobal(self._updateHandler)
        self._updateHandler = nil
    end

    --sdk

    Functions.setAdbrixTag("firstTimeExperience","update_complete")
    Functions.clearGameData()

    -- PromptManager:closeLoadingPrompt()
    Functions.EnterGame() 
end

return LoadingViewController