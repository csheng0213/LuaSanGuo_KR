local CreatureFactory = {}

CreatureFactory.debug = true

local CreatureModel = require("app.ui.combatSystem.model.CreatureModel")


function CreatureFactory:createHero(heroInfo, partHeros, equipInfos, campType, viewType, pos, combatType, heroZxID)

    if heroInfo.id == 0 then return end
    
    local gainValue = 1
    if combatType == CombatCenter.CombatType.RB_HeroTrial and heroInfo.gainValue then
        gainValue = heroInfo.gainValue/100
    end 
    
    local heroData = ConfigHandler:getHeroInfosOfId(heroInfo.id)
    assert(heroData, "not found hero : " .. heroInfo.id .. " data")
    local l_dire = nil
    if campType then
        l_dire = { 1.0, 0.0 }
    else
        l_dire = { -1.0, 0.0 }
    end

    local hp, atk, fas, faf
    local isPossibleNpc = combatType == CombatCenter.CombatType.RB_PVE or combatType == CombatCenter.CombatType.RB_ElitePVE
         or combatType == CombatCenter.CombatType.RB_Tandui
         
    if isPossibleNpc and not campType then
        if heroInfo.preHp then
            hp = heroInfo.preHp*gainValue
        else
            hp  = Functions.getNPCHp({ id = heroInfo.id, level = heroInfo.level, class = heroInfo.class, combatType = combatType })*gainValue
        end
        atk = Functions.getNPCAttackValue({ id = heroInfo.id, level = heroInfo.level, class = heroInfo.class, combatType = combatType })*gainValue
        fas = Functions.getNPCFas({ id = heroInfo.id, level = heroInfo.level, class = heroInfo.class, combatType = combatType })*gainValue
        faf = Functions.getNPCFaf({ id = heroInfo.id, level = heroInfo.level, class = heroInfo.class, combatType = combatType })*gainValue
        baoj = g_baseBaoj
        baos = g_baseBaos
    else
        if heroInfo.curHp then
            hp  = heroInfo.curHp
        else
            hp  = pm_GetCardHp({ heroInfo = heroInfo, partHeros = partHeros, equipInfos = equipInfos })*gainValue
        end
        atk = pm_GetCardAttack({ heroInfo = heroInfo, partHeros = partHeros, equipInfos = equipInfos })*gainValue
        fas = pm_GetCardFas({ heroInfo = heroInfo, partHeros = partHeros, equipInfos = equipInfos })*gainValue
        faf = pm_GetCardFaf({ heroInfo = heroInfo, partHeros = partHeros, equipInfos = equipInfos })*gainValue
        baoj = g_baseBaoj
        baos = g_baseBaos
    end

    local class = Functions.formatHeroClass(heroInfo.class)
    local skills = heroData.classAttrs[class]
    
    local creature = CreatureModel.new({  
                                heroId         = heroInfo.id,
                                class          = heroInfo.class,
                                campType       = campType,
                                viewType       = viewType,
                                dire           = l_dire,
                                pos            = pos,
                                veiwName       = heroData.name,
                                resId          = heroData.imgID,
                                hp             = hp,
                                atk            = atk,
                                fas            = fas,
                                faf            = faf,
                                baoj           = baoj,
                                baos           = baos,
                                wuli           = heroData.wuli,
                                zhili          = heroData.zhili,
                                tongyu         = heroData.tongyu,
                                num            = pm_GetCardLeadSoldierNum({ id = heroInfo.id }),
                                round          = heroData.volume,
                                atk_spd        = heroData.attackSpeed,
                                atk_range      = heroData.attackDistance,
                                vis_field      = heroData.attackView,
                                mv_spd         = heroData.movedSpeed,
                                cnotion        = heroData.camp,
                                zxId           = heroZxID,
                                enemyZxId      = ConfigHandler:getStrikeZxOfId(heroZxID),
                                spells         = clone(skills.mSpellId),
                                passiveSkills  = { skills.passiveSpellId1, skills.passiveSpellId2, skills.passiveSpellId3},
                                skillAnimaName = heroData.effectRes,
                                heroSound      = heroData.heroSound
                            })
    creature:updateAttrExOfZx(combatType, heroZxID, campType)

    -- 天梯战斗中，放大基础血量倍数
    if combatType == CombatCenter.CombatType.RB_PVPPlayerData then
        creature:setHp(creature:getHp() + g_pvpFightHpScale*pm_GetCardHp({ heroInfo = { id = heroInfo.id,
            level = heroInfo.level, class = heroInfo.class }}))
    end


    return creature
end

function CreatureFactory:createSoldiers(heroId, level, campType, pos, count, leadPower, posFunc, combatType, zxId, gain)
    if heroId == 0 then return end
    
    local gainValue = 1
    if combatType == CombatCenter.CombatType.RB_HeroTrial and gain then
        gainValue = gain/100
    end 
    
    local SoldiersData = ConfigHandler:getSoldierInfosOfId(heroId)
    assert(SoldiersData, "not found Soldier : " .. heroId .. " data")
    
    local soldiers = {}   
     
    local l_dire = nil     --初始化小兵方向
    if campType then
        l_dire = { 1.0, 0.0 }
    else
        l_dire = { -1.0, 0.0 }
    end
    
    local l_hp = 0   --初始化小兵血量
    l_hp = SoldiersData.origHP + SoldiersData.growHp*( level - 1 )
    
    local l_atk = 0  --初始化小兵攻击
    l_atk = SoldiersData.origAttack + SoldiersData.growAttack*( level - 1 )

    local l_fas = 0  --初始化小兵法术
    l_fas = SoldiersData.origFas + SoldiersData.growFas*( level - 1 )

    local l_faf = 0  --初始化小兵法防
    l_faf = SoldiersData.origFaf + SoldiersData.growFaf*( level - 1 )

    local points = nil --初始化小兵坐标
    if type(posFunc) == "function" then
        points = posFunc(pos, count, campType)
    else
        assert(false, "小兵坐标应该是一个生成函数！")
    end
     
    for i=1, count do
        
        local soldier = CreatureModel.new({  
                                heroId        = heroId,
                                campType      = campType,
                                viewType      = tonumber(SoldiersData.stype) + 2,
                                dire          = l_dire,
                                pos           = points[i],
                                veiwName      = SoldiersData.name,
                                resId         = SoldiersData.imgID,
                                hp            = pm_GetSoldierHpEx(l_hp, leadPower)*gainValue,
                                atk           = pm_GetSoldierAtkEx(l_atk, leadPower)*gainValue,
                                fas           = pm_GetSoldierFasEx(l_fas, leadPower)*gainValue,
                                faf           = pm_GetSoldierFafEx(l_faf, leadPower)*gainValue,
                                num           = 0,
                                round         = SoldiersData.volume,
                                atk_spd       = SoldiersData.attackSpeed,
                                atk_range     = SoldiersData.attackView,
                                vis_field     = SoldiersData.View,
                                mv_spd        = SoldiersData.movedSpeed,
                                cnotion       = 0,
                                zxId          = zxId,
                                enemyZxId     = ConfigHandler:getStrikeZxOfId(zxId),
                                soldierSkills = {  
                                                    {   
                                                        id = heroId,
                                                        state = SoldiersData.restrainType,
                                                        val_pct = SoldiersData.restrainVal
                                                    }
                                                }
                                           })
        soldier:updateAttrExOfZx(combatType, zxId, campType)
        soldiers[#soldiers + 1] = soldier
    end
    
    return soldiers
end

return CreatureFactory