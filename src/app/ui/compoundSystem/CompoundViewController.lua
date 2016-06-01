--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local CompoundViewController = class("CompoundViewController", BaseViewController)

local Functions = require("app.common.Functions")

CompoundViewController.debug = true
CompoundViewController.modulePath = ...
CompoundViewController.studioSpriteFrames = {"CompoundUI_Text","CB_blackbg","CompoundUI" }
--@auto code head end

local CompoundData = require("app.gameData.CompoundData")

--@Pre loading
CompoundViewController.spriteFrameNames = 
    {
        "headPilistRes"
    }

CompoundViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #CompoundViewController.studioSpriteFrames > 0 then
    CompoundViewController.spriteFrameNames = CompoundViewController.spriteFrameNames or {}
    table.insertto(CompoundViewController.spriteFrameNames, CompoundViewController.studioSpriteFrames)
end
function CompoundViewController:onDidLoadView()

    --output list
    self._bar_board_t = self.view_t.csbNode:getChildByName("main"):getChildByName("bar_board")
	self._resNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("resNode")
	self._ListView_Compound_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("ListView_Compound")
	self._childModel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("ListView_Compound"):getChildByName("model"):getChildByName("childModel")
	self._Image_text_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Image_text")
	
    --label list
    
    --button list
    self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function CompoundViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
    GameCtlManager:pop(self)
end
--@auto code Button_back btFunc end

--@auto code Text_soul btFunc
function CompoundViewController:onText_soulClick()
    Functions.printInfo(self.debug,"Text_soul button is click!")
end
--@auto code Text_soul btFunc end

--@auto code Button_cargo_bg_1 btFunc
function CompoundViewController:onButton_cargo_bg_1Click()
    Functions.printInfo(self.debug,"Button_cargo_bg_1 button is click!")
end
--@auto code Button_cargo_bg_1 btFunc end

--@auto code Button_cargo_bg_2 btFunc
function CompoundViewController:onButton_cargo_bg_2Click()
    Functions.printInfo(self.debug,"Button_cargo_bg_2 button is click!")
end
--@auto code Button_cargo_bg_2 btFunc end

--@auto code Button_cargo_bg_3 btFunc
function CompoundViewController:onButton_cargo_bg_3Click()
    Functions.printInfo(self.debug,"Button_cargo_bg_3 button is click!")
end
--@auto code Button_cargo_bg_3 btFunc end

--@auto button backcall end


--@auto code view display func
function CompoundViewController:onCreate()
    Functions.printInfo(self.debug_b," CompoundViewController controller create!")
end

function CompoundViewController:onDisplayView()
	Functions.printInfo(self.debug_b," CompoundViewController view enter display!")
    self._ListView_Compound_t:setVisible(false)
    Functions.setPopupKey("combining")
    Functions.initResNodeUI(self._resNode_t,{ "jinbi" , "yuanbao", "jifen" })
	self:show()
end
--@auto code view display func end

function CompoundViewController:show()
    Functions.printInfo(self.debug_b,"show")
    self:showSP()
end

function CompoundViewController:sendGetCard(m_mark)
    Functions.printInfo(self.debug,"sendGetCard")

    local onSendGetCard = function (event)
        local id = event.id
        local count = event.count--卡片数量
        local type = event.ftype--卡片类型
        
        local number = event.fcnt
        local card_mark = event.islot--卡片标识
        local mark = event.slot--碎片标识
        
        CompoundData:addCompoundData({id = id, mark = mark, num = number, type = 2})
        
        Functions:addItemResources( {id = id, type = type, count = count, slot = card_mark} )
        --CompoundData:setCompoundBZ()
        --刷新界面
        self:showSP()
        --改变图鉴刷新按扭
        PokedexData:getLight(id)
        
        self:openChildView("app.ui.popViews.CompoundAnimaPopView", { data = {mark = card_mark}})

    end

    NetWork:addNetWorkListener({ 17, 1 }, Functions.createNetworkListener(onSendGetCard, true, "ret"))
    NetWork:sendToServer({ idx = { 17, 1 }, ftype = 5, slot = m_mark })
end

function CompoundViewController:showSP()
    Functions.printInfo(self.debug,"showSP")

    local CompoundData = CompoundData:getCompoundData()
    --是否显示文字提示
    if #CompoundData <= 0 then
        self._Image_text_t:setVisible(true)
        self._childModel_t:setVisible(false)
        self._ListView_Compound_t:setVisible(false)
        return false
    else
        self._Image_text_t:setVisible(false)
    end
    local listHandler = function(index, widget, model, data)

        local ban = widget:getChildByName("Image_cargo_bg_1")
        local head = widget:getChildByName("Image_cargo_bg_1"):getChildByName("Image_hero_head_1")


        ban:getChildByName("Text_hero_name_1"):setText(ConfigHandler:getHeroNameOfId(data.m_id))
        ban:getChildByName("Text_faction_num_1"):setText(tostring(data.m_possessCount).."/"..tostring(data.m_needCount))
        Functions.loadImageWithWidget(head, ConfigHandler:getHeroHeadImageOfId(data.m_id))
        local widg = ban:getChildByName("Image_faction_zhenyin_1")
        Functions.initHeroFaction(widg, data.m_id)
        Functions.HeroStar((ban:getChildByName("Image_star"):ignoreContentAdaptWithSize(true)), data.m_id)
        if data.m_compound == 1 then
            ban:getChildByName("Image_summon_icon_1"):setVisible(true)
        end
        local Loading = math.floor(((data.m_possessCount) / (data.m_needCount)) * 100)
        ban:getChildByName("LoadingBar_icon_1"):setPercent(Loading)

        if Loading < 100 then
            Functions.setGrayImage(ban:getChildByName("Image_star"), true)
            Functions.setGrayImage(head, true)
        end

        local onCompoundBut = function(event)
            print("button click")
            --打开二级界面
            if data.m_compound == 1 then
                --发送合成接口
                self:sendGetCard(data.m_mark)
            else
                self:openChildView("app.ui.popViews.CompoundPopView", { data = data})
            end

        end
        widget:getChildByName("Image_cargo_bg_1"):onTouch(Functions.createClickListener(onCompoundBut, "zoom"))

        if index == 1 then
            self._heChenWidget_t = widget:getChildByName("Image_cargo_bg_1")
        end
    end
    --绑定响应事件函数
    Functions.bindArryListWithData(self._ListView_Compound_t,{ firstData = CompoundData }, listHandler,{direction = true, col = 3, firstSegment = 0, segment = 5 })
end

function CompoundViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end

return CompoundViewController