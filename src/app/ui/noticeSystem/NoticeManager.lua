local NoticeManager = {}

NoticeManager.serverUrl = ServerConfig.currentURL .. "sanguoGMSomeFunc/getgonggao?id="

NoticeManager.SYSTEM_INFO = 1
NoticeManager.SHILIAN_INFO = 2
NoticeManager.XUEZHAN_INFO = 3 
NoticeManager.SEVENSTAR_INFO = 4
NoticeManager.TIANTI_INFO = 5
NoticeManager.EMBATTLE_INFO = 6
NoticeManager.XSSJ_INF0 = 7
NoticeManager.TEAM_FB_INFO = 8
NoticeManager.TEAM_CITY_INFO = 9
NoticeManager.SHOP_REFRESH = 10
NoticeManager.EQUIPMENT = 11
NoticeManager.TASK_INFO = 12
NoticeManager.SELL_CARD_INFO = 13
NoticeManager.VIP_INFO = 14
NoticeManager.EQUIP_ENHANCE = 15
NoticeManager.GUID_BATTLE = 16
NoticeManager.EXP_INFO = 17

NoticeManager.debug = true

NoticeManager.MAINCITY_BUY_POWER_TIPS = 1
NoticeManager.MAINCITY_BUY_MONEY_TIPS = 2
NoticeManager.TIANTI_BUY_COUNT_TIPS = 3
NoticeManager.SEVENSTAR_TIPS = 4
NoticeManager.MAINCITY_GOLD_NOT_ENOUGH_TIPS = 5
NoticeManager.EQUIP_SELL_TIPS = 6
NoticeManager.EQUIP_APPAREL_TIPS = 7

NoticeManager.REWARD_COIN_TIPS = 1
NoticeManager.REWARD_PROP_TIPS = 2
NoticeManager.REWARD_EQUIP_TIPS = 3
NoticeManager.REWARD_CARD_FRAGMENT_TIPS = 4
NoticeManager.REWARD_COMBAT_TIPS = 5
NoticeManager.REWARD_EQUIPQIANGHUA_TIPS = 6
NoticeManager.REWARD_EQUIPHECHENG_TIPS = 7
NoticeManager.REWARD_HERO_CARD_TIPS = 8

NoticeManager.EDIT_NAME_TIPS = 1
NoticeManager.EDIT_BROADCAST_TIPS = 2

--弹出错误提示
function NoticeManager:openErrorNotive(controller, data)
    if not self.errNotice then
        self.errNotice = Factory:createInfoPanel()
        self.errNotice:setInfo(data)
        controller:openChildView(self.errNotice, { isRemove = false })
    else
        self.errNotice:setInfo(data)
    end

    Functions.addCleanFuncWithNode(self.errNotice, function()
            self.errNotice = nil
        end)
end

--获取错误提示显示面板
function NoticeManager:getErrorNotive(data)
    self.errNotice = Factory:createInfoPanel()
    self.errNotice:setInfo(data)
    return self.errNotice
end

--获取提示，并显示
--@param: controller : 当前控制器
--@param: param : { type = , title = } type:为提示类型，title:提示标题
function NoticeManager:openNotice(controller, param)
    assert(param and param.type, "param is error")

    PromptManager:openHttpLinkPrompt()
    HttpClient:sendHttpRequest(NoticeManager.serverUrl .. tostring(param.type), "", function(state, data)
        if state == 0 then
            PromptManager:closeHttpLinkPrompt()
            local notice = Factory:createInfoPanel()
            notice:setInfo(data)
            controller:openChildView(notice)
        else
            PromptManager:closeHttpLinkPrompt()
        end
    end)
    -- NetWork:sendHttpRequst(NoticeManager.serverUrl .. tostring(param.type), "GET", function(data)
 --       print(data)
 --       local notice = Factory:createInfoPanel()
 --       notice:setInfo(data)
 --       notice:setTitle(param.title)
 --       controller:openChildView(notice)
 --    end)

end
--获取提示，并显示
--@param: controller : 当前控制器
--@param: param : { type =  ,handler= ,title = , cancelBtText=, affirmBtText=,isShowNpc =,} type:为提示类型
function NoticeManager:openTips(controller, param)
    assert(param, "param is error")
    local tips = require("app.ui.popViews.TipsPopView").new()

    local str = ""
    if param.type == NoticeManager.TIANTI_BUY_COUNT_TIPS then
        str = string.format(LanguageConfig.language_6_3,TianTiData.myPlayerData.price)        
    elseif param.type == NoticeManager.SEVENSTAR_TIPS then
        str = LanguageConfig.language_9_66
    elseif param.title ~= nil then
        str = param.title
    end
    tips:setTipsInf(str)
    tips:setHandler(param.handler)
    if param.type == NoticeManager.REWARD_COMBAT_TIPS then 
        tips:changeStyle()
    end
    if nil ~= param.cancelBtText then
        tips:cancelBtText(param.cancelBtText)
    end
    if nil ~= param.affirmBtText then
        tips:affirmBtText(param.affirmBtText)
    end
    if nil ~= param.isShowNpc then
        tips:isShowNpc(param.isShowNpc)
    end
    if param.handler1 ~= nil then
        tips:setHandler1(param.handler1)
    end 

    if param.title == LanguageConfig.language_0_45 then
        tips:LoadSelfView()
        GameCtlManager:addCurTopLayer(tips)
    else
        controller:openChildView(tips,{isRemove = false})
    end
end

function NoticeManager:openExitTips(param)
    local tips = require("app.ui.popViews.ExitPopView").new()
    assert(param, "param is error")
    local str = ""
    if param.title ~= nil then
        str = param.title
    end
    tips:setTipsInf(str)
    if param.handler ~= nil then
        tips:setHandler(param.handler)
    end 
    if param.handler1 ~= nil then
        tips:setHandler1(param.handler1)
    end 
    if nil ~= param.isShowNpc then
        tips:isShowNpc(param.isShowNpc)
    end

    GameCtlManager:addCurTopLayer(tips) 
   
end
--显示出售道具界面
function NoticeManager:openSellPropView(controller,param)
    local tips = require("app.ui.popViews.SellPropPopView").new()
    assert(param, "param is error")   
    tips:setPorp(param.propId)
    tips:setHandler(param.handler)
    controller:openChildView(tips,{isRemove = false})
end
--显示充值奖励礼包
function NoticeManager:openPayRewardTips(controller,param)
    local tips = require("app.ui.popViews.PayRewardPopView").new()
    assert(param, "param is error") 
    tips:setRewards(param.rewardData)
    tips:setInf(param.inf)
    controller:openChildView(tips,{isRemove = false})
end
--获取提示，并显示
--@param: controller : 当前控制器
--@param: param : { type =  ,data= } type:为提示类型
function NoticeManager:openRewardTips(controller, param)
  assert(param and param.type, "param is error")
    local tips = require("app.ui.popViews.RewardTipsPopView").new()
    if param.type == NoticeManager.REWARD_COIN_TIPS then
        tips:setShowType(NoticeManager.REWARD_COIN_TIPS)
        if param ~= nil then
            tips:setInf(tostring(param.data.money))
            tips:setIsBurst(param.data.burst)
        end
    elseif param.type == NoticeManager.REWARD_PROP_TIPS then
        tips:setShowType(NoticeManager.REWARD_PROP_TIPS)
        -- tips:setRewardImg(param.data.img)
        -- tips:setRewardLabel(param.data.num)
        tips:setHandler(param.handler)
        if param.againHandler ~= nil then 
            tips:setAgainHandler(param.againHandler)
            tips:setPropData(param.propData)
        end
        tips:createPrizeNode( param.data )
    elseif param.type == NoticeManager.REWARD_EQUIP_TIPS then
        tips:setShowType(NoticeManager.REWARD_EQUIP_TIPS)
        tips:setEquipNode(param.data.equipMark)
        if param.data.againHandler ~= nil then 
            tips:setAgainHandler(param.data.againHandler)
            tips:setPropData(param.data.propData)
        end
    elseif param.type == NoticeManager.REWARD_EQUIPQIANGHUA_TIPS then
        tips:setShowType(NoticeManager.REWARD_EQUIPQIANGHUA_TIPS)
        tips:setEquipNode(param.data.equipMark)
        tips:setHandler(param.data.handler)
    elseif param.type == NoticeManager.REWARD_EQUIPHECHENG_TIPS then
        tips:setShowType(NoticeManager.REWARD_EQUIPHECHENG_TIPS)
        tips:setEquipNode(param.data.equipMark)
        tips:setHandler(param.data.handler)        
    elseif param.type == NoticeManager.REWARD_CARD_FRAGMENT_TIPS then
        tips:setShowType(NoticeManager.REWARD_CARD_FRAGMENT_TIPS)
        tips:createPrizeNode( param.data )
        if param.againHandler ~= nil then 
            tips:setAgainHandler(param.againHandler)
            tips:setPropData(param.propData)
        end
    elseif param.type == NoticeManager.REWARD_HERO_CARD_TIPS then 
        tips:setShowType(NoticeManager.REWARD_HERO_CARD_TIPS)
        tips:createPrizeNode(param.data)
    end
    controller:openChildView(tips,{isRemove = false})
end
--获取血战提示，并显示
--@param: controller : 当前控制器
--@param: param : { type =  ,data= } type:为提示类型:1简单，2困难，3炼狱
function NoticeManager:openXueZhanTips(controller, param)
  assert(param and param.type, "param is error")
    local tips = require("app.ui.popViews.XueZhanTipsPopView").new()
    if param.type ~= nil then
         tips:setXueZhanType(param.type)
    end
    if param.data.currentLevel ~= nil then 
        tips:setXueZhanLevel(param.data.currentLevel)
    end
    controller:openChildView(tips,{isRemove = false})
end
--获取编辑框提示，并显示
--@param: controller : 当前控制器
--@param: param : { type =  ,data= } type:为提示类型
function NoticeManager:openEditTips(controller, param)
  assert(param and param.type, "param is error")
    local tips = require("app.ui.popViews.EditTipsPopView").new()
    if param.type == NoticeManager.EDIT_NAME_TIPS then
        -- tips:setPlaceHolder()
        tips:setHandler(param.handler)
    elseif param.type == NoticeManager.EDIT_BROADCAST_TIPS then
        -- tips:setPlaceHolder("点击输入文字")
        tips:setHandler(param.handler)
    end
    controller:openChildView(tips,{isRemove = false})
end
return NoticeManager