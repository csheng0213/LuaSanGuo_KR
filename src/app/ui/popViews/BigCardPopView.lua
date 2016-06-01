--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local BigCardPopView = class("BigCardPopView", BasePopView)

local Functions = require("app.common.Functions")

BigCardPopView.csbResPath = "lk/csb"
BigCardPopView.debug = true
BigCardPopView.studioSpriteFrames = { }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #BigCardPopView.studioSpriteFrames > 0 then
    BigCardPopView.spriteFrameNames = BigCardPopView.spriteFrameNames or {}
    table.insertto(BigCardPopView.spriteFrameNames, BigCardPopView.studioSpriteFrames)
end
function BigCardPopView:onInitUI()

    --output list
    self._ScrollView_card_t = self.csbNode:getChildByName("ScrollView_card")
	self._Button_right_t = self.csbNode:getChildByName("Button_right")
	self._Button_left_t = self.csbNode:getChildByName("Button_left")
	
    --label list
    
    --button list
    self._Panel_left_t = self.csbNode:getChildByName("Panel_left")
	self._Panel_left_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_leftClick), ""))

	self._Panel_right_t = self.csbNode:getChildByName("Panel_right")
	self._Panel_right_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_rightClick), ""))

	self._Button_close_t = self.csbNode:getChildByName("Button_close")
	self._Button_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Panel_left btFunc
function BigCardPopView:onPanel_leftClick()
    Functions.printInfo(self.debug,"Panel_left button is click!")
    ----------------------临时修改现代武将只显示一张高清大图
    if self._card.m_id >= 132 then
        return
    end
    ----------------------临时修改现代武将只显示一张高清大图
    
    if self.pageIdx <= 1 then
        --self._Button_left_t:setVisible(false)
        return
    end

    if 1 < self.pageIdx then
        self.pageIdx = self.pageIdx - 1
        --self:insertPage()
        --弹出动作
        local moveBy = cc.MoveBy:create(checknumber(0.5), cc.p(0,-display.cy*2))
        self._ScrollView_card_t:runAction(moveBy)
    end
    if self.pageIdx <= 1 then
        self._Button_left_t:setVisible(false)--返回到第一个界面时没有调用self:insertPage()，所以要提前做判断
    end
    if self.pageIdx < 7 then
        self._Button_right_t:setVisible(true)
    end
end
--@auto code Panel_left btFunc end

--@auto code Panel_right btFunc
function BigCardPopView:onPanel_rightClick()
    Functions.printInfo(self.debug,"Panel_right button is click!")
    ----------------------临时修改现代武将只显示一张高清大图
    if self._card.m_id >= 132 then
        return
    end
    ----------------------临时修改现代武将只显示一张高清大图
    
    if self.pageIdx >= 7 then
        self._Button_right_t:setVisible(false)
        return
    end
--    if self.pageIdx == self.num and self.pageIdx ~= 7 then
--        --弹出报错信息
--        PromptManager:openTipPrompt(LanguageConfig.language_BigCard_1)
--    end
    if 7 > self.pageIdx then--self._card.m_class
        self.pageIdx = self.pageIdx + 1
        self:insertPage()
        --弹出动作
        local moveBy = cc.MoveBy:create(checknumber(0.5), cc.p(0,display.cy*2))
        self._ScrollView_card_t:runAction(moveBy)
    end
    if self.pageIdx > 1 then
        self._Button_left_t:setVisible(true)
    end
end
--@auto code Panel_right btFunc end

--@auto code Button_close btFunc
function BigCardPopView:onButton_closeClick()
    Functions.printInfo(self.debug,"Button_close button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_close btFunc end

--@auto button backcall end


--@auto code output func
function BigCardPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function BigCardPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
--	local h = display.height
--	local _Scale = display.height/640
--    self._ScrollView_card_t:setScale(_Scale)
    --当前显示的页码(1 ~ pages)
    self.pageIdx = 1
	self._card = data.card
    self.num = Functions.formatHeroClass(self._card.m_class)
    
    ----------------------临时修改现代武将只显示一张高清大图
    if self._card.m_id >= 132 then
        self.num = 1
        self._Button_left_t:setVisible(false)
        self._Button_right_t:setVisible(false)
        --    self._Panel_left_t:setVisible(false)
        --    self._Panel_right_t:setVisible(false)
	end

    ----------------------临时修改现代武将只显示一张高清大图

    
    --for k = 1, self.num do
		self:insertPage()
	--end
    self:addAction(self._Button_left_t)
    self:addAction(self._Button_right_t)
end

function BigCardPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function BigCardPopView:addPage(pIdx)

    self.spr = Functions.createSpriteOfSfName("lk/uiFonts_res/xuanzhuan.png")
    local str = "bigCard/"..ConfigHandler:getHeroCardImageOfId( self._card.m_id, pIdx)
    str = string.gsub(str,"png","jpg")
    Functions.loadImageWithSprite(self.spr, str)
    --初使化动画所需
    self.sX = self._ScrollView_card_t:getContentSize().width/2
    self.sY = self._ScrollView_card_t:getContentSize().height/2 * 2
    self.spr:setPosition(cc.p(self.sX, self.sY))
    self.csbNode:addChild(self.spr)
    local Rotate = cc.RotateBy:create(0.1, 90)
    self.spr:runAction(Rotate)
end

function BigCardPopView:addAction(widget)

    
    local FadeIn = cc.FadeIn:create(2)
    local FadeOut = cc.FadeOut:create(2)
    local play = cc.Sequence:create(FadeOut,FadeIn)
    local rep = cc.RepeatForever:create(play)--永久播放 （次数设为负数可以一直播放）
    widget:runAction(rep)
end

function BigCardPopView:insertPage()
    local iIdx = self.pageIdx

    local newPage = self._ScrollView_card_t
    local text =  "Panel_card_"..tostring(iIdx)
    local spr = nil
    if iIdx > self.num  then
        local Sprite = "Spt_"..tostring(iIdx)
        local words = "Text_"..tostring(iIdx)
        newPage:getChildByName(text):getChildByName(words):setVisible(true)
        Functions.initLabelOfString(newPage:getChildByName(text):getChildByName(words), LanguageConfig.language_BigCard_1)
        spr = newPage:getChildByName(text):getChildByName(Sprite)
        spr:setVisible(true)
        local spt_str = "lk/uiFonts_res/beauty.png"--self._card.m_class
        Functions.loadImageWithSprite(spr, spt_str)
    else
        local Sprite = "Sprite_"..tostring(iIdx)
        spr = newPage:getChildByName(text):getChildByName(Sprite)
        local str = "bigCard/"..ConfigHandler:getHeroCardImageOfId( self._card.m_id, iIdx)--self._card.m_class
        str = string.gsub(str,"png","jpg")
        Functions.loadImageWithSprite(spr, str)
    end
    
    
    local scaletoBao = nil
    local seq_actio_Bao = nil
    if iIdx == 1 then
        local FIn = cc.FadeIn:create(2)
        self._Button_close_t:runAction(FIn)
        local FadeIn = cc.FadeIn:create(0.5)
        local rotateto_guang = cc.RotateTo:create(0.5, 1170)
        scaletoBao = cc.ScaleTo:create(0.5, 1)
        seq_actio_Bao = cc.Spawn:create(FadeIn,rotateto_guang,scaletoBao)
        spr:runAction(seq_actio_Bao)
    else
        spr:setScale(1)
    end
    
    if self.pageIdx >= 7 then
        self._Button_right_t:setVisible(false)
    end
    if self.pageIdx <= 1 then
        self._Button_left_t:setVisible(false)
    end
end

return BigCardPopView