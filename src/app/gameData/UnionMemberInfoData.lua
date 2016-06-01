local BaseModel = require("app.baseMVC.BaseModel")

local UnionMemberInfoData = class("UnionMemberInfoData", BaseModel)

UnionMemberInfoData.debug = false

--当前所在公会信息
UnionMemberInfoData.info = {}

UnionMemberInfoData.eventAttr.m_id = 0              --成员id
UnionMemberInfoData.eventAttr.m_worship_times = 0   --膜拜次数                      
UnionMemberInfoData.eventAttr.m_copytimes = 0       --副本次数
UnionMemberInfoData.eventAttr.m_vip_level = 0       --vip等级
UnionMemberInfoData.eventAttr.m_activity = 0        --活跃
UnionMemberInfoData.eventAttr.m_pic = 0             --人物头像
UnionMemberInfoData.eventAttr.m_member_type= 0      --成员职位（1会员、2长老、3会长）
UnionMemberInfoData.eventAttr.m_status = 0          --状态（1在线，2离线）
UnionMemberInfoData.eventAttr.m_level = 0           --人物等级
UnionMemberInfoData.eventAttr.m_logout_time = 0     --最后上线时间
UnionMemberInfoData.eventAttr.m_name = 0            --名字



function UnionMemberInfoData:ctor()
	self:init()
end


function UnionMemberInfoData:init()
    self.super.init(self)

    --注册网络监听，游戏开始初始化数据
    --游戏玩家数据初始化命令：idx ＝ { 2, 2 }

end

--接收成员信息
function UnionMemberInfoData:sendMembers()

--    local onMemberInfo = function(event)
--        if  event.reqtype == 19 then
--            if event.ret == 1 then
--                UnionData:clearUnionMemberInfo()
--                local data = event.data
--                for k, v in pairs(data) do
--                    local memberInfo = require("app.ui.unionSystem.MemberModel").new()
--                    
--                    memberInfo.m_id = v.id              --成员id
--                    memberInfo.eventAttr.m_worship_times = v.worship_times   --膜拜次数                      
--                    memberInfo.m_copytimes = v.copytimes       --
--                    memberInfo.m_vip_level = v.vip_level         --vip等级
--                    memberInfo.m_activity = v.activity        --活跃
--                    memberInfo.m_pic = v.pic             --人物头像
--                    memberInfo.eventAttr.m_member_type= v.member_type      --成员职位（1会员、2长老、3会长）
--                    memberInfo.m_status = v.status          --公告
--                    memberInfo.m_level = v.level           --人物等级
--                    memberInfo.m_logout_time = v.logout_time     --最后上线时间
--                    memberInfo.m_name = v.name            --名字
--                    UnionData:addUnionMemberInfoData(memberInfo)
--                end
--            else
--                --弹出报错信息
--                PromptManager:openTipPrompt(g_csErrorString[event.ret])
--            end
--            return true
--        end
--    end
--    NetWork:addNetWorkListener({ 7, 1 }, onMemberInfo)
--    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 19 })
end

return UnionMemberInfoData