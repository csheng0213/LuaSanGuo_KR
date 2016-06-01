--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local SweepPopView = class("SweepPopView", BasePopView)

local Functions = require("app.common.Functions")

SweepPopView.csbResPath = "tyj/csb"
SweepPopView.debug = true
SweepPopView.studioSpriteFrames = {"SweepPopUI","CBO_pveSbg" }
--@auto code head end

SweepPopView.spriteFrameNames = 
    {
    }
--@auto code uiInit
--add spriteFrames
if #SweepPopView.studioSpriteFrames > 0 then
    SweepPopView.spriteFrameNames = SweepPopView.spriteFrameNames or {}
    table.insertto(SweepPopView.spriteFrameNames, SweepPopView.studioSpriteFrames)
end
function SweepPopView:onInitUI()

    --output list
    self._levelNum_t = self.csbNode:getChildByName("Panel_1"):getChildByName("levelNum")
	self._totalNumLabel_t = self.csbNode:getChildByName("Panel_1"):getChildByName("totalNumLabel")
	self._powerLeble_t = self.csbNode:getChildByName("Panel_1"):getChildByName("powerLeble")
	
    --label list
    
    --button list
    self._closeBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))

	self._addBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("addBt")
	self._addBt_t:onTouch(Functions.createClickListener(handler(self, self.onAddbtClick), ""))

	self._okBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("okBt")
	self._okBt_t:onTouch(Functions.createClickListener(handler(self, self.onOkbtClick), ""))

	self._miuBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("miuBt")
	self._miuBt_t:onTouch(Functions.createClickListener(handler(self, self.onMiubtClick), ""))

	self._saodangBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("saodangBt")
	self._saodangBt_t:onTouch(Functions.createClickListener(handler(self, self.onSaodangbtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function SweepPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:close()
end
--@auto code Closebt btFunc end

--@auto code Addbt btFunc
function SweepPopView:onAddbtClick()
    Functions.printInfo(self.debug,"Addbt button is click!")
end
--@auto code Addbt btFunc end

--@auto code Okbt btFunc
function SweepPopView:onOkbtClick()
    Functions.printInfo(self.debug,"Okbt button is click!")
    local callBack = function (data)
    	local prizeTabel = {}
    	for i=1,#data.result do
    		prizeTabel[#prizeTabel+1] = {coin = data.result[i].reward.money,
    									 exp = data.result[i].reward.exps, 
    									 soul = data.result[i].reward.soul, 
    									 prize =  data.result[i].reward.item
    									}
    	end
    	--消耗扫荡令
        PropData:miuProp({m_id = 43,m_count = 1} )
    	-- local sweepCompleteView = require("app.ui.popViews.SweepCompletePopView"):new()
        self:getController():openChildView("app.ui.popViews.SweepCompletePopView", { isRemove = false, data = { prizeTabel = prizeTabel,
         lvlCh = data.levelChange,  upLevelAward = data.allgoods} })
    end
   	BiographyData:getSweepData(1, callBack)
--      local prizeTabel = {}
--      for i=1,10 do
--          prizeTabel[#prizeTabel+1] = {coin = 100,
--                                       exp = 100, 
--                                       soul = 100, 
--                                       prize =  {}
--                                      }
--      end   	
--    local sweepCompleteView = require("app.ui.popViews.SweepCompletePopView"):new()
--    self:getController():openChildView(sweepCompleteView, {isRemove = false,data = {prizeTabel = prizeTabel, lvlCh = 1}})
end
--@auto code Okbt btFunc end

--@auto code Miubt btFunc
function SweepPopView:onMiubtClick()
    Functions.printInfo(self.debug,"Miubt button is click!")
end
--@auto code Miubt btFunc end

--@auto code Saodangbt btFunc
function SweepPopView:onSaodangbtClick()
    Functions.printInfo(self.debug,"Saodangbt button is click!")

   
--	self:updateDisplay()
    local callBack = function (data)
    	local prizeTabel = {}
    	for i=1,#data.result do
    		prizeTabel[#prizeTabel+1] = {coin = data.result[i].reward.money,
    									 exp = data.result[i].reward.exps, 
    									 soul = data.result[i].reward.soul, 
    									 prize =  data.result[i].reward.item
    									}
    	end
    	--消耗扫荡令
    	local temp = self.curNum
    	PropData:miuProp({m_id = 43,m_count = self.curNum} )
    	-- local sweepCompleteView = require("app.ui.popViews.SweepCompletePopView"):new()--cs
        self:getController():openChildView("app.ui.popViews.SweepCompletePopView", { isRemove = false, data = { prizeTabel = prizeTabel, lvlCh = data.levelChange, upLevelAward = data.allgoods} })
    end
   	BiographyData:getSweepData(self.curNum, callBack)
--	    else
--	    	PromptManager:openTipPrompt(LanguageConfig.language_sweep_4)
--	    end
--    end
end
--@auto code Saodangbt btFunc end

--@auto button backcall end


--@auto code output func
function SweepPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function SweepPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
    self.handler = data.handler
    self.customPower = data.levelPower --单词消耗需要的体力
    self.keSaoDangNum =  data.levelNum  --可扫荡次数
	self:updateDisplay()
end

function SweepPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function SweepPopView:updateDisplay()
    Functions.setEnabledBt(self._saodangBt_t, false)
    Functions.setEnabledBt(self._okBt_t, false)
    local propNum = PropData:getPropNumOfId(43) or 0 -- 扫荡令多少
    
    self.curNum = 0  --扫荡N次的
    if propNum <= 0 or self.keSaoDangNum <= 0  or PlayerData.eventAttr.m_energy < self.customPower then 
        Functions.setEnabledBt(self._saodangBt_t, false)
        Functions.setEnabledBt(self._okBt_t, false)
    else
        Functions.setEnabledBt(self._okBt_t, true)
        local tt = self.keSaoDangNum
        self.curNum = self.keSaoDangNum
        if self.curNum >= propNum then
            self.curNum = propNum
        end
        if self.curNum * self.customPower >= PlayerData.eventAttr.m_energy then
            self.curNum = Functions.subIntOfNum(PlayerData.eventAttr.m_energy/self.customPower)
        end
        local temp = self.curNum
        if BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_PVE then
            if g_VipCgf.OpenSweepLevel[VipData.eventAttr.m_vipLevel][1] >= 10 then 
                Functions.setEnabledBt(self._saodangBt_t, true)
                if self.curNum >= 10 then
                    self._saodangBt_t:getChildByName("sdNum"):setString(tostring(10))
                    self.curNum = 10
                else
                    self._saodangBt_t:getChildByName("sdNum"):setString(tostring(self.curNum))
                end 

            else        
                Functions.setEnabledBt(self._saodangBt_t, false)
                self._saodangBt_t:getChildByName("sdNum"):setString(tostring(10))
            end
        elseif BiographyData.eventAttr.curFbType == CombatCenter.CombatType.RB_ElitePVE then 
            --      self.saoDangCount = g_VipCgf.OpenSweepLevel[VipData.eventAttr.m_vipLevel][2]
            if g_VipCgf.OpenSweepLevel[VipData.eventAttr.m_vipLevel][2] >= 3 then 
                Functions.setEnabledBt(self._saodangBt_t, true)
                if self.curNum >= 3 then
                    self._saodangBt_t:getChildByName("sdNum"):setString(tostring(3))
                    self.curNum = 3
                else
                    self._saodangBt_t:getChildByName("sdNum"):setString(tostring(self.curNum))
                end
            else        
                Functions.setEnabledBt(self._saodangBt_t, false)
                self._saodangBt_t:getChildByName("sdNum"):setString(tostring(3))
            end     
        end
    end    
    if self.curNum <= 1 then
        Functions.setEnabledBt(self._saodangBt_t, false)
    end
    
	self._totalNumLabel_t:setString(PropData:getPropNumOfId(43) or 0 )
--	self._levelNum_t:setString(tostring(self.curNum) .. "/" .. tostring(self.levelNum))
    self._powerLeble_t:setString(tostring(self.customPower))
end
return SweepPopView