local BaseModel = require("app.baseMVC.BaseModel")
local sharedScheduler = require("app.common.scheduler")

local MailData = class("MailData", BaseModel)

MailData.debug = false

MailData.MAIL_CHECKED = "MAIL_CHECKED"
MailData.MAIL_GET = "MAIL_GET"

--事件属性
MailData.eventAttr = {}
MailData.eventAttr.mailBZ = 0



function MailData:init()
    self.super.init(self)

    --邮件全局主数据
    self.mailDatas = {}
    
    --self.isRefreshing = false

    local onMail = function(event)
        local data = event.data
        MailData.eventAttr.mailBZ = data.mail
        --self.isRefreshing = false
    end

    --Functions.bindNetWorkListener(self, { 6, 4 }, Functions.createNetworkListener(onChaDui, false, "ret"))
    NetWork:addNetWorkListener({ 6, 4 }, onMail)
    
end

--刷新邮件标志
function MailData:openRefreshMail()


--    local refreshMail = function()
--        if not self.isRefreshing then
--            self.isRefreshing = true
--            NetWork:sendToServerAsny({ idx = { 6, 4 } })
--        end
--    end
--    self.mailRefreshHandler = sharedScheduler.scheduleGlobal(refreshMail, 5)
end

function MailData:closeRefreshMail()
    sharedScheduler.unscheduleGlobal(self.mailRefreshHandler)
end

--清空邮件数据
function MailData:clear()
    self.mailDatas = {}
end
--邮件数据存放
function MailData:addMailDataItem(dataItem)
	self.mailDatas[#self.mailDatas+1] = dataItem
end
--排序
function MailData:sort()
    local data = self.mailDatas

    local comp = function(left, right)
--        if right.eventAttr.m_checked > left.eventAttr.m_checked then 
--           return true
--        elseif right.eventAttr.m_checked == left.eventAttr.m_checked then
            if right.eventAttr.m_stime < left.eventAttr.m_stime then 
                return true
            else
                return false
            end
--        else
--            return false
--        end

--        return false
    end
    print("sfs")
    table.sort(self.mailDatas, comp)

end

--获取主数据
function MailData:getMailDatas()
	return self.mailDatas
end


----刷新邮件标志
--function MailData:refreshMail()
--    --查询邮件
--    local onMail = function(event)
--        local data = event.data
--        if data.mail == 1 then
--            self.eventAttr.mailBZ = true
--        else
--            self.eventAttr.mailBZ = false
--        end
--    end
--
--    Functions.bindNetWorkListener(self, { 6, 4 }, Functions.createNetworkListener(onChaDui, false, "ret"))
--end

return MailData