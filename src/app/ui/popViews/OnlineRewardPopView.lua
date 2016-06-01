--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local OnlineRewardPopView = class("OnlineRewardPopView", BasePopView)

local Functions = require("app.common.Functions")

OnlineRewardPopView.csbResPath = "tyj/csb"
OnlineRewardPopView.debug = true
OnlineRewardPopView.studioSpriteFrames = {"OnlineRewardPopUI","RewardTipsPopUI" }
--@auto code head end
OnlineRewardPopView.spriteFrameNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #OnlineRewardPopView.studioSpriteFrames > 0 then
    OnlineRewardPopView.spriteFrameNames = OnlineRewardPopView.spriteFrameNames or {}
    table.insertto(OnlineRewardPopView.spriteFrameNames, OnlineRewardPopView.studioSpriteFrames)
end
function OnlineRewardPopView:onInitUI()

    --output list
    self._time_t = self.csbNode:getChildByName("Panel_140"):getChildByName("time")
	self._complateTips_t = self.csbNode:getChildByName("Panel_140"):getChildByName("complateTips")
	self._prizePanel_t = self.csbNode:getChildByName("Panel_140"):getChildByName("prizePanel")
	
    --label list
    
    --button list
    self._closeBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))

	self._rewardBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("rewardBt")
	self._rewardBt_t:onTouch(Functions.createClickListener(handler(self, self.onRewardbtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function OnlineRewardPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:getController():closeChildView(self)
end
--@auto code Closebt btFunc end

--@auto code Rewardbt btFunc
function OnlineRewardPopView:onRewardbtClick()
    Functions.printInfo(self.debug,"Rewardbt button is click!")
    local handler = function (event)
    	PromptManager:openTipPrompt(LanguageConfig.language_activity_1)
        if ActivityData.eventAttr.m_onlineIndex < #ActivityData.onlineReward.Rewards then
			ActivityData.eventAttr.m_onlineIndex = ActivityData.eventAttr.m_onlineIndex + 1 
			local prize1 = self._prizePanel_t:getChildByName("prize1")
			local prize2 = self._prizePanel_t:getChildByName("prize2")
			prize1:retain()
			prize2:retain()
            Functions.addCleanFuncWithNode(self._prizePanel_t, function()
								            	prize1:release()
								          end)
            Functions.addCleanFuncWithNode(self._prizePanel_t, function()
								            	prize2:release()
								          end)
			self._prizePanel_t:removeAllChildren()
			self._prizePanel_t:addChild(prize1)
			self._prizePanel_t:addChild(prize2)
            self:displayPrize(ActivityData.eventAttr.m_onlineIndex)
    	end
    	Functions.playSound("getrewards.mp3")
    end    
    ActivityData:RequestOnlineReward(handler)
end
--@auto code Rewardbt btFunc end

--@auto button backcall end


--@auto code output func
function OnlineRewardPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function OnlineRewardPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	Functions.setPopupKey("gift")
	self._rewardBt_t:setVisible(false)
	-- self:initDisplayUI()
	ActivityData:requireOnline(handler(self,self.initDisplayUI))
end

function OnlineRewardPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function OnlineRewardPopView:initDisplayUI( )
	self._rewardBt_t:setVisible(true)
	self:displayPrize(ActivityData.eventAttr.m_onlineIndex)	


	Functions.bindUiWithModelAttr(self._time_t, ActivityData, "remainTime",function(event)
	   local time = TimerManager:formatTime("!%H:%M:%S", event.data)
	   Functions.initLabelOfString(self._time_t, time)
	end)
	
	if ActivityData.eventAttr.m_onlinePrizeState == 1 then
        Functions.setEnabledBt(self._rewardBt_t, true)
        self._complateTips_t:setVisible(false) 
    	self._rewardBt_t:setVisible(true)               
	else
        Functions.setEnabledBt(self._rewardBt_t, false)
        if ActivityData.eventAttr.m_onlinePrizeState == 2 then 
	        if ActivityData.eventAttr.m_onlineIndex == #ActivityData.onlineReward.Rewards then
	    		self._complateTips_t:setVisible(true) 
	    		self._rewardBt_t:setVisible(false)
	    	end
    	end
    end
	Functions.bindUiWithModelAttr(self._rewardBt_t, ActivityData, "m_onlinePrizeState",function(event)
		if event.data == 1 then
	        Functions.setEnabledBt(self._rewardBt_t, true)
	        self._complateTips_t:setVisible(false) 
	    	self._rewardBt_t:setVisible(true)
		else
	        Functions.setEnabledBt(self._rewardBt_t, false)
	        if event.data == 2 then 
		        if ActivityData.eventAttr.m_onlineIndex == #ActivityData.onlineReward.Rewards then
		    		self._complateTips_t:setVisible(true) 
		    		self._rewardBt_t:setVisible(false)
		    	end
	    	end
	    end
	end)
end
function OnlineRewardPopView:displayPrize(index)
	local prizeData = Functions.packagePrizeConfig(ActivityData.onlineReward.Rewards[index])
    Functions.createPrizeNode(self._prizePanel_t,prizeData)
end
return OnlineRewardPopView