local BaseModel = require("app.baseMVC.BaseModel")

local UnionInfoData = class("UnionInfoData", BaseModel)

UnionInfoData.debug = false

--当前所在公会信息
UnionInfoData.info = {}

UnionInfoData.eventAttr.m_id = 0            --公会id
UnionInfoData.eventAttr.m_member_count = 0  --公会人数                      
UnionInfoData.eventAttr.m_join_level = 0    --加入等级
UnionInfoData.eventAttr.m_pic = 0           --公会图标
UnionInfoData.eventAttr.m_activity = 0      --活跃
UnionInfoData.eventAttr.m_join_type = 0     --加入类型
UnionInfoData.eventAttr.s_name = 0          --名字
UnionInfoData.eventAttr.s_notice = 0        --公告


function UnionInfoData:ctor()
	self:init()
end


function UnionInfoData:init()
    self.super.init(self)

    --注册网络监听，游戏开始初始化数据
    --游戏玩家数据初始化命令：idx ＝ { 2, 2 }

end

return UnionInfoData