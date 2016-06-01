--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local MailOnePopView = class("MailOnePopView", BasePopView)

local Functions = require("app.common.Functions")

MailOnePopView.csbResPath = "lk/csb"
MailOnePopView.debug = true
MailOnePopView.studioSpriteFrames = {"MailOnePopUI","MailOnePopUI_Text" }
--@auto code head end

local MailData = require("app.gameData.MailData")

--@Pre loading
MailOnePopView.spriteFrameNames = 
    {
    }

MailOnePopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #MailOnePopView.studioSpriteFrames > 0 then
    MailOnePopView.spriteFrameNames = MailOnePopView.spriteFrameNames or {}
    table.insertto(MailOnePopView.spriteFrameNames, MailOnePopView.studioSpriteFrames)
end
function MailOnePopView:onInitUI()

    --output list
    self._ListView_mail_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_mail_bg"):getChildByName("ListView_mail")
	self._Image_get_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_mail_bg"):getChildByName("ListView_mail"):getChildByName("model"):getChildByName("Button_mail_ban"):getChildByName("Image_get")
	self._Image_name_sender_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_mail_bg"):getChildByName("ListView_mail"):getChildByName("model"):getChildByName("Button_mail_ban"):getChildByName("Image_name_sender")
	
    --label list
    
    --button list
    self._Button_close_t = self.csbNode:getChildByName("Button_close")
	self._Button_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Panel_mail_template btFunc
function MailOnePopView:onPanel_mail_templateClick()
    Functions.printInfo(self.debug,"Panel_mail_template button is click!")
    --打开二级界面
    local setView = require("app.ui.popViews.MailTwoPopView"):new()
    self._controller_t:openChildView(setView)
    
end
--@auto code Panel_mail_template btFunc end

--@auto code Model btFunc
function MailOnePopView:onModelClick()
    Functions.printInfo(self.debug,"Model button is click!")
end
--@auto code Model btFunc end

--@auto code Button_close btFunc
function MailOnePopView:onButton_closeClick()
    Functions.printInfo(self.debug,"Button_close button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_close btFunc end

--@auto button backcall end


--@auto code output func
function MailOnePopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end
--绘制ui
function MailOnePopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    self._ListView_mail_t:setVisible(false)
	
	MailData:clear()
	self:sendCheckMail()
	
	--MailData:sort()
end
--创建界面
function MailOnePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function MailOnePopView:sendCheckMail()
    Functions.printInfo(self.debug," MailOnePopView view enter sendCheckMail!")
    --查询邮件
    local onCheckMail = function(event)
        local data = event.data
        for k, v in pairs(data) do
            local mailData = Factory:createMailDataItem()
            mailData.eventAttr.m_MailIdx = k   --邮件索引
            mailData.eventAttr.m_mtype = v.mtype --邮件类型(0:没有邮件。1:信息邮件。2:物品邮件。)
            mailData.eventAttr.m_checked = v.checked --查看
            mailData.eventAttr.m_fetched = v.fetched --取出道具(0--没领取。1--已领取)
            mailData.eventAttr.m_stime = v.stime --发送的时间
            mailData.eventAttr.m_sender = v.sender --寄件人
            mailData.eventAttr.s_sendername = v.sendername
            mailData.eventAttr.s_mailname = v.mailname
            mailData.eventAttr.s_msg = v.msg
            mailData.eventAttr.m_item = v.item --邮件道具
            MailData:addMailDataItem(mailData)
        end
        MailData:sort()
        self:showRefresh()
    end
    
    NetWork:addNetWorkListener({ 10, 2 }, Functions.createNetworkListener(onCheckMail,true,"ret"))
    NetWork:sendToServer({ idx = { 10, 2 }, reqtype = 1 })
    
    --监听函数
    local onChecked = function(event)
        self:showRefresh()
    end
    Functions.bindEventListener(self, GameEventCenter, MailData.MAIL_CHECKED, onChecked)
    
    --监听函数
    local onGet = function(event)
        self:showRefresh()
    end
    Functions.bindEventListener(self, GameEventCenter, MailData.MAIL_GET, onGet)

end

--整合道具数量
function MailOnePopView:mergeData(data)
    Functions.printInfo(self.debug," MailOnePopView view enter mergData!")

    local item = data.eventAttr.m_item
    local itemData = {}
    for k, v in pairs(item) do
         
        if #itemData == 0 then
            itemData[#itemData + 1] = v
        else
            for q, w in pairs(itemData) do
                if w.id == v.id and w.id < 0 then
                    w.count = v.count + w.count
                    break
            	end
                if q == #itemData then
                    itemData[#itemData + 1] = v
                    break
            	end
            end
        end
    end
    --只修改道具
    data.eventAttr.m_item = itemData
    return data
end

--绘制list
function MailOnePopView:showRefresh()
    Functions.printInfo(self.debug," MailOnePopView view enter showMailList!")
    --排序
    --MailData:sort()
    local listHandler = function(index, widget, data, model)

        local button = widget:getChildByName("Button_mail_ban")
        local banModel = model:getChildByName("Button_mail_ban")
        Functions.initTextColor(banModel:getChildByName("Text_mail_name"),button:getChildByName("Text_mail_name"))
        Functions.initTextColor(banModel:getChildByName("Text_mail_sender_name"),button:getChildByName("Text_mail_sender_name"))
        Functions.initTextColor(banModel:getChildByName("Text_mail_sender_time"),button:getChildByName("Text_mail_sender_time"))
        
        local onClick = function(event)
            print("button click")
            --打开二级界面
            local itemData = MailOnePopView:mergeData(data)
            self._controller_t:openChildView("app.ui.popViews.MailTwoPopView", { data = itemData })
        end
        button:onTouch(Functions.createClickListener(onClick, "zoom"))
        --绘制一级界面
        if data.eventAttr.m_checked == 1 then
            Functions.loadButtonImage(button, "lk/ui_res/MailOnePopUI/Mail_tiao.png")
        else
            Functions.loadButtonImage(button, "lk/ui_res/MailOnePopUI/Mail_tiao2.png")
        end


        if data.eventAttr.m_mtype == 2 then
            if data.eventAttr.m_fetched == 1 then
                button:getChildByName("Image_get"):setVisible(true)
            end
        end
        
        local time = TimerManager:formatTime("%Y-%m-%d %H:%M:%S", data.eventAttr.m_stime)
        
        Functions.initLabelOfString(button:getChildByName("Text_mail_name"), data.eventAttr.s_mailname,button:getChildByName("Text_mail_sender_name"),
            data.eventAttr.s_sendername, button:getChildByName("Text_mail_sender_time"), time)

    end
    --绑定响应事件函数
    Functions.bindListWithData(self._ListView_mail_t, MailData:getMailDatas(), listHandler)

end

return MailOnePopView