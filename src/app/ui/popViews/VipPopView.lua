--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local VipPopView = class("VipPopView", BasePopView)

local Functions = require("app.common.Functions")

VipPopView.csbResPath = "tyj/csb"
VipPopView.debug = true
VipPopView.studioSpriteFrames = {"VipPopUI_Text","VipUI" }
--@auto code head end
VipPopView.spriteFrameNames = 
    {
    }
local RichLabel = require("app.ui.common.RichLabel")
local scheduler = require("app.common.scheduler")
--@auto code uiInit
--add spriteFrames
if #VipPopView.studioSpriteFrames > 0 then
    VipPopView.spriteFrameNames = VipPopView.spriteFrameNames or {}
    table.insertto(VipPopView.spriteFrameNames, VipPopView.studioSpriteFrames)
end
function VipPopView:onInitUI()

    --output list
    self._bar_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("task_tiao"):getChildByName("bar")
	self._vipPay_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("task_tiao"):getChildByName("bar"):getChildByName("vipPay")
	self._vipNum_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("vipNum")
	self._pageView_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("pageView")
	
    --label list
    
    --button list
    self._leftBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("leftBt")
	self._leftBt_t:onTouch(Functions.createClickListener(handler(self, self.onLeftbtClick), ""))

	self._rightBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("rightBt")
	self._rightBt_t:onTouch(Functions.createClickListener(handler(self, self.onRightbtClick), ""))

	self._closeBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))

	self._payBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("payBt")
	self._payBt_t:onTouch(Functions.createClickListener(handler(self, self.onPaybtClick), ""))

	self._helpBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("bg"):getChildByName("helpBt")
	self._helpBt_t:onTouch(Functions.createClickListener(handler(self, self.onHelpbtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Paybt btFunc
function VipPopView:onPaybtClick()
    Functions.printInfo(self.debug,"Paybt button is click!")
    -- local handler = function ( event )
    --     PromptManager:openTipPrompt("充值成功")
    --     self:initDisplayUi()
    -- end
    -- VipData:RequestVipPay(500,handler)

    self._controller_t:openChildView("app.ui.popViews.PayPopView",{isRemove = false})
     -- VipData:RequestVipPay("0","0","GD201512021789764")
end
--@auto code Paybt btFunc end

--@auto code Closebt btFunc
function VipPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
   

    -- local scheduler = require("app.common.scheduler")
    -- local handle = scheduler.performWithDelayGlobal(function()
    --                      self:getController():closeChildView(self)
    --                 end, 0.3)
    if self.resLoadFlag then 
        self:getController():closeChildView(self)
    end
end
--@auto code Closebt btFunc end

--@auto code Leftbt btFunc
function VipPopView:onLeftbtClick()
    Functions.printInfo(self.debug,"Leftbt button is click!")
    if self.curVip > 0 then 
        self.pageTable[self.curVip]:setVisible(false)
        self.curVip  = self.curVip  - 1   
        self:showPage(self._pageView_t,g_VipCgf.VipLevelPrize,self.curVip,1) 

    end
    Functions.delayClickHandler(self._leftBt_t, 0.3) 
end
--@auto code Leftbt btFunc end

--@auto code Rightbt btFunc
function VipPopView:onRightbtClick()
    Functions.printInfo(self.debug,"Rightbt button is click!")
    if self.curVip < 15 then
        self.pageTable[self.curVip]:setVisible(false)
        self.curVip  = self.curVip  + 1 
        self:showPage(self._pageView_t,g_VipCgf.VipLevelPrize,self.curVip,2) 
    end   

    Functions.delayClickHandler(self._rightBt_t, 0.3)    
end
--@auto code Rightbt btFunc end

--@auto code Helpbt btFunc
function VipPopView:onHelpbtClick()
    Functions.printInfo(self.debug,"Helpbt button is click!")
    NoticeManager:openNotice(GameCtlManager.currentController_t, {type = NoticeManager.VIP_INFO})
end
--@auto code Helpbt btFunc end

--@auto button backcall end


--@auto code output func
function VipPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function VipPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    self.resLoadFlag = true
    Functions.setPopupKey("vip")
    self.pageTable = {}
    self.curVip = VipData.eventAttr.m_vipLevel
    self:initDisplayUi()
end

function VipPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function VipPopView:initDisplayUi( )
	--绑定vip等级显示
	self._vipNum_t:setString(tostring(VipData.eventAttr.m_vipLevel))
    Functions.bindUiWithModelAttr(self._vipNum_t, VipData, "m_vipLevel")
    --绑定充值金额显示
    if VipData.eventAttr.m_vipLevel < 15 then
        self._vipPay_t:setString(tostring(VipData.eventAttr.m_recharge).. "/" .. tostring(g_VipCgf.VipLevel[VipData.eventAttr.m_vipLevel+1]))
        self._bar_t:setPercent(math.floor(VipData.eventAttr.m_recharge/g_VipCgf.VipLevel[VipData.eventAttr.m_vipLevel+1]*100))
	else
        self._vipPay_t:setString(tostring(VipData.eventAttr.m_recharge).. "/" .. tostring(g_VipCgf.VipLevel[VipData.eventAttr.m_vipLevel]))
        self._bar_t:setPercent(math.floor(VipData.eventAttr.m_recharge/g_VipCgf.VipLevel[VipData.eventAttr.m_vipLevel]*100))
	end
--	self:disPlayPrize(VipData.eventAttr.m_vipLevel)
    Functions.bindUiWithModelAttr(self._vipPay_t, VipData, "m_recharge", function(event)
        if VipData.eventAttr.m_vipLevel < 15 then
            self._vipPay_t:setString(tostring(event.data).. "/" .. tostring(g_VipCgf.VipLevel[VipData.eventAttr.m_vipLevel+1]))
            self._bar_t:setPercent(math.floor(VipData.eventAttr.m_recharge/g_VipCgf.VipLevel[VipData.eventAttr.m_vipLevel+1]*100))
		    
        else
            self._vipPay_t:setString(tostring(event.data).. "/" .. tostring(g_VipCgf.VipLevel[VipData.eventAttr.m_vipLevel]))
            self._bar_t:setPercent(math.floor(VipData.eventAttr.m_recharge/g_VipCgf.VipLevel[VipData.eventAttr.m_vipLevel]*100))
		end
--		VipPopView:disPlayPrize(VipData.eventAttr.m_vipLevel)
        GameEventCenter:dispatchEvent({ name = "VIP_RECHARGE_EVENT"}) 
    end)
    self:showPage(self._pageView_t,g_VipCgf.VipLevelPrize,VipData.eventAttr.m_vipLevel)
    -- self:showPage(self._pageView_t,g_VipCgf.VipLevelPrize,0,VipData.eventAttr.m_vipLevel)
    --绑定pageView数据显示
    -- local handler = function(index,target,data,model)
    --     self:displayPage(target,index,model)
    -- end
    -- Functions.bindPageWithData(self._pageView_t, g_VipCgf.VipLevelPrize, handler)


     -- --绑定PageView触摸
     -- local listener = function(event)
     --    self._pageView_t:scrollToPage(event.index)
     -- end
     -- Functions.bindPageViewListener(self._pageView_t, listener)

end
-- --显示礼包
-- function VipPopView:disPlayPrize(target,VipLevel)
--     local prizeNode1 = target:getChildByName("prize1")
--     local prizeNode2 = target:getChildByName("prize2")
--     local awardItemDistance = prizeNode2:getPositionX() - prizeNode1:getPositionX()
--     local awardFirstPos = { x = prizeNode1:getPositionX(), y = prizeNode1:getPositionY() }
--     local awardItemScale = prizeNode1:getScale()
--     for i=1, #g_VipCgf.VipLevelPrize[VipLevel] do	        
--         local disNode = Functions.createPartNode({ nodeId = g_VipCgf.VipLevelPrize[VipLevel][i][1], nodeType = g_VipCgf.VipLevelPrize[VipLevel][i][2], count = g_VipCgf.VipLevelPrize[VipLevel][i][3]})
--         disNode:setTag(i)  
--         disNode:setVisible(true)
--         if disNode ~= nil then			            
--             local pos = { x = awardFirstPos.x + awardItemDistance*(i-1), y = awardFirstPos.y }
--             disNode:setScale(awardItemScale)
--             disNode:setPosition(pos)
--             target:addChild(disNode)
--             -- local onDisNodeClick = function()
--             --     PromptManager:openInfPrompt({type = g_VipCgf.VipLevelPrize[VipLevel][i][2],id =  g_VipCgf.VipLevelPrize[VipLevel][i][1],target = disNode})
--             -- end
--             local model = disNode:getChildByName("model")
--             model:setTouchEnabled(false)
--             -- Functions.setEnabledWidget(model, true)
--             -- model:onTouch(Functions.createClickListener(onDisNodeClick, ""))
--         end
        
--         --disNode:onTouch(Functions.createClickListener(handler(disNode, onDisNodeClick), ""))
--     end
-- end


--显示一个page页
function VipPopView:showPage(pagePanel,pageData,index, moveFlag)
    self.resLoadFlag = false
    local isPro = false
    if not self.pageTable[index] then
        if not pagePanel.model then
            pagePanel.model = pagePanel:getChildByName("model") 
            pagePanel.model:retain()

            Functions.addCleanFuncWithNode(pagePanel, function()
                pagePanel.model:release()
            end)
          pagePanel:removeAllPages()
        end     
        local model = pagePanel.model:clone()
        if moveFlag == 1 then
            self.pageTable[index] = model   
            pagePanel:insertPage(model,0)                      
        else 
            self.pageTable[index] = model
            pagePanel:addPage(model) 
        end  
        --vip礼包
        self:displayPage(model,index,pagePanel.model) 
        isPro = true 
    end
    self.pageTable[index]:setVisible(true) 
    --滑动处理
    local curIndex = pagePanel:getCurPageIndex()
    if moveFlag == 1  then    
        if isPro then
            scheduler.performWithDelayGlobal(function()
                self._pageView_t:scrollToPage(curIndex) 
                self.resLoadFlag = true
            end,0.06)
            self._pageView_t:scrollToPage(curIndex+1) 
            scheduler.performWithDelayGlobal(function()
                self._pageView_t:scrollToPage(curIndex-2) 
                self.resLoadFlag = true
            end,0.06)
        else
            curIndex = curIndex - 1
            scheduler.performWithDelayGlobal(function()
                self._pageView_t:scrollToPage(curIndex) 
                self.resLoadFlag = true
            end,0.06)
        end
    elseif moveFlag == 2 then 
        curIndex = curIndex + 1
        scheduler.performWithDelayGlobal(function()
            self._pageView_t:scrollToPage(curIndex) 
            self.resLoadFlag = true
        end,0.06)
    else
         self.resLoadFlag = true
    end
end

-- --显示一个page页
-- function VipPopView:showPage(pagePanel,pageData,oldIndex, newIndex)
--     if not self.pageTable[newIndex] then
--         if not pagePanel.model then
--             pagePanel.model = pagePanel:getChildByName("model") 
--             pagePanel.model:retain()

--             Functions.addCleanFuncWithNode(pagePanel, function()
--                 pagePanel.model:release()
--             end)
-- --            pagePanel:removeAllPages()
--         end     
    
--         if oldIndex == 0 then
--             local curPage = pagePanel:getPage(0)
--             self:displayPage(curPage,newIndex,pagePanel:getChildByName("model"))  
--             self.pageTable[newIndex] = curPage
--         else
--             if newIndex > oldIndex then
--                 local model = pagePanel.model:clone()
--                 local oldTempIndex = table.getKeyOfValue(pagePanel:getPages(),self.pageTable[oldIndex])
--                 pagePanel:insertPage(model, oldTempIndex)
--                 self.pageTable[newIndex] = model
--                 self:displayPage(model,newIndex,pagePanel:getChildByName("model"))
--             else
--                 local model = pagePanel.model:clone()
--                 local oldTempIndex = table.getKeyOfValue(pagePanel:getPages(),self.pageTable[oldIndex])
--                 pagePanel:insertPage(model, oldTempIndex - 1)
--                 self.pageTable[newIndex] = model
--                 self:displayPage(model,newIndex,pagePanel:getChildByName("model"))

--                 local curIndex = pagePanel:getCurPageIndex()
--                 pagePanel:setCurPageIndex(curIndex+1)
--             end

--         end
--         -- if isLeft then
--         --     --table.insert(self.pageTable,2,index)
--         --     self.pageTable[#self.pageTable+1] = index
--         --     pagePanel:insertPage(model,1)                      
--         -- else
--         --     self.pageTable[#self.pageTable+1] = index
--         --     pagePanel:addPage(model)  
--         -- end
--         -- self.pageTable[#self.pageTable+1] = index
--         -- pagePanel:addPage(model) 
--         -- local curPage = pagePanel:getPage(table.getKeyOfValue(self.pageTable,index))
--         --vip礼包
--         -- self:displayPage(curPage,index,model)   
--     -- elseif index < 1 then 
--     --     local curPage = pagePanel:getPage(index)
--     --     self:displayPage(curPage,index,pagePanel:getChildByName("model"))  
--     end
--        local curIndex = pagePanel:getCurPageIndex()
--        if newIndex > oldIndex then
--            curIndex = curIndex + 1
--        else
--            curIndex = curIndex - 1
--        end
--        scheduler.performWithDelayGlobal(function()
--            self._pageView_t:scrollToPage(curIndex) 
--        end,0.1)
--     -- local temp = table.getKeyOfValue(self.pageTable,index)
--     -- if temp == 1 then 
--     --     self._pageView_t:scrollToPage(temp) 
--     -- else
--     --     scheduler.performWithDelayGlobal(function()
--     --         self._pageView_t:scrollToPage(temp) 
--     --     end,0.1)
--     -- end
-- end
--
function VipPopView:displayPage(page,index,model)
    local vipPrizeLabel = page:getChildByName("vipPrizeLabel")
    vipPrizeLabel:setString("VIP" .. tostring(index))
    Functions.initTextColor(model:getChildByName("vipPrizeLabel"),vipPrizeLabel)
    --vip特权
    local vipPrivilegeLabel = page:getChildByName("vipPrivilegeLabel")
    vipPrivilegeLabel:setString("VIP" .. tostring(index))
    Functions.initTextColor(model:getChildByName("vipPrivilegeLabel"),vipPrivilegeLabel)
    --礼包
    local prizePanel = page:getChildByName("prizePanel")
    prizePanel:setTouchEnabled(false)
    -- self:disPlayPrize(prizePanel,index)
    Functions.createPrizeNode(prizePanel,g_VipCgf.VipLevelPrize[index]) 

    --领取礼包按钮
    local rewardBt = page:getChildByName("rewardBt")
    local rewardBtText = rewardBt:getChildByName("btText")
    rewardBtText:ignoreContentAdaptWithSize(true)
    if VipData.eventAttr.m_vipReward[index+1] then
     Functions.setEnabledBt(rewardBt, true)
     -- rewardBtText:setString(LanguageConfig.language_vip_1)
     Functions.loadImageWithWidget(rewardBtText,"tyj/uiFonts_res/linqu.png")
    elseif VipData.eventAttr.m_vipLevel >= index then
     Functions.setEnabledBt(rewardBt, false)
     -- rewardBtText:setString(LanguageConfig.language_vip_2)
     Functions.loadImageWithWidget(rewardBtText,"tyj/uiFonts_res/yilingqu.png")
    end
    if VipData.eventAttr.m_vipLevel < index then 
     Functions.setEnabledBt(rewardBt, false)
     -- rewardBtText:setString(LanguageConfig.language_vip_1)
     Functions.loadImageWithWidget(rewardBtText,"tyj/uiFonts_res/linqu.png")
    end

    Functions.bindEventListener(rewardBtText,GameEventCenter,"VIP_RECHARGE_EVENT",function()
             if VipData.eventAttr.m_vipReward[index+1] then
                 Functions.setEnabledBt(rewardBt, true)
                 -- rewardBtText:setString(LanguageConfig.language_vip_1)
                 Functions.loadImageWithWidget(rewardBtText,"tyj/uiFonts_res/linqu.png")
             elseif VipData.eventAttr.m_vipLevel >= index then
                 Functions.setEnabledBt(rewardBt, false)
                 -- rewardBtText:setString(LanguageConfig.language_vip_2)
                 Functions.loadImageWithWidget(rewardBtText,"tyj/uiFonts_res/yilingqu.png")
             end
             if VipData.eventAttr.m_vipLevel < index then 
                 Functions.setEnabledBt(rewardBt, false)
                 -- rewardBtText:setString(LanguageConfig.language_vip_1)
                 Functions.loadImageWithWidget(rewardBtText,"tyj/uiFonts_res/linqu.png")
            end
        end)
    local rewardBtClickHander = function()
        local rewardHander = function ( event )
             Functions.playSound("getVIPrewards.mp3")
             PromptManager:openTipPrompt(LanguageConfig.language_vip_3)
             Functions.setEnabledBt(rewardBt, false)
             -- rewardBtText:setString(LanguageConfig.language_vip_1)
             Functions.loadImageWithWidget(rewardBtText,"tyj/uiFonts_res/yilingqu.png")
             self:addVipPrize(index)
             VipData:updateVipRewardFlag()
        end
        VipData:RequestVipLevelReward(index,rewardHander)
    end
    rewardBt:onTouch(Functions.createClickListener(rewardBtClickHander, ""))

    --特权显示
    local PrivilegeHandler = function(tag,widget,inf,model)
     local vipPrivilegeText = widget:getChildByName("vipPrivilegeText")
     local str = ""
     if #g_vipConfig.vipPrivilegeNum[index][tag] == 1 then           
         str = string.format(LanguageConfig.language_vipDescribe[inf],g_vipConfig.vipPrivilegeNum[index][tag][1])
     elseif #g_vipConfig.vipPrivilegeNum[index][tag] == 2 then                 
         str = string.format(LanguageConfig.language_vipDescribe[inf],g_vipConfig.vipPrivilegeNum[index][tag][1],g_vipConfig.vipPrivilegeNum[index][tag][2])
     elseif #g_vipConfig.vipPrivilegeNum[index][tag] == 3 then 
         str = string.format(LanguageConfig.language_vipDescribe[inf],g_vipConfig.vipPrivilegeNum[index][tag][1],g_vipConfig.vipPrivilegeNum[index][tag][2],g_vipConfig.vipPrivilegeNum[index][tag][3])
     elseif #g_vipConfig.vipPrivilegeNum[index][tag] == 4 then 
         str = string.format(LanguageConfig.language_vipDescribe[inf],g_vipConfig.vipPrivilegeNum[index][tag][1],g_vipConfig.vipPrivilegeNum[index][tag][2],g_vipConfig.vipPrivilegeNum[index][tag][3],vipPrivilegeNum[tag][4])
     else
         str = LanguageConfig.language_vipDescribe[inf]
     end
--        local temp1 = g_vipConfig.vipPrivilegeNum[index][tag][1]
--     vipPrivilegeText:setString(str)
--        local richText = ccui.RichText:create()
--        vipPrivilegeText:getParent():addChild(richText)
--        Functions.setSubStrAttr(vipPrivilegeText,richText,LanguageConfig.language_attrConfig)
        local richLabel = RichLabel:create({text = str})
        richLabel:setPosition(cc.p(0,25))
        widget:addChild(richLabel)
        vipPrivilegeText:setVisible(false)
    end
    Functions.bindListWithData(page:getChildByName("listView"), g_vipConfig.vipPrivilege[index], PrivilegeHandler) 
end
--添加VIP礼包
function VipPopView:addVipPrize(VipLevel)
	for i=1, #g_VipCgf.VipLevelPrize[VipLevel] do	        
        local disNode = Functions.createPartNode({ nodeId = g_VipCgf.VipLevelPrize[VipLevel][i][1], nodeType = g_VipCgf.VipLevelPrize[VipLevel][i][2], count = g_VipCgf.VipLevelPrize[VipLevel][i][3]})
      	Functions:addItemResources({id = g_VipCgf.VipLevelPrize[VipLevel][i][1],type = g_VipCgf.VipLevelPrize[VipLevel][i][2],count = g_VipCgf.VipLevelPrize[VipLevel][i][3]})
    end
end
return VipPopView