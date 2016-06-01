local Factory = {}

local BaseCreatureView = require("app.ui.combatSystem.view.BaseCreatureView")

local MailDataItem = require("app.gameData.MailDataItem")
local UnionListData = require("app.gameData.UnionDataItem")
local UnionInfoData = require("app.gameData.UnionInfoData")
local UnionMemberInfoData = require("app.gameData.UnionMemberInfoData")
local ShopData = require("app.gameData.ShopData")
local HeroCardData = require("app.gameData.HeroCardData")
local CompoundData = require("app.gameData.CompoundData")
local IntegralShopData = require("app.gameData.IntegralShopData")
local IntegralShopData = require("app.gameData.ChatData")
local IntegralShopData = require("app.gameData.EnhanceData")
local ShopModel = require("app.ui.shopSystem.ShopModel")
local SpellController = require("app.ui.combatSystem.controller.SpellController")

function Factory:createCreatureView(controller, model)
    
    return BaseCreatureView.new(controller, model)
    
end

function Factory:createMailDataItem(...)
    return MailDataItem.new()
end
--公会列表信息
function Factory:createUnionListData(...)
    return UnionListData.new()
end
--公会信息
function Factory:createUnionInfoData(...)
    return UnionInfoData.new()
end

--公会成员信息
function Factory:createUnionMemberInfoData(...)
    return UnionMemberInfoData.new()
end
--商城数据
function Factory:createShopModel()
    return ShopModel.new()
end

--积分商城数据
function Factory:createIntegralShopData(...)
    return IntegralShopData.new()
end

--武将数据
function Factory:createChatData(...)
    return ChatData.new()
end

--合成数据
function Factory:createEnhanceData(...)
    return EnhanceData.new()
end

--合成数据
function Factory:createCompoundData(...)
    return CompoundData.new()
end

--合成数据
function Factory:createCompoundData(...)
    return CompoundData.new()
end

--生成一个子弹
function Factory:createBullet(type)
    local className = "app.ui.combatSystem.view." .. tostring(type) .. "Bullet"
    return require(className).new()
end

function Factory:createSpellCtl(param)
    return SpellController.new(param)
end

--生成提示信息面板
function Factory:createInfoPanel()
    local notice = require("app.ui.popViews.InfoPopView").new()
    return notice
end

--生成团队副本奖励
function Factory:createTdFbAwardItem(data)
    local awardItem = require("app.ui.minFbSelectSystem.FbAwardItem").new(data)
    return awardItem
end

--生成一个英雄节点
function Factory:createHeroNode(viewType)
    if viewType <= 2 then  
        if not self.heroNode then
            self.heroNode = cc.CSLoader:createNode("cs/csb/common/lord.csb")   --加载英雄node
            self.heroNode:retain()
        end

        local copyNode = self.heroNode:getChildByName("panel"):clone()
        copyNode:setParent(nil)
        return copyNode
    else
        if not self.soldierNode then
            self.soldierNode = cc.CSLoader:createNode("cs/csb/common/pawn.csb")   --加载小兵node
            self.soldierNode:retain()
        end

        local copyNode = self.soldierNode:getChildByName("panel"):clone()
        copyNode:setParent(nil)
        return copyNode
    end
end





return Factory