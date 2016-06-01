--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local NaverLoginViewController = class("NaverLoginViewController", BaseViewController)

local Functions = require("app.common.Functions")

NaverLoginViewController.debug = true
NaverLoginViewController.modulePath = ...
NaverLoginViewController.studioSpriteFrames = {"NaverLoginUI","CB_loginBg" }
--@auto code head end

--@Pre loading
NaverLoginViewController.spriteFrameNames = 
    {
    }

NaverLoginViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #NaverLoginViewController.studioSpriteFrames > 0 then
    NaverLoginViewController.spriteFrameNames = NaverLoginViewController.spriteFrameNames or {}
    table.insertto(NaverLoginViewController.spriteFrameNames, NaverLoginViewController.studioSpriteFrames)
end
function NaverLoginViewController:onDidLoadView()

    --output list
    self._npc_t = self.view_t.csbNode:getChildByName("main"):getChildByName("npc")
	
    --label list
    
    --button list
    self._loginBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("loginPanle"):getChildByName("loginBt")
	self._loginBt_t:onTouch(Functions.createClickListener(handler(self, self.onLoginbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Loginbt btFunc
function NaverLoginViewController:onLoginbtClick()
    Functions.printInfo(self.debug,"Loginbt button is click!")
    Functions.callJavaFuc(function()
        NativeUtil:sdkLogin()
    end)    
end
--@auto code Loginbt btFunc end

--@auto button backcall end


--@auto code view display func
function NaverLoginViewController:onCreate()
    Functions.printInfo(self.debug_b," NaverLoginViewController controller create!")
end
function NaverLoginViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
function NaverLoginViewController:onDisplayView()
    Functions.printInfo(self.debug_b," NaverLoginViewController view enter display!")

    Functions.loadImageWithSprite(self._npc_t, GameState.storeAttr.LoadingNpcImage_s)
end
--@auto code view display func end

return NaverLoginViewController