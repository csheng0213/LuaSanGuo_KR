local DeepLinkIntent = {--出征
    ["fighting"] = function ()
    	EmbattleData:getEmbattleInfos(EmbattleData.EmbattleTypeEnum.attack, function(data)
            if data.MainHero[1].id == 0 then
               PromptManager:openTipPrompt("无主将,不出征,请前往布阵!")
            else
                GameCtlManager:push("app.ui.fbSelectSystem.FbSelectViewController")
            end
        end)  
    end,
    ["ladder"] = function()
        GameCtlManager:push("app.ui.sevenStarSystem.SevenStarViewController")
    end,
    ["seven_star"] = function()
    	GameCtlManager:push("app.ui.sevenStarSystem.SevenStarViewController")
    end,
    ["hero_train"] = function()
        GameCtlManager:push("app.ui.shiLianSystem.ShiLianViewController")
    end,
    ["blood_fight"] = function()
        GameCtlManager:push("app.ui.xueZhanSystem.XueZhanViewController")
    end,
    ["recruit"] = function()
        GameCtlManager:push("app.ui.enlistSystem.EnlistViewController")
    end,
    ["main_city"] = function(controller)

    end,
    ["email"] = function()
        -- local emailView = require("app.ui.popViews.MailOnePopView"):new()--cs
        GameCtlManager.currentController_t:openChildView("app.ui.popViews.MailOnePopView",{isRemove = false})
    end,
    ["society"] = function()
        GameCtlManager:push("app.ui.unionSystem.UnionViewController")
    end,
    ["hero"] = function()
        GameCtlManager:push("app.ui.heroSystem.HeroViewController")
    end,
    ["upgrade"] = function()
        GameCtlManager:push("app.ui.enhanceSystem.EnhanceViewController")
    end,
    ["hero_upgrade"] = function()

    end,
    ["hero_advance"] = function()

    end,
    ["soldier_intensify"] = function()

    end,
    ["embattle"] = function()
        GameCtlManager:push("app.ui.embattleSystem.EmbattleViewController",{data = {jumpType = 5,jumpData = {embattleType = 1}}})
    end,
    ["equipment"] = function()
        GameCtlManager:push("app.ui.equipmentSystem.EquipmentViewController")
    end,
    ["package"] = function()
        GameCtlManager:push("app.ui.propSystem.PropViewController")
    end,
    ["combining"] = function()
        GameCtlManager:push("app.ui.compoundSystem.CompoundViewController")
    end,
    ["task"] = function()
        GameCtlManager:push("app.ui.taskSystem.TaskViewController")
    end,
    ["store"] = function()
        GameCtlManager:push("app.ui.shopSystem.ShopViewController")
    end,
    ["achievement"] = function()
        GameCtlManager:push("app.ui.chengJiuSystem.ChengJiuViewController")
    end,
    ["profile"] = function()

    end,
    ["buy_coin"] = function()

    end,
    ["buy_gold"] = function()
        -- local payView = require("app.ui.popViews.PayPopView"):new()--cs
        GameCtlManager.currentController_t:openChildView("app.ui.popViews.PayPopView",{isRemove = false})
    end,
    ["buy_power"] = function()

    end,
    ["reward"] = function()
        -- local loginRewardView = require("app.ui.popViews.LoginRewardPopView"):new()--cs
        GameCtlManager.currentController_t:openChildView("app.ui.popViews.LoginRewardPopView")
    end,
    ["sign_in"] = function()
        -- local signRewardView = require("app.ui.popViews.SignRewardPopView"):new()--cs
        GameCtlManager.currentController_t:openChildView("app.ui.popViews.SignRewardPopView")
    end,
    ["vip"] = function()
        -- local vipView = require("app.ui.popViews.VipPopView"):new()--cs
        GameCtlManager.currentController_t:openChildView("app.ui.popViews.VipPopView",{isRemove = false})
    end,
    ["gift"] = function()
        -- local onlineRewardView = require("app.ui.popViews.OnlineRewardPopView"):new()--cs
        GameCtlManager.currentController_t:openChildView("app.ui.popViews.OnlineRewardPopView",{isRemove = false})
    end,
    ["firstpay_gift"] = function()
        -- local firstPayRewardView = require("app.ui.popViews.FirstPayRewardPopView"):new()--cs
        GameCtlManager.currentController_t:openChildView("app.ui.popViews.FirstPayRewardPopView",{isRemove = false})
    end,
    ["limit_hero"] = function()
        -- local activityHeroView = require("app.ui.popViews.ActivityHeroPopView"):new()--cs
        GameCtlManager.currentController_t:openChildView("app.ui.popViews.ActivityHeroPopView",{isRemove = false})
    end,
    ["welfare"] = function()
        -- local huoDongView = require("app.ui.popViews.HuoDongPopView"):new()--cs
        GameCtlManager.currentController_t:openChildView("app.ui.popViews.HuoDongPopView",{isRemove = false})
    end,
    ["reward"] = function()

    end,
    ["day_pay"] = function()

    end,
    ["accumulate_pay"] = function()

    end,
    ["pay_activity"] = function()

    end,
    ["ladder_fighting"] = function()

    end,
    ["grow_plan"] = function()

    end,
    ["appclosing"] = function()
        Functions.callJavaFuc(function( )
            NativeUtil:javaCallHanler({command = "exitApp"})
        end)
    end,
    
}

return DeepLinkIntent