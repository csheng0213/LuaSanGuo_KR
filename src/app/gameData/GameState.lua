local BaseModel = require("app.baseMVC.BaseModel")

local GameState = class("GameState", BaseModel)

GameState.debug = false

--本地保存属性
GameState.storeAttr = {}
GameState.storeAttr.soundState_b = false
GameState.storeAttr.musicState_b = false
GameState.storeAttr.userName_s = ""
GameState.storeAttr.password_s = ""
GameState.storeAttr.serverToken_s = ""
GameState.storeAttr.serverOldIndex_f = 0
GameState.storeAttr.isLoginNaver_b = false
GameState.storeAttr.NaverUserId_s = ""
GameState.storeAttr.NaverUserName_s = ""
GameState.storeAttr.advertisingId_s = ""
GameState.storeAttr.isConfirmEula_b = false
GameState.storeAttr.adbrixLevel2_b = false
GameState.storeAttr.adbrixLevel3_b = false
GameState.storeAttr.adbrixLevel4_b = false
GameState.storeAttr.adbrixLevel5_b = false
GameState.storeAttr.adbrixLevel6_b = false
GameState.storeAttr.LoadingNpcImage_s = ""
GameState.storeAttr.CurGameBgMusic_s = ""
GameState.storeAttr.CurGameLoginUrl_s = ""
GameState.storeAttr.CurGameUpdateUrl_s = ""
GameState.storeAttr.CurGameDownLoadUrl_s = ""
GameState.storeAttr.curNonce_s = ""
GameState.storeAttr.paymentSeq_s = ""
GameState.storeAttr.curProductCode_s = ""
GameState.storeAttr.forceUpdate_b = false
-- GameState.storeAttr.isExtractExpansionFile_b = false
GameState.storeAttr.isCloseSystemSpeaker_b = false

function GameState:init()
    self.super.init(self)
end

--四种登陆方式
-- defaultLogin NaverSdk CstoreLogin GplayLogin AstoreLogin
function GameState:getLoginType()
	local loginPlatformData= string.split(GameState.storeAttr.NaverUserId_s,"_")
    local loginName = ""
    if GameState.storeAttr.NaverUserId_s == "" then
        loginName = "defaultLogin"
    else
        loginName = loginPlatformData[1]
    end
    
    return loginName
end

return GameState

