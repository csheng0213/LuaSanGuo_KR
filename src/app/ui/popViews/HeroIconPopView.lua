--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local HeroIconPopView = class("HeroIconPopView", BasePopView)

local Functions = require("app.common.Functions")

HeroIconPopView.csbResPath = "lk/csb"
HeroIconPopView.debug = true
HeroIconPopView.studioSpriteFrames = {"CB_unionTankuang" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #HeroIconPopView.studioSpriteFrames > 0 then
    HeroIconPopView.spriteFrameNames = HeroIconPopView.spriteFrameNames or {}
    table.insertto(HeroIconPopView.spriteFrameNames, HeroIconPopView.studioSpriteFrames)
end
function HeroIconPopView:onInitUI()

    --output list
    self._Panel_hero_icon_t = self.csbNode:getChildByName("Panel_icon_bai"):getChildByName("Panel_hero_icon")
	
    --label list
    
    --button list
    self._Button_close_t = self.csbNode:getChildByName("Panel_icon_bai"):getChildByName("Button_close")
	self._Button_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_close btFunc
function HeroIconPopView:onButton_closeClick()
    Functions.printInfo(self.debug,"Button_close button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_close btFunc end

--@auto button backcall end


--@auto code output func
function HeroIconPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

--@para data = { cb = function }
function HeroIconPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
    --发送图鉴接口
    PokedexData:sendServerPokedex(handler(self, self.onSuccess))
	
    self.handler = data.cb
end

function HeroIconPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function HeroIconPopView:show()
    local haveHero = PokedexData:getHeroIconDatas()
    local listHandler = function(index, widget, model, data)
        local oooooooo = widget:getChildByName("head")
        widget:setTouchEnabled(false)
        widget:getChildByName("head"):setTouchEnabled(true)
        widget:getChildByName("head"):setSwallowTouches(false)
        Functions.initLordHeadOfId(widget, ConfigHandler:getLordHeadIdOfId(data.m_id))
        --Functions.initHeroHeadWidget(widget:getChildByName("head"),data.m_id)
        
        local onClick = function(event)
            --弹出提示信息
            local cb = self.handler
            self:close()
            cb(data)
        end
        widget:getChildByName("head"):onTouch(Functions.createTableViewClickListener(self._Panel_hero_icon_t,onClick,"movedis"))
        --绑定响应事件函数
    end
    Functions.bindTableViewWithData(self._Panel_hero_icon_t,{ firstData = haveHero },{handler = listHandler},{direction = true, col = 5, firstSegment = 0, segment = 2 }) 
end

function HeroIconPopView:onSuccess(data)
    Functions.printInfo(self.debug_b,"onSuccess")
    if data.ret == 1 then
        self:show()
    end
end
return HeroIconPopView