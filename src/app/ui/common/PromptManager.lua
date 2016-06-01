local PromptManager = {}

local scheduler = require("app.common.scheduler")

function PromptManager:init()
    GameEventCenter:addEventListener(NetWork.HTTP_REQUST_BEGIN_EVENT, handler(self, self.openHttpLinkPrompt))
    GameEventCenter:addEventListener(NetWork.HTTP_REQUST_RETURN_EVENT, handler(self, self.closeHttpLinkPrompt))
    GameEventCenter:addEventListener(NetWork.HTTP_REQUST_FAIL_EVENT, handler(self, self.openHttpFailPrompt))
end

function PromptManager:openSocketLinkPromp()
    self:openLoadingPrompt("",true)
    -- self:openCircelPrompt()
end

function PromptManager:closeSocketLinkPromp()
    self:closeLoadingPrompt()
    -- self:closeCircelPrompt()
end

function PromptManager:openHttpLinkPrompt()
    self:openLoadingPrompt("",true)
    -- self:openCircelPrompt()
end

function PromptManager:closeHttpLinkPrompt()
    self:closeLoadingPrompt()
    -- self:closeCircelPrompt()
end

function PromptManager:openHttpFailPrompt()

    if self.httpLinkView then
        self.httpLinkView:openHttpFailDis()
    end

end

function PromptManager:openResLoadPrompt()
    self:openLoadingPrompt("资源加载中")
end

function PromptManager:closeResLoadPrompt() 
    self:closeLoadingPrompt()
end

function PromptManager:openTipPrompt(info)

    if not self.tipPanelView then
        self.tipPanelView = CommonWidgets:getTipInfoPanel()
        self.tipPanelView:getChildByName("info_text"):setString(info)
        self.tipPanelView:setPosition(display.cx,display.cy + CC_DESIGN_RESOLUTION.height/2)
        local move = cc.MoveBy:create(1,cc.p(0,-200))
        local easeAction = cc.EaseElasticOut:create(move) 
        local fedeTo = cc.FadeTo:create(0.5,0)
        local seq = cc.Sequence:create(easeAction,cc.DelayTime:create(0.5),fedeTo,NULL)
        transition.execute(self.tipPanelView, seq, {
            onComplete = function()
                self.tipPanelView:removeFromParent()
            end})        
        -- Functions.setCenterOfNode(self.tipPanelView)
        -- GameCtlManager:getCurrentController().rootScene_t:addChild(self.tipPanelView)

        Functions.addCleanFuncWithNode(self.tipPanelView, function()
            self.tipPanelView = nil
        end)
        GameCtlManager:addCurBottomLayer(self.tipPanelView)
    end
end
--弹出道具或英雄详细信息
--@data：{type=,id = ,time = ,target= } 
--type:ItemType.HeroCard,
--ItemType.Prop,
--time显示提示时间默认1.5
--target相对显示位置的目标
function PromptManager:openInfPrompt(data)
    if data.type == ItemType.HeroCard or data.type == ItemType.Prop or data.type == ItemType.CardFragment then
        if data.id > 0 then
            if not self.tipPanel3View then
                self.tipPanel3View = CommonWidgets:getInfPanel()
                if data.target ~= nil then
                    local pos = data.target:getParent():convertToWorldSpace({ x = data.target:getPositionX(), y = data.target:getPositionY()})
                    local newPos = cc.p(0,0)
                    if display.height - pos.y-data.target:getContentSize().height/2 < self.tipPanel3View:getContentSize().height then
                        newPos.y = pos.y - self.tipPanel3View:getContentSize().height/2 - data.target:getContentSize().height/2
                    else
                        newPos.y = pos.y + self.tipPanel3View:getContentSize().height/2 + data.target:getContentSize().height/2
                    end
                    if display.width - pos.x-data.target:getContentSize().width/2 < self.tipPanel3View:getContentSize().width then
                        newPos.x = pos.x - self.tipPanel3View:getContentSize().width/2 - data.target:getContentSize().width/2
                    else
                        newPos.x = pos.x + self.tipPanel3View:getContentSize().width/2 + data.target:getContentSize().width/2
                    end
                    self.tipPanel3View:setPosition(newPos)
                end
                local infTips = self.tipPanel3View:getChildByName("bg")
                local name = infTips:getChildByName("name")
                local inf = infTips:getChildByName("inf")
                local state = infTips:getChildByName("state")
                if data.type == ItemType.HeroCard then     
                    local head = infTips:getChildByName("head")    
                    local headObj = infTips:getChildByName("head"):getChildByName("model"):getChildByName("head")  
                    headObj:ignoreContentAdaptWithSize(true)
                    Functions.getHeroHead(head,{id = data.id},1,true)            
                    name:setString(ConfigHandler:getHeroNameOfId(data.id))             
                    inf:setString(ConfigHandler:getHeroDescriptionId(data.id))             
                    local heroNum = #HeroCardData:getAllHeroData(handler(HeroCardData,HeroCardData.filterHeroOfSameId),data.id)
                    if heroNum > 0 then
                        state:setString(string.format(LanguageConfig.language_2_13,heroNum))
                    else
                        state:setString(LanguageConfig.language_1_9)
                    end
                elseif data.type == ItemType.Prop then
                    local star = infTips:getChildByName("head"):getChildByName("model"):getChildByName("star")
                    star:setVisible(false)
                    local head = infTips:getChildByName("head"):getChildByName("model"):getChildByName("head")
                    head:ignoreContentAdaptWithSize(true)
                    Functions.loadImageWithWidget(head,ConfigHandler:getPropImageOfId(data.id))
                    name:setString(ConfigHandler:getPropNameOfId(data.id)) 
                    inf:setString(ConfigHandler:getPropInfOfId(data.id))
                    local propNum = PropData:getPropNumOfId(data.id)
                    if propNum > 0 then
                        state:setString(string.format(LanguageConfig.language_2_13,propNum))
                    else
                        state:setString(LanguageConfig.language_1_9)
                    end
                elseif data.type == ItemType.CardFragment then
                    local head = infTips:getChildByName("head")    
                    local headObj = infTips:getChildByName("head"):getChildByName("model"):getChildByName("head")  
                    headObj:ignoreContentAdaptWithSize(true)
                    local piece = infTips:getChildByName("head"):getChildByName("model"):getChildByName("piece") 
                    piece:setVisible(true)
                    Functions.getHeroHead(head,{id = data.id},1,true)            
                    name:setString(ConfigHandler:getHeroNameOfId(data.id) .. "(" .. LanguageConfig.language_8_60 .. ")")             
                    inf:setString(ConfigHandler:getHeroDescriptionId(data.id)) 
                    local fragmentNum = 0
                    local cardFragment = CompoundData:getCardFragmentOfId(data.id)    
                    if cardFragment ~= nil then
                        fragmentNum = cardFragment.m_possessCount
                    end                
                    if fragmentNum > 0 then
                        state:setString(string.format(LanguageConfig.language_2_13,fragmentNum))
                    else
                        state:setString(LanguageConfig.language_1_9)
                    end
                end
                UIActionTool:playPopAction({ target = infTips, beginScale = 0.6, endScale = 1, maxScale = 1.3, time = 0.1})
                local time = 1.5
                if data.time ~= nil then
                    time = data.time
                end 

                transition.execute(self.tipPanel3View, cc.DelayTime:create(time), {
                    onComplete = function()
                        self.tipPanel3View:removeFromParent()
                        self.tipPanel3View = nil
                    end})
                Functions.setCenterOfNode(self.tipPanel3View)
                -- GameCtlManager:getCurrentController().rootScene_t:addChild(self.tipPanel3View)
                GameCtlManager:addCurBottomLayer(self.tipPanel3View)
            end
        end
    end
end

function PromptManager:openCircelPrompt()
    if not GameCtlManager:getCurrentController() then return end

    if not self.rotateCircelCount then
        self.rotateCircelCount = 1
        if self.removeRotateCircelHandler then
            scheduler.unscheduleGlobal(self.removeRotateCircelHandler)
            self.removeRotateCircelHandler = nil
        else
            self.rotatCircelView = CommonWidgets:getLoadingPanel()
            self.rotatCircelView:setBackGroundColor(cc.c3b(0,0,0))        

            self.rotatCircelView:setBackGroundColorOpacity(0) 
            local rotateBy = cc.RotateBy:create(0.6, -360)
            Functions.playAnimaWithCreateSprite(self.rotatCircelView,rotateBy,true,"tyj/dynamicUI_res/loading.png",cc.p(568,320),0.6)
            Functions.setCenterOfNode(self.rotatCircelView)
            -- GameCtlManager:getCurrentController().rootScene_t:addChild(self.rotatCircelView)
            GameCtlManager:addCurBottomLayer(self.rotatCircelView)

            Functions.addCleanFuncWithNode(self.rotatCircelView, function()
                if self.removeRotateCircelHandler then
                    scheduler.unscheduleGlobal(self.removeRotateCircelHandler)
                    self.removeRotateCircelHandler = nil
                end
                self.rotateCircelCount = nil
            end)
        end
    else
        self.rotateCircelCount = self.rotateCircelCount + 1
    end

    if self.loadingPanelView and self.rotatCircelView then
        self.rotatCircelView:setVisible(false)
    end

end

function PromptManager:closeCircelPrompt()
    if not GameCtlManager:getCurrentController() then return end
    if self.rotateCircelCount then
        self.rotateCircelCount = self.rotateCircelCount - 1
        if self.rotateCircelCount <= 0 then
            self.rotateCircelCount = nil
            local scheduler = require("app.common.scheduler")
            if not self.removeRotateCircelHandler then
                self.removeRotateCircelHandler = scheduler.performWithDelayGlobal(function()
                    self.rotatCircelView:removeFromParent()
                    self.removeRotateCircelHandler = nil
                    self.rotatCircelView = nil
                end, 0.8)
            end
        end
    end
end

--登陆
function PromptManager:openLoadingPrompt(info,type)
    if not self.loadingPanelView then
        if GameCtlManager.currentController_t then
            self.loadingPanelView = CommonWidgets:getLoadingPanel()
            self.loadingPanelView:setBackGroundColor(cc.c3b(0,0,0))        
            if type ~= nil then
                local inf = self.loadingPanelView:getChildByName("inf")
                inf:setVisible(true)
                inf:setString(info)
                self.loadingPanelView:setBackGroundColorOpacity(0) 
                local rotateBy = cc.RotateBy:create(0.6, -360)
                Functions.playAnimaWithCreateSprite(self.loadingPanelView,rotateBy,true,"tyj/dynamicUI_res/loading.png",cc.p(568,320),0.6)
                --Functions.playAnimaWithCreateSprite(self.loadingPanelView,"An_point",true,"An_point1.png",cc.p(630,230))
            else
                Functions.playAnimaWithCreateSprite(self.loadingPanelView,"An_loading",true,"Ani_loading1.png")
                Functions.playAnimaWithCreateSprite(self.loadingPanelView,"An_point",true,"Ani_point2.png",cc.p(573,230))
            end
            Functions.setCenterOfNode(self.loadingPanelView)
            -- GameCtlManager:getCurrentController().rootScene_t:addChild(self.loadingPanelView)
            GameCtlManager:addCurBottomLayer(self.loadingPanelView)
        end
    end
end

function PromptManager:closeLoadingPrompt()
    if self.loadingPanelView then
        self.loadingPanelView:removeFromParent()
        self.loadingPanelView = nil
    end
end

--打开遮挡层
function PromptManager:openShieldLayer()
    if not self.shieldLayerPanelView then
        if GameCtlManager.currentController_t then
            self.shieldLayerPanelView = CommonWidgets:getLoadingPanel()
            local inf = self.shieldLayerPanelView:getChildByName("inf")
            inf:setVisible(false)
            self.shieldLayerPanelView:setBackGroundColor(cc.c3b(0,0,0))   
            self.shieldLayerPanelView:setBackGroundColorOpacity(0)      
            Functions.setCenterOfNode(self.shieldLayerPanelView)
            -- GameCtlManager:getCurrentController().rootScene_t:addChild(self.shieldLayerPanelView)
            GameCtlManager:addCurBottomLayer(self.shieldLayerPanelView)
        end
    end
end
function PromptManager:closeShieldLayer()

    if self.shieldLayerPanelView then
        self.shieldLayerPanelView:removeFromParent()
        self.shieldLayerPanelView = nil
    end
end
--世界公告
function PromptManager:openSpeakerPrompt(info,handler,infType)
    if not self.tipPanel2View then
        self.tipPanel2View = CommonWidgets:getSpeakerPanel()
        --        local inf = self.tipPanel2View:getChildByName("info_text")
        --        inf:setString(info)

        self.tipPanel2View:getChildByName("infType"):setColor(cc.c3b(2,170,219))
        if infType ~= nil then
            self.tipPanel2View:getChildByName("infType"):setString(infType)
        else
            self.tipPanel2View:getChildByName("infType"):setString(LanguageConfig.language_0_20)
        end
        local inf = cc.Label:create()
        inf:setAnchorPoint(cc.p(0,0.5))
        inf:setSystemFontSize(24)
        inf:setString(info)
        inf:setPosition(cc.p(680,35))

        local clipNode = cc.ClippingNode:create()
        clipNode:setContentSize(680,55)
        clipNode:setPosition(cc.p(245,0))
        local stencil = cc.DrawNode:create()
        local rectangle = {cc.p(0,0),cc.p(clipNode:getContentSize().width,0),cc.p(clipNode:getContentSize().width,clipNode:getContentSize().height),cc.p(0,clipNode:getContentSize().height)}
        stencil:drawPolygon(rectangle,4,cc.c4b(1,1,1,1),1,cc.c4b(1,1,1,1))
        clipNode:setStencil(stencil)
        clipNode:addChild(inf)
        self.tipPanel2View:addChild(clipNode)
        transition.execute(self.tipPanel2View, cc.DelayTime:create(10.5), {
            onComplete = function()
                self.tipPanel2View:removeFromParent()
                self.tipPanel2View = nil
                if handler ~= nil then
                    handler()
                end
            end})
        Functions.playNodeMove(inf,10,cc.p(-1300,0))
        -- Functions.setCenterOfNode(self.tipPanel2View)
        self.tipPanel2View:setPositionX(display.cx)
        -- GameCtlManager:getCurrentController().rootScene_t:addChild(self.tipPanel2View)
        GameCtlManager:addNotificationLayer(self.tipPanel2View)
    end
end

--剧情对话
function PromptManager:openDialoguePrompt(id, callBack)
    if not self.dialoguePanel then
        self.dialoguePanel = CommonWidgets:getDialoguePanel()  
        local allNpcId = ConfigHandler:getAllNPCId(id)
        local dialogueInf = ConfigHandler:getDialogueInfos(id)

        local board = self.dialoguePanel:getChildByName("board")
        -- local npcL =  self.dialoguePanel:getChildByName("npc1")
        -- local npcR =  self.dialoguePanel:getChildByName("npc2")
        local npcL =  Functions.createSprite({pos = {x = 187,y =172}})
        npcL:setAnchorPoint(cc.p(0,0))
        npcL:setVisible(false)
        local npcR =  Functions.createSprite({pos = {x = 950,y = 172}})
        npcR:setAnchorPoint(cc.p(1,0))
        npcR:setVisible(false)
        self.dialoguePanel:addChild(npcL)
        self.dialoguePanel:addChild(npcR)
        local chatInf = self.dialoguePanel:getChildByName("chatInf")
        local index = 1

        local displayNpcDialogue = function(index)
            local npcRes = ConfigHandler:getHeroCardImageOfId(allNpcId[index]) 
            local npcPos = dialogueInf["位置" .. tostring(index)]
            local npcChat = dialogueInf["对白"  .. tostring(index)]
            if npcPos == 1 then
                if allNpcId[index] > 0 then 
                    npcL:setScale(0.8)
                else
                    npcL:setScale(1)
                end
                npcL:setVisible(true)
                npcR:setVisible(false)
                Functions.loadImageWithSprite(npcL,npcRes)
                chatInf:setString(npcChat)
            elseif npcPos == 2 then
                if allNpcId[index] > 0 then 
                    npcR:setScale(0.8)
                else
                    npcR:setScale(1)
                end
                npcL:setVisible(false)
                npcR:setVisible(true)
                Functions.loadImageWithSprite(npcR,npcRes)
                chatInf:setString(npcChat)
            end
        end

        if index <= #allNpcId then
            displayNpcDialogue(1)
        end
        local listener = function()
            index = index + 1
            if index <= #allNpcId then
                displayNpcDialogue(index)                 
            else
                self.dialoguePanel:removeFromParent()
                self.dialoguePanel = nil
                callBack()
            end            
        end
        board:onTouch(Functions.createClickListener(listener,"")) 
        local icon = self.dialoguePanel:getChildByName("icon")
        local move1 = cc.MoveBy:create(0.4,cc.p(0,-15))
        local move2 = cc.MoveBy:create(0.4,cc.p(0,15))
        Functions.playSequenceAction(icon, {{actionName = move1, repeatNum = 1},{actionName = move2, repeatNum = 1}})
        Functions.setCenterOfNode(self.dialoguePanel)
        GameCtlManager:getCurrentController().view_t:addChild(self.dialoguePanel)  
    end
end

function PromptManager:openNewGuide(button, text, listener, isRemove, pos)
    assert(button and type(button) == "userdata", "param type input error")

    if isRemove == nil then isRemove = true end --默认移除引导
    if pos == nil then pos = { x = 0, y = 0 } end

    if not self.newGuidePanel then

        --获取并初始化引导面板
        self.newGuidePanel = CommonWidgets:getNewGuidePanel()  
        Functions.setCenterOfNode(self.newGuidePanel)
        Functions.autoFixChildPos(self.newGuidePanel, true)
        GameCtlManager:getCurrentController().view_t:addChild(self.newGuidePanel , 10000)
        -- self.newGuidePanel:getChildByName("inputPanel"):getChildByName("infoText"):setString(text)
    end 

    local curPos = { x = pos.x + button:getWorldPos().x, y = pos.y + button:getWorldPos().y }

    --调整引导相关节点位置
    local jiantou = self.newGuidePanel:getChildByName("jiantou")
    jiantou:setWorldPos({ x = curPos.x + 30, y = curPos.y - 30 })

    local moveSe = cc.Sequence:create(cc.MoveBy:create(0.4, { x = -30, y = 30 }), cc.MoveBy:create(0.4, { x = 30, y = -30 }))
    jiantou:runAction(cc.RepeatForever:create(moveSe))

    local circle = self.newGuidePanel:getChildByName("circle")


    circle:setWorldPos(curPos)
    circle:runAction(UIActionTool:createScaleAction({ time = 0.4, minScale = 0.6, maxScale = 1 }))

    local disPanel = self.newGuidePanel:getChildByName("inputPanel")

    local dir, worldPos = self:getNewGuideDirAndPos_(curPos, disPanel)
    self:setGuidePanelDis_(disPanel, dir, text, worldPos)

    --添加监听
    local onClick = function(event)
        if event.name == "ended" then
            if self:newGuidePosCheck_(event.target:getTouchEndPosition(), button) then
                if isRemove then
                    self.newGuidePanel:removeFromParent()
                    self.newGuidePanel = nil
                end
                if listener then
                    listener()
                end
                button.clickListener("Guide")
            end
        end
    end
    self.newGuidePanel:onTouch(Functions.createClickListener(onClick))

end

function PromptManager:getNewGuideDirAndPos_(buttonPos, guidePanel)

    local panelSize = guidePanel:getContentSize()
    local panelWorldPos = guidePanel:getWorldPos()

    if buttonPos.x <= display.cx then
        return "right", { x = display.width - panelSize.width/2, y = display.cy }
    else
        return "left", { x = panelSize.width/2, y = display.cy }
    end

end

function PromptManager:setGuidePanelDis_(target, dir, text, worldPos)

    local leftNpc = target:getChildByName("leftNpc")
    local leftText = target:getChildByName("leftInfoText")
    local rightNpc = target:getChildByName("rightNpc")
    local rightText = target:getChildByName("rightInfoText")

    if dir == "left" then
        leftNpc:setVisible(true)
        rightNpc:setVisible(false)

        if text and string.len(text) > 0 then
            leftText:setVisible(true)
            rightText:setVisible(false)

            leftText:setString(text)
        else
            target:setVisible(false)
        end
    else
        leftNpc:setVisible(false)
        rightNpc:setVisible(true)

        if text and string.len(text) > 0 then
            leftText:setVisible(false)
            rightText:setVisible(true)

            rightText:setString(text)
        else
            target:setVisible(false)
        end
    end

    target:setWorldPos(worldPos)
end

function PromptManager:newGuidePosCheck_(touchPos, button)

    local worldButtonPos = button:getWorldPos()
    local size = button:getContentSize()

    local rect = cc.rect(worldButtonPos.x - size.width/2, worldButtonPos.y - size.height/2, size.width, size.height)
    return cc.rectContainsPoint(rect, touchPos)
end

return PromptManager