--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local RewardPopView = class("RewardPopView", BasePopView)

local Functions = require("app.common.Functions")

RewardPopView.csbResPath = "tyj/csb"
RewardPopView.debug = true
RewardPopView.studioSpriteFrames = {"RewardPopUI" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #RewardPopView.studioSpriteFrames > 0 then
    RewardPopView.spriteFrameNames = RewardPopView.spriteFrameNames or {}
    table.insertto(RewardPopView.spriteFrameNames, RewardPopView.studioSpriteFrames)
end
function RewardPopView:onInitUI()

    --output list
    self._rewardPanel_t = self.csbNode:getChildByName("rewardPanel")
	self._activeCntText_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("activeCntText")
	self._activeText_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("activeText")
	self._prize1_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("rewardView1"):getChildByName("prize1")
	self._prize2_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("rewardView2"):getChildByName("prize2")
	self._rewardLabel1_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("rewardLabel1")
	self._rewardLabel2_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("rewardLabel2")
	self._isAwardView_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("isAwardView")
	
    --label list
    
    --button list
    self._rewardBt_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("rewardBt")
	self._rewardBt_t:onTouch(Functions.createClickListener(handler(self, self.onRewardbtClick), ""))

	self._closeBt_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Rewardbt btFunc
function RewardPopView:onRewardbtClick()
    Functions.printInfo(self.debug,"Rewardbt button is click!")
    local handler = function()
        Functions.playSound("getrewards.mp3")
        Functions.setEnabledBt(self._rewardBt_t,false)
        self._rewardBt_t:setVisible(false)
        self._isAwardView_t:setVisible(true)            
        self._controller_t:initUiDisplay_()
    end
    TaskData:RequestTaskReward(self.rewardFlag,handler)
end
--@auto code Rewardbt btFunc end

--@auto code Closebt btFunc
function RewardPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:close()
end
--@auto code Closebt btFunc end

--@auto button backcall end


--@auto code output func
function RewardPopView:getPopAction()
    Functions.printInfo(self.debug,"pop actionFunc is call")
end

function RewardPopView:onDisplayView(data)
    Functions.printInfo(self.debug,"pop action finish ")
    local index = data[1]
    local prizeTable = {}
    for k,v in pairs(g_csMsnRewardBox[index][2]) do
        if k == "money" then
            prizeTable[#prizeTable+1] = {img = "property_money.png",num = v}
        elseif k == "gold" then
            prizeTable[#prizeTable+1] = {img = "property_gold.png",num = v}
        elseif k == "soul" then
            prizeTable[#prizeTable+1] = {img = "property_soul.png",num = v}
        elseif k == "hunjing" then
            prizeTable[#prizeTable+1] = {img = "property_soulCrystal.png",num = v}
        elseif k == "item" and v[1][1] ~= 0 then
            prizeTable[#prizeTable+1] = {img = ConfigHandler:getPropImageOfId(g_csMsnRewardBox[index][2].item[1][1]),num = v[1][3]}
        end
    end

    Functions.loadImageWithWidget(self._prize1_t, prizeTable[1].img)
    self._prize1_t:ignoreContentAdaptWithSize(true)
    self._rewardLabel1_t:setString(tostring(prizeTable[1].num))

    Functions.loadImageWithWidget(self._prize2_t,  prizeTable[2].img)
    self._rewardLabel2_t:setString(tostring( prizeTable[2].num))
    self._prize2_t:ignoreContentAdaptWithSize(true)

    self._activeCntText_t:setString(tostring(g_csMsnRewardBox[index][1]))
    if data[3][index] == true then
        Functions.setEnabledBt(self._rewardBt_t,false)
        self._rewardBt_t:setVisible(false)
        self._isAwardView_t:setVisible(true)
    elseif  data[2] >= g_csMsnRewardBox[index][1] then
        Functions.setEnabledBt(self._rewardBt_t,true)
        self._rewardBt_t:setBright(true)
        self.rewardFlag = index
    end
    self._activeText_t:setText(tostring(data[2]))
    
end

function RewardPopView:onCreate()
    Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
return RewardPopView