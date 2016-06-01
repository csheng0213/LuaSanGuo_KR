local BaseModel = require("app.baseMVC.BaseModel")

local EquipmentData = class("EquipmentData", BaseModel)

EquipmentData.debug = false

EquipmentData.equipmentInf = {}
EquipmentData.equipmentData = {}
EquipmentData.equipmentApparel = {}
EquipmentData.equipmentApparel.attack = {}
EquipmentData.equipmentApparel.attack.mainPos = {0,0,0,0,0,0}
EquipmentData.equipmentApparel.attack.vice1Pos = {0,0,0,0,0,0}
EquipmentData.equipmentApparel.attack.vice2Pos = {0,0,0,0,0,0}
EquipmentData.equipmentApparel.defense = {}
EquipmentData.equipmentApparel.defense.mainPos = {0,0,0,0,0,0}
EquipmentData.equipmentApparel.defense.vice1Pos = {0,0,0,0,0,0}
EquipmentData.equipmentApparel.defense.vice2Pos = {0,0,0,0,0,0}



EquipmentData.equipAttrType= 
{
    attack = 1,
    hp = 2,
    faf = 3,
    fas = 4
}
function EquipmentData:init()
    self.super.init(self)

------模拟数据----------------
    --装备背包数据
    -- for i = 52,57 do
    --     self.equipmentInf[#self.equipmentInf+1]= require("app.ui.equipmentSystem.EquipmentModel").new({m_id = i,mark = i,defFormFlag = 0,atkFormFlag = 1})
    -- end

    local equipmentInfHandler = function(event)
       local data = event.equipData
       
       if data == nil then
        return false
       end
       EquipmentData.equipmentInf = {}
       for k, v in pairs(data) do
            local atkFormFlag = 0 
            local defFormFlag = 0  
            
            if v.m_useFlag > 0 and v.m_useFlag < 4 then
                atkFormFlag = v.m_useFlag
            end
            if v.m_useFlag >= 4 then
                defFormFlag = v.m_useFlag- 3 
            end
            local equipInf = {m_id = v.m_id,mark = k,defFormFlag = defFormFlag,atkFormFlag = atkFormFlag,rdAttrType = v.m_NexType ,rdAttrPercent = v.m_Ratio}
            self:addEquip(equipInf)
       end
    end
    NetWork:addNetWorkListener({ 2, 6 }, equipmentInfHandler)

--    self.equipmentInf[1]= require("app.ui.equipmentSystem.EquipmentModel").new({m_id = 52,mark = 52,defFormFlag = 0,atkFormFlag = 1,rdAttrType = 1,rdAttrPercent = 10})
--    self.equipmentInf[2]= require("app.ui.equipmentSystem.EquipmentModel").new({m_id = 53,mark = 53,defFormFlag = 0,atkFormFlag = 2,rdAttrType = 1,rdAttrPercent = 10})
--    self.equipmentInf[3]= require("app.ui.equipmentSystem.EquipmentModel").new({m_id = 54,mark = 54,defFormFlag = 0,atkFormFlag = 3,rdAttrType = 1,rdAttrPercent = 10})
--  
--    self.equipmentInf[4]= require("app.ui.equipmentSystem.EquipmentModel").new({m_id = 55,mark = 55,defFormFlag = 1,atkFormFlag = 0,rdAttrType = 2,rdAttrPercent = 10})
--    self.equipmentInf[5]= require("app.ui.equipmentSystem.EquipmentModel").new({m_id = 56,mark = 56,defFormFlag = 2,atkFormFlag = 0,rdAttrType = 2,rdAttrPercent = 10})
--    self.equipmentInf[6]= require("app.ui.equipmentSystem.EquipmentModel").new({m_id = 57,mark = 57,defFormFlag = 3,atkFormFlag = 0,rdAttrType = 2,rdAttrPercent = 10})
--
--    self.equipmentInf[7]= require("app.ui.equipmentSystem.EquipmentModel").new({m_id = 97,mark = 97,defFormFlag = 0,atkFormFlag = 0,rdAttrType = 3,rdAttrPercent = 10})
--    self.equipmentInf[8]= require("app.ui.equipmentSystem.EquipmentModel").new({m_id = 42,mark = 42,defFormFlag = 0,atkFormFlag = 0,rdAttrType = 4,rdAttrPercent = 10})
    --装备穿戴数据
--  EquipmentData.equipmentApparel = {attack = {mainPos = {52,0,0,0},
--                                              vice1Pos= {53,0,0,0},
--                                              vice2Pos= {54,0,0,0},
--                                              },
--                                    defense = {mainPos = {55,0,0,0},
--                                              vice1Pos= {56,0,0,0},
--                                              vice2Pos= {57,0,0,0},
--                                              }           
--                                   }
                                     
    local equipmentApparelHandler = function(event)
        local data = event.data
        EquipmentData.equipmentApparel.attack.mainPos = data.m_equipList[1].m_equip
        EquipmentData.equipmentApparel.attack.vice1Pos = data.m_equipList[2].m_equip
        EquipmentData.equipmentApparel.attack.vice2Pos = data.m_equipList[3].m_equip

        EquipmentData.equipmentApparel.defense.mainPos = data.m_equipDefList[1].m_equip
        EquipmentData.equipmentApparel.defense.vice1Pos = data.m_equipDefList[2].m_equip
        EquipmentData.equipmentApparel.defense.vice2Pos = data.m_equipDefList[3].m_equip
    end
    NetWork:addNetWorkListener({ 2, 19 }, equipmentApparelHandler)


    --  GameEventCenter:addEventListener(PlayerData.PLAYER_LOGOUT_EVENT, function ( )
    --     EquipmentData.equipmentInf = {}       
    -- end)
end

--发送替换装备
function EquipmentData:RequestReplaceEquip(inf,handler)
    --监听服务器数据
    local onServerRequest = function (event)
        if handler ~= nil then
            handler()
        end
    end
    NetWork:addNetWorkListener({5,1}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    
    local msg = {idx = {5, 1}, equipSlot = inf.equipSlot,isFighter = inf.isFighter,fightSlot = inf.fightSlot, slot = inf.slot}
    NetWork:sendToServer(msg)
end
--发送装备培养请求
function EquipmentData:requestEquipEnhance(inf,handler)
    --监听服务器数据
    local onServerRequest = function (event)
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({5,3}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    
    local msg = {idx = {5, 3},reqtype = inf.enhanceType,slot = inf.equipMark,needEquipMark = inf.needEquipMark}
    NetWork:sendToServer(msg)
end

--发送出售装备命令
function EquipmentData:requestSellEquip(marks,handler)
    --监听服务器数据
    local onServerRequest = function (event)
        if handler ~= nil then
            handler(event)
        end
    end
    NetWork:addNetWorkListener({5,2}, Functions.createNetworkListener(onServerRequest,true,"ret"))
    local msg = {idx = {5, 2},equipSlots = marks}
    NetWork:sendToServer(msg)
end
--添加装备
function EquipmentData:addEquip(equipInf)
    assert(equipInf and equipInf.m_id > 0 and equipInf.mark > 0,"prama is error")
    self.equipmentInf[#self.equipmentInf+1] = require("app.ui.equipmentSystem.EquipmentModel").new({m_id = equipInf.m_id,mark = equipInf.mark,
                                                                                                   defFormFlag = equipInf.defFormFlag,atkFormFlag = equipInf.atkFormFlag,
                                                                                                   rdAttrType = equipInf.rdAttrType,rdAttrPercent = equipInf.rdAttrPercent})
end
--移除装备
function EquipmentData:miuEquip( mark )
    assert(mark and mark > 0 ,"prama is error")
    local pos = self:getEquipPositoon(mark)
    table.remove(self.equipmentInf,pos)
end
--根据mark获得装备在表中位置
function EquipmentData:getEquipPositoon(mark)
    for i = 1,#self.equipmentInf do 
        if mark == self.equipmentInf[i].mark then
            return i
        end
    end
end
--根据布阵类型及位置返回相应装备信息
function EquipmentData:getEquipApparelMark(embattleType,pos,index)
    local equipMark = 0
     if embattleType == EmbattleData.EmbattleTypeEnum.attack then
        if pos == 1 then
            equipMark = EquipmentData.equipmentApparel.attack.mainPos[index]
        elseif pos == 2 then
            equipMark = EquipmentData.equipmentApparel.attack.vice1Pos[index]
        elseif pos == 3 then
            equipMark = EquipmentData.equipmentApparel.attack.vice2Pos[index]
        end
    elseif embattleType == EmbattleData.EmbattleTypeEnum.defense then
        if pos == 1 then
            equipMark = EquipmentData.equipmentApparel.defense.mainPos[index]
        elseif pos == 2 then
            equipMark = EquipmentData.equipmentApparel.defense.vice1Pos[index]
        elseif pos == 3 then
            equipMark = EquipmentData.equipmentApparel.defense.vice2Pos[index]
        end
    end
    return equipMark
end
--根据布阵类型位置返回所有该位置的装备marks
function EquipmentData:getEquipMarks(embattleType,pos)
    local equipMarks = {}
     if embattleType == EmbattleData.EmbattleTypeEnum.attack then
        if pos == 1 then
            equipMarks = EquipmentData.equipmentApparel.attack.mainPos
        elseif pos == 2 then
            equipMarks = EquipmentData.equipmentApparel.attack.vice1Pos
        elseif pos == 3 then
            equipMarks = EquipmentData.equipmentApparel.attack.vice2Pos
        end
    elseif embattleType == EmbattleData.EmbattleTypeEnum.defense then
        if pos == 1 then
            equipMarks = EquipmentData.equipmentApparel.defense.mainPos
        elseif pos == 2 then
            equipMarks = EquipmentData.equipmentApparel.defense.vice1Pos
        elseif pos == 3 then
            equipMarks = EquipmentData.equipmentApparel.defense.vice2Pos
        end
    end
    return equipMarks
end
--对一组装备进行属性打包处理
function EquipmentData:packageGroupEquipAttr( marks )
    assert(marks and type(marks)== "table","marks is error")
    local packageAtrr = {}
    for i=1,#marks do
        if marks[i] > 0 then 
            packageAtrr[#packageAtrr + 1 ] = self:packageEquipAttr(marks[i])
         end
    end
    return packageAtrr
end
--对装备属性打包以便计算加成
function EquipmentData:packageEquipAttr( mark )
    assert(mark and mark > 0 ,"mark error!")
    local equipInf = EquipmentData:getEquipInf(mark)
    local attrType = ConfigHandler:getEquipAttrTypeOfId(equipInf.m_id)
    local attrValue = ConfigHandler:getEquipAttrValueOfId(equipInf.m_id)
    local rdAttrType = equipInf.rdAttrType
    local rdAttrValue = equipInf.rdAttrPercent
    return { attr = {type = attrType , value = attrValue}, rdAttr = { type = rdAttrType, value = rdAttrValue}}   
end
--根据布阵类型及位置设置装备
function EquipmentData:setEquipAppareMark(embattleType,pos,index,mark)
     if embattleType == EmbattleData.EmbattleTypeEnum.attack then
        if pos == 1 then
            EquipmentData.equipmentApparel.attack.mainPos[index] = mark 
        elseif pos == 2 then
            EquipmentData.equipmentApparel.attack.vice1Pos[index] = mark 
        elseif pos == 3 then
            EquipmentData.equipmentApparel.attack.vice2Pos[index] = mark 
        end
    elseif embattleType == EmbattleData.EmbattleTypeEnum.defense then
        if pos == 1 then
            EquipmentData.equipmentApparel.defense.mainPos[index] = mark 
        elseif pos == 2 then
            EquipmentData.equipmentApparel.defense.vice1Pos[index] = mark 
        elseif pos == 3 then
            EquipmentData.equipmentApparel.defense.vice2Pos[index] = mark 
        end
    end
end
--根据装备id清空相应装备位置的装备
function EquipmentData:cleanEquipAppraleOfMark(mark)
     local atkFormFlag,defFormFlag = self:getApparelFlag(mark)
     if atkFormFlag > 0 then
        if atkFormFlag == 1 then
            self:setTableElement(EquipmentData.equipmentApparel.attack.mainPos,mark,0)
        elseif atkFormFlag == 2 then
            self:setTableElement(EquipmentData.equipmentApparel.attack.vice1Pos,mark,0)
        elseif atkFormFlag == 3 then
            self:setTableElement(EquipmentData.equipmentApparel.attack.vice2Pos,mark,0)
        end
    elseif defFormFlag > 0 then
        if defFormFlag == 1 then
            self:setTableElement(EquipmentData.equipmentApparel.defense.mainPos,mark,0)
        elseif defFormFlag == 2 then
            self:setTableElement(EquipmentData.equipmentApparel.defense.vice1Pos,mark,0)
        elseif defFormFlag == 3 then
            self:setTableElement(EquipmentData.equipmentApparel.defense.vice2Pos,mark,0)
        end
    end 
end
--根据指定颜色的筛选装备
function EquipmentData:getColorNumUpEquip(colorNum)
    local filterData = {}

    for k,v in pairs(EquipmentData.equipmentInf) do 
        if ConfigHandler:getColorNumOfId(v.m_id) <= colorNum  and v.atkFormFlag == 0 and v.defFormFlag == 0  then
            filterData[#filterData+1] = v
        end
    end
    return filterData
end
--筛选未穿戴的装备
function EquipmentData:getEquipWithoutAppareled()
    local filterData = {}
    for k,v in pairs(EquipmentData.equipmentInf) do 
        if v.atkFormFlag == 0 and v.defFormFlag == 0  then
            filterData[#filterData+1] = v
        end
    end
    return filterData
end
function EquipmentData:setTableElement(tableObj,element,newValue)
    for i = 1,#tableObj do
        if tableObj[i] == element then
            tableObj[i] = newValue
        end
    end
end
--对装备排序处理
function EquipmentData:sortEquip(equipData)
    local sortTable = {}
    if #equipData > 0 then
        local tempTable1 = Functions.filterDatas(equipData, function(element)
                if element.atkFormFlag > 0 or element.defFormFlag > 0 then
                    return false
                else
                    return true 
                end
            end)
        
        local tempTable2 = Functions.filterDatas(equipData, function(element)
            if element.atkFormFlag > 0 or element.defFormFlag > 0 then
                return true
            else
                return false 
            end
        end) 
        --根据穿戴标示排序
        table.sort(tempTable2,function(a,b) 
            -- if a.atkFormFlag == b.atkFormFlag then
            --     if a.defFormFlag == b.defFormFlag then
            local a_colorNum = ConfigHandler:getColorNumOfId(a.m_id)
            local b_colorNum = ConfigHandler:getColorNumOfId(b.m_id)
            if a_colorNum == b_colorNum then
                local a_stag = ConfigHandler:getStagOfId(a.m_id)
                local b_stag = ConfigHandler:getStagOfId(b.m_id)
                if a_stag == b_stag then
                    local a_type = ConfigHandler:getEquipTypeOfId(a.m_id)
                    local b_type = ConfigHandler:getEquipTypeOfId(b.m_id)
                    if a_type == b_type then                            
                        return a_type > b_type  
                    else
                        return a_type < b_type  
                    end
                else
                    return a_stag > b_stag                            
                end    
            else                        
                return a_colorNum > b_colorNum
            end
               
        end)        
        table.sort(tempTable1,function(a,b)
           if a.atkFormFlag == b.atkFormFlag then
                if a.defFormFlag == b.defFormFlag then
                    return a.defFormFlag > b.defFormFlag
                else
                    return a.defFormFlag < b.defFormFlag
                end  
            else
                return a.atkFormFlag < b.atkFormFlag
            end    
        end)
        for i=1,#tempTable1 do
            sortTable[#sortTable+1] = tempTable1[i]
        end
        for i=1,#tempTable2 do
            sortTable[#sortTable+1] = tempTable2[i]
        end
    end
    return sortTable 
end
--对装备过滤处理函数
function EquipmentData:filterHandler(equipData,filterCondition1,filterCondition2)
    local filterData = {}
    for i=1,#equipData do
        if ConfigHandler:getEquipTypeOfId(equipData[i].m_id) == filterCondition1 and equipData[i].mark ~= filterCondition2 then
            filterData[#filterData+1] =  equipData[i]
        end
    end
    return filterData
end

--获取所有装备数据
function EquipmentData:getAllEquipData(filterHander,filterCondition1,filterCondition2)
    if filterHander ~= nil then
        return filterHander(self.equipmentInf,filterCondition1,filterCondition2)
    else
        return self.equipmentInf
    end
end
--根据mark查找某个装备信息
function EquipmentData:getEquipInf(mark)
     for i=1,#self.equipmentInf do
        if self.equipmentInf[i].mark == mark then
            return self.equipmentInf[i]
        end
    end
end
--根据mark查找某个装备强化Id
function EquipmentData:getEquipQiangHuaIdOfMark(mark)
    local equipInf = self:getEquipInf(mark)
    return ConfigHandler:getQiangHuaId(equipInf.m_id)
end
--根据mark查找某个装备合成Id
function EquipmentData:getEquipHeChengIdOfMark(mark)
    local equipInf = self:getEquipInf(mark)
    return ConfigHandler:getHeChengId(equipInf.m_id)
end
--根据mark获得装备类型
function EquipmentData:getEquipTypeOfMark(mark)
    local equipInf = self:getEquipInf(mark)
    return ConfigHandler:getEquipTypeOfId(equipInf.m_id)
end
--获取装备穿戴标示
function EquipmentData:getApparelFlag(mark)
    local equipInf = self:getEquipInf(mark)
    return equipInf.atkFormFlag,equipInf.defFormFlag

end
--设置穿戴标示
function EquipmentData:setApparelFalg(embattleType,pos,index,mark)
    local equipInf = self:getEquipInf(mark)
    if embattleType == EmbattleData.EmbattleTypeEnum.attack then
        equipInf.atkFormFlag = pos
    elseif embattleType == EmbattleData.EmbattleTypeEnum.defense then
        equipInf.defFormFlag = pos
    end
end
--修改一个位置的装备
function EquipmentData:modifyEquipAppare(appereFlag,equipMark)
    local equipType = self:getEquipTypeOfMark(equipMark)
    if appereFlag == 1 then  
        EquipmentData.equipmentApparel.attack.mainPos[equipType] = equipMark
    elseif appereFlag == 2 then 
        EquipmentData.equipmentApparel.attack.vice1Pos[equipType] = equipMark
    elseif appereFlag == 3 then 
        EquipmentData.equipmentApparel.attack.vice2Pos[equipType] = equipMark
    elseif appereFlag == 4 then 
        EquipmentData.equipmentApparel.defense.mainPos[equipType] = equipMark
    elseif appereFlag == 5 then 
        EquipmentData.equipmentApparel.defense.vice1Pos[equipType] = equipMark
    elseif appereFlag == 6 then 
        EquipmentData.equipmentApparel.defense.vice2Pos[equipType] = equipMark
    end
end
--根据标志返回装备的穿戴标志
function EquipmentData:getEquipApparelFlag(appereFlag)
    local atkFormFlag = 0 
    local defFormFlag = 0 
    if appereFlag > 0 and appereFlag < 4 then 
        atkFormFlag = appereFlag
    end
    if appereFlag >=4 then
        defFormFlag = appereFlag - 3 
    end
    return atkFormFlag, defFormFlag
end
--根据装备mark修改装备的随机属性
function EquipmentData:setEquipRdAttr(mark,rdAttrType,rdAttrPercent)
    local equipInf = self:getEquipInf(mark)
    equipInf.rdAttrType = rdAttrType
    equipInf.rdAttrPercent = rdAttrPercent
end
--清空装备所有穿戴标志
function EquipmentData:cleanApparelFlag(mark)
    local equipInf = self:getEquipInf(mark)
    equipInf.atkFormFlag = 0 
    equipInf.defFormFlag = 0 
end
--判断装备是否已被穿戴
function EquipmentData:isAppareled(mark)
    local equipInf = self:getEquipInf(mark)
    if equipInf.atkFormFlag > 0 or equipInf.defFormFlag > 0 then
        return true 
    else
        return false
    end
end
--筛选根据装备颜色某种颜色的装备数据
function EquipmentData:getEquipInfOfColorNum(equipData,colorNum)
    local filterData = {}
    for k,v in pairs(equipData) do 
        if ConfigHandler:getColorNumOfId(v.m_id) == colorNum then
            filterData[#filterData+1] = v
        end
    end
    return filterData
end
--根据阶级筛选装备数据
function EquipmentData:getEquipInfOfStagNum(equipData,stagNum)
    local filterData = {}
    for k,v in pairs(equipData) do 
        if ConfigHandler:getStagOfId(v.m_id) == stagNum then
            filterData[#filterData+1] = v
        end
    end
    return filterData
end
--移除指定mark的装备数据
function EquipmentData:removeEquipOfMark(equipData,mark)
    local filterData = {}
    for k,v in pairs(equipData) do 
        if v.mark ~= mark then
            filterData[#filterData+1] = v
        end
    end
    return filterData
end
--根据装备类型筛选装备
function EquipmentData:getEquipDataOfType(filterCondition1,filterCondition2)
    return self:getAllEquipData(handler(self,self.filterHandler),filterCondition1,filterCondition2)
end
return EquipmentData