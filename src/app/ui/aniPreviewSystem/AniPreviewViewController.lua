--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local AniPreviewViewController = class("AniPreviewViewController", BaseViewController)

local Functions = require("app.common.Functions")

AniPreviewViewController.debug = true
AniPreviewViewController.modulePath = ...
--@auto code head end

--@Pre loading
AniPreviewViewController.spriteFrameNames = 
    {
    }

AniPreviewViewController.animaNames = 
    {
    }


--@auto code uiInit
function AniPreviewViewController:onDidLoadView()

    --output list
    self._coinText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("bbg1"):getChildByName("coinText")
	self._goldText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("bbg2_7"):getChildByName("goldText")
	self._soulText_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("bbg3_9"):getChildByName("soulText")
	self._aniListView_t = self.view_t.csbNode:getChildByName("main"):getChildByName("aniListView")
	self._aniNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("aniNode")
	self._slider_t = self.view_t.csbNode:getChildByName("main"):getChildByName("slider")
	self._rate_t = self.view_t.csbNode:getChildByName("main"):getChildByName("rate")
	
    --label list
    
    --button list
    self._backBt_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("backBt_2")
	self._backBt_2_t:onTouch(Functions.createClickListener(handler(self, self.onBackbt_2Click), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt_2 btFunc
function AniPreviewViewController:onBackbt_2Click()
    Functions.printInfo(self.debug,"Backbt_2 button is click!")
end
--@auto code Backbt_2 btFunc end

--@auto button backcall end


--@auto code view display func
function AniPreviewViewController:onCreate()
    Functions.printInfo(self.debug_b," AniPreviewViewController controller create!")
end

function AniPreviewViewController:onDisplayView()
	Functions.printInfo(self.debug_b," AniPreviewViewController view enter display!")
end
--@auto code view display func end

return AniPreviewViewController