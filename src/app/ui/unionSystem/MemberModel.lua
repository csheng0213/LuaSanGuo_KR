local BaseModel = require("app.baseMVC.BaseModel")

local MemberModel = class("MemberModel", BaseModel)

MemberModel.debug = false

--事件属性
MemberModel.eventAttr = {}
MemberModel.eventAttr.m_worship_times = 0     --膜拜次数  
MemberModel.eventAttr.m_member_type = 0         --成员职位（1会员、2长老、3会长）

--事件名称
MemberModel.HERO_SELECT_EVENT = "MEMBER_SELECT_EVENT"


function MemberModel:ctor()

    --parent init
    self:init()

end

function MemberModel:init()
    self.super.init(self)
end

function MemberModel:JobChange()
    self:dispatchEvent({ name = MemberModel.MEMBER_SELECT_EVENT })
end


return MemberModel