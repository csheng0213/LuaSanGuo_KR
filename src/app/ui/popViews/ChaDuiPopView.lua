--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local ChaDuiPopView = class("ChaDuiPopView", BasePopView)

local Functions = require("app.common.Functions")

ChaDuiPopView.csbResPath = "lk/csb"
ChaDuiPopView.debug = true
ChaDuiPopView.studioSpriteFrames = {"ChaDuiPopUI","ChaDuiPopUI_Text" }
--@auto code head end
--@Pre loading
ChaDuiPopView.spriteFrameNames = 
    {
    }

ChaDuiPopView.animaNames = 
    {
    }



--@auto code uiInit
--add spriteFrames
if #ChaDuiPopView.studioSpriteFrames > 0 then
    ChaDuiPopView.spriteFrameNames = ChaDuiPopView.spriteFrameNames or {}
    table.insertto(ChaDuiPopView.spriteFrameNames, ChaDuiPopView.studioSpriteFrames)
end
function ChaDuiPopView:onInitUI()

    --output list
    self._ListView_din_t = self.csbNode:getChildByName("Panel_1"):getChildByName("ListView_din")
	self._ProjectNode_1_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_6"):getChildByName("ProjectNode_1")
	self._Text_Distribution_2_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Text_Distribution_2")
	self._Panel_2_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_2")
	self._Text_Distribution_3_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_2"):getChildByName("Text_Distribution_3")
	self._Panel_3_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_3")
	self._Text_Distribution_6_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_3"):getChildByName("Text_Distribution_6")
	self._Panel_4_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_4")
	self._Text_2_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_4"):getChildByName("Panel_5"):getChildByName("Text_2")
	self._Text_4_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_4"):getChildByName("Panel_5"):getChildByName("Text_4")
	
    --label list
    
    --button list
    self._Button_cha_dui_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Button_cha_dui")
	self._Button_cha_dui_t:onTouch(Functions.createClickListener(handler(self, self.onButton_cha_duiClick), "zoom"))

	self._Button_no_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_4"):getChildByName("Panel_5"):getChildByName("Button_no")
	self._Button_no_t:onTouch(Functions.createClickListener(handler(self, self.onButton_noClick), "zoom"))

	self._Button_ok_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Panel_4"):getChildByName("Panel_5"):getChildByName("Button_ok")
	self._Button_ok_t:onTouch(Functions.createClickListener(handler(self, self.onButton_okClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_cha_dui btFunc
function ChaDuiPopView:onButton_cha_duiClick()
    Functions.printInfo(self.debug,"Button_cha_dui button is click!")
    if self.rank == 1 then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_ChaDui_3)
    else 
        self._Panel_4_t:setVisible(true)
    end
    

end
--@auto code Button_cha_dui btFunc end

--@auto code Button_no btFunc
function ChaDuiPopView:onButton_noClick()
    Functions.printInfo(self.debug,"Button_no button is click!")
    self._Panel_4_t:setVisible(false)
end
--@auto code Button_no btFunc end

--@auto code Button_ok btFunc
function ChaDuiPopView:onButton_okClick()
    Functions.printInfo(self.debug,"Button_ok button is click!")
    
    self.type = 2
    self._Panel_4_t:setVisible(false)
    local onServerRequest = function (event)
        PlayerData.eventAttr.m_gold = event.data.gold
    end
    NetWork:addNetWorkListener({7,3}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {7, 3}, type = self.type, data = {lidx = self.lidx, index = self.idx}}
    NetWork:sendToServer(msg)
    
end
--@auto code Button_ok btFunc end

--@auto button backcall end


--@auto code output func
function ChaDuiPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function ChaDuiPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
    self.idx = data.idx            --物品索引
    self.isApply = data.isApply    --是否申请
    self.lidx = data.lidx          --章节数
    local type = data.awardType     --物品类型
    local id = data.awardId         --物品ID
    self.type = 1                   --发送的类型（查询列表为1，插队为2）
    
    if self.isApply then
    	self._Button_cha_dui_t:setVisible(true)
        self._Panel_3_t:setVisible(true)
    end
    
    local node = Functions.createPartNode({ nodeType = type, nodeId = id})
    --node:setLocalZOrder(-1)
    Functions.copyParam(self._ProjectNode_1_t,node )
    self._ProjectNode_1_t:getParent():addChild(node)
    
    self:sendChaDuiData()
end

function ChaDuiPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function ChaDuiPopView:showChaDui()
    Functions.printInfo(self.debug,"showChaDui")
    
    local datas = self:getChaDuiDatas()
    local ppp = self.rank
    Functions.initLabelOfString(self._Text_Distribution_2_t, tostring(self.ItemCount), self._Text_Distribution_3_t, self:getChaDuiTime(self.time), 
        self._Text_Distribution_6_t, tostring(self.rank), self._Text_2_t, g_guildCompensate, self._Text_4_t, g_guildChaDuiGold * (self.rank-1))
        
    if self.ItemCount ~= 0 then
        self._Panel_2_t:setVisible(true)
    end
    local onList = function(index, widget, data, model)
        local button = widget:getChildByName("Panel_list_fb")
        local banModel = model:getChildByName("Panel_list_fb")
        Functions.initTextColor(banModel:getChildByName("Text_name"),button:getChildByName("Text_name"))
        Functions.initTextColor(banModel:getChildByName("Text_level"),button:getChildByName("Text_level"))
        
        Functions.loadImageWithWidget(button:getChildByName("Image_head_board"):getChildByName("Image_head_icon"), Functions.getDisHeadFImagePathOfId(data.pic))

        Functions.initLabelOfString(button:getChildByName("Text_name"), data.name, button:getChildByName("Text_level"), tostring(data.level),
            button:getChildByName("Text_num"), tostring(index))
    end
    Functions.bindListWithData(self._ListView_din_t, datas, onList)
    
end

function ChaDuiPopView:getChaDuiDatas()
    Functions.printInfo(self.debug,"getChaDuiDatas")
    return self.ChaDuiDatas
end

function ChaDuiPopView:getChaDuiTime(time)
    Functions.printInfo(self.debug,"getChaDuiTime")
    local newTime = time - TimerManager:getCurrentSecond()
    local num = tonumber(TimerManager:formatTime("%M", newTime))
    local str = tostring(num)
    return str
end

function ChaDuiPopView:sendChaDuiData()
    Functions.printInfo(self.debug,"sendChaDuiData")
    local onChaDui = function (event)
    
        Functions.setAdbrixTag("retension","guild_reward_reset_buy", tostring(PlayerData.eventAttr.m_level))
        
        self.ChaDuiDatas = {}
        local data = event.data
        self.ItemCount = data.ItemCount
        self.time = data.sys_distribute_time
        self.rank = data.rank
        for k, v in pairs(data.list) do
            self.ChaDuiDatas[#self.ChaDuiDatas + 1] = v
        end
        self:showChaDui()
    end
    
    Functions.bindNetWorkListener(self, { 7, 3 }, Functions.createNetworkListener(onChaDui, false, "ret"))
    local msg = {idx = {7, 3}, type = self.type, data = {lidx = self.lidx, index = self.idx}}
    NetWork:sendToServer(msg)
end

return ChaDuiPopView