--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local ActivityHeroPopView = class("ActivityHeroPopView", BasePopView)

local Functions = require("app.common.Functions")

ActivityHeroPopView.csbResPath = "tyj/csb"
ActivityHeroPopView.debug = true
ActivityHeroPopView.studioSpriteFrames = {"ActivityHeroPopUI_Text","ActivityHeroPopUI" }
--@auto code head end
ActivityHeroPopView.spriteFrameNames = 
    {
        "headPilistRes"
    }


--@auto code uiInit
--add spriteFrames
if #ActivityHeroPopView.studioSpriteFrames > 0 then
    ActivityHeroPopView.spriteFrameNames = ActivityHeroPopView.spriteFrameNames or {}
    table.insertto(ActivityHeroPopView.spriteFrameNames, ActivityHeroPopView.studioSpriteFrames)
end
function ActivityHeroPopView:onInitUI()

    --output list
    self._payCount_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("payCount")
	self._pageView_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("pageView")
	self._infListView_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("infListView")
	self._rankListView_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("rankListView")
	self._freeTime_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("freeTime")
	self._nowRank_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("nowRank")
	self._nowFen_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("nowFen")
	self._date_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("date")
	self._time_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("time")
	self._gold_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("gold")
	
    --label list
    
    --button list
    self._leftBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("leftBt")
	self._leftBt_t:onTouch(Functions.createClickListener(handler(self, self.onLeftbtClick), "zoom"))

	self._rightBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("rightBt")
	self._rightBt_t:onTouch(Functions.createClickListener(handler(self, self.onRightbtClick), "zoom"))

	self._closeBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))

	self._helpBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("helpBt")
	self._helpBt_t:onTouch(Functions.createClickListener(handler(self, self.onHelpbtClick), ""))

	self._freeBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("freeBt")
	self._freeBt_t:onTouch(Functions.createClickListener(handler(self, self.onFreebtClick), ""))

	self._payBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("payBt")
	self._payBt_t:onTouch(Functions.createClickListener(handler(self, self.onPaybtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Leftbt btFunc
function ActivityHeroPopView:onLeftbtClick()
    Functions.printInfo(self.debug,"Leftbt button is click!")
    local curPageIndex = self._pageView_t:getCurPageIndex()
    if curPageIndex > 0 then
        self._pageView_t:scrollToPage(curPageIndex-1)   
    end
end
--@auto code Leftbt btFunc end

--@auto code Rightbt btFunc
function ActivityHeroPopView:onRightbtClick()
    Functions.printInfo(self.debug,"Rightbt button is click!")
    local pages = self._pageView_t:getPages()
    local curPageIndex = self._pageView_t:getCurPageIndex()
    if curPageIndex <= #pages then
    	self._pageView_t:scrollToPage(curPageIndex+1)	
	end
end
--@auto code Rightbt btFunc end

--@auto code Helpbt btFunc
function ActivityHeroPopView:onHelpbtClick()
    Functions.printInfo(self.debug,"Helpbt button is click!")
    NoticeManager:openNotice(self:getController(), {type = NoticeManager.XSSJ_INF0})
end
--@auto code Helpbt btFunc end

--@auto code Closebt btFunc
function ActivityHeroPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:getController():closeChildView(self)
end
--@auto code Closebt btFunc end

--@auto code Freebt btFunc
function ActivityHeroPopView:onFreebtClick()
    Functions.printInfo(self.debug,"Freebt button is click!")

    local handler = function(event)
    	Functions.setEnabledBt(self._freeBt_t, false)
        -- self:rankPlayer(self._rankListView_t,event.rankPlayer)
       	Functions.setAdbrixTag("retension","newhero_buy_free", tostring(PlayerData.eventAttr.m_level))
       	
        self:getController():openChildView("app.ui.popViews.EnlistThreePopView", {isRemove = true,data = {slot = event.tmp[1].slot,id = event.tmp[1].id,type = 1,handler = function ()
                self:onPaybtClick()
        end}})   
    end

    ActivityData:RequestTakeCard(1,self.xsHeroType,handler)

end
--@auto code Freebt btFunc end

--@auto code Paybt btFunc
function ActivityHeroPopView:onPaybtClick()
    Functions.printInfo(self.debug,"Paybt button is click!")
    local handler = function(event)
    	-- self:rankPlayer(self._rankListView_t,event.rankPlayer)	
    	Functions.setAdbrixTag("retension","newhero_buy_nonfree", tostring(PlayerData.eventAttr.m_level))

        self:getController():openChildView("app.ui.popViews.EnlistThreePopView", {isRemove = true,data = {slot = event.tmp[1].slot,id = event.tmp[1].id, type = 1,handler = function ()
        		self:onPaybtClick()
        end} })   
    end
    ActivityData:RequestTakeCard(2,self.xsHeroType,handler)
end
--@auto code Paybt btFunc end

--@auto button backcall end


--@auto code output func
function ActivityHeroPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function ActivityHeroPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	Functions.setPopupKey("limit_hero")
	Functions.setAdbrixTag("retension","newhero_buy_inter",PlayerData.eventAttr.m_level)
	self.xsHeroType = data.type
	self:initDisplay()

    Functions.handGuideOfFeild("isGuideActivityHero", 1001)
end

function ActivityHeroPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function ActivityHeroPopView:initDisplay()
	 local move1 = cc.MoveBy:create(0.4,cc.p(-6,0))
     local move2 = cc.MoveBy:create(0.4,cc.p(6,0))
     local move3 = cc.MoveBy:create(0.4,cc.p(-6,0))
     local move4 = cc.MoveBy:create(0.4,cc.p(6,0))
     Functions.playSequenceAction(self._rightBt_t, {{actionName = move1, repeatNum = 1},{actionName = move2, repeatNum = 1}}) 
     Functions.playSequenceAction(self._leftBt_t, {{actionName = move4, repeatNum = 1},{actionName = move3, repeatNum = 1}}) 
	--卡牌展示
	self:showHero()
	--元宝绑定显示
	self._gold_t:setString(tostring(ActivityData.eventAttr.gold))
	Functions.bindUiWithModelAttr(self._gold_t, ActivityData, "gold")
	--积分
	self._nowFen_t:setString(tostring(ActivityData.eventAttr.score))
	Functions.bindUiWithModelAttr(self._nowFen_t, ActivityData, "score")
	--排名
	self._nowRank_t:setString(tostring(ActivityData.eventAttr.rank))
	Functions.bindUiWithModelAttr(self._nowRank_t, ActivityData, "rank")

	--活动时间
	self._date_t:setString(tostring(ActivityData.xsHero.startTime.year) .. "." ..
						   tostring(ActivityData.xsHero.startTime.month) .. "." ..
						   tostring(ActivityData.xsHero.startTime.day) .. "~" ..
						   tostring(ActivityData.xsHero.endTime.year) .. "." ..
						   tostring(ActivityData.xsHero.endTime.month) .. "." ..
						   tostring(ActivityData.xsHero.endTime.day)
						  )
	--活动倒计时
    local time = TimerManager:format_time(math.floor(ActivityData.eventAttr.activityHeroTime),LanguageConfig.language_activity_2)
	self._time_t:setString(time)
	Functions.bindUiWithModelAttr(self._time_t, ActivityData, "activityHeroTime",function(event)
        -- local sTime = TimerManager:formatTime(LanguageConfig.language_activity_2, event.data)
        local sTime = TimerManager:format_time(math.floor(event.data),LanguageConfig.language_activity_2)
	   	self._time_t:setString(sTime)
	   	if event.data <= 1 then 
	   		self:getController():closeChildView(self)
	   	end
	end)
	--免费抽卡cd时间
    -- self:showTime(self._freeTime_t)
	if ActivityData.eventAttr.freeHeroRemainTime < 1 then
        Functions.setEnabledBt(self._freeBt_t, true)
    else
        Functions.setEnabledBt(self._freeBt_t, false)
    end
    Functions.bindUiWithModelAttr(self._freeTime_t, ActivityData, "freeHeroRemainTime",function(event)
        local sTime = TimerManager:formatTime("!%H:%M:%S", event.data)
	    self._freeTime_t:setString(sTime)
	    if ActivityData.eventAttr.freeHeroRemainTime < 1 then
        	Functions.setEnabledBt(self._freeBt_t, true)
	    else
	        Functions.setEnabledBt(self._freeBt_t, false)
    	end
	end)
    

	--玩家排行
    self:rankPlayer(self._rankListView_t,ActivityData.eventAttr.rankPlayer)
    Functions.bindUiWithModelAttr(self._time_t, ActivityData, "rankPlayer",function(event)
        self:rankPlayer(self._rankListView_t,event.data)
	end)

    --提示信息
    self._payCount_t:setString(tostring(ActivityData.eventAttr.count))
    Functions.bindUiWithModelAttr(self._payCount_t, ActivityData,"count")
--    self._hero_t:setString(ActivityData.xsHero.tips) 

    --排名奖励信息
    self:rankRewardDescribe(self._infListView_t,ActivityData.xsHero.rankDescribe)
end
--显示倒记时
function ActivityHeroPopView:showTime(widget)
	if widget.timeSprite then
		return
	end
    --任务倒记时
    widget.timeSprite = Functions.createSprite()
    widget:addChild(widget.timeSprite)        
    local onTime = function(event)
        if ActivityData.eventAttr.cdTime > 0 then 
            local m_newtime = TimerManager:getCurrentSecond()
            local tm = m_newtime - ActivityData.eventAttr.cdTime
            if tm < 0 then
                tm = 0
            end
            m_newtime = ActivityData.xsHero.CD - tm
            if m_newtime < 0 then 
                ActivityData.eventAttr.cdTime = 0
                Functions.setEnabledBt(self._freeBt_t, true)  
             --    widget:removeChild(widget.timeSprite)
            	-- widget.timeSprite = nil     
            end
            if m_newtime >= 0 then
            	local time = TimerManager:formatTime("!%H:%M:%S", m_newtime)
            	widget:setString(time)  
        	end
--            print("时间流淌。。。。")
--            print(ActivityData.eventAttr.cdTime)
--            print("倒计时。。。。")
--            print(m_newtime)
--            print("CD时间。。。。")
--            print(m_newtime)
--        else
--            print("时间停止。。。。")
--            print(ActivityData.eventAttr.cdTime)
        end     
    end
    Functions.bindEventListener(widget.timeSprite, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
end

--卡牌展示
function ActivityHeroPopView:showHero()
	local handler = function(index,target,data,model)
		target:getChildByName("nameBoard"):setLocalZOrder(10)
		local nameView = target:getChildByName("nameBoard"):getChildByName("name")
	    nameView:setString(ConfigHandler:getHeroNameOfId(data))
	    nameView:setVisible(true)

	    local star = ConfigHandler:getHeroStarOfId(data) 
	    local heroImg = ""
	    -- if star > 5 then
	    --    heroImg = ConfigHandler:getHeroCard1ImageOfId(data)
	    -- else
	       heroImg = ConfigHandler:getActivityHeroCardImageOfId(data)
	    -- end
	    -- local heroView = target:getChildByName("heroView")
	    -- heroView:ignoreContentAdaptWithSize(true)

	    local heroView =  Functions.createSprite({pos = {x = 254,y =170}})
        heroView:setAnchorPoint(cc.p(0.5,0.5))

	    Functions.loadImageWithSprite(heroView,heroImg)
	    target:addChild(heroView)
    	heroView:setVisible(true)
	end
	local heroType = self.xsHeroType
    Functions.bindPageWithData(self._pageView_t, ActivityData.xsHero.showHero[self.xsHeroType], handler)
end
--玩家排行
function ActivityHeroPopView:rankPlayer(listView,playerData)
	local handler = function(index,widget,data,model)
		local rankView = widget:getChildByName("rank")
		rankView:setString(tostring(index))
		local nameView = widget:getChildByName("name")
		Functions.initTextColor(model:getChildByName("name"),nameView)
		nameView:setString(data.name)
		local fenView = widget:getChildByName("fen")
		Functions.initTextColor(model:getChildByName("fen"),fenView)
		fenView:setString(tostring(data.score))
	end
	Functions.bindListWithData(listView,playerData, handler)
end
--排名领奖描述
function ActivityHeroPopView:rankRewardDescribe(listView,describeData)
	local handler = function(index,widget,data,model)
		local infView = widget:getChildByName("inf")
		Functions.initTextColor(model:getChildByName("inf"),infView)
		infView:setString(data)
        local richText = ccui.RichText:create()
        infView:getParent():addChild(richText)
        Functions.setSubStrAttr(infView,richText,LanguageConfig.language_attrConfig)
	end
	Functions.bindListWithData(listView,describeData, handler)
end
return ActivityHeroPopView