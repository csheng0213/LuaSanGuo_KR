local BaseCreatureView = require("app.ui.combatSystem.view.BaseCreatureView")

local LordCreatureView = class("LordCreatureView", BaseCreatureView)

local ResManager = require("app.common.ResManager")

function LordCreatureView:initDisplayNode()

    --初始化显示节点
    self.displayNode_ = cc.CSLoader:createNode("cs/csb/common/pawn.csb")
    self:addChild(self.displayNode_)
        
end



return LordCreatureView