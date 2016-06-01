--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local GplayLoginViewController = class("GplayLoginViewController", BaseViewController)

local Functions = require("app.common.Functions")

GplayLoginViewController.debug = true
GplayLoginViewController.modulePath = ...
GplayLoginViewController.studioSpriteFrames = {"NaverLoginUI","CB_loginBg" }
--@auto code head end

--@Pre loading
GplayLoginViewController.spriteFrameNames = 
    {
    }

GplayLoginViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #GplayLoginViewController.studioSpriteFrames > 0 then
    GplayLoginViewController.spriteFrameNames = GplayLoginViewController.spriteFrameNames or {}
    table.insertto(GplayLoginViewController.spriteFrameNames, GplayLoginViewController.studioSpriteFrames)
end
function GplayLoginViewController:onDidLoadView()

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
function GplayLoginViewController:onLoginbtClick()
    Functions.printInfo(self.debug,"Loginbt button is click!")
    Functions.callJavaFuc(function()
        NativeUtil:sdkLogin()
    end)
end
--@auto code Loginbt btFunc end

--@auto button backcall end


--@auto code view display func
function GplayLoginViewController:onCreate()
    Functions.printInfo(self.debug_b," GplayLoginViewController controller create!")
end
function GplayLoginViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
function GplayLoginViewController:onDisplayView()
	Functions.printInfo(self.debug_b," GplayLoginViewController view enter display!")
     Functions.loadImageWithSprite(self._npc_t, GameState.storeAttr.LoadingNpcImage_s)
end
--@auto code view display func end

return GplayLoginViewController