local BaseModel = require("app.baseMVC.BaseModel")

local CompoundData = class("CompoundData", BaseModel)

CompoundData.debug = false

CompoundData.CompoundNum =
{
        star5 = 60,  star4 = 40, star3 = 20
}

CompoundData.eventAttr.CompoundBZ = 0
--    //合成属性
--    uint32_t    m_CompoundID;           //合成ID
--    uint32_t    m_PossessCount;         //现在拥有个数
--    uint32_t    m_NeedCount;            //需要个数
--    uint32_t    m_Star;                 //星级
--    uint32_t    m_Mark;                 //记录卡包标记
--    bool        b_Compound;             //是否可以合成

--    self.m_id = 0                       --合成ID
--    self.m_possessCount = 0             --现在拥有个数
--    self.m_needCount = 0                --需要个数
--    self.m_star = 0                     --星级
--    self.m_mark = 0                     --记录卡包标记
--    self.m_compound = 0                 --是否可以合成

--判断碎片重复出现的bug数据
CompoundData.CompoundNUM = 0

function CompoundData:init()
    self.super.init(self)
    
    self.compoundDatas = {}

    local onCompoundDataInit = function(event)
        --判断碎片重复出现的bug数据
        --**************************
        CompoundData.CompoundNUM = CompoundData.CompoundNUM + 1
        if CompoundData.CompoundNUM >= 2 then
            assert(false, "CompoundData.CompoundNUM can not be 2")
        end
        --**************************
        --local data = event.data
        local m_key = event.indextbl
        local data = event.data
        for k, v in pairs(m_key) do
            self:addCompound({id = data.m_roleFragment[v].m_id, mark = v, num = data.m_roleFragment[v].m_count, type = 1})
        end
    end
    NetWork:addNetWorkListener({ 2, 14 }, onCompoundDataInit)
end

--获得碎片是否可能合成标志
function CompoundData:setCompoundBZ()
    local bz = true
    for i = 1,#self.compoundDatas do 
        if self.compoundDatas[i].m_compound == 1 then
            CompoundData.eventAttr.CompoundBZ = 1
            bz = false
            break
        end
    end
    if bz then
        CompoundData.eventAttr.CompoundBZ = 0
    end
end

--获取碎片个数
function CompoundData:getCompoundDatanNum(id)
    local num = 0
    for i = 1,#self.compoundDatas do 
        if self.compoundDatas[i].m_id == id then
            num = self.compoundDatas[i].m_possessCount
            break
        end
    end
    return num
end

--获取所有碎片
function CompoundData:getCompoundData()
    return self.compoundDatas
end
--获得某个卡牌碎片
function CompoundData:getCardFragmentOfId( id )
   for i = 1,#self.compoundDatas do 
        if self.compoundDatas[i].m_id == id then
            return self.compoundDatas[i]
        end
   end
end
--添加碎片
function CompoundData:setCompoundData(num, needCount)
    if num >= needCount then
        return 1
    else
        return 0
    end
end

--添加碎片
--data = {id, mark, num, type}  type为2时，是合成后添加碎片,type为nil时,是普通的添加碎片 
function CompoundData:addCompoundData(data)
    if data.type == nil and data.num == 0 then
        assert(false,"Data can not be 0")
    end
    local kg = false
    --如果type为nil，就判断是否有这种碎片，如果有，就加上以前有的数量，如果没有，就在主数据compoundDatas里添加这种碎片
    --如果type为2，就判断添加的数量为否为0，如果是，就删除以前的数据
    if data.type == nil or data.type == 2 then
        local datas = self:getCompoundData()
    	for k, v in pairs(datas) do
            if datas[k].m_id == data.id then
                if data.type == nil then
                    datas[k].m_possessCount = data.num + datas[k].m_possessCount

                elseif data.type == 2 then
                    if data.num == 0 then
                        table.remove(datas,k)
                        kg = true
                        break
                	else
                        datas[k].m_possessCount = data.num
                    end 
                end
                --如果数量不为0，则计算是否可以合成
                if data.num ~= 0 then
                    local shu = self:setCompoundData(datas[k].m_possessCount, datas[k].m_needCount)
                    datas[k].m_compound = shu
                    kg = true
                    break
                end
    		end
    	end
    end
    --如果删除数据，或者增加碎片数量，则重新排序以及判断标识
    if kg then
        self:sort()
        self:setCompoundBZ()
    	return true
    end
    
    local CompoundData = {}
    
    CompoundData.m_mark = data.mark                
    CompoundData.m_id = data.id
    CompoundData.m_possessCount = data.num

    if ConfigHandler:getHeroStarCountOfId(data.id) == 6 then
        CompoundData.m_star = 6
        CompoundData.m_needCount = g_csBaseCfg.fragment[6]
    elseif ConfigHandler:getHeroStarCountOfId(data.id) == 5 then
        CompoundData.m_star = 5
        CompoundData.m_needCount = g_csBaseCfg.fragment[5]
    elseif ConfigHandler:getHeroStarCountOfId(data.id) == 4 then
        CompoundData.m_star = 4
        CompoundData.m_needCount = g_csBaseCfg.fragment[4]
    end
    
    local shu = self:setCompoundData(CompoundData.m_possessCount, CompoundData.m_needCount)  
    CompoundData.m_compound = shu        

    --判断碎片重复出现的bug代码
    --**************************
    local _dt = self:getCompoundData()
    for k, v in pairs(_dt) do
        if _dt[k].m_id == data.id then
            assert(false,"_dt[k].m_id can not be data.id")
        end
    end
    --**************************

    self.compoundDatas[#self.compoundDatas+1] = CompoundData
    
    self:sort()
    self:setCompoundBZ()
end

--添加碎片
--data = {id, mark, num, type}  type为1时，是进游戏时添加碎片 
function CompoundData:addCompound(data)
    local CompoundData = {}
    local pppppp = self:getCompoundData()
    CompoundData.m_mark = data.mark                
    CompoundData.m_id = data.id
    CompoundData.m_possessCount = data.num

    if ConfigHandler:getHeroStarCountOfId(data.id) == 6 then
        CompoundData.m_star = 6
        CompoundData.m_needCount = g_csBaseCfg.fragment[6]
    elseif ConfigHandler:getHeroStarCountOfId(data.id) == 5 then
        CompoundData.m_star = 5
        CompoundData.m_needCount = g_csBaseCfg.fragment[5]
    elseif ConfigHandler:getHeroStarCountOfId(data.id) == 4 then
        CompoundData.m_star = 4
        CompoundData.m_needCount = g_csBaseCfg.fragment[4]
    end

    local shu = self:setCompoundData(CompoundData.m_possessCount, CompoundData.m_needCount)  
    CompoundData.m_compound = shu        

    self.compoundDatas[#self.compoundDatas+1] = CompoundData

    self:sort()
    self:setCompoundBZ()
end

--碎片排序
function CompoundData:sort()
    local sortfunction = function( left, right )
        if left.m_compound > right.m_compound then
            return true
        elseif left.m_compound < right.m_compound then
            return false
        end

        if left.m_star > right.m_star then
            return true
        elseif left.m_star < right.m_star then
            return false
        end

        if left.m_needCount > right.m_needCount then
            return true
        elseif left.m_needCount < right.m_needCount then
            return false
        end
        
        if left.m_possessCount > right.m_possessCount then
            return true
        elseif left.m_possessCount < right.m_possessCount then
            return false
        end
        
        if left.m_id > right.m_id then
            return true
        elseif left.m_id < right.m_id then
            return false
        end
    end
    table.sort( self.compoundDatas, sortfunction )
end

return CompoundData