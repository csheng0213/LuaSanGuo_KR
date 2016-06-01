--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local ExpTransferViewController = class("ExpTransferViewController", BaseViewController)

local Functions = require("app.common.Functions")

ExpTransferViewController.debug = true
ExpTransferViewController.modulePath = ...
ExpTransferViewController.studioSpriteFrames = {"CB_blackbg","EnhanceUI_Text","ExpTransferUI" }
--@auto code head end

--@Pre loading
ExpTransferViewController.spriteFrameNames = 
    {
    }

ExpTransferViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #ExpTransferViewController.studioSpriteFrames > 0 then
    ExpTransferViewController.spriteFrameNames = ExpTransferViewController.spriteFrameNames or {}
    table.insertto(ExpTransferViewController.spriteFrameNames, ExpTransferViewController.studioSpriteFrames)
end
function ExpTransferViewController:onDidLoadView()

    --output list
    self._resNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("resNode")
	
    --label list
    
    --button list
    self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

	self._Button_Rule_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_Rule")
	self._Button_Rule_t:onTouch(Functions.createClickListener(handler(self, self.onButton_ruleClick), "zoom"))

	self._Button_zhuanyi_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Button_zhuanyi_1")
	self._Button_zhuanyi_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_zhuanyi_1Click), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function ExpTransferViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
    GameCtlManager:pop(self)
end
--@auto code Button_back btFunc end

--@auto code Button_zhuanyi_1 btFunc
function ExpTransferViewController:onButton_zhuanyi_1Click()
    Functions.printInfo(self.debug,"Button_zhuanyi_1 button is click!")
    self:openChildView("app.ui.popViews.ExpTransferPopView", {isRemove = false})
end
--@auto code Button_zhuanyi_1 btFunc end

--@auto code Button_rule btFunc
function ExpTransferViewController:onButton_ruleClick()
    Functions.printInfo(self.debug,"Button_rule button is click!")
    NoticeManager:openNotice(self, {type = NoticeManager.EXP_INFO})
end
--@auto code Button_rule btFunc end

--@auto button backcall end


--@auto code view display func
function ExpTransferViewController:onCreate()
    Functions.printInfo(self.debug_b," ExpTransferViewController controller create!")
end

function ExpTransferViewController:onDisplayView()
	Functions.printInfo(self.debug_b," ExpTransferViewController view enter display!")
	
    --钱币显示
    Functions.initResNodeUI(self._resNode_t,{ "jinbi" , "yuanbao", "soul" })
end
--@auto code view display func end

--接受pop数据
--{data = {jumpType = self.jumpType,jumpData = {heroType = self.jumpData.heroType,heroMark = self.heroMark }}}
function ExpTransferViewController:onReceivePopData(datas)
    if datas == nil then
	   return
    end

    --数据更新监听
    GameEventCenter:dispatchEvent({ name = ExpTransferData.EXP_HERO , data = datas })
end


return ExpTransferViewController