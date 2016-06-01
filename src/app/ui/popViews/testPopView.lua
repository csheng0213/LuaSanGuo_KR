--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local testPopView = class("testPopView", BasePopView)

local Functions = require("app.common.Functions")

testPopView.csbResPath = "lk/csb"
testPopView.debug = true
--@auto code head end
--@Pre loading
testPopView.spriteFrameNames = 
    {
    }

testPopView.animaNames = 
    {
    }

--@auto code uiInit
function testPopView:onInitUI()

    --output list
    self._Sprite_hero_bg_ban_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Sprite_hero_bg_ban")
	self._Text_schedule_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Text_schedule")
	self._ListView_Pokedex_t = self.csbNode:getChildByName("Panel_main"):getChildByName("ListView_Pokedex")
	self._Panel_all_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Panel_all")
	self._Panel_wei_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Panel_wei")
	self._Panel_shu_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Panel_shu")
	self._Panel_wu_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Panel_wu")
	self._Panel_qun_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Panel_qun")
	self._Panel_35_t = self.csbNode:getChildByName("Panel_35")
	self._ProjectNode_hero_t = self.csbNode:getChildByName("Panel_35"):getChildByName("ProjectNode_hero")
	
    --label list
    
    --button list
    self._Button_close_t = self.csbNode:getChildByName("Panel_main"):getChildByName("Button_close")
	self._Button_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_close btFunc
function testPopView:onButton_closeClick()
    Functions.printInfo(self.debug,"Button_close button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_close btFunc end

--@auto button backcall end


--@auto code output func
--function testPopView:getPopAction()
--	Functions.printInfo(self.debug,"pop actionFunc is call")
--end

function testPopView:onDisplayView()
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

function testPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function testPopView:SelectedShow()
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
    local iiii = #self._Card
    local oooo = #self._Card
end

function testPopView:showCard(Pokedexdata)
    self:createTable(Pokedexdata)    
end

function testPopView:createTable(Pokedexdata)

    local size = self._Panel_35_t:getContentSize() 
    self.heroView = cc.TableView:create(cc.size(size.width,size.height))
    --self.heroView = cc.TableView:create(cc.size(810, 450))
    
    self.heroView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.heroView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.heroView:setAnchorPoint(cc.p(0,0)) 
    self.heroView:setPosition(cc.p(0, 0))
--    self.heroView:setTag(100)
    self.heroView:setDelegate()
    
    --self._Sprite_hero_bg_ban_t:addChild(self.heroView)
    --
    self._Panel_35_t:addChild(self.heroView)
    
    local cellSizeForTable = function(view, idx)
        return 200, 200
    end
    
    --table 个数
    local numberOfCellsInTableView = function(view)
        local ppiii = #Pokedexdata
        if #Pokedexdata % 5 == 0 then
            return 1
        end
        return 1
    end



    local tableCellAtIndex = function(view, idx)
        --设置tabler的显示
        --local self = GUI.GetGUI("SkillBoard")
        --local cell = view:cellAtIndex(idx)
        local cell = view:dequeueCell()
        if not cell then
            cell = cc.TableViewCell:new()
            local bgSprite = Functions.createSprite("commonUI/res/icons/adddd.png")
            bgSprite:setPosition(cc.p(500,200))
            --bgSprite:setScale(10)
            cell:addChild(bgSprite)
--            --显示武将头像信息
--            local bgSprite = Functions.showHeroHead(widget,data)
            self._ProjectNode_hero_t:setPosition(cc.p(200,200))
            local model = self._ProjectNode_hero_t:getChildByName("model"):clone()
            cell:addChild(model)
            
--            bgSprite:setAnchorPoint(cc.PointZero)
--            bgSprite:setPosition(cc.p(100,100))
--            cell:addChild(bgSprite)
        end
        return cell
    end
    
    self.heroView:registerScriptHandler(handler(self,self.tableCellTouched), cc.TABLECELL_TOUCHED)
    self.heroView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
    self.heroView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
    self.heroView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
    self.heroView:reloadData()
end



--触摸的哪个table
function testPopView:tableCellTouched(view, cell)
    --cc.log("cell touched at index: %d", cell:getIdx())
    --local self = GUI.GetGUI("SkillBoard")  
--    local pppp = cell:getIdx()  
--    if self:isOpened() then
--        for cl, sitem in pairs(self._skillItems) do
--            local issel = (cl == cell)
--            sitem:select(issel)
--            if issel then
--                self:onClickSkill(sitem:getSkill())
--            end
--        end
--    end
end





return testPopView