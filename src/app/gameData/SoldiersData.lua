local BaseModel = require("app.baseMVC.BaseModel")
local sharedScheduler = require("app.common.scheduler")

local SoldiersData = class("MailData", BaseModel)

SoldiersData.debug = false

SoldiersData.LADDER_EVENT = "LADDER_EVENT"
SoldiersData.RDFRESH_ITEM_EVENT = "RDFRESH_ITEM_EVENT"

SoldiersData.eventAttr.SoldiersBZ = 0

function SoldiersData:init()
    self.super.init(self)

    --士兵主数据
    self.SoldiersDatas = {}
    --士兵能否进阶升级的标志
    self._bu = 0
    self._qi = 0
    self._gong = 0
    
    --得到士兵数据
    local onSoldiersData = function(event)
        local data = event.data
        for k, v in pairs(data) do
            self.SoldiersDatas[k] = v
        end
    end
    NetWork:addNetWorkListener({ 2, 3 }, onSoldiersData)

    local refresh = function()
        --进主城就刷新标志
        self:refreshSoldiers()
    end
    local MAIN_CTL_EVENT_NAME = "ENTER_MAINVIEW_EVENT_NAME"
    GameEventCenter:addEventListener(MAIN_CTL_EVENT_NAME, refresh)
    
    local refreshEvent = function()
        self:refreshSoldiers()
    end
    
    GameEventCenter:addEventListener(PropData.PROP_CHANGE_EVENT, refreshEvent)
    
    --刷新士兵标志
    local refreshSoldiersMoney = function()
        self:refreshSoldiers()
    end
    Functions.bindWithModelAttr(PlayerData, "m_money", refreshSoldiersMoney)
    --刷新士兵标志
    local refreshSoldiersSoul = function()
        self:refreshSoldiers()
    end
    Functions.bindWithModelAttr(PlayerData, "m_soul", refreshSoldiersSoul)
    --sharedScheduler.scheduleGlobal(refreshSoldiersMark, 30)
end

--调用刷新标志数据
function SoldiersData:SoldierMoney()
    --刷新士兵标志
    local refreshSoldiersMoney = function()
        self:refreshSoldiers()
    end
    Functions.bindWithModelAttr(PlayerData, "m_money", refreshSoldiersMoney)
end

--调用刷新标志数据
function SoldiersData:SoldierSoul()
    --刷新士兵标志
    local refreshSoldiersSoul = function()
        self:refreshSoldiers()
    end
    Functions.bindWithModelAttr(PlayerData, "m_soul", refreshSoldiersSoul)
end

--刷新标志数据
function SoldiersData:refreshSoldiers()
    
    if PlayerData.eventAttr.m_level < g_csOpen.StrengthenOpen.level then
        SoldiersData.eventAttr.SoldiersBZ = 0
        return
    end
    self:SoldiersMark()
    local data = self:getSoldiersDatas()
    for i = 1, #data do
        local ladder = ConfigHandler:getSoldierLadderOfId(data[i].m_id)
--        if ladder == 3 then
--            break
--        end
        local _lv = 0
        
        for k = 1, ladder do
            if k < ladder then
                _lv = _lv + g_csBaseCfg.soldierClsLevel[k]
            end
            if k == ladder then
                _lv = _lv + data[i].m_level
            end

        end
--        if ladder == 1 then
--            _lv = data[i].m_level
--        elseif ladder == 2 then
--            _lv = 10+data[i].m_level
--        elseif ladder == 3 then
--            _lv = 10 + 20 + data[i].m_level
--        end
        local _itemNum = ConfigHandler:getSoldierOfNum(_lv)
        local _itemMoney = ConfigHandler:getSoldierOfMoney(_lv)
        local _items = g_csBaseCfg.soldierItemId[i][ladder]

        --规定士兵进阶的等级
        local _level = 0
        _level = g_csBaseCfg.soldierClsLevel[ladder]
        local uplv = 1
        if ladder >= 2 then
            uplv = g_csBaseCfg.soldierUplevel[ladder-1]
        end
        local oooo = PropData:getPropNumOfId(_items[1])
        repeat

            --升级判断
            if data[i].m_level < _level then
                local uiiiuiuiuiui = PropData:getPropNumOfId(_items[1])
                if PlayerData.eventAttr.m_level >= uplv and PropData:getPropNumOfId(_items[1]) >= _itemNum
                    and PlayerData.eventAttr.m_money >= _itemMoney then
                    SoldiersData.eventAttr.SoldiersBZ = 1
                    return
                else
                    SoldiersData.eventAttr.SoldiersBZ = 0
                    break
                end
            end
            --进阶判断
            if data[i].m_level == _level and ladder < #g_csBaseCfg.soldierClsLevel and PlayerData.eventAttr.m_level >= g_csBaseCfg.soldierUplevel[ladder] and 
                PlayerData.eventAttr.m_level >= g_csBaseCfg.soldierUplevel[ladder] then
                local ladderItem = ConfigHandler:getItemLadderOfId(data[i].m_id)
                if PropData:getPropNumOfId(ladderItem[1][1]) >= ladderItem[1][3] and PropData:getPropNumOfId(ladderItem[2][1]) >= ladderItem[2][3] and 
                    PropData:getPropNumOfId(ladderItem[3][1]) >= ladderItem[3][3] and PropData:getPropNumOfId(ladderItem[4][1]) >= ladderItem[4][3] then
                    SoldiersData.eventAttr.SoldiersBZ = 1
                    return
                else
                    SoldiersData.eventAttr.SoldiersBZ = 0
                end
            else
                SoldiersData.eventAttr.SoldiersBZ = 0
            end
        until true
    end
end


--刷新士兵标志数据
function SoldiersData:SoldiersMark()
    local data = self:getSoldiersDatas()
    for i = 1, #data do
        local ladder = ConfigHandler:getSoldierLadderOfId(data[i].m_id)
--        if ladder == 3 then
--            break
--        end
        local _lv = 0
        for k = 1, ladder do
            if k < ladder then
                _lv = _lv + g_csBaseCfg.soldierClsLevel[k]
            end
            if k == ladder then
                _lv = _lv + data[i].m_level
            end

        end
--        if ladder == 1 then
--            _lv = data[i].m_level
--        elseif ladder == 2 then
--            _lv = 10+data[i].m_level
--        elseif ladder == 3 then
--            _lv = 10 + 20 + data[i].m_level
--        end
        local _itemNum = ConfigHandler:getSoldierOfNum(_lv)
        local _itemMoney = ConfigHandler:getSoldierOfMoney(_lv)
        local _items = g_csBaseCfg.soldierItemId[i][ladder]
    
        --规定士兵进阶的等级
        local _level = 0
        _level = g_csBaseCfg.soldierClsLevel[ladder]
        local uplv = 1
        if ladder >= 2 then
            uplv = g_csBaseCfg.soldierUplevel[ladder-1]
        end
        local oooo = PropData:getPropNumOfId(_items[1])
            
        if i == 1 then
            self._bu = 0
        elseif i == 2 then
            self._qi = 0
        elseif i == 3 then
            self._gong = 0
        end
        --升级判断
        if data[i].m_level < _level then
            if PlayerData.eventAttr.m_level >= uplv and PropData:getPropNumOfId(_items[1]) >= _itemNum
                and PlayerData.eventAttr.m_money >= _itemMoney then
                if i == 1 then
                    self._bu = 1
                elseif i == 2 then
                    self._qi = 1
                elseif i == 3 then
                    self._gong = 1
                end
            end
        end
        --进阶判断
        if data[i].m_level == _level and ladder < #g_csBaseCfg.soldierClsLevel and PlayerData.eventAttr.m_level >= g_csBaseCfg.soldierUplevel[ladder] and 
            PlayerData.eventAttr.m_level >= g_csBaseCfg.soldierUplevel[ladder] then 
            local ladderItem = ConfigHandler:getItemLadderOfId(data[i].m_id)
            if PropData:getPropNumOfId(ladderItem[1][1]) >= ladderItem[1][3] and PropData:getPropNumOfId(ladderItem[2][1]) >= ladderItem[2][3] and 
                PropData:getPropNumOfId(ladderItem[3][1]) >= ladderItem[3][3] and PropData:getPropNumOfId(ladderItem[4][1]) >= ladderItem[4][3] then
                if i == 1 then
                    self._bu = 1
                elseif i == 2 then
                    self._qi = 1
                elseif i == 3 then
                    self._gong = 1
                end
            end
        end
        local iiiii = self._bu
        local qqq = self._qi
        local ppp = self._gong
        local llll = self._bu
    end
end

--获取步兵标志
function SoldiersData:getBuSoldiers()
    return self._bu
end
--获取骑兵标志
function SoldiersData:getQiSoldiers()
    return self._qi
end
--获取弓兵标志
function SoldiersData:getGongSoldiers()
    return self._gong
end


--清空申请数据
function SoldiersData:clearSoldiersData()
    self.SoldiersDatas = {}
end

--数据设置
function SoldiersData:setSoldiersData(k, level, id)
    --如果进阶，兵的id会改变，等级也会变成1级，升级就只改变等级
    if id ~= nil then
        self.SoldiersDatas[k].m_level = 1
        self.SoldiersDatas[k].m_id = id
    else
        self.SoldiersDatas[k].m_level = level
    end
end

--获取主数据
function SoldiersData:getSoldiersDatas()
    return self.SoldiersDatas
end

return SoldiersData