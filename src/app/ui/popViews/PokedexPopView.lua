--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local PokedexPopView = class("PokedexPopView", BasePopView)

local Functions = require("app.common.Functions")

PokedexPopView.csbResPath = "lk/csb"
PokedexPopView.debug = true
PokedexPopView.studioSpriteFrames = {"CB_bgup","PokedexPopUI_Text" }
--@auto code head end
--@Pre loading
PokedexPopView.spriteFrameNames = 
    {
    }

PokedexPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #PokedexPopView.studioSpriteFrames > 0 then
    PokedexPopView.spriteFrameNames = PokedexPopView.spriteFrameNames or {}
    table.insertto(PokedexPopView.spriteFrameNames, PokedexPopView.studioSpriteFrames)
end
function PokedexPopView:onInitUI()

    --output list
    self._Text_schedule_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Text_schedule")
	self._Panel_all_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Panel_all")
	self._Panel_wei_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Panel_wei")
	self._Panel_shu_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Panel_shu")
	self._Panel_wu_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Panel_wu")
	self._Panel_qun_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Panel_qun")
	self._Panel_hero_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Panel_hero")
	
    --label list
    
    --button list
    self._Button_close_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Button_close")
	self._Button_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_close btFunc
function PokedexPopView:onButton_closeClick()
    Functions.printInfo(self.debug,"Button_close button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_close btFunc end

--@auto button backcall end


--@auto code output func
function PokedexPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function PokedexPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	
    self.cardState = 1
    --显示图鉴
    self:SelectedShow()
    local onPanel1 = function()
        print("panel 1 click")

        self.cardState = 1
        self:SelectedShow()
    end

    local onPanel2 = function()
        print("panel 2 click")
        self.cardState = 2
        self:SelectedShow()
    end 

    local onPanel3 = function()
        print("panel 3 click")

        self.cardState = 3
        self:SelectedShow()
    end 

    local onPanel4 = function()
        print("panel 4 click")

        self.cardState = 4
        self:SelectedShow()
    end 

    local onPanel5 = function()
        print("panel 5 click")

        self.cardState = 5
        self:SelectedShow()
    end 

    Functions.initTabCom({ { self._Panel_all_t, onPanel1, true }, { self._Panel_wei_t, onPanel2}, { self._Panel_shu_t, onPanel3}, 
        { self._Panel_wu_t, onPanel4}, { self._Panel_qun_t, onPanel5}})
end

function PokedexPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function PokedexPopView:SelectedShow()
    Functions.printInfo(self.debug,"SelectedShow")

    PokedexData.Refresh = false

    if self.cardState == 1 then
        self._Card = PokedexData:getPokedexDatas()
    elseif self.cardState == 2 then
        self._Card = PokedexData:getweiHeroDatas()
    elseif self.cardState == 3 then
        self._Card = PokedexData:getshuHeroDatas()
    elseif self.cardState == 4 then
        self._Card = PokedexData:getwuHeroDatas()
    elseif self.cardState == 5 then
        self._Card = PokedexData:getqunHeroDatas()
    end
    --显示收集进度
    local str = tostring( PokedexData:getPokedexNum(self._Card)).."/"..tostring(#self._Card)
    Functions.initLabelOfString( self._Text_schedule_t, str)

    self:showCard(self._Card)
end

function PokedexPopView:showCard(Pokedexdata)
    Functions.printInfo(self.debug,"showCard")
    local listHandler = function(index, widget, model, data)
        --显示武将头像信息
        widget:setTouchEnabled(false)
        widget:getChildByName("heroView"):setTouchEnabled(true)
        widget:getChildByName("heroView"):setSwallowTouches(false)
        Functions.showPokedexHead(widget,data)

        if data.m_state == 0 then
             --Functions.setGrayImage(widget:getChildByName("heroView"), true)
             --Functions.setGrayImage(widget:getChildByName("type"), true)
             --Functions.setGrayImage(widget:getChildByName("Camp"), true)
            Functions.loadImageWithWidget(widget:getChildByName("frame"), "commonUI/res/PokedexFrame2.png")
            local star = ConfigHandler:getHeroStarOfId(data.m_id)

            local str = "Sprite_star_"..tostring(star)
            Functions.setGrayImage(widget:getChildByName("Panel_head_star"):getChildByName(str), true)
        elseif data.m_state == 1 then
            --Functions.setGrayImage(widget:getChildByName("heroView"), false)
            --Functions.setGrayImage(widget:getChildByName("type"), false)
            --Functions.setGrayImage(widget:getChildByName("Camp"), false)
            Functions.loadImageWithWidget(widget:getChildByName("frame"), "commonUI/res/PokedexFrame2.png")
            local star = ConfigHandler:getHeroStarOfId(data.m_id)

            local str = "Sprite_star_"..tostring(star)
            Functions.setGrayImage(widget:getChildByName("Panel_head_star"):getChildByName(str), false)
        elseif data.m_state == 2 then
            Functions.loadImageWithWidget(widget:getChildByName("frame"), "commonUI/res/PokedexFrame2.png")
            local star = ConfigHandler:getHeroStarOfId(data.m_id)

            local str = "Sprite_star_"..tostring(star)
            Functions.setGrayImage(widget:getChildByName("Panel_head_star"):getChildByName(str), true)
            
--            local sprite = Functions.createSprite("commonUI/res/icons/50003.png")
--            sprite:setLocalZOrder(30)
--            widget:addChild(sprite)
        end

        local onClick = function(event)
            --打开二级界面
            if data.m_state == 2 then
                --弹出提示信息
                PromptManager:openTipPrompt(LanguageConfig.language_Pokedex_2)
            else
                self._controller_t:openChildView("app.ui.popViews.CardInfoPopView", { data = {data.m_id, 4, data.m_class, data.m_state}, isRemove = false })
            end
        end
        widget:getChildByName("heroView"):onTouch(Functions.createTableViewClickListener(self._Panel_hero_t,onClick,"movedis"))
        --绑定响应事件函数
    end
    --Functions.bindArryListWithData(self._ListView_Pokedex_t,{ firstData = Pokedexdata }, listHandler,{direction = true, col = 6, firstSegment = 0, segment = 2 })
    Functions.bindTableViewWithData(self._Panel_hero_t,{ firstData = Pokedexdata },{handler = listHandler},{direction = true, col = 6, firstSegment = 0, segment = 2 }) 
end


return PokedexPopView