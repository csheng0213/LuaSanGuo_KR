--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local XueZhanAttrPopView = class("XueZhanAttrPopView", BasePopView)

local Functions = require("app.common.Functions")

XueZhanAttrPopView.csbResPath = "tyj/csb"
XueZhanAttrPopView.debug = true
XueZhanAttrPopView.studioSpriteFrames = {"XueZhanAttrPopUI","SevenStar" }
--@auto code head end

XueZhanAttrPopView.spriteFrameNames = 
    {
    }
--@auto code uiInit
--add spriteFrames
if #XueZhanAttrPopView.studioSpriteFrames > 0 then
    XueZhanAttrPopView.spriteFrameNames = XueZhanAttrPopView.spriteFrameNames or {}
    table.insertto(XueZhanAttrPopView.spriteFrameNames, XueZhanAttrPopView.studioSpriteFrames)
end
function XueZhanAttrPopView:onInitUI()

    --output list
    self._attackCount_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Image_2"):getChildByName("attackCount")
	self._hpCount_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Image_2"):getChildByName("hpCount")
	self._mpCount_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Image_2"):getChildByName("mpCount")
	self._attackObj_t = self.csbNode:getChildByName("Panel_1"):getChildByName("attackObj")
	self._hpObj_t = self.csbNode:getChildByName("Panel_1"):getChildByName("hpObj")
	self._mpObj_t = self.csbNode:getChildByName("Panel_1"):getChildByName("mpObj")
	self._leftStar_t = self.csbNode:getChildByName("Panel_1"):getChildByName("leftStar")
	
    --label list
    
    --button list
    self._affirmBt_t = self.csbNode:getChildByName("affirmBt")
	self._affirmBt_t:onTouch(Functions.createClickListener(handler(self, self.onAffirmbtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Affirmbt btFunc
function XueZhanAttrPopView:onAffirmbtClick()
    Functions.printInfo(self.debug,"Affirmbt button is click!")
    XueZhanData:RequestAddAttr(self.selctedAttrFlag)
    self.close(self)
end
--@auto code Affirmbt btFunc end

--@auto button backcall end


--@auto code output func
function XueZhanAttrPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function XueZhanAttrPopView:onDisplayView()
    Functions.printInfo(self.debug,"pop action finish ")
    self._attackCount_t :setString(LanguageConfig.language_sevenStar_5 .. "+" .. tostring(XueZhanData.xueZhanData.m_xzAttack) .. "%") --攻击加成
    self._hpCount_t:setString(LanguageConfig.language_sevenStar_6 .. "+" .. tostring(XueZhanData.xueZhanData.m_xzHp) .. "%")     --生命加成
    self._mpCount_t:setString(LanguageConfig.language_sevenStar_7 .. "+" .. tostring(XueZhanData.xueZhanData.m_xzMp) .. "%")--筹谋加成
    self._leftStar_t:setString(tostring(XueZhanData.xueZhanData.m_xzlyStar)) --剩余星数
    self:selectAttr(1)
    if next(XueZhanData.xueZhanData.buff) ~= nil  then
        self:setAttr(self._attackObj_t,XueZhanData.xueZhanData.buff[1])
        self:setAttr(self._hpObj_t,XueZhanData.xueZhanData.buff[2])
        self:setAttr(self._mpObj_t,XueZhanData.xueZhanData.buff[3])
    end

    local handler1 = function()
        self:selectAttr(1)
    end
    local handler2 = function()
        self:selectAttr(2)
    end
    local handler3 = function()
        self:selectAttr(3)
    end
    self._attackObj_t:getChildByName("attrView"):onTouch(Functions.createClickListener(handler1, ""))
    self._hpObj_t:getChildByName("attrView"):onTouch(Functions.createClickListener(handler2, ""))
    self._mpObj_t:getChildByName("attrView"):onTouch(Functions.createClickListener(handler3, ""))

    Functions.handGuideOfFeild("isGuideXZattr", 1000)
end

function XueZhanAttrPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function XueZhanAttrPopView:selectAttr(AttrType)
    if AttrType == 1 then
        self._attackObj_t:getChildByName("choose"):setVisible(true)
        self._hpObj_t:getChildByName("choose"):setVisible(false)
        self._mpObj_t:getChildByName("choose"):setVisible(false)
        self.selctedAttrFlag = 1
    end
    if AttrType == 2  then
        self._attackObj_t:getChildByName("choose"):setVisible(false)
        self._hpObj_t:getChildByName("choose"):setVisible(true)
        self._mpObj_t:getChildByName("choose"):setVisible(false)
        self.selctedAttrFlag = 2
    end
    if AttrType == 3 then
        self._attackObj_t:getChildByName("choose"):setVisible(false)
        self._hpObj_t:getChildByName("choose"):setVisible(false)
        self._mpObj_t:getChildByName("choose"):setVisible(true)
        self.selctedAttrFlag = 3
    end
end
function XueZhanAttrPopView:setAttr( target, data )
    if data[1] == 1 then
        target:getChildByName("attrName"):setString(LanguageConfig.language_sevenStar_5 .. "+")
        -- target:getChildByName("attrName"):setColor(cc.c3b(255,0,0))
        -- target:getChildByName("attrNum"):setColor(cc.c3b(255,0,0))
        Functions.loadImageWithWidget(target:getChildByName("attrView"), "seven_starts_attack.png")
    elseif data[1] == 2 then
        target:getChildByName("attrName"):setString(LanguageConfig.language_sevenStar_6 .. "+")
        -- target:getChildByName("attrName"):setColor(cc.c3b(0,255,0))
        -- target:getChildByName("attrNum"):setColor(cc.c3b(0,255,0))
        Functions.loadImageWithWidget(target:getChildByName("attrView"), "seven_starts_life.png")
    elseif data[1] == 3 then
        target:getChildByName("attrName"):setString(LanguageConfig.language_sevenStar_7 .. "+")
        -- target:getChildByName("attrName"):setColor(cc.c3b(0,0,255))
        -- target:getChildByName("attrNum"):setColor(cc.c3b(0,0,255))
        Functions.loadImageWithWidget(target:getChildByName("attrView"), "seven_starts_mp.png")   
    end
    Functions.setEnabledImage(target:getChildByName("attrView"), self:isAvailable(data[3]))
    target:getChildByName("attrNum"):setString(tostring(data[2]) .. "%")
    target:getChildByName("starNum"):setString(tostring(data[3]))
end
function XueZhanAttrPopView:isAvailable(star)
    if XueZhanData.xueZhanData.m_xzlyStar  < star then
        return false
    end
    return true
end

return XueZhanAttrPopView