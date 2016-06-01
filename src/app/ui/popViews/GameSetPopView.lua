--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local GameSetPopView = class("GameSetPopView", BasePopView)

local Functions = require("app.common.Functions")

GameSetPopView.csbResPath = "cs/csb"
GameSetPopView.debug = true
GameSetPopView.studioSpriteFrames = {"CBO_taxKuang","GameSetPopUI" }
--@auto code head end

--@Pre loading
GameSetPopView.spriteFrameNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #GameSetPopView.studioSpriteFrames > 0 then
    GameSetPopView.spriteFrameNames = GameSetPopView.spriteFrameNames or {}
    table.insertto(GameSetPopView.spriteFrameNames, GameSetPopView.studioSpriteFrames)
end
function GameSetPopView:onInitUI()

    --output list
    self._nstoreBz_t = self.csbNode:getChildByName("Panel_1"):getChildByName("nstoreBz")
	self._head_t = self.csbNode:getChildByName("Panel_1"):getChildByName("head")
	self._playerNameTx_t = self.csbNode:getChildByName("Panel_1"):getChildByName("playerNameTx")
	self._playerId_t = self.csbNode:getChildByName("Panel_1"):getChildByName("playerId")
	self._playerLevelTx_t = self.csbNode:getChildByName("Panel_1"):getChildByName("playerLevelTx")
	self._playerExTx_0_t = self.csbNode:getChildByName("Panel_1"):getChildByName("playerExTx_0")
	self._naverText_t = self.csbNode:getChildByName("Panel_1"):getChildByName("naverText")
	self._codeInput_t = self.csbNode:getChildByName("codeInput")
	self._soundCheckBox_t = self.csbNode:getChildByName("soundCheckBox")
	self._musicCheckBox_t = self.csbNode:getChildByName("musicCheckBox")
	self._notiveSetBt_t = self.csbNode:getChildByName("notiveSetBt")
	self._head_panel_clolor_t = self.csbNode:getChildByName("head_panel_clolor")
	self._head_panel_t = self.csbNode:getChildByName("head_panel_clolor"):getChildByName("head_panel")
	self._headList_t = self.csbNode:getChildByName("head_panel_clolor"):getChildByName("headList")
	
    --label list
    
    --button list
    self._headBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("headBt")
	self._headBt_t:onTouch(Functions.createClickListener(handler(self, self.onHeadbtClick), ""))

	self._sendInviteBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("sendInviteBt")
	self._sendInviteBt_t:onTouch(Functions.createClickListener(handler(self, self.onSendinvitebtClick), ""))

	self._logoutBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("logoutBt")
	self._logoutBt_t:onTouch(Functions.createClickListener(handler(self, self.onLogoutbtClick), ""))

	self._changeServerBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("changeServerBt")
	self._changeServerBt_t:onTouch(Functions.createClickListener(handler(self, self.onChangeserverbtClick), ""))

	self._moreHeadBt_t = self.csbNode:getChildByName("head_panel_clolor"):getChildByName("moreHeadBt")
	self._moreHeadBt_t:onTouch(Functions.createClickListener(handler(self, self.onMoreheadbtClick), ""))

	self._closeHeadBt_t = self.csbNode:getChildByName("head_panel_clolor"):getChildByName("closeHeadBt")
	self._closeHeadBt_t:onTouch(Functions.createClickListener(handler(self, self.onCloseheadbtClick), "zoom"))

	self._closeBt_t = self.csbNode:getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Sendinvitebt btFunc
function GameSetPopView:onSendinvitebtClick()
    Functions.printInfo(self.debug,"Sendinvitebt button is click!")

    local inviteCode = self._codeInput_t:getString()

    NetWork:addNetWorkListener({ 20, 1 }, Functions.createNetworkListener(function()
        PromptManager:openTipPrompt(LanguageConfig.language_6_2)
        end, true, "ret"))
    NetWork:sendToServer({ idx = { 20, 1} , codeid = inviteCode })
end
--@auto code Sendinvitebt btFunc end

--@auto code Logoutbt btFunc
function GameSetPopView:onLogoutbtClick()
    Functions.printInfo(self.debug,"Logoutbt button is click!")
    if not self.logouting then
        self.logouting = true
        Player:logout(true)
        -- Player:reEnterGame()
    end
end
--@auto code Logoutbt btFunc end

--@auto code Sendinvitebt_0 btFunc
function GameSetPopView:onSendinvitebt_0Click()
    Functions.printInfo(self.debug,"Sendinvitebt_0 button is click!")
end
--@auto code Sendinvitebt_0 btFunc end

--@auto code Closebt btFunc
function GameSetPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    
    self:close()
end
--@auto code Closebt btFunc end

--@auto code Changeheadbt btFunc
function GameSetPopView:onChangeheadbtClick()
    Functions.printInfo(self.debug,"Changeheadbt button is click!")

    self._head_panel_clolor_t:setVisible(true)
end
--@auto code Changeheadbt btFunc end

--@auto code Closeheadbt btFunc
function GameSetPopView:onCloseheadbtClick()
    Functions.printInfo(self.debug,"Closeheadbt button is click!")

    self._head_panel_clolor_t:setVisible(false)
end
--@auto code Closeheadbt btFunc end

--@auto code Moreheadbt btFunc
function GameSetPopView:onMoreheadbtClick()
    Functions.printInfo(self.debug,"Moreheadbt button is click!")

    self:getController():openChildView("app.ui.popViews.HeroIconPopView",{ isRemove = false, data = { cb = function(data)
        local id = ConfigHandler:getLordHeadIdOfId(data.m_id)
        local onSetFinish = function()
            PlayerData.eventAttr.m_imgID = id
            self._head_panel_clolor_t:setVisible(false)
        end
        NetWork:addNetWorkListener({ 6, 6 }, Functions.createNetworkListener(onSetFinish,true,"ret"))
        NetWork:sendToServer({ idx = { 6, 6 }, imgID = id })

    end}})
end
--@auto code Moreheadbt btFunc end

--@auto code Headbt btFunc
function GameSetPopView:onHeadbtClick()
    Functions.printInfo(self.debug,"Headbt button is click!")
    self:onChangeheadbtClick()
end
--@auto code Headbt btFunc end

--@auto code Changeserverbt btFunc
function GameSetPopView:onChangeserverbtClick()
    Functions.printInfo(self.debug,"Changeserverbt button is click!")

    if not self.logouting then
        self.logouting = true
        -- Player:logout(true)
        Player:reEnterGame()
    end
end
--@auto code Changeserverbt btFunc end

--@auto button backcall end


--@auto code output func
function GameSetPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function GameSetPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	
    self._codeInput_t:setPlaceHolder(LanguageConfig.ui_language_Chat_2)
    self._codeInput_t:onEvent(Functions.createInputListener(self._controller_t))

    self.naverText = self.csbNode:getChildByName("Panel_1"):getChildByName("naverText")

    if GameState:getLoginType() == "NaverSdk" then
        if self.naverText then
            self.naverText:setString(GameState.storeAttr.NaverUserName_s)
        else
            self.naverText:setVisible(false)
            self._nstoreBz_t:setVisible(false)
        end
    elseif GameState:getLoginType() == "GplayLogin" then
        if self.naverText then
            self.naverText:setString(GameState.storeAttr.NaverUserName_s)
            self._nstoreBz_t:ignoreContentAdaptWithSize(true)
            Functions.loadImageWithWidget(self._nstoreBz_t, "cs/loadRes/loginLogo/G.png")
        else
            self.naverText:setVisible(false)
            self._nstoreBz_t:setVisible(false)
        end
    elseif GameState:getLoginType() == "CstoreLogin" then
        if self.naverText then
            self.naverText:setString(GameState.storeAttr.NaverUserName_s)
            self._nstoreBz_t:ignoreContentAdaptWithSize(true)
            Functions.loadImageWithWidget(self._nstoreBz_t, "cs/loadRes/loginLogo/CL.png")
        else
            self.naverText:setVisible(false)
            self._nstoreBz_t:setVisible(false)
        end
    elseif GameState:getLoginType() == "AstoreLogin" then
        if self.naverText then
            self.naverText:setString(GameState.storeAttr.NaverUserName_s)
            self._nstoreBz_t:ignoreContentAdaptWithSize(true)
            Functions.loadImageWithWidget(self._nstoreBz_t, "cs/loadRes/loginLogo/gamecenter.png")
        else
            self.naverText:setVisible(false)
            self._nstoreBz_t:setVisible(false)
        end

        --ios屏蔽注销
        self._logoutBt_t:setVisible(false)
        self._changeServerBt_t:setPositionX(self._changeServerBt_t:getParent():getSize().width/2)
    else
        self.naverText:setVisible(false)
        self._nstoreBz_t:setVisible(false)
    end

    --初始化人物显示信息
    Functions.initLabelOfString(
                                self._playerLevelTx_t, PlayerData.eventAttr.m_level,
                                self._playerNameTx_t, PlayerData.eventAttr.m_name,
                                self._playerId_t, PlayerData.eventAttr.m_uid
                                )
    
    local expStr = tostring(PlayerData.eventAttr.m_exp) .. "/" .. tostring(g_roleUplevelExp[PlayerData.eventAttr.m_level])
    self._playerExTx_0_t:setString(expStr)


    local onImgIdChange = function(event)
        Functions.initLordHeadOfId(self._head_t:getChildByName("model"), event.data)
    end

    onImgIdChange({ data = PlayerData.eventAttr.m_imgID })
    Functions.bindUiWithModelAttr(self._head_t:getChildByName("model"), PlayerData, "m_imgID", onImgIdChange)
 
    --初始化复选框
    if GameState.storeAttr.musicState_b then
        self._musicCheckBox_t:setSelected(false)
    else
        self._musicCheckBox_t:setSelected(true)
    end
    
    if GameState.storeAttr.soundState_b then
        self._soundCheckBox_t:setSelected(false)
    else
        self._soundCheckBox_t:setSelected(true)
    end

    if GameState.storeAttr.isCloseSystemSpeaker_b then
        self._notiveSetBt_t:setSelected(false)
    else
        self._notiveSetBt_t:setSelected(true)
    end

    local headListData = {}

    for i=1, 4 do
        headListData[#headListData + 1] = { imageName = Functions.getDisHeadImagePathOfId(i), imageId = i }
    end

    --绑定头像列表
    local listHandler = function(index, listChild, data, model)
        
        function onHeadImageBt()
            print("change player imageid : " .. data.imageId)

            local onSetFinish = function()
                PlayerData.eventAttr.m_imgID = data.imageId
                self._head_panel_clolor_t:setVisible(false)
            end
            NetWork:addNetWorkListener({ 6, 6 }, Functions.createNetworkListener(onSetFinish,true,"ret"))
            NetWork:sendToServer({ idx = { 6, 6 }, imgID = data.imageId })
        end

        local bt = listChild:getChildByName("headPanel"):getChildByName("headBt")
        bt:ignoreContentAdaptWithSize(true)
        Functions.loadImageWithWidget(bt, data.imageName)

        bt:onTouch(Functions.createClickListener(onHeadImageBt))
        listChild:setVisible(true)
    end
    
    Functions.bindListWithData(self._headList_t, headListData, listHandler)
            
end

function GameSetPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
    
    local onSoundCheckBox = function(data)
        if data == "selected" then
            GameState.storeAttr.soundState_b = false
        else
            GameState.storeAttr.soundState_b = true
    	end
    end
    Functions.bindCheckBoxListener({ target = self._soundCheckBox_t, listener = onSoundCheckBox})
    
    local onMusicCheckBox = function(data)
        if data == "selected" then
            GameState.storeAttr.CurGameBgMusic_s = ""
            GameState.storeAttr.musicState_b = false
        else
            GameState.storeAttr.musicState_b = true
        end
    end
    Functions.bindCheckBoxListener({ target = self._musicCheckBox_t, listener = onMusicCheckBox})

    local onSpeakCheckBox = function(data)
        if data == "selected" then
            GameState.storeAttr.isCloseSystemSpeaker_b = false
        else
            GameState.storeAttr.isCloseSystemSpeaker_b = true
        end
    end
    Functions.bindCheckBoxListener({ target = self._notiveSetBt_t, listener = onSpeakCheckBox})
    
end
--@auto code output func end

return GameSetPopView