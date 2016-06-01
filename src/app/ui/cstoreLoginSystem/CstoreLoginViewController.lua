--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local CstoreLoginViewController = class("CstoreLoginViewController", BaseViewController)

local Functions = require("app.common.Functions")

CstoreLoginViewController.debug = true
CstoreLoginViewController.modulePath = ...
CstoreLoginViewController.studioSpriteFrames = {"NaverLoginUI","CB_loginBg" }
--@auto code head end

--@Pre loading
CstoreLoginViewController.spriteFrameNames = 
    {
    }

CstoreLoginViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #CstoreLoginViewController.studioSpriteFrames > 0 then
    CstoreLoginViewController.spriteFrameNames = CstoreLoginViewController.spriteFrameNames or {}
    table.insertto(CstoreLoginViewController.spriteFrameNames, CstoreLoginViewController.studioSpriteFrames)
end
function CstoreLoginViewController:onDidLoadView()

    --output list
    self._npc_t = self.view_t.csbNode:getChildByName("main"):getChildByName("npc")
	
    --label list
    
    --button list
    self._loginBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("loginPanle"):getChildByName("loginBt")
	self._loginBt_t:onTouch(Functions.createClickListener(handler(self, self.onLoginbtClick), ""))

	self._cstoreLoginBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("loginPanle"):getChildByName("cstoreLoginBt")
	self._cstoreLoginBt_t:onTouch(Functions.createClickListener(handler(self, self.onCstoreloginbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Loginbt btFunc
function CstoreLoginViewController:onLoginbtClick()
    Functions.printInfo(self.debug,"Loginbt button is click!")
     Functions.callJavaFuc(function()
        NativeUtil:sdkLogin()
    end)
end
--@auto code Loginbt btFunc end

--@auto code Cstoreloginbt btFunc
function CstoreLoginViewController:onCstoreloginbtClick()
    Functions.printInfo(self.debug,"Cstoreloginbt button is click!")
     Functions.callJavaFuc(function()
        NativeUtil:sdkLogin_Cstore()
    end)
end
--@auto code Cstoreloginbt btFunc end

--@auto button backcall end


--@auto code view display func
function CstoreLoginViewController:onCreate()
    Functions.printInfo(self.debug_b," CstoreLoginViewController controller create!")
end

function CstoreLoginViewController:onDisplayView()
	Functions.printInfo(self.debug_b," CstoreLoginViewController view enter display!")
    Functions.loadImageWithSprite(self._npc_t, GameState.storeAttr.LoadingNpcImage_s)
end
--@auto code view display func end
function CstoreLoginViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
return CstoreLoginViewController