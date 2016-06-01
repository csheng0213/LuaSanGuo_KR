--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local ImagePlayerViewController = class("ImagePlayerViewController", BaseViewController)

local Functions = require("app.common.Functions")

ImagePlayerViewController.debug = true
ImagePlayerViewController.modulePath = ...
ImagePlayerViewController.studioSpriteFrames = { }
--@auto code head end

--@Pre loading
ImagePlayerViewController.spriteFrameNames = 
    {
    }

ImagePlayerViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #ImagePlayerViewController.studioSpriteFrames > 0 then
    ImagePlayerViewController.spriteFrameNames = ImagePlayerViewController.spriteFrameNames or {}
    table.insertto(ImagePlayerViewController.spriteFrameNames, ImagePlayerViewController.studioSpriteFrames)
end
function ImagePlayerViewController:onDidLoadView()

    --output list
    self._childPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("childPanel")
	self._imagePage_t = self.view_t.csbNode:getChildByName("main"):getChildByName("childPanel"):getChildByName("imagePage")
	self._optionFlagPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("childPanel"):getChildByName("optionFlagPanel")
	
    --label list
    
    --button list
    self._passBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("childPanel"):getChildByName("passBt")
	self._passBt_t:onTouch(Functions.createClickListener(handler(self, self.onPassbtClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Passbt btFunc
function ImagePlayerViewController:onPassbtClick()
    Functions.printInfo(self.debug,"Passbt button is click!")
    local callBack = self.callBack
    GameCtlManager:pop(self)
    callBack()
end
--@auto code Passbt btFunc end

--@auto button backcall end


--@auto code view display func
function ImagePlayerViewController:onCreate()
    Functions.printInfo(self.debug_b," ImagePlayerViewController controller create!")
end

function ImagePlayerViewController:onDisplayView()
	Functions.printInfo(self.debug_b," ImagePlayerViewController view enter display!")

  
    self:showView()
    self._imagePage_t:setCustomScrollThreshold(20)
    
    
    --图片节点适配
    local size = self._childPanel_t:getContentSize()
    self._childPanel_t:setScale(display.cx*2/size.width)
   
    -- self._imagePage_t:setPositionX(self._imagePage_t:getPositionX() + ( CC_DESIGN_RESOLUTION.width - display.width)/2)
    self._imagePage_t:setWorldPos({x = display.cx,y = display.cy})


--    local fade2 = cc.FadeTo:create(0.8,255)
--    --Functions.playActionWithBackCall(self._passBt_t, UIActionTool:createBlinkAction(1))
--    Functions.playSequenceAction(self._passBt_t, {{actionName = fade1, repeatNum = 1},{actionName = fade2, repeatNum = 1}})   
     local move1 = cc.MoveBy:create(0.4,cc.p(-13,0))
     local move2 = cc.MoveBy:create(0.4,cc.p(13,0))
     Functions.playSequenceAction(self._passBt_t, {{actionName = move1, repeatNum = 1},{actionName = move2, repeatNum = 1}}) 
     self:initDisplayUI()
end
--@auto code view display func end
function ImagePlayerViewController:initDisplayUI()
    local idSeq = ConfigHandler:getCartoonIDSeq(self.jumpData.levelId)
    local optionFlagPanel = self._optionFlagPanel_t:getChildByName("optionFlagPanel" .. tostring(#idSeq))
    optionFlagPanel:setVisible(true)
    self:showOptionFlag(optionFlagPanel,#idSeq,1)

    self:playerImage(idSeq)
    self._passBt_t:setVisible(false)
    local listener = function(event)
        -- print(event.index)
        local pages = self._imagePage_t:getPages()  

        if event.index == #pages - 1 then
            self._passBt_t:setVisible(true)             
        else
            self._passBt_t:setVisible(false)
        end
        self:showOptionFlag(optionFlagPanel,#idSeq,event.index+1)
    end
    Functions.bindPageViewListener(self._imagePage_t, listener)

   self._childPanel_t:setOpacity(0)
   -- self._imagePage_t:setOpacity(0)

   local fade1 = cc.FadeIn:create(3) 
   Functions.playActionWithBackCall(self._childPanel_t,fade1) 
end

function ImagePlayerViewController:playerImage(idSeq)
    for i=1,#idSeq do
        local image = ccui.ImageView:create()
        Functions.loadImageWithWidget(image, ConfigHandler:getCartoonRes(idSeq[i]))
        image:setAnchorPoint(cc.p(0.5,0.5)) 
        local size = self._imagePage_t:getContentSize() 
        image:setPosition( cc.p(size.width/2,size.height/2))
        image:setScale(0.848)
        -- image:ignoreAnchorPointForPosition(true)
        self._imagePage_t:addWidgetToPage(image,i,true)
        if i == 1 then
            image:setOpacity(0)
            local fade1 = cc.FadeIn:create(3) 
            Functions.playActionWithBackCall(image,fade1) 
        end

        -- local size = self._imagePage_t:getContentSize() 
        -- local imageLayout = ccui.Layout:create()

        -- imageLayout:setBackGroundImage(ConfigHandler:getCartoonRes(idSeq[i]))
        -- imageLayout:setContentSize(size)
        -- imageLayout:setAnchorPoint(cc.p(0.5,0.5))
        -- imageLayout:setPosition( cc.p(size.width/2,size.height/2))
        -- imageLayout:setScale(0.848)
        -- imageLayout:ignoreAnchorPointForPosition(true)
        -- self._imagePage_t:insertPage(imageLayout,i)

    end 
end

function ImagePlayerViewController:openBgMusic()
    Audio.playMusic(GameState.storeAttr.CurGameBgMusic_s)
end


function ImagePlayerViewController:showOptionFlag(target,num,index)
    if num > 0 and index > 0 then
        for i =1 ,num do
            target:getChildByName("option" .. tostring(i)):getChildByName("1"):setVisible(false)
            target:getChildByName("option" .. tostring(i)):getChildByName("2"):setVisible(true)
        end
        target:getChildByName("option" .. tostring(index)):getChildByName("1"):setVisible(true)
        target:getChildByName("option" .. tostring(index)):getChildByName("2"):setVisible(false)
    end
end
function ImagePlayerViewController:onReceivePushData(jump)
    self.jumpType = jump.jumpType
    self.jumpData = jump.jumpData 
    self.callBack = self.jumpData.callBack
end


return ImagePlayerViewController