--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local MailTwoPopView = class("MailTwoPopView", BasePopView)

local Functions = require("app.common.Functions")

MailTwoPopView.csbResPath = "lk/csb"
MailTwoPopView.debug = true
MailTwoPopView.studioSpriteFrames = {"CBO_announcementBg" }
--@auto code head end

local MailData = require("app.gameData.MailData")

--@Pre loading
MailTwoPopView.spriteFrameNames = 
    {
    }

MailTwoPopView.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #MailTwoPopView.studioSpriteFrames > 0 then
    MailTwoPopView.spriteFrameNames = MailTwoPopView.spriteFrameNames or {}
    table.insertto(MailTwoPopView.spriteFrameNames, MailTwoPopView.studioSpriteFrames)
end
function MailTwoPopView:onInitUI()

    --output list
    self._Panel_two_page_t = self.csbNode:getChildByName("Panel_two_page")
	self._mail_npc_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("mail_npc")
	self._Image_lingqu_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Button_get"):getChildByName("Image_lingqu")
	self._Text_mail_title_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Text_mail_title")
	self._Text_mail_info_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Text_mail_info")
	self._Panel_bao_1_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_bao_1")
	self._Sprite_bao_1_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_bao_1"):getChildByName("Sprite_bao_1")
	self._Text_bao_num_1_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_bao_1"):getChildByName("Text_bao_num_1")
	self._Panel_gold_2_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_gold_2")
	self._Sprite_gold_2_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_gold_2"):getChildByName("Sprite_gold_2")
	self._Text_gold_num_2_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_gold_2"):getChildByName("Text_gold_num_2")
	self._Panel_power_3_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_power_3")
	self._Sprite_power_3_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_power_3"):getChildByName("Sprite_power_3")
	self._Text_power_num_3_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_power_3"):getChildByName("Text_power_num_3")
	self._Panel_soul_4_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_soul_4")
	self._Sprite_soul_4_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_soul_4"):getChildByName("Sprite_soul_4")
	self._Text_soul_num_4_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_soul_4"):getChildByName("Text_soul_num_4")
	self._Panel_hunjin_5_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_hunjin_5")
	self._Sprite_hunjin_5_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_hunjin_5"):getChildByName("Sprite_hunjin_5")
	self._Text_hunjin_num_5_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_hunjin_5"):getChildByName("Text_hunjin_num_5")
	self._Panel_jifen_6_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_jifen_6")
	self._Sprite_jifen_6_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_jifen_6"):getChildByName("Sprite_jifen_6")
	self._Text_jifen_num_6_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Panel_jifen_6"):getChildByName("Text_jifen_num_6")
	
    --label list
    
    --button list
    self._Button_get_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Button_get")
	self._Button_get_t:onTouch(Functions.createClickListener(handler(self, self.onButton_getClick), "zoom"))

	self._Button_close_t = self.csbNode:getChildByName("Panel_two_page"):getChildByName("Button_close")
	self._Button_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_close btFunc
function MailTwoPopView:onButton_closeClick()
    Functions.printInfo(self.debug,"Button_close button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_close btFunc end

--@auto code Button_get btFunc
function MailTwoPopView:onButton_getClick()
    Functions.printInfo(self.debug,"Button_get button is click!")
    --领取道具
    --local data = MailData:getMailDatas() 
    local onCheckMail = function(event)
        if event.reqtype == 3 then
            Functions.playSound("getmail.mp3")
            local msg = event.data
            for k,v in pairs(msg) do
            	local id = v[1]
            	local type = v[2]
            	local count = v[3]
            	local slot = v.slot
            	
                Functions:addItemResources( {id = id, type = type, count = count, slot = slot} )
            end
            self.param.eventAttr.m_fetched = 1
            
            --local data = MailData:getMailDatas() 
            --数据更新监听
            GameEventCenter:dispatchEvent({ name = MailData.MAIL_CHECKED })
            self._controller_t:closeChildView(self)
        end
    end
    NetWork:addNetWorkListener({ 10, 2 }, Functions.createNetworkListener(onCheckMail,true,"ret"))
    NetWork:sendToServer({ idx = { 10, 2 }, reqtype = 3 ,index = self.param.eventAttr.m_MailIdx})
    
    
end
--@auto code Button_get btFunc end

--@auto button backcall end


--@auto code output func
function MailTwoPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function MailTwoPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	
    --初始化npc
    Functions.loadImageWithSprite(self._mail_npc_t, "npc/NPC_lb_mail.png")
    
	--local param = data
	--assert(#param > 0, "param is nil error")
    self.param = data
	
	local iiii = self.param.eventAttr.m_MailIdx
    local ppppp = self.param.eventAttr.m_MailIdx
    Functions.initLabelOfString(self._Text_mail_title_t, data.eventAttr.s_mailname)
    
    --查看道具
    local MailDatas = MailData:getMailDatas() 
    local onCheckMail = function(event)
        if event.reqtype == 2 then
            --self._controller_t:closeChildView(self)
            self.param.eventAttr.m_checked = 1
--                local data = MailData:getMailDatas() 
--                for k, v in pairs(MailDatas) do
--                    if self.param.eventAttr.m_MailIdx == v.eventAttr.m_MailIdx then
--                        v.eventAttr.m_checked = 1
--                	end
--                end
            
            --数据更新监听
            GameEventCenter:dispatchEvent({ name = MailData.MAIL_CHECKED, data = data })
        end
    end

    NetWork:addNetWorkListener({ 10, 2 }, Functions.createNetworkListener(onCheckMail,true,"ret"))
    NetWork:sendToServer({ idx = { 10, 2 }, reqtype = 2 ,index = self.param.eventAttr.m_MailIdx})
    
    local rows = #self.param.eventAttr.s_msg
	
    if self.param.eventAttr.m_fetched == 1 then
        Functions.setEnabledBt(self._Button_get_t,false)
        Functions.setGrayLabel(self._Image_lingqu_t, true)
	end
   
	local hangY = 1
--	if (rows % 63) then
--        hangY = (math.floor(rows / 63) + 1) * 50
--    else
--        hangY = math.floor(rows / 63) * 50
--    end
    
    
    self._Text_mail_info_t:ignoreContentAdaptWithSize(false)
    self._Text_mail_info_t:setTextAreaSize(cc.size(520,0))

    self._Text_mail_info_t:setString(self.param.eventAttr.s_msg)
    local size = self._Text_mail_info_t:getVirtualRendererSize()
    self._Text_mail_info_t:setTextAreaSize(size)
    hangY = math.floor(250 - size.height)
    --self._Text_mail_info_t:setText( self.param.eventAttr.s_msg)
    --Functions.initTextSize(self._Text_mail_info_t, { width = 520, height = size.height})
    
    self.ItemInit_X = 0
    self.ItemInit_Y = 0 --小道具坐标
    self.MicroItem = 0  --小道具个数
    self.card = 0       --大道具个数
    self.ItemInitBig_Y = 0 --大道具坐标
    
--    if (rows % 63) then
--        self.ItemInit_Y = math.floor(250 - (math.floor(rows / 63) + 1) * 27-10)
--    else
--        self.ItemInit_Y = math.floor(250 - (math.floor(rows / 63) * 27 - 10))
--    end
    
    self.ItemInit_Y = hangY
    
    
    if self.param.eventAttr.m_mtype == 2 then
        local items = self.param.eventAttr.m_item
        
        for i=1, #items do
            local item = items[i]
            
            if item.itype == 4 then
                if item.id == -1 then--经验
                    self.MicroItem = self.MicroItem + 1
            	elseif item.id == -2 then--元宝
                    self.MicroItem = self.MicroItem + 1
            	    self._Panel_bao_1_t:setVisible(true)
                    self._Text_bao_num_1_t:setText(item.count)
                elseif item.id == -3 then--铜币
                    self.MicroItem = self.MicroItem + 1
                    self._Panel_gold_2_t:setVisible(true)
                    self._Text_gold_num_2_t:setText(item.count)
                elseif item.id == -4 then--体力
                    self.MicroItem = self.MicroItem + 1
                    self._Panel_power_3_t:setVisible(true)
                    self._Text_power_num_3_t:setText(item.count)
                elseif item.id == -5 then--武魂
                    self.MicroItem = self.MicroItem + 1
                    self._Panel_soul_4_t:setVisible(true)
                    self._Text_soul_num_4_t:setText(item.count)
                elseif item.id == -6 then--魂精
                    self.MicroItem = self.MicroItem + 1
                    self._Panel_hunjin_5_t:setVisible(true)
                    self._Text_hunjin_num_5_t:setText(item.count)
                elseif item.id == -7 then--天梯积分
                    self.MicroItem = self.MicroItem + 1
                    self._Panel_jifen_6_t:setVisible(true)
                    self._Text_jifen_num_6_t:setText(item.count)
                else
                    --道具
                    self.card = self.card + 1
                end
                
            elseif item.itype == 1 then--如果类型为1则为武将卡
                --self._Panel_item_t:setVisible(true)
                --Functions.loadImageWithWidget(self._Sprite_head_t,ConfigHandler:getHeroHeadImageOfId(item.id))
                self.card = self.card + 1
            end
            
--            if data[param[1]].eventAttr.m_fetched == 1 then
--                self._Button_get_t:setVisible(false)
--            end
        end
        self.ItemInitBig_Y = hangY - ((self.MicroItem / 2) + self.MicroItem % 2) * 50 --初始化大道具坐标
        --self.ItemInitBig_Y = self.ItemInit_Y - ((self.MicroItem / 2) + self.MicroItem % 2) * 50 --初始化大道具坐标
        self:showItem(items)
    else
        self._Button_get_t:setVisible(false)
    end
	
	print("adf")
end

function MailTwoPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end

--@auto code output func end

function MailTwoPopView:showItem(items)
    Functions.printInfo(self.debug,"showItem")
    local c_iMicroItem2 = self.MicroItem    --小道具个数
    local c_iBigItem2 = self.card           --大道具个数
    
    for i = 1, #items do
        self.itemX = 100 + ((c_iMicroItem2 - self.MicroItem ) % 2) * 230
        self.itemY = math.floor(self.ItemInit_Y - (math.floor((c_iMicroItem2 - self.MicroItem) / 2) * 50 + 50) + 250)


        local c_iItemBigX = 100 + ((c_iBigItem2 - self.card ) % 4) * 130
        local c_iItemBigY = self.ItemInitBig_Y - math.floor((c_iBigItem2 - self.card ) / 4) * 150 - 100 + 300
        
        local item = items[i]
        if item.itype == 4 then
            
            if item.id == -1 then--经验
                self.MicroItem = self.MicroItem - 1
            elseif item.id == -2 then--元宝
                self.MicroItem = self.MicroItem - 1
                self._Panel_bao_1_t:setPosition(self.itemX, self.itemY)
                self._Text_bao_num_1_t:setText(item.count)
            elseif item.id == -3 then--铜币
                self.MicroItem = self.MicroItem - 1
                self._Panel_gold_2_t:setPosition(self.itemX, self.itemY)
                self._Text_gold_num_2_t:setText(item.count)
            elseif item.id == -4 then--体力
                self.MicroItem = self.MicroItem - 1
                self._Panel_power_3_t:setPosition(self.itemX, self.itemY)
                self._Text_power_num_3_t:setText(item.count)
            elseif item.id == -5 then--武魂
                self.MicroItem = self.MicroItem - 1
                self._Panel_soul_4_t:setPosition(self.itemX, self.itemY)
                self._Text_soul_num_4_t:setText(item.count)
            elseif item.id == -6 then--魂精
                self.MicroItem = self.MicroItem - 1
                self._Panel_hunjin_5_t:setPosition(self.itemX, self.itemY)
                self._Text_hunjin_num_5_t:setText(item.count)
            elseif item.id == -7 then--魂精
                self.MicroItem = self.MicroItem - 1
                self._Panel_jifen_6_t:setPosition(self.itemX, self.itemY)
                self._Text_jifen_num_6_t:setText(item.count)
            else
                local item = Functions.createPartNode({ nodeType = 4, nodeId = item.id, count = item.count })
                item:setPosition(c_iItemBigX, c_iItemBigY)
                item:setScale(0.7)
                self._Panel_two_page_t:addChild(item)
                self.card = self.card - 1
            end

        elseif item.itype == 1 or item.itype == 5 or item.itype == 8 then--如果类型为1则为武将卡
            local hero = Functions.createPartNode({ nodeType = item.itype, nodeId = item.id, count = item.count })
            hero:setScale(0.7)
            hero:setPosition(c_iItemBigX, c_iItemBigY)
            self._Panel_two_page_t:addChild(hero)
            self.card = self.card - 1
        end
    end
end

return MailTwoPopView