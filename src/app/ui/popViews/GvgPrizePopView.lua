--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local GvgPrizePopView = class("GvgPrizePopView", BasePopView)

local Functions = require("app.common.Functions")

GvgPrizePopView.csbResPath = "lk/csb"
GvgPrizePopView.debug = true
GvgPrizePopView.studioSpriteFrames = {"GvgUI_Text" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #GvgPrizePopView.studioSpriteFrames > 0 then
    GvgPrizePopView.spriteFrameNames = GvgPrizePopView.spriteFrameNames or {}
    table.insertto(GvgPrizePopView.spriteFrameNames, GvgPrizePopView.studioSpriteFrames)
end
function GvgPrizePopView:onInitUI()

    --output list
    self._Sprite_bid_but_text_t = self.csbNode:getChildByName("Panel_prize"):getChildByName("Button_ok"):getChildByName("Sprite_bid_but_text")
	self._Panel_item_t = self.csbNode:getChildByName("Panel_prize"):getChildByName("Panel_item")
	
    --label list
    
    --button list
    self._Button_prize_close_t = self.csbNode:getChildByName("Panel_prize"):getChildByName("Button_prize_close")
	self._Button_prize_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_prize_closeClick), "zoom"))

	self._Button_ok_t = self.csbNode:getChildByName("Panel_prize"):getChildByName("Button_ok")
	self._Button_ok_t:onTouch(Functions.createClickListener(handler(self, self.onButton_okClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_prize_close btFunc
function GvgPrizePopView:onButton_prize_closeClick()
    Functions.printInfo(self.debug,"Button_prize_close button is click!")
    self:close(self)
end
--@auto code Button_prize_close btFunc end

--@auto code Button_ok btFunc
function GvgPrizePopView:onButton_okClick()
    Functions.printInfo(self.debug,"Button_ok button is click!")
    local datas = GuildBattleData:getBuildingInfo()
    if datas[self.BuildingID].rewardState == 1 then
        GuildBattleData:sendGetPrize(self.BuildingID, handler(self, self.showBut))
    end
end
--@auto code Button_ok btFunc end

--@auto button backcall end


--@auto code output func
function GvgPrizePopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function GvgPrizePopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	self.BuildingID = data.id
    --local prop = loadstring("return "..g_bigCity[data.id].everydayReward)
    local prop = GuildBattleData:getBuildingPrize()
    local item = prop[data.id]
	local size = self._Panel_item_t:getContentSize()
    local height = size.height
    local width = size.width
    local num = #item
    --奖励不能超过4个
    if num > 4 then
    	num = 4
    end
    local c_iItemBigX = 0
    local c_iItemBigY = 0
    
    self:showBut()

    for k, v in pairs(item) do
        if num == 1 then
            c_iItemBigX = size.width*0.5
        end
        if num == 2 then
            c_iItemBigX = size.width/num*(k-1)+100
        end
        if num == 3 then
            c_iItemBigX = size.width/num*(k-1)+70
        end
        if num == 4 then
            c_iItemBigX = size.width/num*(k-1)+50
        end
        c_iItemBigY = size.height*0.5
        local hero = Functions.createPartNode({ nodeType = item[k][2], nodeId = item[k][1], count = item[k][3] })
        hero:setScale(0.7)
        hero:setPosition(c_iItemBigX, c_iItemBigY)
        self._Panel_item_t:addChild(hero)
    end
end

function GvgPrizePopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function GvgPrizePopView:showBut()
    Functions.printInfo(self.debug,"child class create call ")
    local datas = GuildBattleData:getBuildingInfo()
    if datas[self.BuildingID].rewardState == 1 then
        Functions.loadImageWithSprite(self._Sprite_bid_but_text_t, "commonUI/res/common/lingqu.png")
        Functions.setEnabledBt(self._Button_ok_t,true)
        
    elseif datas[self.BuildingID].rewardState == 2 then
        Functions.loadImageWithSprite(self._Sprite_bid_but_text_t, "commonUI/res/common/yilingqu.png")--yilingqu
        Functions.setEnabledBt(self._Button_ok_t,false)
        
    elseif datas[self.BuildingID].rewardState == 0 then
        Functions.loadImageWithSprite(self._Sprite_bid_but_text_t, "commonUI/res/common/lingqu.png")
        Functions.setEnabledBt(self._Button_ok_t,false)
        
    end
end

return GvgPrizePopView