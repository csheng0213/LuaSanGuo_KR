local BaseModel = require("app.baseMVC.BaseModel")

local UnionData = class("UnionData", BaseModel)

UnionData.debug = false

--事件属性
UnionData.eventAttr = {}

UnionData.ADD_UNION_LIUYAN_EVENT = "ADD_UNION_LIUYAN_EVENT"
--公会选择图标的监听
UnionData.ADD_UNION_ICON_EVENT = "ADD_UNION_ICON_EVENT"
--公会更改图标的监听
UnionData.ADD_UNION_CHANGE_ICON_EVENT = "ADD_UNION_CHANGE_ICON_EVENT"

--公会职位改变的监听以及公会成员增加监听
UnionData.MEMBER_POSITION_EVENT = "MEMBER_POSITION_EVENT"

--公会公告的监听
UnionData.NOTICE_EVENT = "NOTICE_EVENT"

--公会FB的监听
UnionData.UNION_FB_EVENT = "UNION_FB_EVENT"

--UnionData.eventAttr.m_isNewMail = false

--事件属性
UnionData.eventAttr = {}
UnionData.eventAttr.m_activity = 0

function UnionData:init()
    self.super.init(self)

    --公会列表主数据
    self.unionListData = {}
    --当前所在公会信息
    self.unionInfo = {}
    --公会成员信息
    self.unionMemberInfo = {}
    --工会留言
    self.unionLiuYan = {}
    --公会申请列表
    self.applyList = {}
    --公会副本主数据
    self.unionFBDatas = {}
    --公会今日捐献
    self.DonateInfo = {}
    --公会历史捐献
    self.DonateAllInfo = {}
    
    local onSendMsg = function(event)
        --公会副本主数据
        self.unionFBDatas = {}
        --公会id
        PlayerData.eventAttr.m_tongID = event.id
        local msgList = event.data
        
        for k, v in pairs(msgList) do
            local info = {}
            info.m_id = k+6    --关卡ID
            info.progress = v.progress   --进度值(0到1之间的一个值)
            info.allpassed = v.allpassed --是否全部通关(0带表没通关,1代表通关)
            info.purchased = v.purchased --是否购买(0带表没购买,1代表购买)

            self.unionFBDatas[#self.unionFBDatas+1] = info
        end
        GameEventCenter:dispatchEvent({ name = UnionData.UNION_FB_EVENT, data = {} })
    end
    NetWork:addNetWorkListener({ 2, 18 }, onSendMsg)    

end

--公会捐献排名
function UnionData:sendDonateInfo(listener)
    local onUnionCreat = function(event)
        if event.reqtype == 35 then
            if event.ret == 1 then
            --guildActif    公会总资金
            --playerActif   个人总资金
            --allActif      当前公会个人捐献资金
            --countActif    捐献次数
            --name          名字
            --todayActif    今日捐献资金

                self.DonateInfo = {}
                self.DonateAllInfo = {}
                local data = event.data
                self.guildActif = data.guildActif
                self.playerActif = data.playerActif
                
                for k,v in pairs(data.numberlist) do
                    local info = {}
                    info.allActif = v.allActif
                    info.todayActif = v.todayActif
                    info.name = v.name
                    self.DonateInfo[#self.DonateInfo + 1] = info
                    self.DonateAllInfo[#self.DonateAllInfo + 1] = info
                end
                local pppp = self.DonateInfo
                local ooo = self.DonateAllInfo
                
                
                self:sortDonateInfo()
                self:sortDonateAllInfo()
                
                local ppppp = self.DonateInfo
                local ooooo = self.DonateAllInfo
                
                listener()
            else
                --弹出报错信息
                PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
            end
            return true
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, onUnionCreat)
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 35 })
end

--公会捐献当天排名排序
function UnionData:sortDonateInfo()

    local comp = function(left, rigth)
        if left.todayActif > rigth.todayActif then
    		return true
        elseif left.todayActif < rigth.todayActif then
            return false
    	end
    end
    table.sort(self.DonateInfo,comp)
end

--公会捐献历史排名排序
function UnionData:sortDonateAllInfo()

    local comp = function(left, rigth)
        if left.allActif > rigth.allActif then
            return true
        elseif left.allActif < rigth.allActif then
            return false
        end
    end
    table.sort(self.DonateAllInfo, comp)
end

--公会捐献金额
function UnionData:sendDonateNum(type, typeNum, listener)
    local onUnionCreat = function(event)
        if event.reqtype == 36 then
            if event.ret == 1 then
                local data = event.data
                PlayerData.eventAttr.m_gold = data.gold
                PlayerData.eventAttr.m_money = data.money
                
                self:sendDonateInfo(listener)
                --弹出报错信息
                PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
            else
                --弹出报错信息
                PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
            end
            return true
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, onUnionCreat)
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 36,  data = {type = type, typeNum = typeNum}})
end

--公会捐献当天排名排序
function UnionData:getDonateInfo()
    return self.DonateInfo
end

--公会捐献历史排名排序
function UnionData:getDonateAllInfo()
    return self.DonateAllInfo
end

--公会资金
function UnionData:getguildActif()
    return self.guildActif
end

--个人资金
function UnionData:getplayerActif()
    return self.playerActif
end

--清空数据
function UnionData:clearUnionFBInfo()
    self.unionFBDatas = {}
end

--获得数据
function UnionData:getUnionFBInfo()
    return self.unionFBDatas
end

--清空数据
function UnionData:clearUnionInfo()
    self.unionInfo = {}
end
--清空数据
function UnionData:clearUnionList()
    self.unionListData = {}
end
--清空成员数据
function UnionData:clearUnionMemberInfo()
    self.unionMemberInfo = {}
end

--清空申请数据
function UnionData:clearApplyList()
    self.applyList = {}
end

--当前所在公会数据存放
function UnionData:addUnionInfoData(data)
    self.unionInfo[#self.unionInfo+1] = data
end
--公会列表数据存放
function UnionData:addUnionListData(data)
    self.unionListData[#self.unionListData+1] = data
end

--公会成员数据存放
function UnionData:addUnionMemberInfoData(data)
    self.unionMemberInfo[#self.unionMemberInfo+1] = data
    self:getMemberSort()
end

--公会申请成员数据存放
function UnionData:addApplyListData(data)
    self.applyList[#self.applyList+1] = data
end
--排序
function UnionData:sort()
	
end
--获取当前所在公会主数据
function UnionData:getUnionInfoData()
    return self.unionInfo
end
--获取列表主数据
function UnionData:getUnionListData()
    return self.unionListData
end

--获取申请成员主数据
function UnionData:getApplyListData()
    return self.applyList
end

--获取成员信息
function UnionData:getMemberInfoData()
    return self.unionMemberInfo
end

--删除一条成员信息
function UnionData:subMemberInfoData(id)
    local data = self.unionMemberInfo
    for k, v in pairs(data) do
    	if id == v.m_id then
    		table.remove(data,k)
    		break
    	end
    end
end

--添加工会留言
function UnionData:addUnionLiuYan(data)
	self.unionLiuYan[#self.unionLiuYan + 1] = data
    GameEventCenter:dispatchEvent({ name = UnionData.ADD_UNION_LIUYAN_EVENT, data = data })
end

--获取工会ID
function UnionData:isHaveTong()
    if PlayerData.eventAttr.m_tongID <= 0 then
        return false
    else
        return true
    end
end

--获取章节副本开启状态
function UnionData:isTeamFBOff(id)
    local fbInfo = self.unionFBDatas
    for k, v in pairs(fbInfo)  do
        if id == v.m_id then
    		if v.purchased == 1 then
    			return true
    		else
    		    return false
    		end
    	end
    end
end

--成员信息排序
function UnionData:getMemberSort()
    local comp = function(left , right)
        if left.eventAttr.m_member_type > right.eventAttr.m_member_type then
            return true
        elseif left.eventAttr.m_member_type < right.eventAttr.m_member_type then
            return false
        end
        if left.m_level > right.m_level then
            return true
        elseif left.m_level < right.m_level then
            return false
        end
    end

    table.sort(self.unionMemberInfo, comp)
    return self.unionMemberInfo
end

--成员活跃排序
function UnionData:getActivitySort()
    local comp = function(left , right)
    
        if left.eventAttr.m_member_type > right.eventAttr.m_member_type then
            return true
        elseif left.eventAttr.m_member_type < right.eventAttr.m_member_type then
            return false
        end

        if left.m_activity > right.m_activity then
            return true
        elseif left.m_activity < right.m_activity then
            return false
        end
        if left.m_level > right.m_level then
            return true
        elseif left.m_level < right.m_level then
            return false
        end
    end

    table.sort(self.unionMemberInfo, comp)
    --return self.unionMemberInfo
end

--成员最后上线时间排序
function UnionData:getMemberTimeSort()
    local comp = function(left , right)
        if left.eventAttr.m_member_type > right.eventAttr.m_member_type then
            return true
        elseif left.eventAttr.m_member_type < right.eventAttr.m_member_type then
            return false
        end
        
        if left.m_logout_time > right.m_logout_time then
            return true
        elseif left.m_logout_time < right.m_logout_time then
            return false
        end
        if left.m_level > right.m_level then
            return true
        elseif left.m_level < right.m_level then
            return false
        end
    end

    table.sort(self.unionMemberInfo, comp)
    --return self.unionMemberInfo
end

--成员副本挑战次数排序
function UnionData:getMemberFBSort()
    local comp = function(left , right)
        if left.eventAttr.m_member_type > right.eventAttr.m_member_type then
            return true
        elseif left.eventAttr.m_member_type < right.eventAttr.m_member_type then
            return false
        end
        
        if left.m_copytimes > right.m_copytimes then
            return true
        elseif left.m_copytimes < right.m_copytimes then
            return false
        end
        if left.m_level > right.m_level then
            return true
        elseif left.m_level < right.m_level then
            return false
        end
    end

    table.sort(self.unionMemberInfo, comp)
    --return self.unionMemberInfo
end

return UnionData