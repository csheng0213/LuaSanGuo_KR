local ConfigHandler = {}

local CsvReader = require("app.common.CsvReader")
local TextReader = require("app.common.TextReader")

ConfigHandler.fbinfoPath = "data/BiographySrc"
ConfigHandler.debug = false

ConfigHandler.Littlelevels = nil
ConfigHandler.skillInfos = nil
if G_CurrentLanguage == "ch" then
    ConfigHandler.Language = "中文"
elseif G_CurrentLanguage == "hr" then
    ConfigHandler.Language = "韩文"
end

function ConfigHandler:init()
    self.Littlelevels = TextReader.parserFile("data/passconfig.txt", true)
    self.debrisInfos = TextReader.parserFile("data/debrisdata.txt", true)
    self.formationInfos = TextReader.parserFile("data/formation.txt", true)
    self.getheros = TextReader.parserFile("data/gethero.txt", true)
    self.CSerrorcode = TextReader.parserFile("data/CSerrorcode.txt", true)
    self.soldiersStrengcfgs = TextReader.parserFile("data/soldiersStrengcfg.txt", true)
    self.heroAnimaInfos = CsvReader.parserFile("configs/combat/heroResource.csv", 2)
    self.soldierAnimaInfos = CsvReader.parserFile("configs/combat/soldierResource.csv", 2)
    self.skillInfos = TextReader.parserFile("data/spellconfig.txt",true)
end

--获取试炼相关配置
function ConfigHandler:getTrialHeroConfigOfLevel(level)
    if not self.heroTrialConfigs then
        self.heroTrialConfigs = TextReader.parserFile("data/herotrail.txt", true)    
    end

    assert(self.heroTrialConfigs[level], "hero trial config is error hero level is " .. tostring(level))
    return self.heroTrialConfigs[level]
end

--获取士兵升级资源数量
function ConfigHandler:getSoldierOfNum(level)
    local soldiersStrengcfgs = self.soldiersStrengcfgs[level]
    return soldiersStrengcfgs["材料数量"]
end

function ConfigHandler:getSoldierOfMoney(level)
    local soldiersStrengcfgs = self.soldiersStrengcfgs[level]
    return soldiersStrengcfgs["消耗金钱"]
end


--获取英雄缘分资源
function ConfigHandler:getHeroFateInfosOfId(id)
    return g_RoleCardConfig[id].relation
end

function ConfigHandler:getServerErrorCode(code)
    return ConfigHandler.CSerrorcode[code][ConfigHandler.Language]
end

function ConfigHandler:getFateHero1IdOfId(id) 
    return g_RoleCardConfig[id].relation.relatedID1
end
function ConfigHandler:getFateName1OfId(id) 
    return g_RoleCardConfig[id].relation.name1
end
function ConfigHandler:getFateInf1OfId(id) 
    return g_RoleCardConfig[tonumber(id)].relation.effectName1
end
function ConfigHandler:getFateHero2IdOfId(id) 
    return g_RoleCardConfig[tonumber(id)].relation.relatedID2
end
function ConfigHandler:getFateName2OfId(id) 
    return g_RoleCardConfig[tonumber(id)].relation.name2
end
function ConfigHandler:getFateInf2OfId(id)
    return g_RoleCardConfig[tonumber(id)].relation.effectName2
end

--根据缘分id 获取缘分1效果类型
function ConfigHandler:getFateType1OfId(id)
    return g_RoleCardConfig[tonumber(id)].relation.type1
end

--根据缘分id 获取缘分1效果值
function ConfigHandler:getFateValue1OfId(id)
    return g_RoleCardConfig[tonumber(id)].relation.value1
end

--根据缘分id 获取缘分2效果类型
function ConfigHandler:getFateType2OfId(id)
    return g_RoleCardConfig[tonumber(id)].relation.type2
end

--根据缘分id 获取缘分2效果值
function ConfigHandler:getFateValue2OfId(id)
    return g_RoleCardConfig[tonumber(id)].relation.value2
end

--获取士兵资源
function ConfigHandler:getSoldierInfosOfId(id)
    return g_SoldierConfig[id]
end

function ConfigHandler:getSoldierHeadImageOfId(id) 
    return g_SoldierConfig[id].head
end

function ConfigHandler:getSoldierCardImageOfId(id) 
    return g_SoldierConfig[id].card
end

function ConfigHandler:getSoldierResIdOfId(id) 
    return g_SoldierConfig[id].imgID
end

function ConfigHandler:getSoldierNameOfId(id) 
    return g_SoldierConfig[id].name
end

function ConfigHandler:getUpLadderOfId(id)
    return g_SoldierConfig[id].classto
end
function ConfigHandler:getSoldierLadderOfId(id) 
    return g_SoldierConfig[id].class
end

function ConfigHandler:getKeZhiOfId(id) 
    return g_SoldierConfig[id].restrainDes
end

function ConfigHandler:getItemLadderOfId(id) 
    return g_SoldierConfig[id].item
end

--获取英雄资源
function ConfigHandler:getHeroInfosOfId(id)
    return g_RoleCardConfig[id]
end

function ConfigHandler:getHeroHeadImageOfId(id) 
    return g_RoleCardConfig[id].heroHead
end

function ConfigHandler:getHeroStarCountOfId(id)
    return g_RoleCardConfig[id].quality
end

function ConfigHandler:getHeroCardImageOfId(id,bigClass,isLimitHero) 
    
    local heroCardImage = nil
    if id < 0 then
        return "heroCard/" .. tostring(id) .. ".png"
    else
        if g_RoleCardConfig[id].heroCard1 ~= "" then   
            if bigClass ~= nil and bigClass > 0 then      
                heroCardImage = g_RoleCardConfig[id]["heroCard" .. tostring(bigClass)]
            else    
                heroCardImage = g_RoleCardConfig[id].heroCard 
            end
        else
            heroCardImage = g_RoleCardConfig[id].heroCard
        end
    end
    assert(heroCardImage, "heroCardImage not found")
    return heroCardImage    
end 

function ConfigHandler:getActivityHeroCardImageOfId(id) 
    return g_RoleCardConfig[id].heroCard
end 

function ConfigHandler:getHeroNameOfId(id,class) 
    if class == nil then
        class = 1
    end
    return g_RoleCardConfig[id].classAttrs[class].disName
end

function ConfigHandler:getLordHeadIdOfId(id)
    local image = g_RoleCardConfig[id].heroHead
    local id = string.sub(image, 10,#image - 4)
    id = tonumber(id)%10000
    return id
end

function ConfigHandler:getHeroCountryOfId(id)
    local temp = g_RoleCardConfig[id]
    return temp.camp
end

function ConfigHandler:getHeroStarOfId(id) 
    return g_RoleCardConfig[id].quality
end

function ConfigHandler:getHeroResIdOfId(id) 
    return g_RoleCardConfig[id].imgID
end

function ConfigHandler:getHeroZxResNameOfId(id)
--    local resName = g_RoleCardConfig[id].formation .. ".tmx"
    local resName = self.formationInfos[self:getHeroZxIdOfId(id)]["阵型资源"]
    return resName
end

function ConfigHandler:getHeroZxResOfId(id)
    local formation = self.formationInfos[self:getHeroZxIdOfId(id)]
    return formation["图片资源"]
end

function ConfigHandler:getHeroZxNameOfId(id)
    local formation = self.formationInfos[self:getHeroZxIdOfId(id)]
    return formation["显示名称"]
end

function ConfigHandler:getHeroZxIdOfId(id)
    return tonumber(g_RoleCardConfig[id].formationId)
end

function ConfigHandler:getZxDescriptionOfHeroId(id)
    local formation = self.formationInfos[self:getHeroZxIdOfId(id)]
    return formation["描述"]
end

--获取阵型效果类型
function ConfigHandler:getZxEffectType(id)
    local formation = self.formationInfos[id]
    return tonumber(formation["效果类型"])
end

--获取阵型效果值
function ConfigHandler:getZxEffectValue(id)
    local formation = self.formationInfos[id]
    return tonumber(formation["效果值"])
end

--获取阵型名称根据id
function ConfigHandler:getZxNameOfId(id)
    local formation = self.formationInfos[id]
    return formation["名称"]
end

function ConfigHandler:getStrikeZxOfId(id)
    local formation = self.formationInfos[id]
    return formation["克敌阵型"]
end

function ConfigHandler:getHerTypeId(id)
    return g_RoleCardConfig[id].ctype
end

function ConfigHandler:getHeroFateId(id)
    return g_RoleCardConfig[id].relation.id
end

function ConfigHandler:getHeroSkillId(id, class)
    class = Functions.formatHeroClass(class) 
    return g_RoleCardConfig[id].classAttrs[class]
end

function ConfigHandler:getPspellsOfId(id, class)
    local info = self:getHeroSkillId(id, class)
    local pspells = {}
    for i=1, 10 do
        if pspells['passiveSpellId' + i] then
            pspells[#pspells + 1] = pspells['passiveSpellId' + i]
        else
            break
        end
    end
    return pspells
end

function ConfigHandler:getHeroDescriptionId(id)
    return g_RoleCardConfig[id].describe
end
--武力
function ConfigHandler:getHeroWuliId(id)
    return g_RoleCardConfig[id].wuli
end
--智力
function ConfigHandler:getHeroZhiliId(id)
    return g_RoleCardConfig[id].zhili
end
--统御
function ConfigHandler:getHeroTongyuId(id)
    return g_RoleCardConfig[id].tongyu
end
--获得英雄基础信息：id level class,soldier attack mp hp
function ConfigHandler:getHeroBaseInf(id)
    local heroBaseInf = {}
    heroBaseInf.id = id
    heroBaseInf.level = 1
    heroBaseInf.class = 1
    
    return heroBaseInf
end

--获取被动技能
function ConfigHandler:getPassiveSkillId(id)
    return g_PassiveSpellConfig[tonumber(id)]
end

function ConfigHandler:getPassiveSkillNameId(id)
    local PassiveSkillInfos = self:getPassiveSkillId(tonumber(id))
    return PassiveSkillInfos.name
end

function ConfigHandler:getPassiveSkillTextId(id)
    local PassiveSkillInfos = self:getPassiveSkillId(tonumber(id))
    return PassiveSkillInfos.describe
end

--获取道具资源
function ConfigHandler:getPropInforsOfId(id)
    return g_ItemConfig[tonumber(id)]
end

--获取道具掉落关卡
function ConfigHandler:getPropGkOfId(id)
    local propInfos = self:getPropInforsOfId(tonumber(id))
    return g_ItemConfig[tonumber(id)].gkid
end

function ConfigHandler:getPropImageOfId(id)
    local propInfos = self:getPropInforsOfId(tonumber(id))
    return g_ItemConfig[tonumber(id)].imgID
end

function ConfigHandler:getPropNameOfId(id)
    local propInfos = self:getPropInforsOfId(tonumber(id))
    return propInfos.name
end
function ConfigHandler:getPropInfOfId(id)
    local propInfos = self:getPropInforsOfId(tonumber(id))
    return propInfos.describe
end

function ConfigHandler:getScriptInfOfId(id)
    local propInfos = self:getPropInforsOfId(tonumber(id))
    return propInfos.script
end

function ConfigHandler:getPropTypeOfId(id)
    local propInfos = self:getPropInforsOfId(tonumber(id))
    return propInfos.type
end
function ConfigHandler:getPropPriceOfId(id)
    local propInfos = self:getPropInforsOfId(tonumber(id))
    return propInfos.price
end
--获取道具出处
function ConfigHandler:getPropPlace(id)
    local propInfos = self:getPropInforsOfId(tonumber(id))
    local info = {}
    for i = 1, 1 do
        info[i] = { type = propInfos.sellType, drop = propInfos.drop }
    end
    return info
end

--获取装备资源
function ConfigHandler:getEquipInforsOfId(id)
    return g_EquipConfig[id]
end
function ConfigHandler:getEquipTypeOfId(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    return equipInfos.ctype
end

function ConfigHandler:getEquipImageOfId(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    return equipInfos.imgID
end

function ConfigHandler:getQualityOfId(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    return equipInfos.quality
end
--获取装备的品质
function ConfigHandler:getColorNumOfId( id )
    return Functions.subIntOfNum(self:getQualityOfId(id)/10)
end
--获取装备的阶级
function ConfigHandler:getStagOfId( id )
    return self:getQualityOfId(id)%10
end
--获取装备强化材料
function  ConfigHandler:getQiangHuaRes(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    local script = " local qiangHuaRes = " .. equipInfos.strEngMater .. "  return qiangHuaRes"
    local qiangHuaRes=assert(loadstring(script))()  
    return qiangHuaRes
end
--获取装备强化ID
function  ConfigHandler:getQiangHuaId(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    return equipInfos.strEngToId
end
--获取装备合成材料
function  ConfigHandler:getHeChengRes(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    local script = " local heChengRes = " .. equipInfos.CompoundMater .. "  return heChengRes"
    local heChengRes = assert(loadstring(script))()  
    return heChengRes
end
--获取装备合成ID
function  ConfigHandler:getHeChengId(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    return equipInfos.CompoundId
end
--获取装备洗练材料
function  ConfigHandler:getXiLianRes(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    local script = " local xiLianRes = " .. equipInfos.refreshAttr .. "  return xiLianRes"
    local xiLianRes = assert(loadstring(script))()  
    return xiLianRes
end

function ConfigHandler:getEquipAttrTypeOfId(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    return equipInfos.attrType
end

function ConfigHandler:getEquipAttrValueOfId(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    return equipInfos.attrValue
end
function ConfigHandler:getEquipInfOfId(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    return equipInfos.describe
end
function ConfigHandler:getEquipPriceOfId(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    return equipInfos.sellPrice
end
function ConfigHandler:getEquipNameOfId(id)
    local equipInfos = self:getEquipInforsOfId(tonumber(id))
    return equipInfos.name
end
-- --获取Vip相关配置数据
-- function ConfigHandler:getVipfuncInfos(level)
--     if not self.vipFunInfos then
--         self.vipFunInfos = TextReader.parserFile("data/vipfuction.txt",true)
--     end
--     return self.vipFunInfos[level]
-- end

function ConfigHandler:getVipDescribeInfos(id)
    if not self.vipDescribeInfos then
        self.vipDescribeInfos = TextReader.parserFile("data/vipdescribe.txt",true)
    end
    return self.vipDescribeInfos[id]
end

-- --获取Vip特权ID
-- function ConfigHandler:getVipfuncId(level)
--     local vipFuncInfos = self:getVipfuncInfos(level)
--     return self.vipFunInfos["特权ID"]
-- end
-- --获取Vip特权数值
-- function ConfigHandler:getVipfuncNum(level)
--     local vipFuncInfos = self:getVipfuncInfos(level)
--     return self.vipFunInfos["特权数值"]
-- end
--获取Vip特权描述
function ConfigHandler:getVipDescribe(id)
    local vipDescribeInfos = self:getVipDescribeInfos(id)
    return self.vipDescribeInfos["功能描述"]
end

--获取任务相关数据
function ConfigHandler:getTaskInfos()
    if not self.taskInfos then
        self.taskInfos = TextReader.parserFile("data/task.txt",true)
    end
    return self.taskInfos
end
--获取章节漫画
function ConfigHandler:getChapter(id)
    if not self.chapterInfos then
        self.chapterInfos = TextReader.parserFile("data/chapter.txt",true)
    end
    return self.chapterInfos[id]
end
function ConfigHandler:getCartoonIDSeq(id)
    local chapterInfos = self:getChapter(id)
    local idSeq = string.split(chapterInfos["漫画ID序列"],",") 
    for i = 1,#idSeq do 
        idSeq[i] = tonumber(idSeq[i])
    end
    return idSeq
end
--获取漫画资源
function ConfigHandler:getCartoon(id)
    if not self.cartoonInfos then
        self.cartoonInfos = TextReader.parserFile("data/cartoon.txt",true)
    end
    return self.cartoonInfos[id]
end
function ConfigHandler:getCartoonRes(id)
    local cartoonInfos = self:getCartoon(id)
    return cartoonInfos["资源路径"]
end

--获取对话资源
function ConfigHandler:getDialogueInfos(id)
    if not self.dialogueInfos then
        self.dialogueInfos = TextReader.parserFile("data/dialogue.txt",true)
    end
    return self.dialogueInfos[id]
end

function ConfigHandler:getAllNPCId(id)
    local dialogueInfos = self:getDialogueInfos(id)
    local npcIdTable = {}
    for i=1,10 do
        local  npcId = dialogueInfos["人物" .. tostring(i)]
        if npcId ~= 0 then
            npcIdTable[#npcIdTable+1] = npcId
        end
    end
    return npcIdTable
end

function ConfigHandler:getNPC1Id(id)
    local dialogueInfos = self:getDialogueInfos(id)
    return dialogueInfos["人物1"]
end

--根据对话id获取对话触发位置
function ConfigHandler:getTalkPosOfId(id)
    local dialogueInfos = self:getDialogueInfos(id)
    local posID = dialogueInfos["时机"]
    
    assert(posID, "对话 " .. tostring(id) .. " 配置表错误，时机为nil")
    
    return posID
end


--获取技能资源
function ConfigHandler:getSkillInfos(skillId)
    assert(self.skillInfos[skillId], "skill " .. tostring(skillId) .. " config is nil ")
    return self.skillInfos[skillId]
end

--获取技能描述
function ConfigHandler:getSkillDescribeOfId(skillId)
    local skillInfos = self:getSkillInfos(skillId)
    return skillInfos["技能描述"]
end

function ConfigHandler:getSkillResOfId(skillId)
    local skillInfos = self:getSkillInfos(skillId)
    return skillInfos["技能片特效"]
end

function ConfigHandler:getSkillEffScaleOfId(skillId)
    local skillInfos = self:getSkillInfos(skillId)
    return skillInfos["技能片缩放比例"]
end

function ConfigHandler:getSkillBuffName(skillId)
    local skillInfos = self:getSkillInfos(skillId)
    
    local buffId = skillInfos["效果描述"]
    
    local buffImagePath = nil
    if buffId then

        local buffIds = Functions.strSplit(tostring(buffId), ",")
        if not self.buffData then
            self.buffData = TextReader.parserFile("data/buff.txt", true)
        end
        buffImagePath = {}
        for i=1,#buffIds do
            buffImagePath[#buffImagePath + 1] = self.buffData[tonumber(buffIds[i])]["路径"]
        end
    end
    
    return buffImagePath
end

function ConfigHandler:getSkillSoundName(skillId)
    local skillInfos = self:getSkillInfos(skillId)
    return skillInfos["技能声效"]
end

function ConfigHandler:getSkillBuffTypeOfId(skillId)
    local skillInfos = self:getSkillInfos(skillId)
    return skillInfos["效果选择"]
end

function ConfigHandler:loadFBInfo(fbID)
    Functions.printInfo(self.debug, "loadFBInfo id : ".. fbID)
    
    if self.currentFbId ~= fbID then
        
        local fbFilePath = self.Littlelevels[fbID]["士兵分布图"]
        local fbFilePath = self.fbinfoPath .. "/" .. fbFilePath
        print(fbFilePath)
        
        self.currentFbInfos = { fbInfo =  self.Littlelevels[fbID], fbHeroInfo = PaserFBXml(fbFilePath) }
        
        self.currentFbId = fbID
    end
    
    return self.currentFbInfos
end

function ConfigHandler:getGkDialogueOfId(id)
    local dialogueId = self.Littlelevels[tonumber(id)]["小关卡对话"]
    local dialogueIds = string.split(tostring(dialogueId), ",")

    table.map(dialogueIds, function(v,k)
        return tonumber(v)
     end)
    return dialogueIds
end

function ConfigHandler:getFbMaxCountOfId(id)
    return self.Littlelevels[tonumber(id)]["每日最多"]
end

function ConfigHandler:getFbNameOfId(id)
    return self.Littlelevels[tonumber(id)]["小关卡标题"]
end

function ConfigHandler:getFbCoinOfId(id)
    return self.Littlelevels[tonumber(id)]["铜钱奖励"]
end

function ConfigHandler:getFbExpOfId(id)
    return self.Littlelevels[tonumber(id)]["主角经验Exp"]
end

function ConfigHandler:getFbSoulOfId(id)
    return self.Littlelevels[tonumber(id)]["武魂"]
end

function ConfigHandler:getFbDrainPowerOfId(id)
    return self.Littlelevels[tonumber(id)]["每次扣除体力"]
end

function ConfigHandler:fbAwardDataHandler_(awardStr)
    local datas = string.split(awardStr, ",")
    --去掉首尾双引号
    table.map(datas, function(v,k)
        return tonumber(v)
    end)
    return datas
end

function ConfigHandler:getFbAwardData(id)
    local awardStr = self.Littlelevels[tonumber(id)]["奖励道具"]
    local datas = self:fbAwardDataHandler_(awardStr)
    return datas
end

function ConfigHandler:getTdFbAwardData(id)
    local awardStr = self.Littlelevels[tonumber(id)]["公会掉落"]
    local datas = self:fbAwardDataHandler_(awardStr)
    return datas
end

function ConfigHandler:getFbLimitLevel(fbId, index)
    local levelLimit = g_PassConfig[fbId].ppass[index].condition.levelLimit
    return levelLimit
end

function ConfigHandler:loadZxInfoOfName(fileName)
    local filePath = "data/ArmyFormation/" .. fileName
    return PaserFBXml(filePath)
end

function ConfigHandler:loadZxInfoOfAllName(fileName)
    local filePath = "data/" .. fileName
    return PaserFBXml(filePath)
end

function ConfigHandler:loadFastZxInfoOfName(fileName)
    local filePath = "data/ArmyFormation_fast/" .. fileName
    return PaserFBXml(filePath)
end

function ConfigHandler:loadHeroAnimaInfo(resId)
    Functions.printInfo(self.debug, "loadHeroAnimaInfo id : " .. resId)
    return self.heroAnimaInfos[resId]
    
end

function ConfigHandler:loadSoldierAnimaInfo(resId)
    Functions.printInfo(self.debug, "loadSoldierAnimaInfo id : " .. resId)
    return self.soldierAnimaInfos[resId]
end
--加载需要预览的动画信息
function ConfigHandler:loadAnimaInfo(resConfigFile)
    Functions.printInfo(self.debug, "loadPreAnimaInfo id : ")

    if not self.animaInfos then
        self.animaInfos = CsvReader.parserFile(resConfigFile, 2)
    end

    return self.animaInfos
end
--获取碎片掉落关卡id
function ConfigHandler:getDebrisLevel(id)
    local debrisInfos = self.debrisInfos[id]
    assert( debrisInfos, "碎片掉落 " .. tostring(id) .. " 配置表错误，掉落关卡为nil")
    return debrisInfos
end

function ConfigHandler:getDebrisInfoTwo(id)
    local debrisInfos = self.debrisInfos[id]
    return debrisInfos["关卡ID2"]
end

function ConfigHandler:getDebrisInfoThree(id)
    local debrisInfos = self.debrisInfos[id]
    return debrisInfos["关卡ID3"]
end


--获取碎片掉落关卡id

function ConfigHandler:getCardDrop(id)
    local getheros = self.getheros[id]
    --assert( debrisInfos, "碎片掉落 " .. tostring(id) .. " 配置表错误，掉落关卡为nil")
    return getheros["是否掉落"]
end

function ConfigHandler:getCardChapter(id)
    local getheros = self.getheros[id]
    return getheros["掉落章节"]
end

function ConfigHandler:getCardType(id)
    local getheros = self.getheros[id]
    return getheros["副本类型"]
end

function ConfigHandler:getCardDescriptions(id)
    local getheros = self.getheros[id]

    local infos = {}
    local iii = ConfigHandler:getCardChapter(id)
    if ConfigHandler:getCardChapter(id)  and ConfigHandler:getCardChapter(id) ~= 0 then

        local m_chapter = ConfigHandler:getCardChapter(id)
        local m_chapters = Functions.strSplit(tostring(m_chapter), ",")
        for i=1, #m_chapters do
            infos[#infos+1] = { m_type = 1, m_chapter = tonumber(m_chapters[i]) }
        end
    end

    for i=1, 6 do
        if getheros["掉落描述" .. i] and getheros["掉落描述" .. i] ~= 0 then
            infos[#infos+1] = { m_type = 2, m_chapter = getheros["掉落描述" .. i] }
        end
    end

    return infos
end


function ConfigHandler:getMajorInfos(id)
    if not self.checkPointInfos then
       self.checkPointInfos = TextReader.parserFile("data/majorhurdles.txt", true)
    end
    return self.checkPointInfos[tonumber(id)]
end

--获取大关卡名称
function ConfigHandler:getCheckPointNameOfID(id)
    local infos = self:getMajorInfos(id)
    return infos["大关卡标题"]
end

--获取漫画id
function ConfigHandler:getChapterOfID(id)
    local infos = self:getMajorInfos(id)
    return infos["结尾漫画"]
end

--获取关卡地图
function ConfigHandler:getMapOfID(id)
    local infos = self:getMajorInfos(id)
    return infos["地图"]
end


return ConfigHandler