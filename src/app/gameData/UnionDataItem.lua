local BaseModel = require("app.baseMVC.BaseModel")

local UnionListData = class("UnionListData", BaseModel)

UnionListData.debug = false

--公会列表
UnionListData.eventAttr = {}

UnionListData.eventAttr.m_id = 0            --公会列表id
UnionListData.eventAttr.m_member_count = 0  --公会人数                      
UnionListData.eventAttr.m_join_level = 0    --加入等级
UnionListData.eventAttr.m_pic = 0           --公会图标
UnionListData.eventAttr.m_activity = 0      --活跃
UnionListData.eventAttr.m_join_type = 0     --加入类型
UnionListData.eventAttr.s_name = 0          --名字
UnionListData.eventAttr.s_notice = 0        --公告


function UnionListData:ctor()
	self:init()
end


function UnionListData:init()
    self.super.init(self)

    --注册网络监听，游戏开始初始化数据
    --游戏玩家数据初始化命令：idx ＝ { 2, 2 }

end

return UnionListData