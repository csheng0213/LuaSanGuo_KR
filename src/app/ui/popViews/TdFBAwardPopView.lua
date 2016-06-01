--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local TdFBAwardPopView = class("TdFBAwardPopView", BasePopView)

local Functions = require("app.common.Functions")

TdFBAwardPopView.csbResPath = "cs/csb"
TdFBAwardPopView.debug = true
TdFBAwardPopView.studioSpriteFrames = {"CB_unionTankuang","TdFBAwardPopUI","CBO_guildPrizeTiao","FbSelectUI" }
--@auto code head end

TdFBAwardPopView.REQUIRE_DIS_DATA = 1
TdFBAwardPopView.REQUIRE_APPLY_DATA = 2


TdFBAwardPopView.spriteFrameNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #TdFBAwardPopView.studioSpriteFrames > 0 then
    TdFBAwardPopView.spriteFrameNames = TdFBAwardPopView.spriteFrameNames or {}
    table.insertto(TdFBAwardPopView.spriteFrameNames, TdFBAwardPopView.studioSpriteFrames)
end
function TdFBAwardPopView:onInitUI()

    --output list
    self._awardList_t = self.csbNode:getChildByName("awardList")
	self._sure_panel_t = self.csbNode:getChildByName("sure_panel")
	self._text1_str_t = self.csbNode:getChildByName("sure_panel"):getChildByName("text1_str")
	self._text2_str_t = self.csbNode:getChildByName("sure_panel"):getChildByName("text2_str")
	self._text3_str_t = self.csbNode:getChildByName("sure_panel"):getChildByName("text3_str")
	
    --label list
    
    --button list
    self._cancelBt_t = self.csbNode:getChildByName("sure_panel"):getChildByName("cancelBt")
	self._cancelBt_t:onTouch(Functions.createClickListener(handler(self, self.onCancelbtClick), ""))

	self._sureBt_t = self.csbNode:getChildByName("sure_panel"):getChildByName("sureBt")
	self._sureBt_t:onTouch(Functions.createClickListener(handler(self, self.onSurebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Cancelbt btFunc
function TdFBAwardPopView:onCancelbtClick()
    Functions.printInfo(self.debug,"Cancelbt button is click!")
    self._sure_panel_t:setVisible(false)
end
--@auto code Cancelbt btFunc end

--@auto code Surebt btFunc
function TdFBAwardPopView:onSurebtClick()
    Functions.printInfo(self.debug,"Surebt button is click!")
    self._sure_panel_t:setVisible(false)
    self.sendApply()
end
--@auto code Surebt btFunc end

--@auto button backcall end


--@auto code output func
function TdFBAwardPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function TdFBAwardPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")
	
    self._awardList_t:setVisible(false)
    self.lidx = data.lidx
    Functions.bindNetWorkListener(self, { 7, 4 }, Functions.createNetworkListener(handler(self, self.refreshAwardList), false, "ret"))
    local msg = {idx = { 7, 4 }, type = TdFBAwardPopView.REQUIRE_DIS_DATA, data = { lidx = data.lidx }}
    NetWork:sendToServer(msg)
end

function TdFBAwardPopView:refreshAwardList(event)

    if event.data.lidx ~= self.lidx then  --判断当前收到的fb奖励数据，是否是当前管卡的数据，如果不是，则不刷新界面
        return 
    end

    local tdAwardItems = {}
    for k, v in ipairs(event.data.list) do 
        tdAwardItems[#tdAwardItems+1] = Factory:createTdFbAwardItem(v)
        if k == event.data.reqinfo.idx then
            tdAwardItems[#tdAwardItems].eventAttr.isApply = true 
        end
    end

    local awardList = tdAwardItems
    local curData = event.data.reqinfo
    
    self.sendApply = nil

    local listHandler = function(index, listChild, data, model)

        self._awardList_t:setVisible(true)
        --替换奖品头像
        local awardNodeTemp = listChild:getChildByName("awardNode")
        local awardNode     = Functions.createPartNode({ nodeType = data.itype, nodeId = data.id})
        Functions.copyParam(awardNodeTemp, awardNode)  
        listChild:addChild(awardNode)

        --申请详情按钮点击函数
        local onApplyListBtClick = function()
            self._controller_t:openChildView("app.ui.popViews.ChaDuiPopView", { data = { lidx = BiographyData.eventAttr.curSelectFbId - 6,
             idx = index , isApply = data.eventAttr.isApply, awardType = data.itype, awardId = data.id } })
        end
        
        local applyListBt = listChild:getChildByName("applyListBt")
        if data.eventAttr.requestCount > 0 then
            applyListBt:setVisible(true)
        else
            applyListBt:setVisible(false)
        end
        
        applyListBt:onTouch(Functions.createClickListener(onApplyListBtClick, "zoom"))  --绑定申请详情点击函数

        local rule = listChild:getChildByName("rule_text")  --更新显示奖励申请信息
        if data.eventAttr.requestCount > 0 or data.count > 0 then
            rule:setString(string.format(LanguageConfig["language_0_27"], data.eventAttr.requestCount, data.count))
            Functions.initTextColor(model:getChildByName("rule_text"), rule)
        else
            rule:setVisible(false)
        end

        local name = listChild:getChildByName("name_text")
        Functions.initLabelOfString(name, data.name)
        Functions.initTextColor(model:getChildByName("name_text"), name)
        
        --奖励品申请按钮绑定
        local onApplyClick = function()
            if curData.idx ~= 0 then
                self._sure_panel_t:setVisible(true)
                Functions.initLabelOfString(
                    self._text1_str_t, string.format(LanguageConfig["language_0_28"], awardList[curData.idx].name, curData.order),
                    self._text2_str_t, string.format(LanguageConfig["language_0_29"], awardList[curData.idx].name),
                    self._text3_str_t, string.format(LanguageConfig["language_0_30"], awardList[index].name)
                    )
                
                self.sendApply = function()
                    local msg = {idx = { 7, 4 }, type = TdFBAwardPopView.REQUIRE_APPLY_DATA, data = { lidx = self.lidx, idx = index } }
                    NetWork:sendToServer(msg)
                end
            else
                local msg = {idx = { 7, 4 }, type = TdFBAwardPopView.REQUIRE_APPLY_DATA, data = { lidx = self.lidx, idx = index } }
                NetWork:sendToServer(msg)
            end
        end

        local applyBt = listChild:getChildByName("applyBt")
        if data.eventAttr.isApply then
            self:setApplyBtDis(applyBt, true)
            applyBt:onTouch(function()
            end)
        else
            self:setApplyBtDis(applyBt, false)
             applyBt:onTouch(Functions.createClickListener(function()
                    onApplyClick()
                end, "zoom"))
        end

    end
    
    Functions.bindListWithData(self._awardList_t, awardList, listHandler)
end

function TdFBAwardPopView:setApplyBtDis(applyBt, isDis)
	applyBt:getChildByName("1"):setVisible(isDis)
	applyBt:getChildByName("2"):setVisible(not isDis)
end

function TdFBAwardPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return TdFBAwardPopView