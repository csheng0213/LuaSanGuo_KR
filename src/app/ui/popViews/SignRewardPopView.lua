--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local SignRewardPopView = class("SignRewardPopView", BasePopView)

local Functions = require("app.common.Functions")

SignRewardPopView.csbResPath = "tyj/csb"
SignRewardPopView.debug = true
SignRewardPopView.studioSpriteFrames = {"PropUI","SignRewardPopUI","SignRewardPopUI_Text" }
--@auto code head end
SignRewardPopView.spriteFrameNames = 
    {
    }

SignRewardPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #SignRewardPopView.studioSpriteFrames > 0 then
    SignRewardPopView.spriteFrameNames = SignRewardPopView.spriteFrameNames or {}
    table.insertto(SignRewardPopView.spriteFrameNames, SignRewardPopView.studioSpriteFrames)
end
function SignRewardPopView:onInitUI()

    --output list
    self._signPrizePanel_t = self.csbNode:getChildByName("signPrizePanel")
	
    --label list
    
    --button list
    self._closeBt_t = self.csbNode:getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function SignRewardPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:close()
end
--@auto code Closebt btFunc end

--@auto button backcall end


--@auto code output func
function SignRewardPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function SignRewardPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    Functions.setPopupKey("sign_in")
    self:initPrizeList(self._signPrizePanel_t,g_SampleCfg.NewReward,RewardStateData.rewardState)

    self._prizeBt_t = self._signPrizePanel_t:getChildByTag(1):getChildByName("bg")
end

function SignRewardPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

--custom code start
function SignRewardPopView:initPrizeList(prizePanel,prizeData,prizeStateData)
 
    for i = 1,#prizeData do
        local prizeBox = prizePanel:getChildByTag(i)        
        local prize1 = prizeBox:getChildByName("prize1")
        local prize2 = prizeBox:getChildByName("prize2")
        local prize3 = prizeBox:getChildByName("prize3")
        prize1:ignoreContentAdaptWithSize(true)
        prize2:ignoreContentAdaptWithSize(true)
        prize3:ignoreContentAdaptWithSize(true)
        local prize1Cnt = prizeBox:getChildByName("prize1Cnt")
        local prize2Cnt = prizeBox:getChildByName("prize2Cnt")
        local prize3Cnt = prizeBox:getChildByName("prize3Cnt")
        prize1Cnt:setString("x" .. tostring(prizeData[i][1][3]))
        prize2Cnt:setString("x" .. tostring(prizeData[i][2][3]))
        prize3Cnt:setString("x" .. tostring(prizeData[i][3][3]))
        
        local mask = prizeBox:getChildByName("mask")
        local done = prizeBox:getChildByName("done")
        local choose = prizeBox:getChildByName("choose")
        local prize = prizeBox:getChildByName("bg")

        if prizeData[i][1][2] == 1 then
            local heroHeadImg = ConfigHandler:getHeroHeadImageOfId(prizeData[i][1][1]) 
            Functions.loadImageWithWidget(prize1, heroHeadImg)
        elseif prizeData[i][1][2] == 4 and prizeData[i][1][1] > 0 then
            local propImg = ConfigHandler:getPropImageOfId(prizeData[i][1][1]) 
            Functions.loadImageWithWidget(prize1, propImg)
        elseif prizeData[i][1][1] == -3 then
            Functions.loadImageWithWidget(prize1, "property_money.png")
        elseif prizeData[i][1][1] == -2 then
            Functions.loadImageWithWidget(prize1, "property_gold.png")
        elseif prizeData[i][1][1] == -5 then
            Functions.loadImageWithWidget(prize1, "soul80.png")
        elseif prizeData[i][1][1] == -6 then    
            Functions.loadImageWithWidget(prize1, "property_soulCrystal.png")
        end
        
        if prizeData[i][2][2] == 1 then
            local heroHeadImg = ConfigHandler:getHeroHeadImageOfId(prizeData[i][1][1]) 
            Functions.loadImageWithWidget(prize2, heroHeadImg)
        elseif prizeData[i][2][2] == 4 and prizeData[i][2][1] > 0 then
            local propImg = ConfigHandler:getPropImageOfId(prizeData[i][2][1]) 
            Functions.loadImageWithWidget(prize2, propImg)
        elseif prizeData[i][2][1] == -3 then
            Functions.loadImageWithWidget(prize2, "property_money.png")
        elseif prizeData[i][2][1] == -2 then
            Functions.loadImageWithWidget(prize2, "property_gold.png")
        elseif prizeData[i][2][1] == -5 then
            Functions.loadImageWithWidget(prize2, "soul80.png")
        elseif prizeData[i][2][1] == -6 then    
            Functions.loadImageWithWidget(prize2, "property_soulCrystal.png")
        end
        
        if prizeData[i][3][2] == 1 then
            local heroHeadImg = ConfigHandler:getHeroHeadImageOfId(prizeData[i][3][1]) 
            Functions.loadImageWithWidget(prize3, heroHeadImg)
        elseif prizeData[i][3][2] == 4 and prizeData[i][3][1] > 0 then
            local propImg = ConfigHandler:getPropImageOfId(prizeData[i][3][1]) 
            Functions.loadImageWithWidget(prize3, propImg)
        elseif prizeData[i][3][1] == -3 then
            Functions.loadImageWithWidget(prize3, "property_money.png")
        elseif prizeData[i][3][1] == -2 then
            Functions.loadImageWithWidget(prize3, "property_gold.png")
        elseif prizeData[i][3][1] == -5 then
            Functions.loadImageWithWidget(prize3, "soul80.png")
        elseif prizeData[i][3][1] == -6 then    
            Functions.loadImageWithWidget(prize3, "property_soulCrystal.png")
        end

        if i == prizeStateData.m_keepLoginDay and  prizeStateData.m_loginReward == 1 then
            mask:setVisible(true)
            done:setVisible(true)
            choose:setVisible(true) 
            prize:setTouchEnabled(false)
        elseif  i < prizeStateData.m_keepLoginDay and  prizeStateData.m_loginReward == 1 then
            mask:setVisible(true)
            done:setVisible(true)
            prize:setTouchEnabled(false)
        elseif i < prizeStateData.m_keepLoginDay then
             mask:setVisible(true) 
             done:setVisible(true)
             prize:setTouchEnabled(false)
        elseif i == prizeStateData.m_keepLoginDay and prizeStateData.m_loginReward ~= 1 then --当前可领取状态
            choose:setVisible(true) 
            prize:setTouchEnabled(true)
        end
        local onPrizeClick = function()
            local handler = function(event)
                Functions.playSound("getrewards.mp3")
                mask:setVisible(true)
                done:setVisible(true)
                prize:setTouchEnabled(false)   
                prizeStateData.m_loginReward = 1    
                Functions:addItemResources({id = prizeData[i][1][1],type = prizeData[i][1][2],count = prizeData[i][1][3],slot = event.rettbl[1]})
                Functions:addItemResources({id = prizeData[i][2][1],type = prizeData[i][2][2],count = prizeData[i][2][3],slot = event.rettbl[2]})
                Functions:addItemResources({id = prizeData[i][3][1],type = prizeData[i][3][2],count = prizeData[i][3][3],slot = event.rettbl[3]})
                RewardStateData.eventAttr.signRewardFlag = 0   --签到领奖：是否有奖可领 1/0
            end
            RewardData:RequestSignReward(handler)
        end
        prize:onTouch(Functions.createClickListener(handler(prize, onPrizeClick), ""))
    end
   
    local dayCnt = prizePanel:getChildByName("dayCnt")
    dayCnt:setString(tostring(prizeStateData.m_keepLoginDay))
end
--custom code end
return SignRewardPopView