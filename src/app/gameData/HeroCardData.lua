local BaseModel = require("app.baseMVC.BaseModel")

local HeroCardData = class("HeroCardData", BaseModel)

HeroCardData.debug = false

HeroCardData.HeroType =
{
    LI = 30001, SHU = 30002, MOU = 30003, YI = 30004, ALL = 99999
}

--event 
HeroCardData.CARDS_DATA_CHANGE_EVENT = "CARDS_DATA_CHANGE_EVENT"

HeroCardData.CARDS_DATA_SORT_EVENT = "CARDS_DATA_SORT_EVENT"

HeroCardData.CARDS_ENHANCE = "CARDS_ENHANCE"


function HeroCardData:init()
    self.super.init(self)
    
    self.HeroDatas = {}     --总卡片数据
    self.liHeroDatas = {}
    self.shuHeroDatas = {}
    self.mouHeroDatas = {}
    self.yiHeroDatas = {}
    self.WillSellHeroDatas = {} --准备出售卡片数据
    self.shangZhenCard = {} --上阵的卡片

    self.shangZhenGong = {} --攻击阵型卡片
    self.shangZhenFang = {} --防御阵型卡片
    self.shangZhenWei = {}  --未上阵的卡片


    self.taskCard = {} --做任务的卡片
    
    
    local onHeroCardInit = function(event)
        self.HeroDatas = {}
        local data = event.data
        --local m_RCBagCount = data.m_RCBagCount  --武将现在有数
        self.m_BagBaseSize = data.BagBaseSize  --武将包最大容量
        
        local m_key = event.indextbl
        
        local m_roleData = event.roleData
        
        for k, v in pairs(m_roleData) do

            --添加武将
            --参数data = {slot =,id =,level＝,exp ＝, class = ,skillLevel = ,skillExp = ,atkFormFlag = ,defFormFlag = ,
            --atkFormFlagTemp = ,defFormFlagTemp = ,Combat =,hp =,attack =,mp =,soldier = }

            local info = {slot = k, id = v.m_id, level = v.m_level, exp = v.m_exp, class = v.m_class,atkFormFlag = v.m_atkFormFlag,defFormFlag = v.m_defFormFlag,
             atkFormFlagTemp = v.m_atkFormFlag, defFormFlagTemp = v.m_defFormFlag, hp = v.m_hp, attack = v.m_attack, mp = v.m_mp, soldier = v.m_soldier}
            self:addCard(info, false)
        end
        --self:sort()
        self:card_fen_zhu()
        self:card_sort()
    end
    NetWork:addNetWorkListener({ 2, 6 }, onHeroCardInit)
    
    local sortEvent = function(event)
        self:card_fen_zhu()
        self:card_sort()
    end
    GameEventCenter:addEventListener(HeroCardData.CARDS_DATA_SORT_EVENT, sortEvent)
    --Functions.bindEventListener(self, GameEventCenter, HeroCardData.CARDS_DATA_SORT_EVENT,sortEvent)
    
end
--设置武将经验
function HeroCardData:setHeroExp(mark,exp)
    local heroInfo = self:getHeroInfo(mark)
    heroInfo.m_exp = exp
end
--根据ID打包武将属性用于战力计算
function HeroCardData:packageHeroAttr( mark )
    assert(mark and mark > 0 ,"mark is error")
    local heroInf = self:searchHeroOfMark(mark)
    return {id = heroInf.m_id,level = heroInf.m_level,class = heroInf.m_class,  attackEx = heroInf.m_attackEx, hpEx =heroInf.m_hpEx , fasEx = heroInf.m_fasEx, fafEx = heroInf.m_fafEx}
end
--更新卡牌的七星坛数据
--@exAttr= {attackEX = ,hpEx = , fasEx = ,fafEx =  }
function HeroCardData:updateHeroExAttr(mark,exAttr)
    assert(mark and mark > 0 ,"mark is error")
    local heroInf = self:searchHeroOfMark(mark)
    heroInf.m_attackEx = exAttr.attackEX or 0
    heroInf.m_hpEx = exAttr.hpEx or 0
    heroInf.m_fasEx = exAttr.fasEx or 0 
    heroInf.m_fafEx = exAttr.fafEx or 0 
    self:updateHeroBaseAttr(mark)
end

function HeroCardData:updateHeroBaseAttr(mark)
    local pacakageData = self:packageHeroAttr(mark)
    local heroInf = self:searchHeroOfMark(mark)
    heroInf.m_baseCombat = cs_GetCardFightValue({heroInfo = pacakageData}) --卡牌战斗力
    heroInf.m_baseAttack = pm_GetCardAttack({heroInfo = pacakageData}) --卡牌攻击力
    heroInf.m_baseHp     = pm_GetCardHp({heroInfo = pacakageData}) -- 卡牌血量
    heroInf.m_baseFas    = pm_GetCardFas({heroInfo = pacakageData}) --卡牌法术
    heroInf.m_baseFaf    = pm_GetCardFaf({heroInfo = pacakageData}) --卡牌法防
end
--排序后武将分组
function HeroCardData:sort_fen_zhu()

    --加卡之后，清空所有类型的卡片
    self.liHeroDatas = {}
    self.shuHeroDatas = {}
    self.mouHeroDatas = {}
    self.yiHeroDatas = {}
    
    local data = self.HeroDatas
    for k, v in pairs(data) do
        if ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.LI then
            self.liHeroDatas[#self.liHeroDatas+1] = v
        elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.SHU then
            self.shuHeroDatas[#self.shuHeroDatas+1] = v
        elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.MOU then
            self.mouHeroDatas[#self.mouHeroDatas+1] = v
        elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.YI then
            self.yiHeroDatas[#self.yiHeroDatas+1] = v
        end
    end
end

--排序（倒序）
function HeroCardData:sortReverse()

    local comp = function(left , right)


        --星级
        if ConfigHandler:getHeroStarCountOfId(right.m_id) > ConfigHandler:getHeroStarCountOfId(left.m_id) then
            return true
        elseif ConfigHandler:getHeroStarCountOfId(right.m_id) < ConfigHandler:getHeroStarCountOfId(left.m_id) then
            return false
        end
        
        --阶级
        if right.m_class > left.m_class then
            return true
        elseif right.m_class < left.m_class then
            return false
        end

        --等级
        if right.m_level > left.m_level then
            return true
        elseif right.m_level < left.m_level then
            return false
        end

        --战斗力
        if right.m_baseCombat > left.m_baseCombat then 
            return true
        elseif right.m_baseCombat < left.m_baseCombat then
            return false
        end

        --人物id
        if left.m_id > right.m_id then
            return true
        else
            return false
        end
    end
    print("sfs")
    table.sort(self.HeroDatas, comp)

    --加卡之后，清空所有类型的卡片
    self.liHeroDatas = {}
    self.shuHeroDatas = {}
    self.mouHeroDatas = {}
    self.yiHeroDatas = {}

    local data = self.HeroDatas
    for k, v in pairs(data) do
        if ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.LI then
            self.liHeroDatas[#self.liHeroDatas+1] = v
        elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.SHU then
            self.shuHeroDatas[#self.shuHeroDatas+1] = v
        elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.MOU then
            self.mouHeroDatas[#self.mouHeroDatas+1] = v
        elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.YI then
            self.yiHeroDatas[#self.yiHeroDatas+1] = v
        end
    end
end


--添加武将(武将所有数据)
function HeroCardData:addCardData(data)
    for k, v in pairs(data) do
        self.HeroDatas[#self.HeroDatas+1] = v
    end
    --self:sort()
    --先进行阵型分组
    self:card_fen_zhu()
    self:card_sort()

end
--添加多张武将
--参数{datas = { {slot =,id =,level＝,exp ＝, class = ,atkFormFlag = ,defFormFlag = ,
--atkFormFlagTemp = ,defFormFlagTemp = ,Combat =,hp =,attack =,mp =,soldier = }}
function HeroCardData:addCards(datas)
    for k, v in pairs(datas) do
        HeroCardData:addCard( v, false )
    end
    --self:sort()
    --先进行阵型分组
    self:card_fen_zhu()
    self:card_sort()
end
--添加武将
--参数data = {slot =,id =,level＝,exp ＝, class = ,atkFormFlag = ,defFormFlag = ,
--atkFormFlagTemp = ,defFormFlagTemp = ,Combat =,hp =,attack =,mp =,soldier = }
function HeroCardData:addCard(data, isSort)
    assert(data and data.slot and data.id,"param is err")

    if isSort == nil then isSort = true end
    
    data.level = data.level or 1
    data.exp = data.exp or 0
    
    data.atkFormFlag = data.atkFormFlag or 0
    data.defFormFlag = data.defFormFlag or 0
    data.atkFormFlagTemp = data.atkFormFlagTemp or 0
    data.defFormFlagTemp = data.defFormFlagTemp or 0
    data.Combat = data.Combat or 0
    data.hp = data.hp or 0
    data.attack = data.attack or 0
    data.mp = data.mp or 0
    data.soldier = data.soldier or 0
    
    
    if data.class == nil or data.class < 1 then
    	data.class = 1
    end
    
    local cardInfo         = require("app.ui.heroSystem.CardModel").new()

    cardInfo.m_mark        = data.slot                        --卡片标记
    cardInfo.m_id          = data.id
    cardInfo.m_level       = data.level
    cardInfo.m_exp         = data.exp
    cardInfo.m_class       = data.class                --card +5，当前阶的强化数
--    cardInfo.m_skillLevel  = data.skillLevel
--    cardInfo.m_skillExp    = data.skillExp
    cardInfo.m_atkFormFlag = data.atkFormFlag    --攻击阵形标记：0-未使用 1-主将 2-副将1 3-副将2 4-偏将1 ..... 9-偏将6
    cardInfo.m_defFormFlag = data.defFormFlag    --防御阵形标记：0-未使用 1-主将 2-副将1 3-副将2 4-偏将1 ..... 9-偏将6
    cardInfo.m_atkFormFlagTemp = data.atkFormFlag    --攻击阵形标记：0-未使用 1-主将 2-副将1 3-副将2 4-偏将1 ..... 9-偏将6
    cardInfo.m_defFormFlagTemp = data.defFormFlag     --防御阵形标记：0-未使用 1-主将 2-副将1 3-副将2 4-偏将1 ..... 9-偏将6
    cardInfo.m_Combat      = data.Combat                       --战斗力
    
    cardInfo.m_hpEx          = data.hp                    
    cardInfo.m_attackEx      = data.attack
    cardInfo.m_fasEx         = data.mp
    cardInfo.m_fafEx         = data.soldier

    --card base data
    -- heroInfo format { id = , level = , class = , attackEx = , hpEx = , fasEx = , fafEx = } 
    -- id,level,class( 卡牌id, 等级, 阶级); attackEx,hpEx,fasEx,fafEx(其他系统额外添加的 攻击力, 生命, 法术, 法防)
    --card base data
    local param = { heroInfo = { id = cardInfo.m_id, level = cardInfo.m_level, class = cardInfo.m_class,  attackEx = cardInfo.m_attackEx,
        hpEx = cardInfo.m_hpEx, fasEx = cardInfo.m_fasEx, fafEx = cardInfo.m_fafEx } }

    cardInfo.m_baseCombat = cs_GetCardFightValue(param) --卡牌战斗力
    cardInfo.m_baseAttack = pm_GetCardAttack(param) --卡牌攻击力
    cardInfo.m_baseHp     = pm_GetCardHp(param) -- 卡牌血量
    cardInfo.m_baseFas    = pm_GetCardFas(param) --卡牌法术
    cardInfo.m_baseFaf    = pm_GetCardFaf(param) --卡牌法防
    
    self.HeroDatas[#self.HeroDatas+1] = cardInfo

    if isSort then
        --self:sort()
        --先进行阵型分组
        self:card_fen_zhu()
        self:card_sort()
    end
end

--武将分组
function HeroCardData:card_fen_zhu()

    self.shangZhenWei = {}
    self.shangZhenGong = {}
    self.shangZhenFang = {}
    
    for k, v in pairs(self.HeroDatas) do
        if self.HeroDatas[k].m_atkFormFlagTemp == 0 and self.HeroDatas[k].m_defFormFlagTemp == 0 then 
            self.shangZhenWei[#self.shangZhenWei+1] = v  --未上阵的卡片
        elseif self.HeroDatas[k].m_atkFormFlagTemp > 0 then
            self.shangZhenGong[#self.shangZhenGong+1] = v --攻击阵型卡片  
        elseif self.HeroDatas[k].m_defFormFlagTemp > 0 then
            self.shangZhenFang[#self.shangZhenFang+1] = v --防御阵型卡片
        end 
    end
    local iii = self.shangZhenWei
    local oo = self.shangZhenGong
    local pp = self.shangZhenFang
    local kkk = 55
end

--未上阵武将排序
function HeroCardData:wei_Sort()

    local comp = function(left , right)
        
        --星级
        if ConfigHandler:getHeroStarCountOfId(left.m_id) > ConfigHandler:getHeroStarCountOfId(right.m_id) then
            return true
        elseif ConfigHandler:getHeroStarCountOfId(left.m_id) < ConfigHandler:getHeroStarCountOfId(right.m_id) then
            return false
        end
        
        --阶级
        if left.m_class > right.m_class then
            return true
        elseif left.m_class < right.m_class then
            return false
        end
        
        --等级
        if left.m_level > right.m_level then
            return true
        elseif left.m_level < right.m_level then
            return false
        end
        
        --战斗力
        if left.m_baseCombat > right.m_baseCombat then 
            return true
        elseif left.m_baseCombat < right.m_baseCombat then
            return false
        end
        
        --人物id
        if left.m_id > right.m_id then
            return true
        else
            return false
        end
    end
    print("sfs")
    table.sort(self.shangZhenWei, comp)
end

--武将交叉排序
function HeroCardData:card_sort()
    self:card_fen_zhu()
    
    if #self.shangZhenGong > 0 then
        self:gong_sort(self.shangZhenGong)
    end
    
    if #self.shangZhenFang > 0 then
        self:fang_sort(self.shangZhenFang)
    end
    
    self.HeroDatas = {}
    if #self.shangZhenGong > 0 and self.shangZhenGong[1].m_atkFormFlagTemp == 1 then
        self.HeroDatas[#self.HeroDatas+1] = self.shangZhenGong[1]
        table.remove(self.shangZhenGong, 1)
    end

    if #self.shangZhenFang > 0 and self.shangZhenFang[1].m_defFormFlagTemp == 1 then
        self.HeroDatas[#self.HeroDatas+1] = self.shangZhenFang[1]
        table.remove(self.shangZhenFang, 1)
    end

    if #self.shangZhenGong > 0 and self.shangZhenGong[1].m_atkFormFlagTemp == 2 then
        self.HeroDatas[#self.HeroDatas+1] = self.shangZhenGong[1]
        table.remove(self.shangZhenGong, 1)
    end
    if #self.shangZhenGong > 0 and self.shangZhenGong[1].m_atkFormFlagTemp == 3 then
        self.HeroDatas[#self.HeroDatas+1] = self.shangZhenGong[1]
        table.remove(self.shangZhenGong, 1)
    end

    if #self.shangZhenFang > 0 and self.shangZhenFang[1].m_defFormFlagTemp == 2 then
        self.HeroDatas[#self.HeroDatas+1] = self.shangZhenFang[1]
        table.remove(self.shangZhenFang, 1)
    end

    if #self.shangZhenFang > 0 and self.shangZhenFang[1].m_defFormFlagTemp == 3 then
        self.HeroDatas[#self.HeroDatas+1] = self.shangZhenFang[1]
        table.remove(self.shangZhenFang, 1)
    end

    if #self.shangZhenGong > 0 then
        for k, v in pairs(self.shangZhenGong) do
            self.HeroDatas[#self.HeroDatas+1] = v
        end
    end

    if #self.shangZhenFang > 0 then
        for k, v in pairs(self.shangZhenFang) do
            self.HeroDatas[#self.HeroDatas+1] = v
        end
    end
    
    --接入未上阵武将
    self:wei_Sort()

    if #self.shangZhenWei > 0 then
        for k, v in pairs(self.shangZhenWei) do
            self.HeroDatas[#self.HeroDatas+1] = v
        end
    end

local opop = self.HeroDatas
    --排序后对武将进行分组
    self:sort_fen_zhu()
    --排序后再对武将进行上阵与否的分组(修改上阵排序时屏蔽)
    --HeroCardData:card_fen_zhu()
end

--攻击阵型排序
function HeroCardData:gong_sort(data)
    local comp = function(left , right)
        if right.m_atkFormFlagTemp > left.m_atkFormFlagTemp then
            return true
        else
            return false
        end
    end
    table.sort(data, comp)
end

--防御阵型排序
function HeroCardData:fang_sort(data)
    local comp = function(left , right)
        if right.m_defFormFlagTemp > left.m_defFormFlagTemp then
            return true
        else
            return false
        end
    end
    table.sort(data, comp)
end

--删除武将
function HeroCardData:subCard()

end

--判断武将是否可以进阶
function HeroCardData:CardClassUP(id,class)
    assert(id,"Card Class UP id nil")
    assert(class,"Card Class UP class nil")
    local num = self:getHaveHeroNum(id)
    --num减一是因为它要算上本身，
    if g_csBaseCfg.upCardCount[class] > num then
        return true
    else
        return false
    end
end


function HeroCardData:saiXuan(data)

    --小于最高阶数的武将才能进阶
    if data.m_class > #g_csBaseCfg.upLevel then
        return true
    end
    
    local class = data.m_class
    local level = data.m_level
	local money = PlayerData.eventAttr.m_money
	local soul = PlayerData.eventAttr.m_soul
	
	
    if class == 1 and (level < g_csBaseCfg.upLevel[class]) then
        return true
    end
        
    if class == 2 and (level < g_csBaseCfg.upLevel[class]) then
        return true
    end
    
    if class == 3 and (level < g_csBaseCfg.upLevel[class] or self:CardClassUP(data.m_id, class)) then
        return true
    end
    if class == 4 and ( level < g_csBaseCfg.upLevel[class] or self:CardClassUP(data.m_id, class)) then
        return true
    end
    
    if class == 5 and (level < g_csBaseCfg.upLevel[class] or self:CardClassUP(data.m_id, class)) then
        return true
    end
    
    if class == 6 and (level < g_csBaseCfg.upLevel[class] or self:CardClassUP(data.m_id, class)) then
        return true
    end

    return false
end

--获得任务武将
function HeroCardData:getTaskCard(HeroDatas)
    if #HeroDatas == 0 then
        return false
    end
    --清空任务卡
    local taskCard = clone(HeroDatas)
    
    local task = CityData:getTaskOldCard()
    for p, j in pairs(task) do
        for k, v in pairs(taskCard) do
            if v.m_mark == j then
                table.remove(taskCard,k)
                break
            end
        end
    end
    return taskCard
end

--获得经验转移武将
function HeroCardData:getExpCard(HeroDatas)
    if #HeroDatas == 0 then
        return false
    end
    --清空任务卡
    local ExpHero = clone(HeroDatas)

    local ExpCard = ExpTransferData:getExpHero()
    for p, j in pairs(ExpCard) do
        for k, v in pairs(ExpHero) do
            if v.m_mark == j then
                table.remove(ExpHero,k)
                break
            end
        end
    end
    return ExpHero
end

--获取所有武将
function HeroCardData:getAllHeroData(filterHander,filterCondition)
    if filterHander ~= nil then
        return filterHander(self.HeroDatas,filterCondition)
    else
        return self.HeroDatas
    end
end
--获取力武将
function HeroCardData:getliHeroData(filterHander,filterCondition)
    if filterHander ~= nil then
        return filterHander(self.liHeroDatas,filterCondition)
    else
        return self.liHeroDatas
    end
end

--获取术武将
function HeroCardData:getShuHeroData(filterHander,filterCondition)
    if filterHander ~= nil then
        return filterHander(self.shuHeroDatas,filterCondition)
    else
        return self.shuHeroDatas
    end
end

--获取谋武将
function HeroCardData:getMouHeroData(filterHander,filterCondition)
    if filterHander ~= nil then
        return filterHander(self.mouHeroDatas,filterCondition)
    else
        return self.mouHeroDatas
    end
end

--获取医武将
function HeroCardData:getYiHeroData(filterHander,filterCondition)
    if filterHander ~= nil then
        return filterHander(self.yiHeroDatas,filterCondition)
    else
        return self.yiHeroDatas
    end
end
--获取真阶以上的卡牌
function HeroCardData:getBigClass()
    local filterData = {}
    for i=1,#self.HeroDatas do
        local bigClass = Functions.formatHeroClass(self.HeroDatas[i].m_class)
        if bigClass > 1 then
            filterData[#filterData+1] =  self.HeroDatas[i]
        end
    end
    return filterData
end
--获取准备出售，但未选武将
function HeroCardData:getWillSellHeroData(card)
    self.WillSellHeroDatas = {}
    for k, v in pairs(card) do
        --不为上阵武将，不为正在做主城任务和卡，才能加数量
        local taskHreo = CityData:getTaskHoreInfo()
        local _task = true
        for q,w in pairs(taskHreo) do
            if v.m_mark == w then
                _task = fasle
                break
            end
        end
        if _task and ((card[k].m_atkFormFlagTemp == 0) and (card[k].m_defFormFlagTemp == 0))  then
            self.WillSellHeroDatas[#self.WillSellHeroDatas+1] = v
        end
    end
    return self.WillSellHeroDatas
end

--获取背包最大容量
function HeroCardData:getBagBaseSize()
    return self.m_BagBaseSize
end

--获取选中要出售武将
function HeroCardData:getPickSellHeroData(card)
    
end


--获取没上阵相同id武将个数
function HeroCardData:getHaveHeroNum(id)
    local card = self.HeroDatas
    local num = 0
    for k, v in pairs(card) do
        if v.m_id == id and v.m_atkFormFlagTemp == 0 and v.m_defFormFlagTemp then
            num = num + 1
        end
    end
    return num
end

--通过武将mark得到id
function HeroCardData:getHeroID(mark)
    local id = 0
    for k, v in pairs(self.HeroDatas) do
    	if mark == v.m_mark then
            id = v.m_id
    	end
    end
    return id
end

--通过武将mark得到强化次数
function HeroCardData:getHeroClass(mark)
    local class = 0
    for k, v in pairs(self.HeroDatas) do
        if mark == v.m_mark then
            class = v.m_class
        end
    end
    return class
end

--改变武将任务状态
function HeroCardData:setHeroTask(mark, task)
    for k, v in pairs(self.HeroDatas) do
        if mark == v.m_mark then
            v.m_task = task
        end
    end
end

--通过武将mark得到武将所有信息
function HeroCardData:getHeroInfo(mark)
    local info = {}
    for k, v in pairs(self.HeroDatas) do
        if mark == v.m_mark then
            info = v
        end
    end
    return info
end
--添加某个武将的等级
function HeroCardData:addHeroCardLevel(mark,addLevel)
    local info = self:getHeroInfo(mark)
    info.m_level = info.m_level + addLevel
end
--删除武将
function HeroCardData:getSellHeroData(card)
    local data = self.HeroDatas
    for y, u in pairs(card) do
        for k, v in pairs(data) do
            if u.m_mark == v.m_mark then
    			table.remove(data, k)
    		end
    	end
    end
    local wei = self.shangZhenWei --未上阵的卡片
    for y, u in pairs(card) do
        for k, v in pairs(wei) do
            if u.m_mark == v.m_mark then
                table.remove(wei, k)
            end
        end
    end
    
    --出售卡片之后，清空所有类型的卡片
    self.liHeroDatas = {}
    self.shuHeroDatas = {}
    self.mouHeroDatas = {}
    self.yiHeroDatas = {}
    
    for k, v in pairs(data) do
        if ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.LI then
            self.liHeroDatas[#self.liHeroDatas+1] = v
        elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.SHU then
            self.shuHeroDatas[#self.shuHeroDatas+1] = v
        elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.MOU then
            self.mouHeroDatas[#self.mouHeroDatas+1] = v
        elseif ConfigHandler:getHerTypeId(v.m_id) == HeroCardData.HeroType.YI then
            self.yiHeroDatas[#self.yiHeroDatas+1] = v
        end
    end
end
function HeroCardData:filterHeroOfSameId(heroData,id)
    local filterData = {}
    for i=1,#heroData do
        if heroData[i].m_id == id then
            filterData[#filterData+1] =  heroData[i]
        end
    end
    return filterData
end
--根据 mark(背包标识) 获取玩家已有武将的信息
function HeroCardData:searchHeroOfMark(mark)
    for i=1,#self.HeroDatas do
        if self.HeroDatas[i].m_mark == mark then
            return self.HeroDatas[i]
        end
    end  
end
--根据英雄Id与布阵类型及阵型模式获得英雄信息
function HeroCardData:getHeroMark( heroId, embattleType, embattleMode )
    for i=1,#self.HeroDatas do
        if embattleMode == 1 then
            if self.HeroDatas[i].m_id == heroId  and self.HeroDatas[i].m_atkFormFlagTemp == embattleType then
               return self.HeroDatas[i] 
            end
        elseif embattleMode == 2 then
            if self.HeroDatas[i].m_id == heroId  and self.HeroDatas[i].m_defFormFlagTemp == embattleType then
               return self.HeroDatas[i] 
            end
        end
    end
end

--卡包数据变动
function HeroCardData:cardsDataChange(data)
    local event = { name = HeroCardData.CARDS_DATA_CHANGE_EVENT, data = data }
    GameEventCenter:dispatchEvent(event)   --发送背包数据改变事件
end
return HeroCardData