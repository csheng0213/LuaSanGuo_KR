--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionApplyPopView = class("UnionApplyPopView", BasePopView)

local Functions = require("app.common.Functions")

UnionApplyPopView.csbResPath = "lk/csb"
UnionApplyPopView.debug = true
UnionApplyPopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","UnionUI" }
--@auto code head end
--@Pre loading
UnionApplyPopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionApplyPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #UnionApplyPopView.studioSpriteFrames > 0 then
    UnionApplyPopView.spriteFrameNames = UnionApplyPopView.spriteFrameNames or {}
    table.insertto(UnionApplyPopView.spriteFrameNames, UnionApplyPopView.studioSpriteFrames)
end
function UnionApplyPopView:onInitUI()

    --output list
    self._Text_union_cheng_yuan_num_t = self.csbNode:getChildByName("Panel_add_apply_6"):getChildByName("Text_union_cheng_yuan_num")
	self._ListView_apply_t = self.csbNode:getChildByName("Panel_add_apply_6"):getChildByName("ListView_apply")
	self._Image_apply_head_icon_t = self.csbNode:getChildByName("Panel_add_apply_6"):getChildByName("ListView_apply"):getChildByName("model"):getChildByName("Image_list_apply_bg"):getChildByName("Image_apply_head_bg"):getChildByName("Image_apply_head_icon")
	self._Image_apply_no_t = self.csbNode:getChildByName("Panel_add_apply_6"):getChildByName("ListView_apply"):getChildByName("model"):getChildByName("Image_list_apply_bg"):getChildByName("Button_no"):getChildByName("Image_apply_no")
	self._Image_apply_ok_t = self.csbNode:getChildByName("Panel_add_apply_6"):getChildByName("ListView_apply"):getChildByName("model"):getChildByName("Image_list_apply_bg"):getChildByName("Button_ok"):getChildByName("Image_apply_ok")
	
    --label list
    
    --button list
    self._Button_apply_close_t = self.csbNode:getChildByName("Panel_add_apply_6"):getChildByName("Button_apply_close")
	self._Button_apply_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_apply_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_apply_close btFunc
function UnionApplyPopView:onButton_apply_closeClick()
    Functions.printInfo(self.debug,"Button_apply_close button is click!")
    --关闭
    self._controller_t:closeChildView(self)
end
--@auto code Button_apply_close btFunc end

--@auto button backcall end


--@auto code output func
function UnionApplyPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionApplyPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	--查询申请列表
    self:sendApplyList()
end

function UnionApplyPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
--查询申请列表
function UnionApplyPopView:sendApplyList()
    Functions.printInfo(self.debug,"sendApplyList")
    local ApplyList = function(event)
        if event.reqtype  == 16 then
        UnionData:clearApplyList()
        local data = event.data
        	for k, v in pairs(data) do
        		UnionData:addApplyListData(data)
        	end
            --显示
            self:showApply()
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(ApplyList,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 16 })
end

--同意申请
function UnionApplyPopView:sendAgree(id)
    Functions.printInfo(self.debug,"sendApplyList")
    local ApplyList = function(event)
        if event.reqtype  == 17 then
            --删除当前申请列表里已同意的数据
            local  listDatas = UnionData:getApplyListData()
            for k, v in pairs(listDatas) do
                if v.id == idx then
                    table.remove(listDatas,k)
                    break
                end
                
            end
            --添加当前申请列表里已同意的数据到公会成员中
            local v = event.data
            local memberInfo = require("app.ui.unionSystem.MemberModel").new()
            memberInfo.m_id = v.id                                  --成员id
            memberInfo.eventAttr.m_worship_times = v.worship_times  --膜拜次数                      
            memberInfo.m_copytimes = v.copytimes                    --副本次数
            memberInfo.m_vip_level = v.vip_level                    --vip等级
            memberInfo.m_activity = v.activity                      --活跃
            memberInfo.m_pic = v.pic                                --人物头像
            memberInfo.eventAttr.m_member_type= v.member_type       --成员职位（1会员、2长老、3会长）
            memberInfo.m_status = v.status                          --公告
            memberInfo.m_level = v.level                            --人物等级
            memberInfo.m_logout_time = v.logout_time                --最后上线时间
            memberInfo.m_name = v.name                              --名字
            UnionData:addUnionMemberInfoData(memberInfo)                                                                                                    
            
            
            --数据更新监听
            GameEventCenter:dispatchEvent({ name = UnionData.MEMBER_POSITION_EVENT, data = {} })    
            self:showApply()
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(ApplyList,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 17, data = {id = id} })
end

--拒绝申请
function UnionApplyPopView:sendRefuse(id)
    Functions.printInfo(self.debug,"sendApplyList")
    local ApplyList = function(event)
        if event.reqtype  == 18 then
            --删除当前申请列表里已同意的数据
            local  listDatas = UnionData:getApplyListData()
            for k, v in pairs(listDatas) do
                if v.id == idx then
                    table.remove(listDatas,k)
                    break
                end
            end
             
            self:showApply()
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(ApplyList,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 18, data = {id = id} })
end

--显示
function UnionApplyPopView:showApply()
    Functions.printInfo(self.debug,"showApply")
    
    local MemberInfo = UnionData:getMemberInfoData()
    Functions.initLabelOfString(self._Text_union_cheng_yuan_num_t, tostring(#MemberInfo).."/50")
    
    local listHandler = function(index, widget, data)
        local Image = widget:getChildByName("Image_list_apply_bg")
        local onNo = function(event)
            print("button onNo")
            --点击拒绝
            self:sendRefuse(data[index].id)
        end
        Image:getChildByName("Button_no"):onTouch(Functions.createClickListener(onNo, "zoom"))

        local onOk = function(event)
            print("button onOk")
            --点击同意
            self:sendAgree(data[index].id)
        end
        Image:getChildByName("Button_ok"):onTouch(Functions.createClickListener(onOk, "zoom"))


        Image:getChildByName("Text_add_apply_name_level"):setText(data[index].name.."        "..tostring(data[index].level)..LanguageConfig.language_Union_4)
        Functions.loadImageWithWidget(Image:getChildByName("Image_apply_head_bg"):getChildByName("Image_apply_head_icon"), Functions.getDisHeadFImagePathOfId(data[index].pic))

    end
    --绑定响应事件函数
    local  listDatas = UnionData:getApplyListData()
    Functions.bindListWithData(self._ListView_apply_t, listDatas, listHandler)
end

return UnionApplyPopView