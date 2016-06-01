cc.FileUtils:getInstance():setPopupNotify(false)

require("app.common.GameStaticInit")
--加载资源管理器
ResManager = require("app.common.ResManager")
PRELOAD_INIT_MODEL["app.common.ResManager"] = ResManager

math.newrandomseed()

local main = function()
	--初始场景
    local rootScene_t = cc.Scene:create()
    cc.Director:getInstance():replaceScene(rootScene_t)
	
    if not G_IsHaveLanchImage then
        local bg = Functions.createSpriteOfSfName("commonUI/res/bg/CB_loginBg.png")
        bg:addTo(rootScene_t)
        bg:setPosition(cc.p(display.cx, display.cy))

        lanchLoadRes()
    else
        local bg = Functions.createSpriteOfSfName("commonUI/res/bg/custom_bg.png")
        bg:addTo(rootScene_t)
        bg:setPosition(cc.p(display.cx, display.cy))
        bg:setOpacity(0)

        local fade     = cc.FadeIn:create(0.5)
        local sequence = cc.Sequence:create(fade, cc.DelayTime:create(0.2), cc.CallFunc:create(function()
            lanchLoadRes()
        end))
        bg:runAction(sequence)
    end
end

function lanchLoadRes()
    --场景切换
    ResManager:loadCommonRes(function()

            --初始化通用ui min组件
            CommonWidgets = require("app.ui.common.CommonWidgets")
            CommonWidgets:init()
            PRELOAD_INIT_MODEL["app.ui.common.CommonWidgets"] = CommonWidgets
            GameCtlManager:goTo("app.ui.loadingSystem.LoadingViewController")
           -- GameCtlManager:goTo("app.ui.eulaSceneSystem.EulaSceneViewController")
        end)
end

Functions.debugCall(main)
