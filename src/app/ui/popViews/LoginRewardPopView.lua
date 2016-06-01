--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local LoginRewardPopView = class("LoginRewardPopView", BasePopView)

local Functions = require("app.common.Functions")

LoginRewardPopView.csbResPath = "tyj/csb"
LoginRewardPopView.debug = true
LoginRewardPopView.studioSpriteFrames = { }
--@auto code head end

LoginRewardPopView.spriteFrameNames = 
    {
        "SignRewardPopUI_Text"
    }

LoginRewardPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #LoginRewardPopView.studioSpriteFrames > 0 then
    LoginRewardPopView.spriteFrameNames = LoginRewardPopView.spriteFrameNames or {}
    table.insertto(LoginRewardPopView.spriteFrameNames, LoginRewardPopView.studioSpriteFrames)
end
function LoginRewardPopView:onInitUI()

    --output list
    self._prizePanel_t = self.csbNode:getChildByName("prizePanel")
	self._infLayout_t = self.csbNode:getChildByName("infLayout")
	
    --label list
    
    --button list
    self._closeBt_t = self.csbNode:getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function LoginRewardPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:close()
end
--@auto code Closebt btFunc end

--@auto code Bgbt btFunc
function LoginRewardPopView:onBgbtClick()
    Functions.printInfo(self.debug,"Bgbt button is click!")
end
--@auto code Bgbt btFunc end

--@auto button backcall end


--@auto code output func
function LoginRewardPopView:getPopAction()
    Functions.printInfo(self.debug,"pop actionFunc is call")
end

function LoginRewardPopView:onDisplayView()
    Functions.printInfo(self.debug,"pop action finish ")
    Functions.setPopupKey("reward")
    local tempData = Functions.copyTab(RewardData.rewardInf.Accumulate) 

    self:initPrizeList(self._prizePanel_t,tempData,RewardStateData.rewardState)
    
end

function LoginRewardPopView:onCreate()
    Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

--custom code start
function LoginRewardPopView:initPrizeList(prizePanel,prizeData,prizeStateData)
    for i = 1,#prizeData do
        local prizeNode = prizePanel:getChildByTag(i)
        
        local prizeCntLabel = prizeNode:getChildByName("prizePanel"):getChildByName("prizeCntLabel")
        local prize = prizeNode:getChildByName("prizePanel"):getChildByName("prize")
        local mask = prizeNode:getChildByName("prizePanel"):getChildByName("mask")
        local choose = prizeNode:getChildByName("prizePanel"):getChildByName("choose")
        local done = prizeNode:getChildByName("prizePanel"):getChildByName("done")
        --是否双倍天数
        local vipDouble = prizeNode:getChildByName("prizePanel"):getChildByName("vipDouble")
        for t =1,#g_VipCgf.VipLevel do 
            if g_VipCgf.VipLogReward[t] == i then
                vipDouble:getChildByName("level"):setString("V" .. tostring(t))
                vipDouble:setVisible(true)
            end
            
        end

        local touchType = ItemType.HeroCard
        local isReward = false
        prizeCntLabel:setString("x" .. tostring(prizeData[i][1][3]))
        
        -- if prizeData[i][1][2] == 1 then
        --     prizeData[i][1][2] = 5
        -- elseif prizeData[i][1][2] == 4 and prizeData[i][1][1] > 0 then
        --     prizeData[i][1][2] = 1
        -- elseif prizeData[i][1][1] == -2 then
        --     prizeData[i][1][2] = 3
        -- elseif prizeData[i][1][1] == -3 then
        --     prizeData[i][1][2] = 2
        -- elseif prizeData[i][1][1] == -5 then
        --     prizeData[i][1][2] = 4      
        -- end

        if prizeData[i][1][2] == 1 then
            local heroHeadImg = ConfigHandler:getHeroHeadImageOfId(prizeData[i][1][1]) 
            prize:ignoreContentAdaptWithSize(true)
            Functions.loadImageWithWidget(prize, heroHeadImg)
            touchType = ItemType.HeroCard
        elseif prizeData[i][1][2] == 5 then
            local heroHeadImg = ConfigHandler:getHeroHeadImageOfId(prizeData[i][1][1]) 
            prize:ignoreContentAdaptWithSize(true)
            prizeNode:getChildByName("prizePanel"):getChildByName("piece"):setVisible(true)
            Functions.loadImageWithWidget(prize, heroHeadImg)
            touchType = ItemType.CardFragment
        elseif prizeData[i][1][2] == 4  and prizeData[i][1][1] > 0 then
            local propImg = ConfigHandler:getPropImageOfId(prizeData[i][1][1])  
            prize:ignoreContentAdaptWithSize(true)           
            Functions.loadImageWithWidget(prize, propImg)
            touchType = ItemType.Prop
        elseif prizeData[i][1][2] == 4  and prizeData[i][1][1] == -3 then
            Functions.loadImageWithWidget(prize, "property_money.png")
            touchType = -1
        elseif prizeData[i][1][2] == 4  and prizeData[i][1][1] == -2 then
            Functions.loadImageWithWidget(prize, "property_gold.png")
            touchType = -1
        elseif prizeData[i][1][2] == 4  and prizeData[i][1][1] == -5 then
            Functions.loadImageWithWidget(prize, "soul80.png")
            touchType = -1
        end
        
        if i < prizeStateData.m_lgAccumu then  --无法领取状态
            mask:setVisible(true)
        end
        if i == prizeStateData.m_lgAccumu then
            choose:setVisible(true) 
        end        
        if i == prizeStateData.m_lgAccumu and prizeStateData.m_lgAccumuRd[i] == false then --当前可领取状态
            isReward = true            
        end
        
        if prizeStateData.m_lgAccumuRd[i] == true then --当前已领取状态
            done:setVisible(true) 
            mask:setVisible(true)
        end   
        local onPrizeClick = function() 
            if isReward == true then    
                local handler = function (event)
                    Functions.playSound("getrewards.mp3")
                    mask:setVisible(true)
                    done:setVisible(true)
                    isReward = false
                    prizeStateData.m_lgAccumuRd[i] = true 
                    local count = prizeData[i][1][3]
                    for t =1,VipData.eventAttr.m_vipLevel do 
                        if g_VipCgf.VipLogReward[t] == i then
                            count = prizeData[i][1][3] * 2
                        end
                    end
                    Functions:addItemResources({id = prizeData[i][1][1],type = prizeData[i][1][2],count = count,slot = event.rettbl[1]})
                    -- RewardData:updatePrizeData(prizeData[i][1][2],prizeData[i][1][1],prizeData[i][1][3],event.rettbl[1]) 
                    --更新登陆领奖是否可领奖标示
                    RewardStateData.eventAttr.loginRewardFlag = 0   --登陆领奖：30天每天的领奖状态
                end  
                RewardData:RequestLoginReward(handler)
            else
                PromptManager:openInfPrompt({type = touchType,id = prizeData[i][1][1],target = prize})
            end
        end
        prize:onTouch(Functions.createClickListener(handler(prize, onPrizeClick), ""))
    end
end

--custom code end
return LoginRewardPopView