--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local PayRewardPopView = class("PayRewardPopView", BasePopView)

local Functions = require("app.common.Functions")

PayRewardPopView.csbResPath = "tyj/csb"
PayRewardPopView.debug = true
PayRewardPopView.studioSpriteFrames = {"CBO_cz_bg" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #PayRewardPopView.studioSpriteFrames > 0 then
    PayRewardPopView.spriteFrameNames = PayRewardPopView.spriteFrameNames or {}
    table.insertto(PayRewardPopView.spriteFrameNames, PayRewardPopView.studioSpriteFrames)
end
function PayRewardPopView:onInitUI()

    --output list
    self._rewardPanel_t = self.csbNode:getChildByName("rewardPanel")
	self._prizePanel_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("prizePanel")
	self._describe_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("describe")
	
    --label list
    
    --button list
    self._okBt_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("okBt")
	self._okBt_t:onTouch(Functions.createClickListener(handler(self, self.onOkbtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Okbt btFunc
function PayRewardPopView:onOkbtClick()
    Functions.printInfo(self.debug,"Okbt button is click!")
     self:close()
end
--@auto code Okbt btFunc end

--@auto button backcall end


--@auto code output func
function PayRewardPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function PayRewardPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    if self.rewardData ~= nil then
        Functions.createPrizeNode(self._prizePanel_t,self.rewardData) 
    end
    if self.inf then 
        self._describe_t:setString(self.inf)
    end
end

function PayRewardPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function PayRewardPopView:setRewards(rewardData)
   self.rewardData = rewardData
end
function PayRewardPopView:setInf(inf)
   self.inf = inf
end
return PayRewardPopView