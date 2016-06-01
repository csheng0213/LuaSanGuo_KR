--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local RankViewController = class("RankViewController", BaseViewController)

local Functions = require("app.common.Functions")

RankViewController.debug = true
RankViewController.modulePath = ...
RankViewController.studioSpriteFrames = {"CB_bgup","RankUI_Text","CB_blackbg","RankUI" }
--@auto code head end

--@Pre loading
RankViewController.spriteFrameNames = 
    {
    }

RankViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #RankViewController.studioSpriteFrames > 0 then
    RankViewController.spriteFrameNames = RankViewController.spriteFrameNames or {}
    table.insertto(RankViewController.spriteFrameNames, RankViewController.studioSpriteFrames)
end
function RankViewController:onDidLoadView()

    --output list
    self._bar_board_t = self.view_t.csbNode:getChildByName("main"):getChildByName("bar_board")
	self._resNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("resNode")
	self._Panel_player_rank_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Sprite_compound_bg"):getChildByName("Panel_player_rank")
	self._Panel_guild_rank_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Sprite_compound_bg"):getChildByName("Panel_guild_rank")
	self._Sprite_title_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Sprite_title_1")
	self._Sprite_title_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Sprite_title_2")
	self._Text_rank_num_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Sprite_ban"):getChildByName("Text_rank_num")
	self._Text_page_num_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Sprite_ban"):getChildByName("Text_page_num")
	self._Panel_guild_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_guild")
	self._Panel_player_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_player")
	
    --label list
    
    --button list
    self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

	self._Button_left_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Sprite_ban"):getChildByName("Button_left")
	self._Button_left_t:onTouch(Functions.createClickListener(handler(self, self.onButton_leftClick), "zoom"))

	self._Button_right_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Sprite_ban"):getChildByName("Button_right")
	self._Button_right_t:onTouch(Functions.createClickListener(handler(self, self.onButton_rightClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function RankViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
    RankData.GuildRank = false
    GameCtlManager:pop(self)
end
--@auto code Button_back btFunc end

--@auto code Button_left btFunc
function RankViewController:onButton_leftClick()
    Functions.printInfo(self.debug,"Button_left button is click!")
--    if self.MaxPage <= self.TypePage then
--        return
--    end

    if self.TypePage > 1 then
        self.playerDatas = {}
        self.TypePage = self.TypePage - 1
        if self.TypeState == 1 then
            self:showPlayer()
        elseif self.TypeState == 2 then
            self:showGuild()
        end
    end
end
--@auto code Button_left btFunc end

--@auto code Button_right btFunc
function RankViewController:onButton_rightClick()
    Functions.printInfo(self.debug,"Button_right button is click!")
    local oooo = self.MaxPage
    local pppp = self.TypePage
    if self.MaxPage <= self.TypePage then
        return
    end
    if self.TypePage < 50 then
        self.TypePage = self.TypePage + 1
        if self.TypeState == 1 then
        	self:showPlayer()
        elseif self.TypeState == 2 then
            self:showGuild()
        end
    end
end
--@auto code Button_right btFunc end

--@auto button backcall end


--@auto code view display func
function RankViewController:onCreate()
    Functions.printInfo(self.debug_b," RankViewController controller create!")
end

function RankViewController:onDisplayView()
	Functions.printInfo(self.debug_b," RankViewController view enter display!")
    Functions.initResNodeUI(self._resNode_t,{ "jinbi" , "yuanbao", "soul" })
	
	--当前选择武将类型(1为玩家排行，2为公会排行)
    self.TypeState = 1
    --当前页数为1
    self.TypePage = 1
    --RankData:sendPlayerDatas(handler(self, self.showWJ))
    --最大页数
    self.MaxPage = 1
    
    self:getMaxPage(RankData:getPlayerDatas())
    self:showPlayer()
    
     
	local onPanel1 = function()
        print("panel 1 click")
        if self.TypeState ~= 1 then
            self.TypeState = 1
            self.TypePage = 1
            Functions.loadImageWithSprite(self._Sprite_title_1_t, "commonUI/res/lk/RankUI/wanjiapaihangbang.png")
            Functions.loadImageWithSprite(self._Sprite_title_2_t, "commonUI/res/lk/RankUI/wanjia.png")
            self._Panel_player_t:setVisible(true)
            self._Panel_guild_t:setVisible(false)
            self:getMaxPage(RankData:getPlayerDatas())
        end
        self:showPlayer()
    end 
    
    local onPanel2 = function()
        print("panel 2 click")
        if self.TypeState ~= 2 then
            self.TypeState = 2
            self.TypePage = 1
            Functions.loadImageWithSprite(self._Sprite_title_1_t, "commonUI/res/lk/RankUI/gonghuipaihangbang.png")
            Functions.loadImageWithSprite(self._Sprite_title_2_t, "commonUI/res/lk/RankUI/gonghui.png")
            self._Panel_guild_t:setVisible(true)
            self._Panel_player_t:setVisible(false)
            self:getMaxPage(RankData:getGuildDatas())
        end
        
        if RankData.GuildRank == false then
            RankData:sendGuildDatas(handler(self, self.showGH))
            return
        end
        self:showGuild()
    end 
	
	Functions.initTabCom({ { self._Panel_player_rank_t, onPanel1, true }, { self._Panel_guild_rank_t, onPanel2}})
end
--@auto code view display func end

function RankViewController:showWJ()
    Functions.printInfo(self.debug_b," showWJ")
    self:getMaxPage(RankData:getPlayerDatas())
    self:showPlayer()
end

function RankViewController:showGH()
    Functions.printInfo(self.debug_b," showGH")
    self:getMaxPage(RankData:getGuildDatas())
    self:showGuild()
end

function RankViewController:getMaxPage(data)
    Functions.printInfo(self.debug_b," getMaxPage")
    local num = math.floor(#data%50)
    if num == 0 then
        self.MaxPage = math.floor(#data/50)
    else
        self.MaxPage = math.floor(#data/50) + 1
    end
    if self.MaxPage > 50 then
        self.MaxPage = 50
    end
    if self.MaxPage <= 0 then
        self.MaxPage = 1
    end
end

function RankViewController:showPlayer()
    Functions.printInfo(self.debug_b," showPlayer")
    
    --现在所在页数
    Functions.initLabelOfString(self._Text_page_num_t,tostring(self.TypePage).."/"..tostring(self.MaxPage))
    --我的排名:%d
    local PlayerNum = RankData:getPlayerNum()
    if PlayerNum ~= 0 then
        local str = string.format(LanguageConfig.language_Rank_1, PlayerNum)
        Functions.initLabelOfString(self._Text_rank_num_t, str)
    else
        local ppp = LanguageConfig.language_Rank_5
        Functions.initLabelOfString(self._Text_rank_num_t, LanguageConfig.language_Rank_5)
    end
    
    local listHandler = function(index, widget, model, data)
        Functions.initTextColor(model:getChildByName("Text_name"),widget:getChildByName("Text_name"))
        Functions.initTextColor(model:getChildByName("Text_atk_num"),widget:getChildByName("Text_atk_num"))
        Functions.initTextColor(model:getChildByName("Text_level"),widget:getChildByName("Text_level"))
        Functions.initTextColor(model:getChildByName("Text_player"),widget:getChildByName("Text_player"))
        widget:setTouchEnabled(false)
        local str = tostring((self.TypePage - 1)*50 + index)
        widget:getChildByName("BitmapFontLabel_rank"):setText(str)
        widget:getChildByName("Image_rank_num_2"):setVisible(false)
        
        if ((self.TypePage - 1)*50 + index) == 1 then
            Functions.loadImageWithWidget(widget:getChildByName("Image_rank_num_2"), "commonUI/res/lk/RankUI/1.png")
            widget:getChildByName("Image_rank_num_2"):setVisible(true)
        elseif ((self.TypePage - 1)*50 + index) == 2 then
            Functions.loadImageWithWidget(widget:getChildByName("Image_rank_num_2"), "commonUI/res/lk/RankUI/2.png")
            widget:getChildByName("Image_rank_num_2"):setVisible(true)
        elseif ((self.TypePage - 1)*50 + index) == 3 then
            Functions.loadImageWithWidget(widget:getChildByName("Image_rank_num_2"), "commonUI/res/lk/RankUI/3.png")
            widget:getChildByName("Image_rank_num_2"):setVisible(true)
        end 
        
        if data.tongName == nil then
            widget:getChildByName("Text_name"):setString(LanguageConfig.language_Rank_4)
        else
            widget:getChildByName("Text_name"):setString(data.tongName)
        end
        
        widget:getChildByName("Text_atk_num"):setString(data.allfight)
        widget:getChildByName("Text_level"):setString(data.level)
        widget:getChildByName("Text_player"):setString(data.name)
    end
    local datas = RankData:getPlayerDatas()
    local playerDatas = {}
    local num = 1
    if self.TypePage > 1 then
    	num = (self.TypePage-1)*50+1
    end
    for k = num,num+49, 1 do
        if num > #datas then
        	break
        end
        if datas[k] ~= nil  then
            playerDatas[#playerDatas+1] = datas[k]
        end
    end
    Functions.bindTableViewWithData(self._Panel_player_t,{ firstData = playerDatas },{handler = listHandler},{direction = false, col = 1, firstSegment = 0, segment = 2 }) 
end

function RankViewController:showGuild()
    Functions.printInfo(self.debug_b," showGuild")
    --现在所在页数
    Functions.initLabelOfString(self._Text_page_num_t,tostring(self.TypePage).."/"..tostring(self.MaxPage))
    local GuildNum = RankData:getGuildNum()
    if GuildNum ~= 0 then
        local str = string.format(LanguageConfig.language_Rank_1, GuildNum)
        Functions.initLabelOfString(self._Text_rank_num_t, str)
    else
        Functions.initLabelOfString(self._Text_rank_num_t, LanguageConfig.language_Rank_5)
    end
    
    local listHandler = function(index, widget, model, data)

        Functions.initTextColor(model:getChildByName("Text_name"),widget:getChildByName("Text_name"))
        Functions.initTextColor(model:getChildByName("Text_atk_num"),widget:getChildByName("Text_atk_num"))
        Functions.initTextColor(model:getChildByName("Text_count"),widget:getChildByName("Text_count"))
        Functions.initTextColor(model:getChildByName("Text_president_name"),widget:getChildByName("Text_president_name"))
        widget:setTouchEnabled(false)
        local str = tostring((self.TypePage - 1)*50 + index)
        widget:getChildByName("BitmapFontLabel_rank"):setText(str)
        widget:getChildByName("Image_rank_num_1"):setVisible(false)
        local ppppp = ((self.TypePage - 1)*50 + index)
        if ((self.TypePage - 1)*50 + index) == 1 then
            Functions.loadImageWithWidget(widget:getChildByName("Image_rank_num_1"), "commonUI/res/lk/RankUI/1.png")
            widget:getChildByName("Image_rank_num_1"):setVisible(true)
        elseif ((self.TypePage - 1)*50 + index) == 2 then
            Functions.loadImageWithWidget(widget:getChildByName("Image_rank_num_1"), "commonUI/res/lk/RankUI/2.png")
            widget:getChildByName("Image_rank_num_1"):setVisible(true)
        elseif ((self.TypePage - 1)*50 + index) == 3 then
            Functions.loadImageWithWidget(widget:getChildByName("Image_rank_num_1"), "commonUI/res/lk/RankUI/3.png")
            widget:getChildByName("Image_rank_num_1"):setVisible(true)
        end
        
        if data.allfight == nil then
            widget:getChildByName("Text_atk_num"):setString("0")
        else
            widget:getChildByName("Text_atk_num"):setString(data.allfight)
        end
        
        widget:getChildByName("Text_name"):setString(data.gname)
        widget:getChildByName("Text_count"):setString(data.gcount)
        widget:getChildByName("Text_president_name"):setString(data.chairmanname)
    end
    local datas = RankData:getGuildDatas()
    local GuildDatas = {}
    local num = 1
    if self.TypePage > 1 then
        num = (self.TypePage-1)*50+1
    end
    for k = num,num+49, 1 do
        if num > #datas then
            break
        end
        if datas[k] ~= nil  then
            GuildDatas[#GuildDatas+1] = datas[k]
        end
    end
    Functions.bindTableViewWithData(self._Panel_guild_t,{ firstData = GuildDatas },{handler = listHandler},{direction = false, col = 1, firstSegment = 0, segment = 2 }) 
end

function RankViewController:PalyerHandler(event)
    Functions.printInfo(self.debug_b," showHandler")
    if event.reqtype == 35 and event.ret == 1 then
        self:showPlayer()
    end
end


return RankViewController