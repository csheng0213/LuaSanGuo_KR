local BaseModel = require("app.baseMVC.BaseModel")

local PropData = class("PropData", BaseModel)

PropData.debug = false

PropData.propInf = {}
PropData.PROP_CHANGE_EVENT = "PROP_CHANGE_EVENT"
--PropData.propInf.indextbl= {}                 --背包ID
--PropData.propInf.m_itemBagCount =  0          --背包数量
--PropData.propInf.m_itemBagSizeExt = 0         --道具ID
PropData.propInf.m_itemBag = {}


function PropData:init()
    self.super.init(self)
    --注册网络监听，游戏开始初始化数据
    --游戏道具数据初始化命令：idx ＝ { 2, 4 }
    local onPropInit = function(event)

        local data = event.data
        self.propInf.m_itemBag = {}
        for k, v in pairs(data.m_itemBag) do
            v.index = k
            self.propInf.m_itemBag[#self.propInf.m_itemBag+1] = require("app.ui.propSystem.PropModel").new(v)
        end

        --模拟数据
        --        self.propInf.m_itemBag[#self.propInf.m_itemBag+1] = require("app.ui.propSystem.PropModel").new({index = 36,m_id = 36,m_count=2,script = 10})
        --        self.propInf.m_itemBag[#self.propInf.m_itemBag+1] = require("app.ui.propSystem.PropModel").new({index = 37,m_id = 37,m_count=2,script = 10})
        --        self.propInf.m_itemBag[#self.propInf.m_itemBag+1] = require("app.ui.propSystem.PropModel").new({index = 38,m_id = 38,m_count=2,script = 10})
    end
    NetWork:addNetWorkListener({ 2, 4 }, onPropInit)

    -- GameEventCenter:addEventListener(PlayerData.PLAYER_LOGOUT_EVENT, function ( )
    --    PropData.propInf.m_itemBag = {}

    -- end)
end
--获取背包某个道具数量
function PropData:getPropNumOfId(id)
    for i = 1,#PropData.propInf.m_itemBag do
        if PropData.propInf.m_itemBag[i].m_id == id then
            return PropData.propInf.m_itemBag[i].eventAttr.m_count , i
        end
    end
    return 0
end
function PropData:requestSellProp(id,num,handler)
     --监听服务器数据
    local onServerRequest = function (event)
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({13,2}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {13, 2},propId = id,propNum = num}
    NetWork:sendToServer(msg)
end
--发送抽保箱请求
function PropData:RequestUseCard(id,handler)
    --监听服务器数据
    local onServerRequest = function (event)
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({5,7}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {5, 7}, id = id }
    NetWork:sendToServer(msg)
end
--发送使用经验卡请求
function PropData:requestUseExpCard(heroMark,propId,propNum,handler)
    local onServerRequest = function (event)
        PropData:miuProp( {m_id = event.propId,m_count = event.propNum})
        PlayerData.eventAttr.m_money = event.m_money
        HeroCardData:setHeroExp(heroMark,event.newExp)
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({5,9}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {5, 9}, heroMark  = heroMark ,itemId = propId,itemNum = propNum}
    NetWork:sendToServer(msg)
end
--发送使用体力丹请求
function PropData:RequestUsePower(id,handler)
    --监听服务器数据
    local onServerRequest = function (event)
        Functions:addItemResources({id = event.gid,type = event.gtype,count = event.gcount})
        PropData:miuProp( {m_id = event.id,m_count = 1})
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({5,8}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {5, 8}, id = id}
    NetWork:sendToServer(msg)
end
--发送使用改名卡请求
function PropData:RequestModifyName(name,id,handler)
    --监听服务器数据
    local onServerRequest = function (event)
        if handler ~= nil then
            handler(event)
        end 
    end
    NetWork:addNetWorkListener({6,1}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {6, 1}, m_name = name, id = id}
    NetWork:sendToServer(msg)
end
--发送使用广播卡请求
function PropData:RequestBroadcast(inf,id,handler)
    --监听服务器数据
    local onServerRequest = function (event)
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({6,5}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {6, 5}, info = inf, id = id}
    NetWork:sendToServer(msg)
end
--获得经验丹数据
function PropData:getExpProp()
    local propData ={} 
    for i = 1,#self.propInf.m_itemBag do 
        if self.propInf.m_itemBag[i].m_id >= 70 and self.propInf.m_itemBag[i].m_id <= 72 then 
            propData[#propData+1] = self.propInf.m_itemBag[i]
        end
    end
    return propData
end
function PropData:getPropPositoon(id)
    for i = 1,#self.propInf.m_itemBag do 
        if id == self.propInf.m_itemBag[i].m_id then
            return i
        end
    end
end

--添加道具
--@prop格式：{m_id= ,m_count=},道具id，数量
function PropData:addProp(prop)
    assert(prop and prop.m_id and prop.m_count, "param is error")
    local isHavePorp = false
    if PropData:getPropNumOfId(prop.m_id) < 1 then 
        isHavePorp = true
    end
    if PlayerData.eventAttr.m_curBagSize > #self.propInf.m_itemBag then
        if prop.m_id < 1 then
            if prop.m_id == -2 then 
                PlayerData.eventAttr.m_gold = PlayerData.eventAttr.m_gold+ prop.m_count
            elseif prop.m_id == -3 then
                PlayerData.eventAttr.m_money = PlayerData.eventAttr.m_money + prop.m_count
            elseif prop.m_id == -4 then
                PlayerData:setPlayerPower(PlayerData.eventAttr.m_energy + prop.m_count)
            elseif prop.m_id == -5 then
                PlayerData.eventAttr.m_soul = PlayerData.eventAttr.m_soul + prop.m_count
            elseif prop.m_id == -6 then
                PlayerData.eventAttr.m_hunjing = PlayerData.eventAttr.m_hunjing + prop.m_count
            end
        else            
            local pos = self:getPropPositoon(prop.m_id)
            if  pos ~= nil then
                self.propInf.m_itemBag[pos].eventAttr.m_count = self.propInf.m_itemBag[pos].eventAttr.m_count + prop.m_count
            else
                if prop.script == nil then
                    prop.script = ConfigHandler:getScriptInfOfId(prop.m_id)
                end
                local v = prop
                v.index = #self.propInf.m_itemBag+1
                self.propInf.m_itemBag[#self.propInf.m_itemBag+1] = require("app.ui.propSystem.PropModel").new(v)
            end
            GameEventCenter:dispatchEvent({ name = PropData.PROP_CHANGE_EVENT  })
        end
        if prop.handler ~= nil and isHavePorp then 
            prop.handler()
        end
    else
        PromptManager:openTipPrompt(LanguageConfig.language_prop_9)
    end    
end
--减少道具
--@prop格式：{m_id= ,m_count=},道具id，减少的数量
function PropData:miuProp( prop )
    assert(prop and prop.m_id and prop.m_count, "param is error")
    if prop.m_id < 1 then 
        if prop.m_id == -2 then 
            PlayerData.eventAttr.m_gold = PlayerData.eventAttr.m_gold - prop.m_count
        elseif prop.m_id == -3 then
            PlayerData.eventAttr.m_money = PlayerData.eventAttr.m_money - prop.m_count
        elseif prop.m_id == -4 then
            PlayerData:setPlayerPower(PlayerData.eventAttr.m_energy - prop.m_count)
        elseif prop.m_id == -5 then
            PlayerData.eventAttr.m_soul = PlayerData.eventAttr.m_soul - prop.m_count
        elseif prop.m_id == -6 then
            PlayerData.eventAttr.m_hunjing = PlayerData.eventAttr.m_hunjing - prop.m_count
        end
    else
        local pos = self:getPropPositoon(prop.m_id)
        if pos ~= nil then
            if self.propInf.m_itemBag[pos].eventAttr.m_count >= prop.m_count then
                self.propInf.m_itemBag[pos].eventAttr.m_count = self.propInf.m_itemBag[pos].eventAttr.m_count - prop.m_count

                if self.propInf.m_itemBag[pos].eventAttr.m_count == 0 then
                    table.remove(self.propInf.m_itemBag,pos)
                    GameEventCenter:dispatchEvent({ name = PropData.PROP_CHANGE_EVENT  })
                end
            end 
        else
            PromptManager:openTipPrompt(LanguageConfig.language_prop_10)
        end
    end
end
return PropData