--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local HuoDongPopView = class("HuoDongPopView", BasePopView)

local Functions = require("app.common.Functions")

HuoDongPopView.csbResPath = "lk/csb"
HuoDongPopView.debug = true
HuoDongPopView.studioSpriteFrames = {"HuoDongPopUI","HuoDongPopUI_Text_Bg","HuoDongPopUI_Text" }
--@auto code head end


HuoDongPopView.spriteFrameNames = 
{
}

HuoDongPopView.animaNames = 
{
}


--@auto code uiInit
--add spriteFrames
if #HuoDongPopView.studioSpriteFrames > 0 then
    HuoDongPopView.spriteFrameNames = HuoDongPopView.spriteFrameNames or {}
    table.insertto(HuoDongPopView.spriteFrameNames, HuoDongPopView.studioSpriteFrames)
end
function HuoDongPopView:onInitUI()

    --output list
    self._Panel_Every_day_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("ScrollView_title"):getChildByName("Panel_Every_day")
	self._Sprite_Every_day_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("ScrollView_title"):getChildByName("Panel_Every_day"):getChildByName("Sprite_Every_day")
	self._Panel_lei_ji_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("ScrollView_title"):getChildByName("Panel_lei_ji")
	self._Sprite_lei_ji_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("ScrollView_title"):getChildByName("Panel_lei_ji"):getChildByName("Sprite_lei_ji")
	self._Panel_chong_zhi_huo_dong_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("ScrollView_title"):getChildByName("Panel_chong_zhi_huo_dong")
	self._Sprite_chong_zhi_huo_dong_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("ScrollView_title"):getChildByName("Panel_chong_zhi_huo_dong"):getChildByName("Sprite_chong_zhi_huo_dong")
	self._Panel_tian_ti_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("ScrollView_title"):getChildByName("Panel_tian_ti")
	self._Panel_cheng_zhang_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("ScrollView_title"):getChildByName("Panel_cheng_zhang")
	self._Sprite_cheng_zhang_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("ScrollView_title"):getChildByName("Panel_cheng_zhang"):getChildByName("Sprite_cheng_zhang")
	self._Panel_all_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("Panel_all")
	self._Text_time_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("Panel_all"):getChildByName("Text_time")
	self._Text_time_num_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("Panel_all"):getChildByName("Text_time_num")
	self._Text_jie_shao_info_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("Panel_all"):getChildByName("Text_jie_shao_info")
	self._Panel_cheng_zhang_text_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("Panel_cheng_zhang_text")
	self._Text_cheng_zhang_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("Panel_cheng_zhang_text"):getChildByName("Text_cheng_zhang")
	self._ListView_Every_day_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("ListView_Every_day")
	self._ListView_xiao_fei_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("ListView_xiao_fei")
	self._ListView_chong_zhi_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("ListView_chong_zhi")
	self._ListView_tian_ti_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("ListView_tian_ti")
	self._ListView_chen_zhang_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("ListView_chen_zhang")
	self._Text_ji_jin_1_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("ListView_chen_zhang"):getChildByName("model"):getChildByName("Image_mei_ri_bg"):getChildByName("Text_ji_jin_1")
	self._Text_ji_jin_2_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("ListView_chen_zhang"):getChildByName("model"):getChildByName("Image_mei_ri_bg"):getChildByName("Text_ji_jin_2")
	
    --label list
    
    --button list
    self._Button_close_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Button_close")
	self._Button_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_closeClick), "zoom"))

	self._Button_cheng_zhang_t = self.csbNode:getChildByName("Panel_huo_dong"):getChildByName("Panel_info"):getChildByName("Panel_cheng_zhang_text"):getChildByName("Button_cheng_zhang")
	self._Button_cheng_zhang_t:onTouch(Functions.createClickListener(handler(self, self.onButton_cheng_zhangClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_cheng_zhang btFunc
--购买成长基金
function HuoDongPopView:onButton_cheng_zhangClick()
    Functions.printInfo(self.debug,"Button_cheng_zhang button is click!")
    if PlayerData.eventAttr.m_gold < g_VipCgf.GrowUpGold then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_Enlist_11)
        return true
    end
    --监听服务器数据
    local onServerRequest = function (event)
        Functions.setAdbrixTag("retension","growth_wealth_buy",PlayerData.eventAttr.m_level)
        PlayerData.eventAttr.m_gold = event.gold
        local data = event.state
        ActivityData.VIPJiHua = {}
        for k, v in pairs(data) do
            ActivityData.VIPJiHua[#ActivityData.VIPJiHua + 1] = v
        end
        ActivityData.VIPJiHuaBuy = 1
        self:ShowChengZhang()
        self:ListBZ()
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_9_7)
    end
    NetWork:addNetWorkListener({25,3}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {25, 3}}
    NetWork:sendToServer(msg)

end
--@auto code Button_cheng_zhang btFunc end

--@auto code Button_close btFunc
function HuoDongPopView:onButton_closeClick()
    Functions.printInfo(self.debug,"Button_close button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_close btFunc end

--@auto button backcall end


--@auto code output func
function HuoDongPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function HuoDongPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    Functions.setPopupKey("welfare")
    --请求每日充值
    local onData = function()
        self:ListClose()
        self:ShowTime(1)
        self:ShowEveryDay()
        self:showView()
        self:ListBZ()
    end
    ActivityData:sendEveryDay(onData)
    
    --VipData:RequestVipPay("111111","1231321","1000021769")
    
    --请求累积消费
    ActivityData:sendXiaoFei()
    
    --请求充值活动
    ActivityData:sendNumHuoDong()
    
    --发送天梯
    ActivityData:sendTianTi()
    
	--请求vip成长基金状态
    ActivityData:sendJiHua()

    
    self.State = 1
    local onPanel1 = function()
        print("panel 1 click")

        self.State = 1
        if self._Text_time_num_t.timeSprite ~= nil then
            self._Text_time_num_t:removeChild(self._Text_time_num_t.timeSprite)
            self._Text_time_num_t.timeSprite = nil
        end

        self:Show(self.State)
    end

    local onPanel2 = function()
        print("panel 2 click")

        self.State = 2
        if self._Text_time_num_t.timeSprite ~= nil then
            self._Text_time_num_t:removeChild(self._Text_time_num_t.timeSprite)
            self._Text_time_num_t.timeSprite = nil
        end

        self:Show(self.State)
    end 

    local onPanel3 = function()
        print("panel 3 click")

        self.State = 3
        if self._Text_time_num_t.timeSprite ~= nil then
            self._Text_time_num_t:removeChild(self._Text_time_num_t.timeSprite)
            self._Text_time_num_t.timeSprite = nil
        end

        self:Show(self.State)
    end 

    local onPanel4 = function()
        print("panel 4 click")

        self.State = 4
        if self._Text_time_num_t.timeSprite ~= nil then
            self._Text_time_num_t:removeChild(self._Text_time_num_t.timeSprite)
            self._Text_time_num_t.timeSprite = nil
        end

        self:Show(self.State)
    end 

    local onPanel5 = function()
        print("panel 5 click")
        self.State = 5
        if self._Text_time_num_t.timeSprite ~= nil then
            self._Text_time_num_t:removeChild(self._Text_time_num_t.timeSprite)
            self._Text_time_num_t.timeSprite = nil
        end

        self:Show(self.State)
    end 

    Functions.initTabCom({ { self._Panel_Every_day_t, onPanel1, true }, { self._Panel_lei_ji_t, onPanel2}, { self._Panel_chong_zhi_huo_dong_t, onPanel3}, 
        { self._Panel_tian_ti_t, onPanel4}, { self._Panel_cheng_zhang_t, onPanel5}})
    --self:ListBZ()
end

function HuoDongPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function HuoDongPopView:onChangeView()
end

function HuoDongPopView:ListClose()
    Functions.printInfo(self.debug,"ListClose")
    self._ListView_Every_day_t:setVisible(false)
    self._ListView_xiao_fei_t:setVisible(false)
    self._ListView_chong_zhi_t:setVisible(false)
    self._ListView_tian_ti_t:setVisible(false)
    self._ListView_chen_zhang_t:setVisible(false)
    
end

function HuoDongPopView:ListBZ()
    Functions.printInfo(self.debug,"ListBZ")
    --获取标志
--    ActivityData:getVIPBZ()
--    ActivityData:getEveryDayBZ()
--    ActivityData:getMoneyBZ()
--    ActivityData:getXiaoFeiBZ()
    
    --对标志进行展示
    if ActivityData.EveryDayBZ then
        self._Sprite_Every_day_t:setVisible(true)
    else
        self._Sprite_Every_day_t:setVisible(false)
    end
    local ooo = ActivityData.XiaoFeiBZ
    if ActivityData.XiaoFeiBZ then
        self._Sprite_lei_ji_t:setVisible(true)
    else
        self._Sprite_lei_ji_t:setVisible(false)
    end
    
    if ActivityData.MoneyBZ then
        self._Sprite_chong_zhi_huo_dong_t:setVisible(true)
    else
        self._Sprite_chong_zhi_huo_dong_t:setVisible(false)
    end
    
    if ActivityData.VIPBZ then
        self._Sprite_cheng_zhang_t:setVisible(true)
    else
        self._Sprite_cheng_zhang_t:setVisible(false)
    end
end

--显示倒记时
function HuoDongPopView:showTime_(wiget, time)

    if time == 0 then
        return
    end
    if wiget.timeSprite then
        return
    end
    wiget.timeSprite = Functions.createSprite()
    wiget:addChild(wiget.timeSprite)
    --任务倒记时
    local onTime = function()
        local m_newtime = TimerManager:getCurrentSecond()
        local tm = time - m_newtime
        if tm < 0 then
            tm = 0
        end
        local str = LanguageConfig.language_HuoDong_3..string.format(LanguageConfig.language_HuoDong_1, tm/(3600*24), tm%(3600*24)/3600, tm/60%60)
        if tm == 0 then
            str = LanguageConfig.language_HuoDong_2
        end
        Functions.initLabelOfString(wiget, str)
        
--        local time = str--TimerManager:formatTime(LanguageConfig.language_HuoDong_1, tm)
--        local day = TimerManager:formatTime("%d", tm)
--        local iii = tonumber(day)
        --天数小于10天时，就要显示一位数，否则显示二位数

--        else
--            if tonumber(day) < 10 then
--                str = LanguageConfig.language_HuoDong_3..string.sub(time,2,#time)
--            else
--                str = LanguageConfig.language_HuoDong_3..tostring(time)
--            end
--            
--        end
    end
    Functions.bindEventListener(wiget.timeSprite, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
    onTime()
end

function HuoDongPopView:Show(type)
    Functions.printInfo(self.debug,"Show")
    self:ListClose()
    self:ShowTime(type)
    if type == 1 then
        self:ShowEveryDay()
    elseif type == 2 then
        self:ShowXiaoFei()
    elseif type == 3 then
        self:ShowNumHuoDong()
    elseif type == 4 then
        self:ShowTianTi()
    elseif type == 5 then
        self:ShowChengZhang()
    end
    if type < 5 then
        self._Panel_all_t:setVisible(true)
        self._Panel_cheng_zhang_text_t:setVisible(false)
    end
end

function HuoDongPopView:ShowTime(type)
    Functions.printInfo(self.debug,"Show")

    
    if type == 5 then
        local jieShao = self._Text_cheng_zhang_t
        Functions.initLabelOfString(jieShao, ActivityData:getStrText()[type] )
    else
        local Start = ActivityData:getStartTime()[type]
        local Start_hour = tostring(Start.hour)
        --因为是显示时间，所以小于10时前面加个0
        if Start.hour < 10 then
            Start_hour = "0"..tostring(Start.hour)
        end
        local Start_min = tostring(Start.min)
        if Start.min < 10 then
            Start_min = "0"..tostring(Start_min)
        end
        assert(Start, "No start time")
        local EndTime = ActivityData:getEndTime()[type]
        --因为是显示时间，所以小于10时前面加个0
        local EndTime_hour = tostring(EndTime.hour)
        if EndTime.hour < 10 then
            EndTime_hour = "0"..tostring(EndTime.hour)
        end
        local EndTime_min = tostring(EndTime.min)
        if EndTime.min < 10 then
            EndTime_min = "0"..tostring(EndTime_min)
        end
        local str = tostring(Start.month)..LanguageConfig.language_HuoDong_4..tostring(Start.day)..LanguageConfig.language_HuoDong_5.." "..Start_hour..":"..Start_min.."--"..
            tostring(EndTime.month)..LanguageConfig.language_HuoDong_4..tostring(EndTime.day)..LanguageConfig.language_HuoDong_5.." "..EndTime_hour..":"..EndTime_min
        local jieShao = self._Text_jie_shao_info_t
        Functions.initLabelOfString( self._Text_time_t, str, jieShao, ActivityData:getStrText()[type] )
        
        
--        if self.label ~= nil then
--        	self.label:removeSelf()
--        end
--
--        self.label = Functions.createLabel({scale = 1,pos = {x = 471, y = 99 },zorder = 10,text = ""})
--        self._Panel_all_t:addChild(self.label,4)
--        self.label:setSystemFontSize(22)
--        self.label:setColor(cc.c3b(115,240,65))
--        local ioioioioi = ActivityData.EndTime[type]
        --活动开始时间小于现在时间，就是活动未开启

        if os.time(ActivityData.StartTime[type]) > TimerManager:getCurrentSecond() then
            Functions.initLabelOfString(self._Text_time_num_t, LanguageConfig.language_HuoDong_12)
        else
            self:showTime_(self._Text_time_num_t, os.time(ActivityData.EndTime[type]))
        end
    end
end

--成长计划
function HuoDongPopView:ShowChengZhang()
    Functions.printInfo(self.debug,"ShowChengZhang")
    
    self._Panel_all_t:setVisible(false)
    self._Panel_cheng_zhang_text_t:setVisible(true)

    if ActivityData.VIPJiHuaBuy == 0 then
        Functions.setEnabledBt(self._Button_cheng_zhang_t,true)
    elseif ActivityData.VIPJiHuaBuy == 1 then
        Functions.setEnabledBt(self._Button_cheng_zhang_t,false)
    end
    
    local listHandler = function(index, widget, data, model)

        local button = widget:getChildByName("Image_mei_ri_bg")
        local banModel = model:getChildByName("Image_mei_ri_bg")
        Functions.initTextColor(banModel:getChildByName("Text_ji_jin_1"),button:getChildByName("Text_ji_jin_1"))
        Functions.initTextColor(banModel:getChildByName("Text_ji_jin_2"),button:getChildByName("Text_ji_jin_2"))

        local onClick = function(event)
            print("button click")
            --打开二级界面
            self:getJiHuaJiang(index)
        end
        button:getChildByName("Button_get"):onTouch(Functions.createClickListener(onClick, "zoom"))

        local num = ActivityData:getJiHuaItem()
        local JiHuaOne = tostring(num[index].level)..LanguageConfig.language_HuoDong_6
        local JiHuaTwo = string.format(LanguageConfig.language_HuoDong_7,num[index].level, num[index].gold )  --(LanguageConfig.language_HuoDong_7)..tostring(num[index].level)..LanguageConfig.language_HuoDong_8..tostring(num[index].gold)..LanguageConfig.language_HuoDong_9
        Functions.initLabelOfString(button:getChildByName("Text_ji_jin_1"), JiHuaOne,button:getChildByName("Text_ji_jin_2"),JiHuaTwo)
        if ActivityData.VIPJiHuaBuy == 0 or data == 0 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),false)
        elseif data == 2 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),false)
            button:getChildByName("Button_get"):getChildByName("Image_get"):ignoreContentAdaptWithSize(true)
            Functions.loadImageWithWidget(button:getChildByName("Button_get"):getChildByName("Image_get"),"commonUI/res/common/yilingqu.png")
        elseif data == 1 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),true)
        end
    end
    --绑定响应事件函数
    Functions.bindListWithData(self._ListView_chen_zhang_t, ActivityData:getJiHua(), listHandler)
end

--成长计划领奖
function HuoDongPopView:getJiHuaJiang(idx)
    --监听服务器数据
    local onServerRequest = function (event)
        PlayerData.eventAttr.m_gold = event.gold
        ActivityData.VIPJiHua[idx] = 2
        self:ShowChengZhang()
        self:ListBZ()
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_task_1)
    end
    NetWork:addNetWorkListener({25,4}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {25, 4},index = idx }
    NetWork:sendToServer(msg)
end

--每日充值领奖
function HuoDongPopView:getEveryDayJiang(idx)
    --监听服务器数据
    local onServerRequest = function(event)
        local data = event.data
        PlayerData.eventAttr.m_gold = data.gold
        PlayerData.eventAttr.m_hunjing = data.hunjing
        PlayerData.eventAttr.m_money = data.money
        PlayerData.eventAttr.m_soul = data.soul
        for k, v in pairs(data.items) do
            Functions:addItemResources( {id = v.id, type = v.type, count = v.count, slot = v.slot} )
        end
        ActivityData.EveryDay[idx] = 2
        self:ShowEveryDay()
        self:ListBZ()
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_task_1)
    end
    NetWork:addNetWorkListener({20,16}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {20, 16},index = idx }
    NetWork:sendToServer(msg)
end

--充值活动领奖
function HuoDongPopView:getMoneyHuoDong(idx)
    --监听服务器数据
    local onServerRequest = function(event)
        local data = event.data
        PlayerData.eventAttr.m_gold = data.gold
        PlayerData.eventAttr.m_hunjing = data.hunjing
        PlayerData.eventAttr.m_money = data.money
        PlayerData.eventAttr.m_soul = data.soul
        for k, v in pairs(data.items) do
            Functions:addItemResources( {id = v.id, type = v.type, count = v.count, slot = v.slot} )
        end
        ActivityData.MoneyHuoDong[idx] = 2
        self:ShowNumHuoDong()
        self:ListBZ()
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_task_1)
    end
    NetWork:addNetWorkListener({20,9}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {20, 9}, index = idx }
    NetWork:sendToServer(msg)
end

--累积消费领奖
function HuoDongPopView:getXiaoFei(idx)
    --监听服务器数据
    local onServerRequest = function(event)
        local data = event.data
        PlayerData.eventAttr.m_gold = data.gold
        PlayerData.eventAttr.m_hunjing = data.hunjing
        PlayerData.eventAttr.m_money = data.money
        PlayerData.eventAttr.m_soul = data.soul
        for k, v in pairs(data.items) do
            Functions:addItemResources( {id = v.id, type = v.type, count = v.count, slot = v.slot} )
        end
        ActivityData.XiaoFei[idx] = 2
        self:ShowXiaoFei()
        self:ListBZ()
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_task_1)
    end
    NetWork:addNetWorkListener({20,21}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {20, 21}, index = idx }
    NetWork:sendToServer(msg)
end

--天梯领奖
function HuoDongPopView:getTianTi(idx)
    --监听服务器数据
    local onServerRequest = function(event)
        local data = event.data
        PlayerData.eventAttr.m_gold = data.gold
        PlayerData.eventAttr.m_hunjing = data.hunjing
        PlayerData.eventAttr.m_money = data.money
        PlayerData.eventAttr.m_soul = data.soul
        for k, v in pairs(data.items) do
            Functions:addItemResources( {id = v.id, type = v.type, count = v.count, slot = v.slot} )
        end
        ActivityData.MoneyHuoDong[idx] = 2
        self:ShowNumHuoDong()
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_task_1)
    end
    NetWork:addNetWorkListener({20,9}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {20, 9}, index = idx }
    NetWork:sendToServer(msg)
end

--每日充值
function HuoDongPopView:ShowEveryDay()
    Functions.printInfo(self.debug,"ShowChengZhang")

    local listHandler = function(index, widget, data, model)

        local button = widget:getChildByName("Image_chong_zhi_bg")

        local onClick = function(event)
            print("button click")
            --打开二级界面
            self:getEveryDayJiang(index)
        end
        button:getChildByName("Button_get"):onTouch(Functions.createClickListener(onClick, "zoom"))
        
        local heroNode = nil
        local item = ActivityData:getEveryDayItem()[index].goods
        
        assert(#item <= 4,"HuoDongPopView:ShowEveryDay————每日充值奖励物品大于4个")
        
        for k, v in pairs(item) do
            if v.type == 4 then --4为道具
                heroNode = Functions.createPartNode({nodeType = ItemType.Prop, nodeId = v.id, count = v.count})
            elseif v.type == 1 then--1为武将卡
                heroNode = Functions.createPartNode({nodeType = ItemType.HeroCard, nodeId = v.id, count = v.count})
            elseif v.type == 5 then--1为武将卡碎片
                heroNode = Functions.createPartNode({nodeType = ItemType.CardFragment, nodeId = v.id, count = v.count})
                --Functions.loadImageWithWidget(head, ConfigHandler:getHeroHeadImageOfId(v.id))
            else
                assert(false,"商店出售的商品类型 type = " .. data.m_ItemType .. "错误")
            end
            local Image = "Image_"..tostring(k)
            Functions.copyParam(button:getChildByName(Image), heroNode)
            local wgt = heroNode:getChildByName("model")
            wgt:setTouchEnabled(false)

            button:getChildByName(Image):setVisible(true)
            button:addChild(heroNode)
        end


        local EveryDayNum = tostring(ActivityData:getEveryDayItem()[index].payCount)..LanguageConfig.language_HuoDong_10
        Functions.initLabelOfString(button:getChildByName("Text_chong_num"), EveryDayNum)
        if data == 0 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),false)
        elseif data == 2 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),false)
            button:getChildByName("Button_get"):getChildByName("Image_get"):ignoreContentAdaptWithSize(true)
            Functions.loadImageWithWidget(button:getChildByName("Button_get"):getChildByName("Image_get"),"commonUI/res/common/yilingqu.png")
        elseif data == 1 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),true)
        end
    end
    --绑定响应事件函数
    local iiiii = ActivityData:getEveryDay()
    Functions.bindListWithData(self._ListView_Every_day_t, ActivityData:getEveryDay(), listHandler)
end

--充值活动
function HuoDongPopView:ShowNumHuoDong()
    Functions.printInfo(self.debug,"ShowChengZhang")

    local listHandler = function(index, widget, data, model)

        local button = widget:getChildByName("Image_mei_ri_bg")

        local onClick = function(event)
            print("button click")
            --打开二级界面
            self:getMoneyHuoDong(index)
        end
        button:getChildByName("Button_get"):onTouch(Functions.createClickListener(onClick, "zoom"))

        local heroNode = nil
        local item = ActivityData:getMoneyHuoDongItem()[index].goods

        assert(#item <= 4,"HuoDongPopView:ShowEveryDay————每日充值奖励物品大于4个")

        for k, v in pairs(item) do
            if v.type == 4 then --4为道具
                heroNode = Functions.createPartNode({nodeType = ItemType.Prop, nodeId = v.id, count = v.count})
            elseif v.type == 1 then--1为武将卡
                heroNode = Functions.createPartNode({nodeType = ItemType.HeroCard, nodeId = v.id, count = v.count})
            elseif v.type == 5 then--1为武将卡碎片
                heroNode = Functions.createPartNode({nodeType = ItemType.CardFragment, nodeId = v.id, count = v.count})
                --Functions.loadImageWithWidget(head, ConfigHandler:getHeroHeadImageOfId(v[1]))
            else
                assert(false,"商店出售的商品类型 type = " .. data.m_ItemType .. "错误")
            end
            local Image = "Image_"..tostring(k)
            Functions.copyParam(button:getChildByName(Image), heroNode)
            local wgt = heroNode:getChildByName("model")
            wgt:setTouchEnabled(false)

            button:getChildByName(Image):setVisible(true)
            button:addChild(heroNode)
        end


        local EveryDayNum = tostring(ActivityData:getMoneyHuoDongItem()[index].payCount)..LanguageConfig.language_HuoDong_9
        Functions.initLabelOfString(button:getChildByName("Text_chong_num"), EveryDayNum)
        if data == 0 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),false)
        elseif data == 2 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),false)
            button:getChildByName("Button_get"):getChildByName("Image_get"):ignoreContentAdaptWithSize(true)
            Functions.loadImageWithWidget(button:getChildByName("Button_get"):getChildByName("Image_get"),"commonUI/res/common/yilingqu.png")
        elseif data == 1 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),true)
        end
    end
    --绑定响应事件函数
    local iiiii = ActivityData:getEveryDay()
    Functions.bindListWithData(self._ListView_chong_zhi_t, ActivityData:getMoneyHuoDong(), listHandler)
end

--累积消费
function HuoDongPopView:ShowXiaoFei()
    Functions.printInfo(self.debug,"ShowChengZhang")

    local listHandler = function(index, widget, data, model)

        local button = widget:getChildByName("Image_mei_ri_bg")

        local onClick = function(event)
            print("button click")
            --打开二级界面
            self:getXiaoFei(index)
        end
        button:getChildByName("Button_get"):onTouch(Functions.createClickListener(onClick, "zoom"))

        local heroNode = nil
        local item = ActivityData:getXiaoFeiItem()[index].goods

        assert(#item <= 4,"HuoDongPopView:ShowEveryDay————每日充值奖励物品大于4个")

        for k, v in pairs(item) do
            if v.type == 4 then --4为道具
                heroNode = Functions.createPartNode({nodeType = ItemType.Prop, nodeId = v.id, count = v.count})
            elseif v.type == 1 then--1为武将卡
                heroNode = Functions.createPartNode({nodeType = ItemType.HeroCard, nodeId = v.id, count = v.count})
            elseif v.type == 5 then--1为武将卡碎片
                heroNode = Functions.createPartNode({nodeType = ItemType.CardFragment, nodeId = v.id, count = v.count})
                --Functions.loadImageWithWidget(head, ConfigHandler:getHeroHeadImageOfId(v[1]))
            else
                assert(false,"商店出售的商品类型 type = " .. data.m_ItemType .. "错误")
            end
            local Image = "Image_"..tostring(k)
            Functions.copyParam(button:getChildByName(Image), heroNode)
            local wgt = heroNode:getChildByName("model")
            wgt:setTouchEnabled(false)

            button:getChildByName(Image):setVisible(true)
            button:addChild(heroNode)
        end


        local EveryDayNum = tostring(ActivityData:getXiaoFeiItem()[index].consumeCount)..LanguageConfig.language_HuoDong_9
        Functions.initLabelOfString(button:getChildByName("Text_chong_num"), EveryDayNum)
        if data == 0 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),false)
        elseif data == 2 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),false)
            button:getChildByName("Button_get"):getChildByName("Image_get"):ignoreContentAdaptWithSize(true)
            Functions.loadImageWithWidget(button:getChildByName("Button_get"):getChildByName("Image_get"),"commonUI/res/common/yilingqu.png")
        elseif data == 1 then
            Functions.setEnabledBt(button:getChildByName("Button_get"),true)
        end
    end
    --绑定响应事件函数
    local iiiii = ActivityData:getXiaoFei()
    Functions.bindListWithData(self._ListView_xiao_fei_t, ActivityData:getXiaoFei(), listHandler)
end

--天梯争霸
function HuoDongPopView:ShowTianTi()
    Functions.printInfo(self.debug,"ShowChengZhang")

    local listHandler = function(index, widget, data, model)

        local button = widget:getChildByName("Image_mei_ri_bg")


        local heroNode = nil
        local item = data.goods

        assert(#item <= 4,"HuoDongPopView:ShowEveryDay————每日充值奖励物品大于4个")

        for k, v in pairs(item) do
            if v.type == 4 then --4为道具
                heroNode = Functions.createPartNode({nodeType = ItemType.Prop, nodeId = v.id, count = v.count})
            elseif v.type == 1 then--1为武将卡
                heroNode = Functions.createPartNode({nodeType = ItemType.HeroCard, nodeId = v.id, count = v.count})
            elseif v.type == 5 then--1为武将卡碎片
                heroNode = Functions.createPartNode({nodeType = ItemType.CardFragment, nodeId = v.id, count = v.count})
                --Functions.loadImageWithWidget(head, ConfigHandler:getHeroHeadImageOfId(v[1]))
            else
                assert(false,"商店出售的商品类型 type = " .. data.m_ItemType .. "错误")
            end
            local Image = "Image_"..tostring(k)
            Functions.copyParam(button:getChildByName(Image), heroNode)
            local wgt = heroNode:getChildByName("model")
            wgt:setTouchEnabled(false)

            button:getChildByName(Image):setVisible(true)
            button:addChild(heroNode)
        end

        local level = ActivityData:getTianTiRank()
        local EveryDayNum = 0
        if index == 1 then
            EveryDayNum = tostring(data.rank)
        else
            local iii = level[index-1].rank+1
            if level[index-1].rank+1 == data.rank then
                EveryDayNum = tostring(data.rank)
            else
                EveryDayNum = tostring(level[index-1].rank+1).."-"..tostring(data.rank)
            end
        end

        local str = "X"..tostring(data.score)
        Functions.initLabelOfString(button:getChildByName("Text_chong_num"), EveryDayNum, button:getChildByName("Image_4"):getChildByName("Text_score_num"), str)

    end
    --绑定响应事件函数
    Functions.bindListWithData(self._ListView_tian_ti_t, ActivityData:getTianTiRank(), listHandler)
end

return HuoDongPopView