--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local FirstPayRewardPopView = class("FirstPayRewardPopView", BasePopView)

local Functions = require("app.common.Functions")

FirstPayRewardPopView.csbResPath = "tyj/csb"
FirstPayRewardPopView.debug = true
FirstPayRewardPopView.studioSpriteFrames = {"firstPayBg" }
--@auto code head end

FirstPayRewardPopView.spriteFrameNames = 
    {
    }
--@auto code uiInit
--add spriteFrames
if #FirstPayRewardPopView.studioSpriteFrames > 0 then
    FirstPayRewardPopView.spriteFrameNames = FirstPayRewardPopView.spriteFrameNames or {}
    table.insertto(FirstPayRewardPopView.spriteFrameNames, FirstPayRewardPopView.studioSpriteFrames)
end
function FirstPayRewardPopView:onInitUI()

    --output list
    self._npc_t = self.csbNode:getChildByName("Panel_140"):getChildByName("npc")
	self._money_t = self.csbNode:getChildByName("Panel_140"):getChildByName("money")
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
function FirstPayRewardPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:getController():closeChildView(self)
end
--@auto code Closebt btFunc end

--@auto code Rewardbt btFunc
function FirstPayRewardPopView:onRewardbtClick()
    Functions.printInfo(self.debug,"Rewardbt button is click!")
    local handler = function()
    	Functions.playSound("fisrtCharge.mp3")
        PromptManager:openTipPrompt(LanguageConfig.language_activity_1)
    end
    ActivityData:RequestFirstPayReward(handler)
end
--@auto code Rewardbt btFunc end

--@auto button backcall end


--@auto code output func
function FirstPayRewardPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function FirstPayRewardPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	Functions.setPopupKey("firstpay_gift")
    self:initDisplayUI()
end

function FirstPayRewardPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function FirstPayRewardPopView:initDisplayUI()
	Functions.createPrizeNode(self._prizePanel_t,VipData.eventAttr.firstRaward)
	Functions.loadImageWithSprite(self._npc_t,"npc/NPC_rw_firstPay.png")
	self._money_t:setString(tostring(VipData.eventAttr.payMoney))
	if PlayerData.eventAttr.m_vipFirstFlag == 1 then 
		Functions.setEnabledBt(self._rewardBt_t, true)
	else 
		Functions.setEnabledBt(self._rewardBt_t, false)
	end
	Functions.bindUiWithModelAttr(self._rewardBt_t, PlayerData, "m_vipFirstFlag",function(event)
		if event.data == 1 then
	        Functions.setEnabledBt(self._rewardBt_t, true)
		else
	        Functions.setEnabledBt(self._rewardBt_t, false)
	    end
	end)

end
return FirstPayRewardPopView