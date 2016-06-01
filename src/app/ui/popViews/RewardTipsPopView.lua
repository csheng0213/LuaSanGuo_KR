--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local RewardTipsPopView = class("RewardTipsPopView", BasePopView)

local Functions = require("app.common.Functions")

RewardTipsPopView.csbResPath = "tyj/csb"
RewardTipsPopView.debug = true
RewardTipsPopView.studioSpriteFrames = {"CBO_taxKuang","RewardTipsPopUI","EquipEhancePopUI_Text" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #RewardTipsPopView.studioSpriteFrames > 0 then
    RewardTipsPopView.spriteFrameNames = RewardTipsPopView.spriteFrameNames or {}
    table.insertto(RewardTipsPopView.spriteFrameNames, RewardTipsPopView.studioSpriteFrames)
end
function RewardTipsPopView:onInitUI()

    --output list
    self._Panel_2_t = self.csbNode:getChildByName("Panel_2")
	self._congration_t = self.csbNode:getChildByName("Panel_2"):getChildByName("congration")
	self._title_t = self.csbNode:getChildByName("Panel_2"):getChildByName("title")
	self._getCoin_t = self.csbNode:getChildByName("Panel_2"):getChildByName("getCoin")
	self._inf_t = self.csbNode:getChildByName("Panel_2"):getChildByName("inf")
	self._rewardView_t = self.csbNode:getChildByName("Panel_2"):getChildByName("rewardView")
	self._prize_t = self.csbNode:getChildByName("Panel_2"):getChildByName("rewardView"):getChildByName("prize")
	self._piece_t = self.csbNode:getChildByName("Panel_2"):getChildByName("rewardView"):getChildByName("piece")
	self._rewardLabel_t = self.csbNode:getChildByName("Panel_2"):getChildByName("rewardView"):getChildByName("rewardLabel")
	self._equipView_t = self.csbNode:getChildByName("Panel_2"):getChildByName("equipView")
	self._heroPanel_t = self.csbNode:getChildByName("Panel_2"):getChildByName("heroPanel")
	
    --label list
    
    --button list
    self._okbt_t = self.csbNode:getChildByName("Panel_2"):getChildByName("okbt")
	self._okbt_t:onTouch(Functions.createClickListener(handler(self, self.onOkbtClick), "zoom"))

	self._againbt_t = self.csbNode:getChildByName("Panel_2"):getChildByName("againbt")
	self._againbt_t:onTouch(Functions.createClickListener(handler(self, self.onAgainbtClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Okbt btFunc
function RewardTipsPopView:onOkbtClick()
    Functions.printInfo(self.debug,"Okbt button is click!")
    if self.handler ~= nil then 
        self.handler()
    end
    self:getController():closeChildView(self)
end
--@auto code Okbt btFunc end

--@auto code Againbt btFunc
function RewardTipsPopView:onAgainbtClick()
    Functions.printInfo(self.debug,"Againbt button is click!")
    if self.againHandler ~= nil then 
        self.againHandler(self.propData)
    end
    self:getController():closeChildView(self)
end
--@auto code Againbt btFunc end

--@auto button backcall end


--@auto code output func
--@auto code output func
function RewardTipsPopView:getPopAction()
    Functions.printInfo(self.debug,"pop actionFunc is call")
    -- if self.showType == NoticeManager.REWARD_COIN_TIPS then
        local animation = cc.ParticleSystemQuad:create("tyj/animaRes/tax_light.plist")
        animation:setPosition(display.width/2,display.height/2)
        animation:setScale(1.3)
        local layer = self:getParent()
        layer:addChild(animation)
        local callFunc = cc.CallFunc:create(function()
            animation:removeFromParentAndCleanup()
        end)
        local seq = cc.Sequence:create(cc.DelayTime:create(1),callFunc,NULL)
        transition.execute(layer,seq)
    -- end
    self:setScale(0.6)
    local scaleTo1 = cc.ScaleTo:create(0.1, 1.2, 1.2)
    local scaleTo2 = cc.ScaleTo:create(0.1, 1, 1)
    return cc.Sequence:create(scaleTo1, scaleTo2,NULL);
end

function RewardTipsPopView:onDisplayView()
    Functions.printInfo(self.debug,"pop action finish ")
    Functions.playSound("getVIPrewards.mp3")
    if self.showType ~= nil then
        if self.showType == NoticeManager.REWARD_PROP_TIPS then
            self._congration_t:setVisible(true)
            Functions.loadImageWithSprite(self._congration_t, "tyj/uiFonts_res/congration.png")
            self._rewardView_t:setVisible(true)
        elseif self.showType == NoticeManager.REWARD_COIN_TIPS then
            self._getCoin_t:setVisible(true)
            self._inf_t:setVisible(true)
        elseif self.showType == NoticeManager.REWARD_EQUIP_TIPS then
            self._congration_t:setVisible(true)     
            Functions.loadImageWithSprite(self._congration_t, "tyj/uiFonts_res/congration.png")
            self._equipView_t:setVisible(true)
        elseif self.showType == NoticeManager.REWARD_EQUIPQIANGHUA_TIPS then
            self._congration_t:setVisible(true)     
            Functions.loadImageWithSprite(self._congration_t, "tyj/uiFonts_res/qhcg.png")
            self._equipView_t:setVisible(true)
        elseif self.showType == NoticeManager.REWARD_EQUIPHECHENG_TIPS then
            self._congration_t:setVisible(true)     
            Functions.loadImageWithSprite(self._congration_t, "tyj/uiFonts_res/hccg.png")
            self._equipView_t:setVisible(true)
        elseif self.showType ==  NoticeManager.REWARD_CARD_FRAGMENT_TIPS then
            self._congration_t:setVisible(true)
            Functions.loadImageWithSprite(self._congration_t, "tyj/uiFonts_res/congration.png")
            self._rewardView_t:setVisible(true)
            self._piece_t:setVisible(true)
        end
    end
    if self.nodeData ~= nil  then 
        if self.showType == NoticeManager.REWARD_HERO_CARD_TIPS then 
            self._heroPanel_t:setVisible(true)
            local heroView = self._heroPanel_t:getChildByName("heroView")
            Functions.getHeroHead(heroView,{id = self.nodeData.heroId},2)
            local heroNum = self._heroPanel_t:getChildByName("heroNum")
            heroNum:setString(tostring(self.nodeData.heroNum))
        else
            if #self.nodeData == 1 then
                self._prize_t:ignoreContentAdaptWithSize(true)
                Functions.loadImageWithWidget(self._prize_t, self.nodeData[1].img)
                self._rewardLabel_t:setString("x" .. self.nodeData[1].num)
            elseif  #self.nodeData == 2 then
                local oldPositionX = self._rewardView_t:getPositionX()
                local width = self._rewardView_t:getContentSize().width
                self._rewardView_t:setPositionX(oldPositionX - width/2 - 10) 
                self._prize_t:ignoreContentAdaptWithSize(true)
                Functions.loadImageWithWidget(self._prize_t, self.nodeData[1].img)
                self._rewardLabel_t:setString("x" .. self.nodeData[1].num)
        
                local newRewardView = self._rewardView_t:clone()
                newRewardView:setVisible(true)
                newRewardView:setPositionX(oldPositionX + width/2 + 10) 
                Functions.loadImageWithWidget(newRewardView:getChildByName("prize"),self.nodeData[2].img)
                newRewardView:getChildByName("rewardLabel"):setString(self.nodeData[2].num)
                self._rewardView_t:getParent():addChild(newRewardView)
            end
        end
    end
    if self.nodeMark then 
        Functions.getEquipNode(self._equipView_t,{mark = self.nodeMark,isName = true})
    end

    if self.burst ~= nil and self.burst > 1 then
        self._title_t:setVisible(true)
        self._title_t:getChildByName("num"):setString(tostring(self.burst))
    else
        self._title_t:setVisible(false)
    end
    if self.inf ~= nil then
        self._inf_t:setString(self.inf)
    end
    if self.againHandler ~= nil then 
        self._okbt_t:setPositionX(155)
        self._againbt_t:setVisible(true)
    else
        self._okbt_t:setPositionX(256.5)
        self._againbt_t:setVisible(false)
    end 
end

function RewardTipsPopView:onCreate()
    Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function RewardTipsPopView:setShowType(showType)
    self.showType = showType
    
end
function RewardTipsPopView:setInf(inf)
    self.inf = inf
end
function RewardTipsPopView:setHandler(handler)
    self.handler = handler
end
--data = {{img = ,num},}
function RewardTipsPopView:createPrizeNode( data )
    self.nodeData = data
end
function RewardTipsPopView:setAgainHandler(againHandler)
    self.againHandler = againHandler
end
function RewardTipsPopView:setPropData(propData)
    self.propData = propData
end
-- function RewardTipsPopView:setRewardImg(img)
--     self._prize_t:ignoreContentAdaptWithSize(true)
--     Functions.loadImageWithWidget(self._prize_t, img)
-- end

-- function RewardTipsPopView:setRewardLabel(num)
--     self._rewardLabel_t:setString(num)
-- end
function RewardTipsPopView:setIsBurst( burst)
    self.burst = burst
    
end
function RewardTipsPopView:setEquipNode( equipMark )
    self.nodeMark = equipMark
    assert(equipMark and equipMark > 0,"equipID is error")
end

return RewardTipsPopView