local BaseModel = require("app.baseMVC.BaseModel")

local MailDataItem = class("MailDataItem", BaseModel)

MailDataItem.debug = false

--事件属性
MailDataItem.eventAttr = {}

MailDataItem.eventAttr.m_MailIdx = 0        --邮件索引
MailDataItem.eventAttr.m_mtype = 0          --邮件类型(0:没有邮件。1:信息邮件。2:物品邮件。)                        
MailDataItem.eventAttr.m_checked = 0        --查看
MailDataItem.eventAttr.m_fetched = 0        --取出道具(0--没领取。1--已领取)
MailDataItem.eventAttr.m_stime = 0          --发送的时间
MailDataItem.eventAttr.m_sender = 0         --寄件人
MailDataItem.eventAttr.s_sendername = 0     --寄件人姓名
MailDataItem.eventAttr.s_mailname = 0       --邮件名
MailDataItem.eventAttr.s_msg = 0            --邮件内容

MailDataItem.eventAttr.m_item = {}          --邮件里的道具信息

function MailDataItem:init()
    self.super.init(self)

    --注册网络监听，游戏开始初始化数据
    --游戏玩家数据初始化命令：idx ＝ { 2, 2 }

end

return MailDataItem