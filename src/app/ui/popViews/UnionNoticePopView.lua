--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionNoticePopView = class("UnionNoticePopView", BasePopView)

local Functions = require("app.common.Functions")

UnionNoticePopView.csbResPath = "lk/csb"
UnionNoticePopView.debug = true
UnionNoticePopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","UnionUI","CBO_union_dialogue_ban" }
--@auto code head end
--@Pre loading
UnionNoticePopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionNoticePopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #UnionNoticePopView.studioSpriteFrames > 0 then
    UnionNoticePopView.spriteFrameNames = UnionNoticePopView.spriteFrameNames or {}
    table.insertto(UnionNoticePopView.spriteFrameNames, UnionNoticePopView.studioSpriteFrames)
end
function UnionNoticePopView:onInitUI()

    --output list
    self._TextField_Notice_t = self.csbNode:getChildByName("Panel_Notice_5"):getChildByName("TextField_Notice")
	
    --label list
    
    --button list
    self._Button_notice_ok_t = self.csbNode:getChildByName("Panel_Notice_5"):getChildByName("Button_notice_ok")
	self._Button_notice_ok_t:onTouch(Functions.createClickListener(handler(self, self.onButton_notice_okClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_notice_ok btFunc
function UnionNoticePopView:onButton_notice_okClick()
    Functions.printInfo(self.debug,"Button_notice_ok button is click!")
    -- 修改公告
    self:sendNotice()
    
end
--@auto code Button_notice_ok btFunc end

--@auto button backcall end


--@auto code output func
function UnionNoticePopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionNoticePopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    self._TextField_Notice_t:setPlaceHolder(LanguageConfig.ui_Union_35)
end

function UnionNoticePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
-- 修改公告
function UnionNoticePopView:sendNotice()
    Functions.printInfo(self.debug,"sendNotice")
    local onSendNotice = function(event)
        if event.reqtype == 11 then
            local data = UnionData:getUnionInfoData()
            data[1].eventAttr.s_notice = self._TextField_Notice_t:getString()
            GameEventCenter:dispatchEvent({ name = UnionData.NOTICE_EVENT, data = {} })
            self._controller_t:closeChildView(self)
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onSendNotice,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 11, data = { notice = self._TextField_Notice_t:getString() } })
end

return UnionNoticePopView