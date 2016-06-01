--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local PayPopView = class("PayPopView", BasePopView)

local Functions = require("app.common.Functions")

PayPopView.csbResPath = "tyj/csb"
PayPopView.debug = true
PayPopView.studioSpriteFrames = {"PayUI","CB_unionTankuang" }
--@auto code head end

PayPopView.spriteFrameNames = 
    {
    }
PayPopView.animaNames = 
{
    "An_taskReward"
}
--@auto code uiInit
--add spriteFrames
if #PayPopView.studioSpriteFrames > 0 then
    PayPopView.spriteFrameNames = PayPopView.spriteFrameNames or {}
    table.insertto(PayPopView.spriteFrameNames, PayPopView.studioSpriteFrames)
end
function PayPopView:onInitUI()

    --output list
    self._payListView_t = self.csbNode:getChildByName("Panel_1"):getChildByName("payListView")
	self._firstPay_t = self.csbNode:getChildByName("Panel_1"):getChildByName("firstPay")
	
    --label list
    
    --button list
    self._closeBt_t = self.csbNode:getChildByName("Panel_1"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function PayPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:close(self)
end
--@auto code Closebt btFunc end

--@auto button backcall end


--@auto code output func
function PayPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function PayPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
  Functions.setPopupKey("buy_gold")
  Functions.setAdbrixTag("retension","gold_recharging_inter",PlayerData.eventAttr.m_level)
  Functions.bindEventListener(self, GameEventCenter, "PAY_ACTIVITY", function (event)
        self:initDisplayUI()
    end)
  self:initDisplayUI()
end

function PayPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
	-- local inf = LanguageConfig.language_pay_3
    
end
--@auto code output func end
function PayPopView:initDisplayUI()
  if PlayerData.eventAttr.m_vipFirstFlag == 0 then 
      self._firstPay_t:getChildByName("inf"):setString(LanguageConfig.ui_payInf_1)
      self._firstPay_t:setVisible(true)
  else
      self._firstPay_t:setVisible(false)
  end
	local listHandler = function(index, widget, model, data)
		local payGoldLabel = widget:getChildByName("payGoldLabel")
        local rmb = widget:getChildByName("rmb")
--        local inf = widget:getChildByName("inf")
		    local rewardBox = widget:getChildByName("rewardBox")
        self:playRewardBoxAni(rewardBox)
       if VipData.eventAttr.payActivity ~= nil and VipData.eventAttr.payActivity.flags[data["gold"]] then 
           rewardBox:setVisible(true)
           rewardBox:onTouch(Functions.createClickListener(function()
               NoticeManager:openPayRewardTips(GameCtlManager.currentController_t,{rewardData = VipData.eventAttr.payActivity.rewards[data["gold"]],inf = VipData.eventAttr.payActivity.infs[data["gold"]] })
           end), "zoom")
       else
           rewardBox:setVisible(false)
       end
        

        payGoldLabel:setString(data.show_goldStr)
		
		    Functions.initTextColor(model:getChildByName("payGoldLabel"),payGoldLabel)
		
        rmb:setString(tostring(data.show_moneyStr))
        Functions.initTextColor(model:getChildByName("rmb"),rmb)

        if data.isRecommand then 
           local recommandTag = widget:getChildByName("payRec")
           recommandTag:setVisible(true)
        end
        if data.rate > 0 then 
          local bonus = widget:getChildByName("bonus")
          bonus:setVisible(true)
          bonus:getChildByName("rate"):setString(tostring(data.rate) .. "%")
        end
        -- if index == 7 then 
        --     inf:setString(LanguageConfig.language_pay_5)
        -- else
        --     inf:setString(LanguageConfig.language_pay_3)
        -- end    
--        inf:setString(data.inf)    
--        Functions.initTextColor(model:getChildByName("inf"),inf)
--        if PlayerData.eventAttr.m_vipFirstFlag == 0 then 
--           inf:setVisible(true)
--        else
--           inf:setVisible(false)
--        end
        local payView = widget:getChildByName("payView")
        payView:ignoreContentAdaptWithSize(true)
        Functions.loadImageWithWidget(payView, "tyj/dynamicUI_res/" .. data.img)
      	
      	local onWidgetBtClick = function(event)
             Functions.printInfo(self.debug," onWidgetClick") 
             Functions.setAdbrixTag("retension","gold_recharging_inter")  
             Functions.callJavaFuc(function()
                PromptManager:openHttpLinkPrompt()   
                NativeUtil:javaCallHanler({command = "pay",productCode = data.productCode,productName = data.productName})
             end)         
        end
      	widget:onTouch(Functions.createClickListener(onWidgetBtClick, "zoom"))
    end
  if G_SDKType == 1 then
	   Functions.bindArryListWithData(self._payListView_t,{ firstData = g_payProductConfig_Nstore }, listHandler,{direction = true, col = 2, firstSegment = 10, segment = 15 })
  elseif G_SDKType == 2 then 
     Functions.bindArryListWithData(self._payListView_t,{ firstData = g_payProductConfig_Tstore }, listHandler,{direction = true, col = 2, firstSegment = 10, segment = 15 })
  elseif G_SDKType == 3 then
     Functions.bindArryListWithData(self._payListView_t,{ firstData = g_payProductConfig_Cstore }, listHandler,{direction = true, col = 2, firstSegment = 10, segment = 15 })
  elseif G_SDKType == 4 then
     Functions.bindArryListWithData(self._payListView_t,{ firstData = g_payProductConfig_Gplay }, listHandler,{direction = true, col = 2, firstSegment = 10, segment = 15 }) 
  elseif G_SDKType == 5 then
     Functions.bindArryListWithData(self._payListView_t,{ firstData = g_payProductConfig_Astore }, listHandler,{direction = true, col = 2, firstSegment = 10, segment = 15 }) 
  end 
end
function PayPopView:playRewardBoxAni(target)
    local animationSprite = cc.Sprite:create()
    animationSprite:setPosition(cc.p(target:getContentSize().width/2,target:getContentSize().height/2))
    target:addChild(animationSprite)
    Functions.playAnimaOfUI(animationSprite, "An_taskReward", 0)
end
return PayPopView