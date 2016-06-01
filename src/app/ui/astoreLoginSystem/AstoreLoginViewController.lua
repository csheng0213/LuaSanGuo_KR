--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local AstoreLoginViewController = class("AstoreLoginViewController", BaseViewController)

local Functions = require("app.common.Functions")

AstoreLoginViewController.debug = true
AstoreLoginViewController.modulePath = ...
AstoreLoginViewController.studioSpriteFrames = {"NaverLoginUI","CB_loginBg" }
--@auto code head end

--@Pre loading
AstoreLoginViewController.spriteFrameNames = 
    {
    }

AstoreLoginViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #AstoreLoginViewController.studioSpriteFrames > 0 then
    AstoreLoginViewController.spriteFrameNames = AstoreLoginViewController.spriteFrameNames or {}
    table.insertto(AstoreLoginViewController.spriteFrameNames, AstoreLoginViewController.studioSpriteFrames)
end
function AstoreLoginViewController:onDidLoadView()

    --output list
    self._npc_t = self.view_t.csbNode:getChildByName("main"):getChildByName("npc")
	
    --label list
    
    --button list
    self._astoreLoginBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("loginPanle"):getChildByName("astoreLoginBt")
	self._astoreLoginBt_t:onTouch(Functions.createClickListener(handler(self, self.onAstoreloginbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Loginbt btFunc
function AstoreLoginViewController:onLoginbtClick()
    Functions.printInfo(self.debug,"Loginbt button is click!")
    Functions.callJavaFuc(function()
        NativeUtil:sdkLogin()
    end) 
end
--@auto code Loginbt btFunc end

--@auto code Astoreloginbt btFunc
function AstoreLoginViewController:onAstoreloginbtClick()
    Functions.printInfo(self.debug,"Astoreloginbt button is click!")
     Functions.callJavaFuc(function()
        NativeUtil:GameCenterLogin()
    end) 
end
--@auto code Astoreloginbt btFunc end

--@auto button backcall end


--@auto code view display func
function AstoreLoginViewController:onCreate()
    Functions.printInfo(self.debug_b," AstoreLoginViewController controller create!")
end
function AstoreLoginViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
function AstoreLoginViewController:onDisplayView()
	Functions.printInfo(self.debug_b," AstoreLoginViewController view enter display!")
    Functions.loadImageWithSprite(self._npc_t, GameState.storeAttr.LoadingNpcImage_s)
end
--@auto code view display func end

return AstoreLoginViewController