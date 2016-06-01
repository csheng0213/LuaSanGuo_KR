--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionButFunctionPopView = class("UnionButFunctionPopView", BasePopView)

local Functions = require("app.common.Functions")

UnionButFunctionPopView.csbResPath = "lk/csb"
UnionButFunctionPopView.debug = true
UnionButFunctionPopView.studioSpriteFrames = {"UnionUI_Text","CBO_unionBgTwo","UnionUI" }
--@auto code head end

--@Pre loading
UnionButFunctionPopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionButFunctionPopView.animaNames = 
    {
    }
--@auto code uiInit
--add spriteFrames
if #UnionButFunctionPopView.studioSpriteFrames > 0 then
    UnionButFunctionPopView.spriteFrameNames = UnionButFunctionPopView.spriteFrameNames or {}
    table.insertto(UnionButFunctionPopView.spriteFrameNames, UnionButFunctionPopView.studioSpriteFrames)
end
function UnionButFunctionPopView:onInitUI()

    --output list
    
    --label list
    
    --button list
    self._Button_but_function_1_t = self.csbNode:getChildByName("Panel_but_function_10"):getChildByName("Button_but_function_1")
	self._Button_but_function_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_but_function_1Click), "zoom"))

	self._Button_but_function_2_t = self.csbNode:getChildByName("Panel_but_function_10"):getChildByName("Button_but_function_2")
	self._Button_but_function_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_but_function_2Click), "zoom"))

	self._Button_but_function_3_t = self.csbNode:getChildByName("Panel_but_function_10"):getChildByName("Button_but_function_3")
	self._Button_but_function_3_t:onTouch(Functions.createClickListener(handler(self, self.onButton_but_function_3Click), "zoom"))

	self._Button_but_function_4_t = self.csbNode:getChildByName("Panel_but_function_10"):getChildByName("Button_but_function_4")
	self._Button_but_function_4_t:onTouch(Functions.createClickListener(handler(self, self.onButton_but_function_4Click), "zoom"))

	self._Button_but_function_5_t = self.csbNode:getChildByName("Panel_but_function_10"):getChildByName("Button_but_function_5")
	self._Button_but_function_5_t:onTouch(Functions.createClickListener(handler(self, self.onButton_but_function_5Click), "zoom"))

	self._Button_but_function_6_t = self.csbNode:getChildByName("Panel_but_function_10"):getChildByName("Button_but_function_6")
	self._Button_but_function_6_t:onTouch(Functions.createClickListener(handler(self, self.onButton_but_function_6Click), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_but_function_1 btFunc
function UnionButFunctionPopView:onButton_but_function_1Click()
    Functions.printInfo(self.debug,"Button_but_function_1 button is click!")
    --入会申请
    self._controller_t:openChildView("app.ui.popViews.UnionApplyPopView", {isRemove = false})
end
--@auto code Button_but_function_1 btFunc end

--@auto code Button_but_function_2 btFunc
function UnionButFunctionPopView:onButton_but_function_2Click()
    Functions.printInfo(self.debug,"Button_but_function_2 button is click!")
    --成员管理
    self._controller_t:openChildView("app.ui.popViews.UnionMembersPopView", {isRemove = false})
end
--@auto code Button_but_function_2 btFunc end

--@auto code Button_but_function_3 btFunc
function UnionButFunctionPopView:onButton_but_function_3Click()
    Functions.printInfo(self.debug,"Button_but_function_3 button is click!")
    --修改公告
    self._controller_t:openChildView("app.ui.popViews.UnionNoticePopView")
end
--@auto code Button_but_function_3 btFunc end

--@auto code Button_but_function_4 btFunc
function UnionButFunctionPopView:onButton_but_function_4Click()
    Functions.printInfo(self.debug,"Button_but_function_4 button is click!")
    --公会设置
    self._controller_t:openChildView("app.ui.popViews.UnionSetPopView", {isRemove = false})
end
--@auto code Button_but_function_4 btFunc end

--@auto code Button_but_function_5 btFunc
function UnionButFunctionPopView:onButton_but_function_5Click()
    Functions.printInfo(self.debug,"Button_but_function_5 button is click!")
    --全员邮件
    self._controller_t:openChildView("app.ui.popViews.UnionMailPopView")
end
--@auto code Button_but_function_5 btFunc end

--@auto code Button_but_function_6 btFunc
function UnionButFunctionPopView:onButton_but_function_6Click()
    Functions.printInfo(self.debug,"Button_but_function_6 button is click!")
    
    --弹出框
    NoticeManager:openTips(self:getController(), { handler = handler(self,self.Prompt), title = LanguageConfig.language_Union_34})
    
end
--@auto code Button_but_function_6 btFunc end

--@auto button backcall end


--@auto code output func
function UnionButFunctionPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionButFunctionPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
end

function UnionButFunctionPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function UnionButFunctionPopView:Prompt()
    Functions.printInfo(self.debug,"Prompt")
    
    local onServerPokedex = function(event)
        if event.reqtype == 7 then
            --公会ID置为0
            PlayerData.eventAttr.m_tongID = 0
            GameCtlManager:popToRoot()
        end
    end
    NetWork:addNetWorkListener({7,1}, Functions.createNetworkListener(onServerPokedex,true,"ret"))
    local msg = {idx = {7,1}, reqtype = 7}
    NetWork:sendToServer(msg)
end

return UnionButFunctionPopView