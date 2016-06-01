--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local CombatAwardPopView = class("CombatAwardPopView", BasePopView)

local Functions = require("app.common.Functions")

CombatAwardPopView.csbResPath = "cs/csb"
CombatAwardPopView.debug = true
CombatAwardPopView.studioSpriteFrames = {"CombatAwardPopUI_Text" }
--@auto code head end

CombatAwardPopView.spriteFrameNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #CombatAwardPopView.studioSpriteFrames > 0 then
    CombatAwardPopView.spriteFrameNames = CombatAwardPopView.spriteFrameNames or {}
    table.insertto(CombatAwardPopView.spriteFrameNames, CombatAwardPopView.studioSpriteFrames)
end
function CombatAwardPopView:onInitUI()

    --output list
    self._award_panel_t = self.csbNode:getChildByName("award_panel")
	self._isReceive_t = self.csbNode:getChildByName("award_panel"):getChildByName("isReceive")
	self._need_star_num_t = self.csbNode:getChildByName("award_panel"):getChildByName("need_star_num")
	self._star_num_t = self.csbNode:getChildByName("award_panel"):getChildByName("star_num")
	self._partNode1_t = self.csbNode:getChildByName("award_panel"):getChildByName("partNode1")
	self._disNode_t = self.csbNode:getChildByName("award_panel"):getChildByName("partNode1"):getChildByName("disNode")
	self._num_t = self.csbNode:getChildByName("award_panel"):getChildByName("partNode1"):getChildByName("num")
	self._partNode2_t = self.csbNode:getChildByName("award_panel"):getChildByName("partNode2")
	self._num2_t = self.csbNode:getChildByName("award_panel"):getChildByName("partNode2"):getChildByName("num2")
	self._disNode2_t = self.csbNode:getChildByName("award_panel"):getChildByName("partNode2"):getChildByName("disNode2")
	
    --label list
    
    --button list
    self._receiveBt_t = self.csbNode:getChildByName("award_panel"):getChildByName("receiveBt")
	self._receiveBt_t:onTouch(Functions.createClickListener(handler(self, self.onReceivebtClick), ""))

	self._close_t = self.csbNode:getChildByName("award_panel"):getChildByName("close")
	self._close_t:onTouch(Functions.createClickListener(handler(self, self.onCloseClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Receivebt btFunc
function CombatAwardPopView:onReceivebtClick()
    Functions.printInfo(self.debug,"Receivebt button is click!")
end
--@auto code Receivebt btFunc end

--@auto code Close btFunc
function CombatAwardPopView:onCloseClick()
    Functions.printInfo(self.debug,"Close button is click!")
    self:close()
end
--@auto code Close btFunc end

--@auto button backcall end


--@auto code output func
function CombatAwardPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	
    Functions.initLabelOfString(self._star_num_t, data.awardData.curStarCount, self._need_star_num_t, data.awardData.neetStarCount)
	if data.awardData.isReceive == 1 then
		self._receiveBt_t:setVisible(false)
		self._isReceive_t:setVisible(true)
	else
		self._isReceive_t:setVisible(false)
        self._receiveBt_t:setVisible(true)
        if data.awardData.curStarCount >= data.awardData.neetStarCount then
            Functions.setEnabledBt(self._receiveBt_t, true)
        else
            Functions.setEnabledBt(self._receiveBt_t, false)
		end
		
		local onReceiveAwardClick = function()
            BiographyData:receiveAwared(BiographyData.eventAttr.curSelectFbId, data.awardType, data.awardData.award.gold, handler(self, self.onReceiveAwardSuccess))
		end
        self._receiveBt_t:onTouch(Functions.createClickListener(onReceiveAwardClick))
	end
	
	--初始化掉落物品
	self._disNode_t:getChildByName("disImage"):setVisible(false)
	if data.awardType == 0 then   --奖励类型， 0 普通奖励 1 精英奖励
		self._partNode1_t:getChildByName("coin"):setVisible(true)
		self._partNode1_t:getChildByName("yb"):setVisible(false)
		self._num_t:setString(data.awardData.award.money)
	else
		self._partNode1_t:getChildByName("coin"):setVisible(false)
		self._partNode1_t:getChildByName("yb"):setVisible(true)
		self._num_t:setString(data.awardData.award.gold)
	end

	local partNode = Functions.createPartNode({ nodeType = data.awardData.award.item[1][2], nodeId = data.awardData.award.item[1][1] })
	self._disNode2_t:setVisible(false)

	Functions.copyParam(self._disNode2_t, partNode)
	self._disNode2_t:getParent():addChild(partNode)

	self._num2_t:setString(data.awardData.award.item[1][3])
	
end

function CombatAwardPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function CombatAwardPopView:onReceiveAwardSuccess()
	self._receiveBt_t:setVisible(false)
    self._isReceive_t:setVisible(true)
end

return CombatAwardPopView