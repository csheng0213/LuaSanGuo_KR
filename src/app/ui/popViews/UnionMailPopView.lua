--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionMailPopView = class("UnionMailPopView", BasePopView)

local Functions = require("app.common.Functions")

UnionMailPopView.csbResPath = "lk/csb"
UnionMailPopView.debug = true
UnionMailPopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","CBO_union_dialogue_ban" }
--@auto code head end
--@Pre loading
UnionMailPopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionMailPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #UnionMailPopView.studioSpriteFrames > 0 then
    UnionMailPopView.spriteFrameNames = UnionMailPopView.spriteFrameNames or {}
    table.insertto(UnionMailPopView.spriteFrameNames, UnionMailPopView.studioSpriteFrames)
end
function UnionMailPopView:onInitUI()

    --output list
    self._TextField_mail_1_t = self.csbNode:getChildByName("Panel_mail_9"):getChildByName("TextField_mail_1")
	self._TextField_mail_2_t = self.csbNode:getChildByName("Panel_mail_9"):getChildByName("TextField_mail_2")
	
    --label list
    
    --button list
    self._Button_mail_ok_t = self.csbNode:getChildByName("Panel_mail_9"):getChildByName("Button_mail_ok")
	self._Button_mail_ok_t:onTouch(Functions.createClickListener(handler(self, self.onButton_mail_okClick), "zoom"))

	self._Button_mail_no_t = self.csbNode:getChildByName("Panel_mail_9"):getChildByName("Button_mail_no")
	self._Button_mail_no_t:onTouch(Functions.createClickListener(handler(self, self.onButton_mail_noClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_mail_ok btFunc
function UnionMailPopView:onButton_mail_okClick()
    Functions.printInfo(self.debug,"Button_mail_ok button is click!")
    --发送邮件
    self:sendMail()
end
--@auto code Button_mail_ok btFunc end

--@auto code Button_mail_no btFunc
function UnionMailPopView:onButton_mail_noClick()
    Functions.printInfo(self.debug,"Button_mail_no button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_mail_no btFunc end

--@auto button backcall end


--@auto code output func
function UnionMailPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionMailPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    self._TextField_mail_1_t:setPlaceHolder(LanguageConfig.ui_Union_33)
    self._TextField_mail_2_t:setPlaceHolder(LanguageConfig.ui_Union_34)
end

function UnionMailPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

-- 发送邮件
function UnionMailPopView:sendMail()
    Functions.printInfo(self.debug,"sendMail")
    local onSendMail = function(event)
        if event.reqtype == 9 then
            --弹出报错信息
            ConfigHandler:getServerErrorCode(event.ret)
            --PromptManager:openTipPrompt(g_csErrorString[event.ret])
            self._controller_t:closeChildView(self)
        end
    end
    local mail1 = self._TextField_mail_1_t:getString()
    local mail2 = self._TextField_mail_2_t:getString()
    
    if mail1 and mail2 then
        NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onSendMail,true,"ret"))
        NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 9, data = { title = mail1, content = mail2} })
    end

end

return UnionMailPopView