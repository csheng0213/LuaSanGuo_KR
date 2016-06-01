--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionFBPopView = class("UnionFBPopView", BasePopView)

local Functions = require("app.common.Functions")

UnionFBPopView.csbResPath = "lk/csb"
UnionFBPopView.debug = true
UnionFBPopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","UnionUI" }
--@auto code head end
local UnionData = require("app.gameData.UnionData")
--@Pre loading
UnionFBPopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionFBPopView.animaNames = 
    {
    }
--@auto code uiInit
--add spriteFrames
if #UnionFBPopView.studioSpriteFrames > 0 then
    UnionFBPopView.spriteFrameNames = UnionFBPopView.spriteFrameNames or {}
    table.insertto(UnionFBPopView.spriteFrameNames, UnionFBPopView.studioSpriteFrames)
end
function UnionFBPopView:onInitUI()

    --output list
    self._ListView_fb_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("ListView_fb")
	self._Image_2_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("ListView_fb"):getChildByName("model"):getChildByName("Panel_list_fb"):getChildByName("Button_list_fb_but"):getChildByName("Image_2")
	self._Image_3_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("ListView_fb"):getChildByName("model"):getChildByName("Panel_list_fb"):getChildByName("Button_list_fb_but"):getChildByName("Image_3")
	
    --label list
    
    --button list
    self._Button_Rule_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Button_Rule")
	self._Button_Rule_t:onTouch(Functions.createClickListener(handler(self, self.onButton_ruleClick), "zoom"))

	self._Button_fb_close_t = self.csbNode:getChildByName("Panel_fb_2"):getChildByName("Button_fb_close")
	self._Button_fb_close_t:onTouch(Functions.createClickListener(handler(self, self.onButton_fb_closeClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_rule btFunc
function UnionFBPopView:onButton_ruleClick()
    Functions.printInfo(self.debug,"Button_rule button is click!")
    NoticeManager:openNotice(self._controller_t, {type = NoticeManager.TEAM_FB_INFO})
end
--@auto code Button_rule btFunc end

--@auto code Button_list_fb_but btFunc
function UnionFBPopView:onButton_list_fb_butClick()
    Functions.printInfo(self.debug,"Button_list_fb_but button is click!")
end
--@auto code Button_list_fb_but btFunc end

--@auto code Button_fb_close btFunc
function UnionFBPopView:onButton_fb_closeClick()
    Functions.printInfo(self.debug,"Button_fb_close button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_fb_close btFunc end

--@auto button backcall end


--@auto code output func
function UnionFBPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionFBPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	
    self:showFB()
    
    --监听FB界面
    local onShowFB = function(event)
        self:showFB()
    end
    Functions.bindEventListener(self._ListView_fb_t, GameEventCenter, UnionData.UNION_FB_EVENT, onShowFB)
end

function UnionFBPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function UnionFBPopView:showFB()
    Functions.printInfo(self.debug,"showFB")
        --获取副本数据
    local dataFB = UnionData:getUnionFBInfo()
    
    local listHandler = function(index, widget, data, model)
        
        local ban = widget:getChildByName("Panel_list_fb")
        local banModel = model:getChildByName("Panel_list_fb")
        local buttonFB = ban:getChildByName("Button_list_fb_but")
        Functions.initTextColor(banModel:getChildByName("Text_fb_name"),ban:getChildByName("Text_fb_name"))
        Functions.initTextColor(banModel:getChildByName("Text_fb_Active_num"),ban:getChildByName("Text_fb_Active_num"))
        local nameFB = string.format(LanguageConfig.language_Union_24, data.m_id).." "..ConfigHandler:getCheckPointNameOfID(data.m_id)
        local BarNum = math.floor(data.progress * 10000)/100
        local jindu = LanguageConfig.language_Union_12..tostring(BarNum).."％"
        Functions.initLabelOfString(ban:getChildByName("Text_fb_name"), nameFB, ban:getChildByName("Text_fb_Active_num"), tostring(cs_UnionLiven()), ban:getChildByName("Text_jin_du_string"), jindu )
        ban:getChildByName("LoadingBar_tiao"):setPercent(BarNum)
        
        if (data.purchased == 1 and data.allpassed == 1) or data.purchased == 0 then
            ban:getChildByName("Button_list_fb_but"):getChildByName("Image_2"):setVisible(true)
            ban:getChildByName("Button_list_fb_but"):getChildByName("Image_3"):setVisible(false)
            --ban:getChildByName("Button_list_fb_but"):getChildByName("_Image_2_t"):setString(LanguageConfig.language_Union_133)
        else
            ban:getChildByName("Button_list_fb_but"):getChildByName("Image_2"):setVisible(false)
            ban:getChildByName("Button_list_fb_but"):getChildByName("Image_3"):setVisible(true)
            --ban:getChildByName("Button_list_fb_but"):getChildByName("test"):setString(LanguageConfig.language_Union_144)
        end
        
        local onClick = function(event)
            print("button click")
            --点击开启副本
            
            if data.purchased > 0 then
                if data.allpassed == 1 then
                    self:sendTeamBoss(data.m_id)
                elseif data.allpassed == 0 then
                    local iiii = data.m_id
                    local ppp = data.m_id
                    local str = BiographyData:checkFbState({fbType = CombatCenter.CombatType.RB_PVE, fbId = data.m_id, gkId = 10})
                    if str then
                        --跳转到团队副本
                        Functions.jumpFbSeleckOfData({fbType = CombatCenter.CombatType.RB_Tandui, fbId = data.m_id})
                    else
                        PromptManager:openTipPrompt(LanguageConfig.language_Union_29)
                    end 
                end
            else
                self:sendTeamBoss(data.m_id)
            end
            
        end
        buttonFB:onTouch(Functions.createClickListener(onClick, "zoom"))
        
    end
    --绑定响应事件函数
    Functions.bindListWithData(self._ListView_fb_t, dataFB, listHandler)
end

function UnionFBPopView:sendTeamBoss(id)
    Functions.printInfo(self.debug,"sendTeamBoss")
    local onFB = function(event)
        if event.reqtype == 27 then

        	UnionData.eventAttr.m_activity = event.data.activity
            local idFB = event.data.lidx
        	local dataFB = UnionData:getUnionFBInfo()
            
        	for k, v in pairs(dataFB) do
                if idFB == v.m_id - 6 then
                    v.purchased = 1
        			break
        		end
        	end
        	self:showFB()
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onFB,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 27, data = {lidx = id - 6} })
end

return UnionFBPopView