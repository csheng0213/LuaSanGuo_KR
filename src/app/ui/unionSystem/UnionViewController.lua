--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local UnionViewController = class("UnionViewController", BaseViewController)

local Functions = require("app.common.Functions")

UnionViewController.debug = true
UnionViewController.modulePath = ...
UnionViewController.studioSpriteFrames = {"UnionUI","CBO_unionBgOne","CB_blackbg","UnionUI_Text","CBO_unionBg" }
--@auto code head end

local UnionData = require("app.gameData.UnionData")

--@Pre loading
UnionViewController.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #UnionViewController.studioSpriteFrames > 0 then
    UnionViewController.spriteFrameNames = UnionViewController.spriteFrameNames or {}
    table.insertto(UnionViewController.spriteFrameNames, UnionViewController.studioSpriteFrames)
end
function UnionViewController:onDidLoadView()

    --output list
    self._resNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("resNode")
	self._Panel_union_main_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main")
	self._Image_nuion_main_icon_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Sprite_nuion_main_icon_bg"):getChildByName("Image_nuion_main_icon")
	self._Text_main_union_name_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Text_main_union_name")
	self._Text_id_num_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Text_id_num")
	self._Text_ren_shu_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Text_ren_shu")
	self._Text_xuan_yan_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Text_xuan_yan_2")
	self._ListView_cheng_yuan_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("ListView_cheng_yuan")
	self._Text_name_level_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("ListView_cheng_yuan"):getChildByName("model"):getChildByName("Button_cheng_yuan_list"):getChildByName("Text_name_level")
	self._Text_Position_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("ListView_cheng_yuan"):getChildByName("model"):getChildByName("Button_cheng_yuan_list"):getChildByName("Text_Position")
	self._Panel_C_box_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_C_box")
	self._Panel_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_C_box"):getChildByName("Panel_1")
	self._Panel_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_C_box"):getChildByName("Panel_2")
	self._Panel_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_C_box"):getChildByName("Panel_3")
	self._Panel_add_union_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_add_union")
	self._ListView_add_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_add_union"):getChildByName("ListView_add")
	self._Text_add_list_name_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_add_union"):getChildByName("ListView_add"):getChildByName("model"):getChildByName("Image_add_list"):getChildByName("Text_add_list_name")
	self._Text_add_list_level_num_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_add_union"):getChildByName("ListView_add"):getChildByName("model"):getChildByName("Image_add_list"):getChildByName("Text_add_list_level_num")
	self._Text_palyer_num_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_add_union"):getChildByName("ListView_add"):getChildByName("model"):getChildByName("Image_add_list"):getChildByName("Text_palyer_num")
	self._Panel_creat_union_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_creat_union")
	self._TextField_union_name_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_creat_union"):getChildByName("TextField_union_name")
	self._Image_creat_union_icon_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_creat_union"):getChildByName("Sprite_union_icon_bg"):getChildByName("Image_creat_union_icon")
	self._Text_creat_bao_num_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_creat_union"):getChildByName("Text_creat_bao_num")
	self._Panel_find_union_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_find_union")
	self._TextField_find_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_find_union"):getChildByName("TextField_find")
	self._Image_find_list_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_find_union"):getChildByName("Image_find_list")
	self._Image_find_list_head_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_find_union"):getChildByName("Image_find_list"):getChildByName("Image_find_list_head_bg"):getChildByName("Image_find_list_head")
	self._Text_find_list_name_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_find_union"):getChildByName("Image_find_list"):getChildByName("Text_find_list_name")
	self._Text_find_list_level_num_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_find_union"):getChildByName("Image_find_list"):getChildByName("Text_find_list_level_num")
	
    --label list
    
    --button list
    self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_left"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

	self._Button_log_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Button_log")
	self._Button_log_t:onTouch(Functions.createClickListener(handler(self, self.onButton_logClick), "zoom"))

	self._Button_out_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Button_out")
	self._Button_out_t:onTouch(Functions.createClickListener(handler(self, self.onButton_outClick), "zoom"))

	self._Button_manage_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Button_manage")
	self._Button_manage_t:onTouch(Functions.createClickListener(handler(self, self.onButton_manageClick), "zoom"))

	self._Button_god_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Button_god")
	self._Button_god_t:onTouch(Functions.createClickListener(handler(self, self.onButton_godClick), "zoom"))

	self._Button_FB_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Button_FB")
	self._Button_FB_t:onTouch(Functions.createClickListener(handler(self, self.onButton_fbClick), "zoom"))

	self._Button_msg_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Button_msg")
	self._Button_msg_t:onTouch(Functions.createClickListener(handler(self, self.onButton_msgClick), "zoom"))

	self._Button_cheng_yuan_list_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("ListView_cheng_yuan"):getChildByName("model"):getChildByName("Button_cheng_yuan_list")
	self._Button_cheng_yuan_list_t:onTouch(Functions.createClickListener(handler(self, self.onButton_cheng_yuan_listClick), "zoom"))

	self._Button_donate_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_union_main"):getChildByName("Button_donate")
	self._Button_donate_t:onTouch(Functions.createClickListener(handler(self, self.onButton_donateClick), "zoom"))

	self._Button_add_list_but_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_add_union"):getChildByName("ListView_add"):getChildByName("model"):getChildByName("Image_add_list"):getChildByName("Button_add_list_but")
	self._Button_add_list_but_t:onTouch(Functions.createClickListener(handler(self, self.onButton_add_list_butClick), "zoom"))

	self._Button_Modify_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_creat_union"):getChildByName("Button_Modify")
	self._Button_Modify_t:onTouch(Functions.createClickListener(handler(self, self.onButton_modifyClick), "zoom"))

	self._Button_creat_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_creat_union"):getChildByName("Button_creat")
	self._Button_creat_t:onTouch(Functions.createClickListener(handler(self, self.onButton_creatClick), "zoom"))

	self._Button_find_but_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_find_union"):getChildByName("Button_find_but")
	self._Button_find_but_t:onTouch(Functions.createClickListener(handler(self, self.onButton_find_butClick), "zoom"))

	self._Button_find_list_but_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_main"):getChildByName("Panel_find_union"):getChildByName("Image_find_list"):getChildByName("Button_find_list_but")
	self._Button_find_list_but_t:onTouch(Functions.createClickListener(handler(self, self.onButton_find_list_butClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Text_soul btFunc
function UnionViewController:onText_soulClick()
    Functions.printInfo(self.debug,"Text_soul button is click!")
end
--@auto code Text_soul btFunc end

--@auto code Button_back btFunc
function UnionViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
    GameCtlManager:pop(self)
    
end
--@auto code Button_back btFunc end

--@auto code Button_add_list btFunc
function UnionViewController:onButton_add_listClick()
    Functions.printInfo(self.debug,"Button_add_list button is click!")
end
--@auto code Button_add_list btFunc end

--@auto code Button_modify btFunc
function UnionViewController:onButton_modifyClick()
    Functions.printInfo(self.debug,"Button_modify button is click!")
    --打开选择公会图标
    --self._controller_t:openChildView("app.ui.popViews.UnionIconPopView")
    self:openChildView("app.ui.popViews.UnionIconPopView")
end
--@auto code Button_modify btFunc end

--@auto code Button_creat btFunc
function UnionViewController:onButton_creatClick()
    Functions.printInfo(self.debug,"Button_creat button is click!")
    if (#self._TextField_union_name_t:getString() ~= 0 and PlayerData.eventAttr.m_money >= g_csBaseCfg.CreateGuildGold) then
        local onUnionCreat = function(event)
            if event.reqtype == 6 then
                if event.ret == 1 then
                    Functions.setAdbrixTag("retension","guild_create_buy",tostring(PlayerData.eventAttr.m_level))
                    PlayerData.eventAttr.m_money = event.data.nmoney
                    --查询公会信息
                    self:sendUnionInfo()
                else
                    --弹出报错信息
                    PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
                    --PromptManager:openTipPrompt(g_csErrorString[event.ret])
                end
                return true
            end
        end
        NetWork:addNetWorkListener({ 7, 1 }, onUnionCreat)
        NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 6, data = { name = self._TextField_union_name_t:getString(), pic = self.pic } })
    else
        if PlayerData.eventAttr.m_money < g_csBaseCfg.CreateGuildGold then
            --弹出报错信息
            PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(17))
        elseif #self._TextField_union_name_t:getString() == 0 then
            --弹出报错信息
            PromptManager:openTipPrompt(LanguageConfig.language_Union_2)
        end
    end
end
--@auto code Button_creat btFunc end

--@auto code Button_find_but btFunc
function UnionViewController:onButton_find_butClick()
    Functions.printInfo(self.debug,"Button_find_but button is click!")

    if #self._TextField_find_t:getString() ~= 0 then
        local onUnionCreat = function(event)
            if event.reqtype == 5 then
                local data = event.data
                if event.ret == 1 then
                    self._Image_find_list_t:setVisible(true)

                    Functions.initLabelOfString(self._Text_find_list_name_t, data.name, self._Text_find_list_level_num_t, data.join_level)
                    self.tongId = data.id
                    
                    --绘制公会图标
                    Functions.loadImageWithWidget(self._Image_find_list_head_t, Functions:getGongHuiImageOfId(data.pic)) 
                    
                else
                    --弹出报错信息
                    PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
                    --PromptManager:openTipPrompt(g_csErrorString[event.ret])
                end
                return true
            end
        end
        NetWork:addNetWorkListener({ 7, 1 }, onUnionCreat)
        NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 5, data = { id = tonumber(self._TextField_find_t:getString()) } })
    else
        if tonumber(self._TextField_find_t:getString()) <= 0 then
            --弹出报错信息
            PromptManager:openTipPrompt(LanguageConfig.language_Union_3)
        end
    end
    
end
--@auto code Button_find_but btFunc end

--@auto code Button_log btFunc
function UnionViewController:onButton_logClick()
    Functions.printInfo(self.debug,"Button_log button is click!")
    --打开公会日志
    self:openChildView("app.ui.popViews.UnionLogPopView")
end
--@auto code Button_log btFunc end

--@auto code Button_out btFunc
function UnionViewController:onButton_outClick()
    Functions.printInfo(self.debug,"Button_out button is click!")
    local MemberInfo = UnionData:getMemberInfoData()
    local zhiWei = 0
    for k, v in pairs(MemberInfo) do
        if PlayerData.eventAttr.m_uid == v.m_id then
            zhiWei = v.eventAttr.m_member_type
            break
        end
    end
    if zhiWei == 3 then
        --弹出报错信息
        PromptManager:openTipPrompt(LanguageConfig.language_Union_35)
    else
        NoticeManager:openTips(self, { handler = handler(self,self.Prompt), title = LanguageConfig.language_Union_28})
    end
    
end
--@auto code Button_out btFunc end

--@auto code Button_manage btFunc
function UnionViewController:onButton_manageClick()
    Functions.printInfo(self.debug,"Button_manage button is click!")
    --打开公会管理
    self:openChildView("app.ui.popViews.UnionButFunctionPopView")
end
--@auto code Button_manage btFunc end

--@auto code Button_god btFunc
function UnionViewController:onButton_godClick()
    Functions.printInfo(self.debug,"Button_god button is click!")
    --膜拜大神
    self:openChildView("app.ui.popViews.UnionGodPopView")
end
--@auto code Button_god btFunc end

--@auto code Button_fb btFunc
function UnionViewController:onButton_fbClick()
    Functions.printInfo(self.debug,"Button_fb button is click!")
    --团队副本
    self:openChildView("app.ui.popViews.UnionFBPopView")
end
--@auto code Button_fb btFunc end

--@auto code Button_msg btFunc
function UnionViewController:onButton_msgClick()
    Functions.printInfo(self.debug,"Button_msg button is click!")
    --公会留言
    self:openChildView("app.ui.popViews.UnionMsgPopView")
end
--@auto code Button_msg btFunc end


--@auto code Button_add_list_but btFunc
function UnionViewController:onButton_add_list_butClick()
    Functions.printInfo(self.debug,"Button_add_list_but button is click!")
end
--@auto code Button_add_list_but btFunc end

--@auto code Button_cheng_yuan_list btFunc
function UnionViewController:onButton_cheng_yuan_listClick()
    Functions.printInfo(self.debug,"Button_cheng_yuan_list button is click!")
end
--@auto code Button_cheng_yuan_list btFunc end

--@auto code Button_find_list_but btFunc
function UnionViewController:onButton_find_list_butClick()
    --查找公会的按扭加入公会
    Functions.printInfo(self.debug,"Button_find_list_but button is click!")
    --点击加入公会
    self:sendAddUnion(self.tongId)
end
--@auto code Button_find_list_but btFunc end

--@auto code Button_donate btFunc
function UnionViewController:onButton_donateClick()
    Functions.printInfo(self.debug,"Button_donate button is click!")
    -- PromptManager:openTipPrompt(LanguageConfig.language_Union_42)
    --公会留言
    self:openChildView("app.ui.popViews.UnionDonatePopView")
end
--@auto code Button_donate btFunc end

--@auto button backcall end


--@auto code view display func
function UnionViewController:onCreate()
    Functions.printInfo(self.debug," UnionViewController controller create!")
end

function UnionViewController:onDisplayView()
	Functions.printInfo(self.debug_b," UnionViewController view enter display!")
    Functions.setPopupKey("society")
    --Functions.bindMGSDisplay(self._Text_money_t, self._Text_bao_t)
    local iiii = PlayerData.eventAttr.m_tongID 
	if PlayerData.eventAttr.m_tongID == 0 then
        UnionData:clearUnionList()
        --查询公会列表接口
        self:sendUnionList()
        self:showView()
	else
        --查询公会信息接口
        self:sendUnionInfo()
	end
	
	
    local onPanel1 = function()
        print("panel 1 click")
        self._Panel_add_union_t:setVisible(true)
        self._Panel_creat_union_t:setVisible(false)
        self._Panel_find_union_t:setVisible(false)
    end

    local onPanel2 = function()
        print("panel 2 click")
        Functions.loadImageWithWidget(self._Image_creat_union_icon_t, ConfigHandler:getHeroHeadImageOfId(g_headicon[1])) 
        self._Panel_add_union_t:setVisible(false)
        self._Panel_creat_union_t:setVisible(true)
        self._Panel_find_union_t:setVisible(false)
        Functions.initLabelOfString( self._Text_creat_bao_num_t, g_csBaseCfg.CreateGuildGold)
    end
    local onPanel3 = function()
        print("panel 3 click")
        self._Panel_add_union_t:setVisible(false)
        self._Panel_creat_union_t:setVisible(false)
        self._Panel_find_union_t:setVisible(true)
    end 
    Functions.initTabCom({ { self._Panel_1_t, onPanel1, true }, { self._Panel_2_t, onPanel2}, { self._Panel_3_t, onPanel3} })

	--初使化公会图标
    self.pic = g_headicon[1]
	
    Functions.initResNodeUI(self._resNode_t,{ "jinbi" , "yuanbao", "huoyue" })
    --监听函数
    local onCheckedIcon = function(event)
        Functions.loadImageWithWidget(self._Image_nuion_main_icon_t, Functions:getGongHuiImageOfId(event.data))
        --Functions.loadImageWithWidget(self._Image_nuion_main_icon_t, ConfigHandler:getHeroHeadImageOfId(event.data)) 
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, UnionData.ADD_UNION_CHANGE_ICON_EVENT, onCheckedIcon)
    
    --监听函数
    local onCreatIcon = function(event)
        self.pic = event.data
        
        Functions.loadImageWithWidget(self._Image_creat_union_icon_t, Functions:getGongHuiImageOfId(event.data)) 
        --Functions.loadImageWithWidget(self._Image_creat_union_icon_t, ConfigHandler:getHeroHeadImageOfId(event.data)) 
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, UnionData.ADD_UNION_ICON_EVENT, onCreatIcon)
    
    --监听职位改变ui变化
    local onPosition = function(event)
        UnionData:getMemberSort()
        self:showMemberInfo()
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, UnionData.MEMBER_POSITION_EVENT, onPosition)
    
    --监听修改公告
    local onNotice = function(event)
        --公告
        local data = UnionData:getUnionInfoData()
        Functions.initLabelOfString(self._Text_xuan_yan_2_t, data[1].eventAttr.s_notice)
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, UnionData.NOTICE_EVENT, onNotice)
    
    --self._TextField_find_t:setPlaceHolder(LanguageConfig.language_Union_32)
    self._TextField_union_name_t:setPlaceHolder(LanguageConfig.language_Union_36)
end
--@auto code view display func end

function UnionViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end

--查询公会列表接口
function UnionViewController:sendUnionList()
    Functions.printInfo(self.debug_b," UnionViewController view enter sendUnionList!")
	
    local onUnionList = function(event)
        if event.reqtype == 1 then
    	     if event.ret == 1 then
    	     
                self._Panel_add_union_t:setVisible(true)
                self._Panel_C_box_t:setVisible(true)
                self._Panel_creat_union_t:setVisible(false)
                self._Panel_find_union_t:setVisible(false)
                self._Panel_union_main_t:setVisible(false)
                
                local data = event.data
                for k, v in pairs(data) do
                    local unionList = Factory:createUnionListData()
                    unionList.eventAttr.m_id = v.id
                    unionList.eventAttr.m_member_count = v.member_count
                    unionList.eventAttr.m_join_level = v.join_level
                    unionList.eventAttr.m_pic = v.pic
                    unionList.eventAttr.m_activity = v.activity
                    unionList.eventAttr.m_join_type = v.join_type
                    unionList.eventAttr.s_name = v.name
                    unionList.eventAttr.s_notice = v.notice
                    UnionData:addUnionListData(unionList)
                end
                
                local listHandler = function(index, widget, data, model)
                    local ban = widget:getChildByName("Image_add_list")
                    local banModel = model:getChildByName("Image_add_list")
                    local button = ban:getChildByName("Button_add_list_but")
                    Functions.initTextColor(banModel:getChildByName("Text_add_list_name"),ban:getChildByName("Text_add_list_name"))
                    Functions.initTextColor(banModel:getChildByName("Text_palyer_num"),ban:getChildByName("Text_palyer_num"))
                    Functions.initTextColor(banModel:getChildByName("Text_add_list_level_num"),ban:getChildByName("Text_add_list_level_num"))
                    
                    local onClick = function(event)
                        print("button click")
                        --点击加入公会
                        self:sendAddUnion(data.eventAttr.m_id)
                    end
                    button:onTouch(Functions.createClickListener(onClick, "zoom"))
                    
                    --绘制公会图标
                    Functions.loadImageWithWidget(ban:getChildByName("Image_add_list_head_bg"):getChildByName("Image_add_list_head"), Functions:getGongHuiImageOfId(data.eventAttr.m_pic)) 
                    --Functions.loadImageWithWidget(ban:getChildByName("Image_add_list_head_bg"):getChildByName("Image_add_list_head"), ConfigHandler:getHeroHeadImageOfId(data.eventAttr.m_pic)) 
                    
                    Functions.initLabelOfString( ban:getChildByName("Text_add_list_name"), data.eventAttr.s_name, ban:getChildByName("Text_add_list_level_num"), 
                        data.eventAttr.m_join_level, ban:getChildByName("Text_notice"), data.eventAttr.s_notice, ban:getChildByName("Text_palyer_num"), (tostring(data.eventAttr.m_member_count).."/50"))
                    
                end
                --绑定响应事件函数
                Functions.bindListWithData(self._ListView_add_t, UnionData:getUnionListData(), listHandler)
            else
                --弹出报错信息
                PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
                --PromptManager:openTipPrompt(g_csErrorString[event.ret])
            end
            return true
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, onUnionList)
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 1 })
end

--加入公会接口
function UnionViewController:sendAddUnion(m_id)
    Functions.printInfo(self.debug_b," UnionViewController view enter sendAddUnion!")
    local onAddUnion = function(event)
        if event.reqtype == 4 then
            if event.ret == 1 then
                --查询公会信息接口
                self:sendUnionInfo()
            else
                --弹出报错信息
                PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
                --PromptManager:openTipPrompt(g_csErrorString[event.ret])
            end
            return true
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, onAddUnion)
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 4, data = { id = m_id }})
    
end

function UnionViewController:onChangeView()
end

--查询公会信息
function UnionViewController:sendUnionInfo()
    Functions.printInfo(self.debug," UnionViewController view enter sendUnionInfo!")
    
    local onUnionInfo = function(event)
        if  event.reqtype == 3 then
            if event.ret == 1 then
                self:sendMembersInfo()
                UnionData:clearUnionInfo()
                local data = event.data
                local unionInfo = Factory:createUnionInfoData()
                unionInfo.eventAttr.m_id = data.id
                unionInfo.eventAttr.m_member_count = data.member_count
                unionInfo.eventAttr.m_join_level = data.join_level
                unionInfo.eventAttr.m_pic = data.pic
                unionInfo.eventAttr.m_join_type = data.join_type
                unionInfo.eventAttr.s_name = data.name
                unionInfo.eventAttr.s_notice = data.notice
                UnionData:addUnionInfoData(unionInfo)
                
                --公会活跃
                UnionData.eventAttr.m_activity = data.activity
                	
                --公会id赋值
                PlayerData.eventAttr.m_tongID = data.id
                
                self._Text_main_union_name_t:setText(data.name)
                self._Text_id_num_t:setText(tostring(PlayerData.eventAttr.m_tongID))
                self._Text_ren_shu_t:setText(tostring(data.member_count) .. "/50")
                local iiiii = g_headicon[unionInfo.eventAttr.m_pic]
                --绘制公会图标
                Functions.loadImageWithWidget(self._Image_nuion_main_icon_t, Functions:getGongHuiImageOfId(unionInfo.eventAttr.m_pic))
                --Functions.loadImageWithWidget(self._Image_nuion_main_icon_t, ConfigHandler:getHeroHeadImageOfId(unionInfo.eventAttr.m_pic)) 
                --公告
                Functions.initLabelOfString(self._Text_xuan_yan_2_t, unionInfo.eventAttr.s_notice)
                --等待界面初使化
                self:showView()
            else
                --弹出报错信息
                PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
                --PromptManager:openTipPrompt(g_csErrorString[event.ret])
            end
            return true
        end
        
    end
    NetWork:addNetWorkListener({ 7, 1 }, onUnionInfo)
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 3})
end

--查询成员信息
function UnionViewController:sendMembersInfo()
    Functions.printInfo(self.debug," UnionViewController view enter sendUnionInfo!")
    
    local onMemberInfo = function(event)
        if  event.reqtype == 19 then
            if event.ret == 1 then
                UnionData:clearUnionMemberInfo()
                local data = event.data
                for k, v in pairs(data) do
                    local memberInfo = require("app.ui.unionSystem.MemberModel").new()
                    
                    memberInfo.m_id = v.id                                  --成员id
                    memberInfo.eventAttr.m_worship_times = v.worship_times  --膜拜次数                      
                    memberInfo.m_copytimes = v.copytimes                    --副本次数
                    memberInfo.m_vip_level = v.vip_level                    --vip等级
                    memberInfo.m_activity = v.activity                      --活跃
                    memberInfo.m_pic = v.pic                                --人物头像
                    memberInfo.eventAttr.m_member_type= v.member_type       --成员职位（1会员、2长老、3会长）
                    memberInfo.m_status = v.status                          --(1在线，2下线)
                    memberInfo.m_level = v.level                            --人物等级
                    memberInfo.m_logout_time = v.logout_time                --最后上线时间
                    memberInfo.m_name = v.name                              --名字
                    UnionData:addUnionMemberInfoData(memberInfo)
                end
                --公会成员信息ui
                self:showMemberInfo()
                
                --进入公会界面
                self._Panel_add_union_t:setVisible(false)
                self._Panel_creat_union_t:setVisible(false)
                self._Panel_find_union_t:setVisible(false)
                self._Panel_C_box_t:setVisible(false)
                self._Panel_union_main_t:setVisible(true)

            else
                --弹出报错信息
                PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
                --PromptManager:openTipPrompt(g_csErrorString[event.ret])
            end
                return true
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, onMemberInfo)
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 19 })
end

--加入公会ui改变
function UnionViewController:showMainUnion()
    Functions.printInfo(self.debug_b,"showMainUnion")
    local MemberInfo = UnionData:getMemberInfoData()
    local zhiWei = 0
    for k, v in pairs(MemberInfo) do
        if PlayerData.eventAttr.m_uid == v.m_id then
            zhiWei = v.eventAttr.m_member_type
        end
    end
    --根据职位来显示是否可以管理成员
    if zhiWei == 1 then
    	self._Button_manage_t:setVisible(false)
    end
end

--加入公会ui改变
function UnionViewController:showMemberInfo()
    Functions.printInfo(self.debug_b,"showMemberInfo")
    
    local listHandler = function(index, widget, data, model)
        local ban = widget:getChildByName("Button_cheng_yuan_list")
        local banModel = model:getChildByName("Button_cheng_yuan_list")
        Functions.initTextColor(banModel:getChildByName("Text_name_level"),ban:getChildByName("Text_name_level"))
        Functions.initTextColor(banModel:getChildByName("Text_Position"),ban:getChildByName("Text_Position"))

        if data.m_level > PlayerData.eventAttr.m_level then
            ban:getChildByName("Button_mo_bai"):setVisible(true)
        else
            ban:getChildByName("Button_mo_bai"):setVisible(false)
        end

        local onMoBai = function(event)
            print("button click")
            --点击显示膜拜
            self:openChildView("app.ui.popViews.UnionMoBaiPopView", { data = data })
        end
        ban:getChildByName("Button_mo_bai"):onTouch(Functions.createClickListener(onMoBai, "zoom"))
        --打开人物信息
        local onClick = function(event)
            print("button click")
            --点击显示人物信息
            self:openChildView("app.ui.popViews.Union_CY_Info_PopView", { data = data })
        end
        ban:onTouch(Functions.createClickListener(onClick, "zoom"))

        Functions.loadImageWithWidget(ban:getChildByName("Image_head_bg_list"):getChildByName("Image_list_head"), Functions.getDisHeadFImagePathOfId(data.m_pic))

        local name = data.m_name.."  "..tostring(data.m_level)..LanguageConfig.language_Union_4
        local str = ""
        if data.eventAttr.m_member_type == 2 then
            str = LanguageConfig.language_Union_5
        elseif data.eventAttr.m_member_type == 3 then
            str = LanguageConfig.language_Union_6
        else
            str = LanguageConfig.language_Union_7
        end
        --加入公会ui改变
        self:showMainUnion()

        Functions.initLabelOfString(ban:getChildByName("Text_name_level"), name, ban:getChildByName("Text_Position"), str)

        Functions.bindUiWithModelAttr(ban:getChildByName("Text_Position"), data, "m_member_type", function(event)
            --加入公会ui改变
            self:showMainUnion()
            if event.data == 3 then
                str = LanguageConfig.language_Union_5
            elseif event.data == 2 then
                str = LanguageConfig.language_Union_6
            else
                str = LanguageConfig.language_Union_7
            end
            ban:getChildByName("Text_Position"):setText(str)
        end)

    end
    --绑定响应事件函数
    local  listDatas = UnionData:getMemberInfoData()
    Functions.bindListWithData(self._ListView_cheng_yuan_t, listDatas, listHandler)

end

--加入公会ui改变
function UnionViewController:Prompt()
    Functions.printInfo(self.debug_b,"Prompt")
    local onUnionOut = function(event)
        if event.reqtype == 23 then
            if event.ret == 1 then
                --公会ID置为0
                PlayerData.eventAttr.m_tongID = 0
                GameCtlManager:pop(self)

            else
                --弹出报错信息
                PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(event.ret))
                --PromptManager:openTipPrompt(g_csErrorString[event.ret])
            end
            return true
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, onUnionOut)
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 23 })
end


return UnionViewController