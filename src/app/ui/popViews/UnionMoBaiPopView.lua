--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionMoBaiPopView = class("UnionMoBaiPopView", BasePopView)

local Functions = require("app.common.Functions")

UnionMoBaiPopView.csbResPath = "lk/csb"
UnionMoBaiPopView.debug = true
UnionMoBaiPopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","UnionUI" }
--@auto code head end
--@Pre loading
UnionMoBaiPopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionMoBaiPopView.animaNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #UnionMoBaiPopView.studioSpriteFrames > 0 then
    UnionMoBaiPopView.spriteFrameNames = UnionMoBaiPopView.spriteFrameNames or {}
    table.insertto(UnionMoBaiPopView.spriteFrameNames, UnionMoBaiPopView.studioSpriteFrames)
end
function UnionMoBaiPopView:onInitUI()

    --output list
    
    --label list
    self._Text_free_text_0_t = self.csbNode:getChildByName("Panel_mo_bai"):getChildByName("Button_free"):getChildByName("Text_free_text_0")
	self._Text_free_text_0_t:setString(LanguageConfig.ui_Union_18)

	self._Text_free_text_0_t = self.csbNode:getChildByName("Panel_mo_bai"):getChildByName("Button_money"):getChildByName("Text_free_text_0")
	self._Text_free_text_0_t:setString(LanguageConfig.ui_Union_19)
    --button list
    self._Button_free_t = self.csbNode:getChildByName("Panel_mo_bai"):getChildByName("Button_free")
	self._Button_free_t:onTouch(Functions.createClickListener(handler(self, self.onButton_freeClick), "zoom"))

	self._Button_money_t = self.csbNode:getChildByName("Panel_mo_bai"):getChildByName("Button_money")
	self._Button_money_t:onTouch(Functions.createClickListener(handler(self, self.onButton_moneyClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_free btFunc
function UnionMoBaiPopView:onButton_freeClick()
    Functions.printInfo(self.debug,"Button_free button is click!")
    --膜拜类型 1 免费
    self:sendMoBai(1)
end
--@auto code Button_free btFunc end

--@auto code Button_money btFunc
function UnionMoBaiPopView:onButton_moneyClick()
    Functions.printInfo(self.debug,"Button_money button is click!")
    --膜拜类型 2 金钱
    self:sendMoBai(2)
end
--@auto code Button_money btFunc end

--@auto button backcall end


--@auto code output func
function UnionMoBaiPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionMoBaiPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	
	--数据初使化
	self.data = data
end

function UnionMoBaiPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

function UnionMoBaiPopView:sendMoBai(type)
    Functions.printInfo(self.debug,"sendMoBai")
    local onAddUnion = function(event)
        if event.reqtype == 24 then

            --弹出报错信息
            PlayerData.eventAttr.m_money = event.data.money
            PlayerData:setPlayerPower(event.data.energy)

            PromptManager:openTipPrompt(LanguageConfig.language_Union_18)

        end
    end
    NetWork:addNetWorkListener({ 7, 1 }, Functions.createNetworkListener(onAddUnion,true,"ret"))
    NetWork:sendToServer({ idx = { 7, 1 }, reqtype = 24, data = { id = self.data.m_id, t = type }})
    
end

return UnionMoBaiPopView