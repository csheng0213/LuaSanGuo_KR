local BaseModel = require("app.baseMVC.BaseModel")

local EnhanceData = class("EnhanceData", BaseModel)

EnhanceData.ENHANCE_SHENG_JI_ZHU = "ENHANCE_SHENG_JI_ZHU"       --换主卡时的监听
EnhanceData.ENHANCE_SHENG_JI_FU = "ENHANCE_SHENG_JI_FU"         --换副卡时的监听
EnhanceData.ENHANCE_JIN_JIE_ZHU = "ENHANCE_JIN_JIE_ZHU"         --换主卡时的监听
EnhanceData.ENHANCE_JIN_JIE_FU = "ENHANCE_JIN_JIE_FU"           --换副卡时的监听


EnhanceData.debug = false

EnhanceData.HeroShowType = 0       --(1为升级加主卡，2为升级加副卡，3为进阶加主卡，4为进阶加副卡)

EnhanceData.MasterData = {}        --主卡的所有信息

EnhanceData.DeputyData = {}        --副卡的所有信息

EnhanceData.UPData = {}             --进阶到＋5时卡片添加和删除时的存放

function EnhanceData:init()

end

--加副卡前删除主卡
function EnhanceData:deleteCard()
    if EnhanceData.MasterData ~= nil then
        HeroCardData:getSellHeroData(EnhanceData.MasterData)
    end
end

--进阶或升级后改变主卡数据

function EnhanceData:MasterCardData(param)
    --进阶后改变主卡数据的阶数
    local iii = param.heroInfo.class
    EnhanceData.MasterData[1].m_class = param.heroInfo.class
    
    EnhanceData.MasterData[1].m_baseCombat  = cs_GetCardFightValue(param) --卡牌战斗力
    EnhanceData.MasterData[1].m_baseAttack  = pm_GetCardAttack(param) --卡牌攻击力
    EnhanceData.MasterData[1].m_baseHp      = pm_GetCardHp(param) -- 卡牌血量
    EnhanceData.MasterData[1].m_baseFas     = pm_GetCardFas(param) -- 卡牌法术
    EnhanceData.MasterData[1].m_baseFaf     = pm_GetCardFaf(param) -- 卡牌法防
    
end

function EnhanceData:requstUpgrade(requistType,reaistData,handler)
     local requstHander = function(event)

         if handler~=nil then 
             handler()
         end
     end
     NetWork:addNetWorkListener({ 5, 6 }, Functions.createNetworkListener(requstHander,true,"ret"))
     if requistType == 1 then 
         NetWork:sendToServer({ idx = { 5, 6 }, reqtype = 1, slot = reaistData.m_mark, metSlot = reaistData.metMark })
     else
         NetWork:sendToServer({ idx = { 5, 6 }, reqtype = 2, slot = reaistData.m_mark, prop = reaistData.prop })
     end
 end

--card base data
function EnhanceData:getParam(hero)
    local param = {heroInfo = { id = hero.m_id, level = hero.m_level, class = hero.m_class, attackEx = hero.m_attackEx,
        hpEx = hero.m_hpEx, fasEx = hero.m_fasEx, fafEx = hero.m_fafEx }}
    return param
end

--设置武将属性
function EnhanceData:setHeroAttr(hero, param)
    hero.m_baseCombat  = math.floor(cs_GetCardFightValue(param)) --卡牌战斗力
    hero.m_baseAttack  = math.floor(pm_GetCardAttack(param)) --卡牌攻击力
    hero.m_baseHp      = math.floor(pm_GetCardHp(param)) -- 卡牌血量
    hero.m_baseFas     = math.floor(pm_GetCardFas(param)) -- 卡牌法术
    hero.m_baseFaf     = math.floor(pm_GetCardFaf(param)) -- 卡牌法防
end

----上阵卡的删除
--function EnhanceData:deleteShangZhenCard()
--    local ShangZhen = HeroCardData:getShangZhenInfo()
--    HeroCardData:getSellHeroData(ShangZhen)
--end
--
----上阵卡的加入
--function EnhanceData:addShangZhenCard()
--    local ShangZhen = HeroCardData:getShangZhenInfo()
--    HeroCardData:addCardData(ShangZhen)
--    --加入之后就让它为空表
--end
--    
----主卡进阶到＋5时删除
--function EnhanceData:deleteUPCard()
--    local allCard = HeroCardData:getAllHeroData()
--    for k, v in pairs(allCard) do
--        if v.m_atkFormFlag > 0 or v.m_defFormFlag > 0 then
--            EnhanceData.UPData[#EnhanceData.UPData+1] = v
--        end
--    end
--    HeroCardData:addCardData(ShangZhen)
--end
--
----主卡进阶到＋5时加入
--function EnhanceData:addUPCard()
--    local allCard = HeroCardData:getAllHeroData()
--    for k, v in pairs(EnhanceData.UPData) do
--        allCard[#allCard+1] = v
--    	
--    end
--end

return EnhanceData