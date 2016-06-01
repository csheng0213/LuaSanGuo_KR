--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionGodPopView = class("UnionGodPopView", BasePopView)

local Functions = require("app.common.Functions")

UnionGodPopView.csbResPath = "lk/csb"
UnionGodPopView.debug = true
UnionGodPopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","UnionUI" }
--@auto code head end
--@Pre loading
UnionGodPopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionGodPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #UnionGodPopView.studioSpriteFrames > 0 then
    UnionGodPopView.spriteFrameNames = UnionGodPopView.spriteFrameNames or {}
    table.insertto(UnionGodPopView.spriteFrameNames, UnionGodPopView.studioSpriteFrames)
end
function UnionGodPopView:onInitUI()

    --output list
    self._Text_mo_bai_num_t = self.csbNode:getChildByName("Panel_god_4"):getChildByName("Text_mo_bai_num")
	self._Text_mo_bai_num_money_t = self.csbNode:getChildByName("Panel_god_4"):getChildByName("Text_mo_bai_num_money")
	
    --label list
    self._Text_mo_bai_shuo_ming_t = self.csbNode:getChildByName("Panel_god_4"):getChildByName("Text_mo_bai_shuo_ming")
	self._Text_mo_bai_shuo_ming_t:setString(LanguageConfig.ui_Union_8)
    --button list
    self._Button_mo_bai_receive_t = self.csbNode:getChildByName("Panel_god_4"):getChildByName("Button_mo_bai_receive")
	self._Button_mo_bai_receive_t:onTouch(Functions.createClickListener(handler(self, self.onButton_mo_bai_receiveClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_mo_bai_receive btFunc
function UnionGodPopView:onButton_mo_bai_receiveClick()
    Functions.printInfo(self.debug,"Button_mo_bai_receive button is click!")
    self:sendGetGodMoney()
    
end
--@auto code Button_mo_bai_receive btFunc end

--@auto button backcall end


--@auto code output func
function UnionGodPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionGodPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	--查询膜拜信息
	self:sendGodInfo()
end

function UnionGodPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
--发送膜拜接口
function UnionGodPopView:sendGodInfo()
    Functions.printInfo(self.debug,"sendGodInfo ")
    
    local onGod = function(event)
        if event.reqtype == 26 then 
            self._Text_mo_bai_num_t:setText(event.data.count_rest.."/"..event.data.count_all)
            self._Text_mo_bai_num_money_t:setText(event.data.reward)
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onGod,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 26})
    
end
--领取膜拜奖励
function UnionGodPopView:sendGetGodMoney()
    Functions.printInfo(self.debug,"sendGodInfo ")
    
    local onGodMoney = function(event)
        if event.reqtype == 25 then
            PlayerData.eventAttr.m_money = event.data.money
            self._controller_t:closeChildView(self)
        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onGodMoney,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 25})
    
end

return UnionGodPopView