--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local XueZhanTipsPopView = class("XueZhanTipsPopView", BasePopView)

local Functions = require("app.common.Functions")

XueZhanTipsPopView.csbResPath = "tyj/csb"
XueZhanTipsPopView.debug = true
XueZhanTipsPopView.studioSpriteFrames = {"CBO_xzTipsBan" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #XueZhanTipsPopView.studioSpriteFrames > 0 then
    XueZhanTipsPopView.spriteFrameNames = XueZhanTipsPopView.spriteFrameNames or {}
    table.insertto(XueZhanTipsPopView.spriteFrameNames, XueZhanTipsPopView.studioSpriteFrames)
end
function XueZhanTipsPopView:onInitUI()

    --output list
    self._rewardPanel_t = self.csbNode:getChildByName("rewardPanel")
	self._level_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("level")
	self._stageLable_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("stageLable")
	self._extPrizePanel_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("extPrizePanel")
	self._basePrizePanel_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("basePrizePanel")
	
    --label list
    self._Text_10_0_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("Text_10_0")
	self._Text_10_0_t:setString(LanguageConfig.language_1_23)

	self._Text_10_0_0_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("Text_10_0_0")
	self._Text_10_0_0_t:setString(LanguageConfig.language_1_24)
    --button list
    self._closeBt_t = self.csbNode:getChildByName("rewardPanel"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function XueZhanTipsPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:close()
end
--@auto code Closebt btFunc end

--@auto button backcall end


--@auto code output func
function XueZhanTipsPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function XueZhanTipsPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	local TextReader = require("app.common.TextReader")
	local xueZhanReward = TextReader.parserFile("data/xzreward.txt")

	if self.type == 1 then 
		self._stageLable_t:setString(LanguageConfig.language_1_20)
	elseif self.type == 2 then 
		self._stageLable_t:setString(LanguageConfig.language_1_21)
	elseif self.type == 3 then 
		self._stageLable_t:setString(LanguageConfig.language_1_22)
	end
	if self.currentLevel ~= nil and self.type ~= nil then 
		self._level_t:setString(string.format(LanguageConfig.language_Teach28,self.currentLevel))
		local levelData = self:getPrizeInf(xueZhanReward,self.type,self.currentLevel)
		
		local script = " local basePrize = " .. levelData["基础"] .. "  return basePrize"

		local basePrize=assert(loadstring(script))()  
		self:setBasePrize(basePrize)
		if levelData["额外"] ~= nil then 
			script = " local extPrize = " .. levelData["额外"] .. "  return extPrize"

			local extPrize = assert(loadstring(script))() 
			Functions.createPrizeNode(self._extPrizePanel_t,extPrize)
		end
	end
end

function XueZhanTipsPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function XueZhanTipsPopView:setXueZhanType( type )
	self.type  = type
end
function XueZhanTipsPopView:setXueZhanLevel( currentLevel )
	self.currentLevel = currentLevel
end
function XueZhanTipsPopView:getPrizeInf(allData,xueZhanType,currentLevel)
	local selectedData = {}
	for k,v in pairs(allData) do 
		if v["难度"] == xueZhanType and v["关卡"] == currentLevel then 
			selectedData = v
		end
	end
	return selectedData
end
function XueZhanTipsPopView:setBasePrize(basePrize)
	for k,v in pairs(basePrize) do 
		local basePrizeNode = self._basePrizePanel_t:getChildByName("item" .. k)
		basePrizeNode:setVisible(true)
		if v[1] == -2 then 
			Functions.loadImageWithSprite(basePrizeNode, "commonUI/res/image/yuanbao.png")
		elseif v[1] == -3 then
			Functions.loadImageWithSprite(basePrizeNode, "commonUI/res/image/jinbi.png")
		elseif v[1] == -4 then
			Functions.loadImageWithSprite(basePrizeNode, "commonUI/res/image/jitui.png")
		elseif v[1] == -5 then
			Functions.loadImageWithSprite(basePrizeNode, "commonUI/res/image/soul.png")
		elseif v[1] == -6 then
			Functions.loadImageWithSprite(basePrizeNode, "commonUI/res/image/hunjin.png")
		end
		local basePrizeText = self._basePrizePanel_t:getChildByName("itemText" .. k)
		basePrizeText:setString("x" .. v[3])
		basePrizeText:setVisible(true)
	end
end
return XueZhanTipsPopView