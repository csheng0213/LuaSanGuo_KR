--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local GvgBidRankPopView = class("GvgBidRankPopView", BasePopView)

local Functions = require("app.common.Functions")

GvgBidRankPopView.csbResPath = "lk/csb"
GvgBidRankPopView.debug = true
GvgBidRankPopView.studioSpriteFrames = {"GvgUI_Text","CB_unionTankuang","UnionUI","GuildBattleUI" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #GvgBidRankPopView.studioSpriteFrames > 0 then
    GvgBidRankPopView.spriteFrameNames = GvgBidRankPopView.spriteFrameNames or {}
    table.insertto(GvgBidRankPopView.spriteFrameNames, GvgBidRankPopView.studioSpriteFrames)
end
function GvgBidRankPopView:onInitUI()

    --output list
    self._Text_title_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Text_title")
	self._Sprite_bid_text_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Sprite_bid_text")
	self._Sprite_daojishi_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Sprite_daojishi")
	self._Text_daojishi_num_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Sprite_daojishi"):getChildByName("Text_daojishi_num")
	self._ListView_bid_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("ListView_bid")
	self._Panel_result_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Panel_result")
	self._Image_win_icon_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Panel_result"):getChildByName("Image_win"):getChildByName("Image_win_icon")
	self._Image_win_logo_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Panel_result"):getChildByName("Image_win"):getChildByName("Image_win_logo")
	self._Image_lose_icon_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Panel_result"):getChildByName("Image_lose"):getChildByName("Image_lose_icon")
	self._Image_lose_logo_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Panel_result"):getChildByName("Image_lose"):getChildByName("Image_lose_logo")
	self._Text_win_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Panel_result"):getChildByName("Panel_win"):getChildByName("Text_win")
	self._Text_lose_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Panel_result"):getChildByName("Panel_lose"):getChildByName("Text_lose")
	self._Text_zhan_ling_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Text_zhan_ling")
	self._Text_multiple_1_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Text_zhan_ling"):getChildByName("Text_multiple_1")
	self._Sprite_bid_but_text_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Button_bid"):getChildByName("Sprite_bid_but_text")
	
    --label list
    
    --button list
    self._Button_bid_close_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Button_bid_close")
	self._Button_bid_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_bid_closeClick), "zoom"))

	self._Button_prize_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Text_zhan_ling"):getChildByName("Button_prize")
	self._Button_prize_t:onTouch(Functions.createClickListener(handler(self, self.onButton_prizeClick), "zoom"))

	self._Button_bid_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Button_bid")
	self._Button_bid_t:onTouch(Functions.createClickListener(handler(self, self.onButton_bidClick), "zoom"))

	self._Button_Rule_t = self.csbNode:getChildByName("Panel_bid_2"):getChildByName("Button_Rule")
	self._Button_Rule_t:onTouch(Functions.createClickListener(handler(self, self.onButton_ruleClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_bid_close btFunc
function GvgBidRankPopView:onButton_bid_closeClick()
    Functions.printInfo(self.debug,"Button_bid_close button is click!")
    local tttt = GuildBattleData:getBidInfo()
    local id = GuildBattleData:getBidInfo().id
    GuildBattleData:sendCloseBuilding(id)
    self:close(self)

end
--@auto code Button_bid_close btFunc end

--@auto code Button_bid btFunc
function GvgBidRankPopView:onButton_bidClick()
    Functions.printInfo(self.debug,"Button_bid button is click!")
    local data = GuildBattleData:getBidInfo()
    --测试状态
    --data.state = 3
    --状态 0普通 1竞标 2战斗准备 3战斗
    if data.state == 1 then
        --竟价排行界面
        self:hand()
        --GuildBattleData:sendBidRank(data.id, handler(self, self.hand))
        
        --self._controller_t:openChildView("app.ui.popViews.GvgBidNumPopView")
    elseif data.state == 3 then
        GuildBattleData:sendAttackGuildBuilding(data.id, handler(self, self.GuildBuildingInfo))
        --self._controller_t:openChildView("app.ui.popViews.GvgBidNumPopView")
    end
end
--@auto code Button_bid btFunc end

--@auto code Button_prize btFunc
function GvgBidRankPopView:onButton_prizeClick()
    Functions.printInfo(self.debug,"Button_prize button is click!")
    local data = GuildBattleData:getBidInfo()
    self._controller_t:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = data.id}})
end
--@auto code Button_prize btFunc end

--@auto code Button_rule btFunc
function GvgBidRankPopView:onButton_ruleClick()
    Functions.printInfo(self.debug,"Button_rule button is click!")
    NoticeManager:openNotice(self._controller_t, {type = NoticeManager.GUID_BATTLE})
end
--@auto code Button_rule btFunc end

--@auto button backcall end


--@auto code output func
function GvgBidRankPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function GvgBidRankPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    self:showRank()
    --显示谁占领
    local data = GuildBattleData:getBidInfo()
    local GuildName = GuildBattleData:getBuildingInfo()[data.id].ownName
    local str = g_bigCity[data.id].name.."("..GuildName..LanguageConfig.language_GuildBattle_7..")"
    Functions.initLabelOfString( self._Text_title_t, str, self._Text_zhan_ling_t, LanguageConfig.language_GuildBattle_9)
    self:showRank()
    --接收竟价公会排名广播
    local onListInfo = function(event)
        --self:showListRank()
        self:showRank()
    end
    Functions.bindEventListener(self, GameEventCenter, GuildBattleData.BID_RANK_CHANGE, onListInfo)
    
    local data = GuildBattleData:getBidInfo()
    if data.state == 0 then
        --活动倒计时
        local time = TimerManager:formatOverTime("%02d:%02d:%02d", math.floor(GuildBattleData.eventAttr.Time))
        self._Text_daojishi_num_t:setString(time)
    elseif data.state == 1 then
        --活动倒计时
        local time = TimerManager:formatOverTime("%02d:%02d:%02d", math.floor(GuildBattleData.eventAttr.bidTime))
        self._Text_daojishi_num_t:setString(time)
    elseif data.state == 2 then
        --活动倒计时
        local time = TimerManager:formatOverTime("%02d:%02d:%02d", math.floor(GuildBattleData.eventAttr.planTime))
        self._Text_daojishi_num_t:setString(time)
    end
    Functions.bindUiWithModelAttr(self._Text_daojishi_num_t, GuildBattleData, "alltime",function(event)
        if math.floor(event.data) == 0 then
            self:showRank()
        end
        local sTime = TimerManager:formatOverTime("%02d:%02d:%02d", math.floor(event.data))
        self._Text_daojishi_num_t:setString(sTime)
    end)
--    Functions.bindUiWithModelAttr(self._Text_daojishi_num_t, GuildBattleData, "bidTime",function(event)
--        local sTime = TimerManager:formatOverTime("%02d:%02d:%02d", math.floor(event.data))
--        self._Text_daojishi_num_t:setString(sTime)
--    end)
--    Functions.bindUiWithModelAttr(self._Text_daojishi_num_t, GuildBattleData, "planTime",function(event)
--        local sTime = TimerManager:formatOverTime("%02d:%02d:%02d", math.floor(event.data))
--        self._Text_daojishi_num_t:setString(sTime)
--    end)
end

function GvgBidRankPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function GvgBidRankPopView:showRank()
    Functions.printInfo(self.debug,"showRank")
    local data = GuildBattleData:getBidInfo()
    --状态 0普通 1竞标 2战斗准备 3战斗
    self._ListView_bid_t:setVisible(false)
    self._Panel_result_t:setVisible(false)
    
    --奖励翻倍
    local Rate = GuildBattleData:getBuildingInfo()[data.id].Rate
    local str = "X "..Rate
    Functions.initLabelOfString( self._Text_multiple_1_t, str)
    
    --data.state = 1
    if data.state == 0 then
        self._Panel_result_t:setVisible(true)
        --self:ResultTime(data.startbidTime)
        self:showResult()
        --self:bidTime(data.endBidTime)
        self._Sprite_daojishi_t:setVisible(true)
        self._Button_bid_t:setVisible(false)
        --self._Text_daojishi_num_t:setPosition(self._Text_daojishi_num_t:getPositionX()+30, self._Text_daojishi_num_t:getPositionY())
        Functions.loadImageWithSprite( self._Sprite_bid_text_t, "commonUI/res/lk/GvgUI/zhandoujieguo.png" )
        Functions.loadImageWithSprite( self._Sprite_daojishi_t, "commonUI/res/lk/GvgUI/xiacijingjia.png" )
    elseif data.state == 1 then
        self._ListView_bid_t:setVisible(true)
        self._Button_bid_t:setVisible(true)
        Functions.loadImageWithSprite(self._Sprite_daojishi_t, "commonUI/res/lk/GvgUI/jingjiadaojishi.png")
        self:showListRank()
        --self:bidTime(data.endBidTime)
        Functions.loadImageWithSprite( self._Sprite_bid_text_t, "commonUI/res/lk/GvgUI/gcjj.png" )
    elseif data.state == 2 then
        --self:battleTime(data.endPlanTime)
        Functions.loadImageWithSprite(self._Sprite_daojishi_t, "commonUI/res/lk/GvgUI/gongchengdaojishi.png")
        Functions.setEnabledBt(self._Button_bid_t,false)
        Functions.loadImageWithSprite(self._Sprite_bid_but_text_t, "commonUI/res/lk/GvgUI/jrzc.png")
        self:showListRank()
    elseif data.state == 3 then
        self._Sprite_daojishi_t:setVisible(false)
        Functions.setEnabledBt(self._Button_bid_t,true)
        --self:battleTime(data.endfightTime)
        Functions.loadImageWithSprite(self._Sprite_bid_but_text_t, "commonUI/res/lk/GvgUI/jrzc.png")
        self:showListRank()
    end
end

function GvgBidRankPopView:showResult()
    Functions.printInfo(self.debug,"showResult")
    local fightResult = GuildBattleData:getBidInfo().preInfo
    Functions.initLabelOfString( self._Text_win_t, fightResult.win.name, self._Text_lose_t, fightResult.lose.name)
    self._Image_win_icon_t:ignoreContentAdaptWithSize(true)
    self._Image_lose_icon_t:ignoreContentAdaptWithSize(true)
    
    Functions.loadImageWithWidget(self._Image_win_icon_t, Functions:getGongHuiImageOfId(fightResult.win.pic)) 
    Functions.loadImageWithWidget(self._Image_lose_icon_t, Functions:getGongHuiImageOfId(fightResult.lose.pic)) 
    
end
function GvgBidRankPopView:showListRank()
    Functions.printInfo(self.debug,"showRank")
    local datas = GuildBattleData:getBidInfo()
    
    local list = {}
    for k = 1, 3 do
        list[#list + 1] = datas.bidList[k]
    end
    --状态 0普通 1竞标 2战斗准备 3战斗
    --绑定响应事件函数
    local listHandler = function(index, widget, data, model)
        local ban = widget:getChildByName("Panel_list_fb")
        local banModel = model:getChildByName("Panel_list_fb")
        Functions.initTextColor(banModel:getChildByName("Text_CY_name"), ban:getChildByName("Text_CY_name"))
        Functions.initTextColor(banModel:getChildByName("Text_donate_num"), ban:getChildByName("Text_donate_num"))
        local rank = nil
        if index == 1 then
            rank = LanguageConfig.language_GuildBattle_3
        elseif index == 2 then
            rank = LanguageConfig.language_GuildBattle_4
        elseif index == 3 then
            rank = LanguageConfig.language_GuildBattle_5
        end
        local str = rank..data.name
        ban:getChildByName("Text_CY_name"):setString(str)
        local text = string.format(LanguageConfig.language_GuildBattle_6, data.price) 
        ban:getChildByName("Text_donate_num"):setString(text)
        local datas = GuildBattleData:getBidInfo()
        if (datas.state == 2 or datas.state == 3) and (index == 1 or index == 2) then
            ban:getChildByName("Image_reach"):setVisible(true)
        else 
            ban:getChildByName("Image_reach"):setVisible(false)
        end
        
    end
    --绑定响应事件函数
    Functions.bindListWithData(self._ListView_bid_t, list, listHandler)
--    Functions.bindArryListWithData(self._ListView_bid_t,{ firstData = data.bidList }, listHandler,{direction = true, col = 1, firstSegment = 0, segment = 2 })

end

function GvgBidRankPopView:ResultTime(time)
    Functions.printInfo(self.debug,"bidTime")

    local remove = 0
    --倒记时
    local onTime = function(event)

        local m_newtime = TimerManager:getCurrentSecond()
        local CountdownTime = time
        m_newtime = CountdownTime - m_newtime 

        if m_newtime < 0 then
            m_newtime = 0
            GuildBattleData:getBidInfo().state = 1
            self:showRank()
           
        end

        local time = TimerManager:formatOverTime("%02d:%02d:%02d", m_newtime)
        --local str = LanguageConfig.language_Shop_3..time
        Functions.initLabelOfString( self._Text_daojishi_num_t, time)
    end
    Functions.removeEventBeforeUiClean(self._Text_daojishi_num_t)
    remove = Functions.bindEventListener(self._Text_daojishi_num_t, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
    onTime()
end

function GvgBidRankPopView:bidTime(time)
    Functions.printInfo(self.debug,"bidTime")
    
    local remove = 0
    --倒记时
    local onTime = function(event)
        local m_newtime = TimerManager:getCurrentSecond()
        local CountdownTime = time
        m_newtime = CountdownTime - m_newtime 
        
        if m_newtime < 0 then
            m_newtime = 0
            GuildBattleData:getBidInfo().state = 2
            self:showRank()
            Functions.removeEventListenerByView(self._Text_daojishi_num_t, GameEventCenter, remove)
        end

        local time = TimerManager:formatOverTime("%02d:%02d:%02d", m_newtime)
        --local str = LanguageConfig.language_Shop_3..time
        Functions.initLabelOfString( self._Text_daojishi_num_t, time)
    end
    remove = Functions.bindEventListener(self._Text_daojishi_num_t, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
    onTime()
end

function GvgBidRankPopView:battleTime(time)
    Functions.printInfo(self.debug,"bidTime")
    local remove = 0
    --倒记时
    local onTime = function(event)
        local m_newtime = TimerManager:getCurrentSecond()
        local CountdownTime = time
        m_newtime = CountdownTime - m_newtime 
        if m_newtime < 0 then
            m_newtime = 0
            GuildBattleData:getBidInfo().state = 3
            self:showRank()
            Functions.removeEventListenerByView(self._Text_daojishi_num_t, GameEventCenter, remove)
        end

        local time = TimerManager:formatOverTime("%02d:%02d:%02d", m_newtime)
        --local str = LanguageConfig.language_Shop_3..time
        Functions.initLabelOfString( self._Text_daojishi_num_t, time)
    end
    remove = Functions.bindEventListener(self._Text_daojishi_num_t, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
    onTime()
end

function GvgBidRankPopView:hand()
    Functions.printInfo(self.debug,"child class create call ")
    self._controller_t:openChildView("app.ui.popViews.GvgBidNumPopView")
end

function GvgBidRankPopView:GuildBuildingInfo()
    Functions.printInfo(self.debug,"child class create call ")
    
    GameCtlManager:push("app.ui.guildBattleMapSystem.GuildBattleMapViewController")
    local scheduler = require("app.common.scheduler") 
    scheduler.performWithDelayGlobal(function ( )
        self:close(self)
    end, 0.3)
    
end


return GvgBidRankPopView