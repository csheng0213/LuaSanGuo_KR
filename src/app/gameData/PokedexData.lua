local BaseModel = require("app.baseMVC.BaseModel")

local PokedexData = class("PokedexData", BaseModel)

PokedexData.debug = false

function PokedexData:init()
    --self.super.init(self)

    self.PokedexDatas = {}     --总卡片数据
    self.weiHeroDatas = {}
    self.shuHeroDatas = {}
    self.wuHeroDatas = {}
    self.qunHeroDatas = {}
    
    self.HeroIconDatas = {}     --君主头像  
    
    self.Refresh = false

--    local sortEvent = function(event)
--        self:card_fen_zhu()
--        self:card_sort()
--    end
--    GameEventCenter:addEventListener(HeroCardData.CARDS_DATA_SORT_EVENT, sortEvent)


end

function PokedexData:sendServerPokedex(listener)
    local onServerPokedex = function(event)
    
        self.PokedexDatas = {}
        self.weiHeroDatas = {}
        self.shuHeroDatas = {}
        self.wuHeroDatas = {}
        self.qunHeroDatas = {}
        self.HeroIconDatas = {}     --君主头像 
        local data = event.cardState 
            
        for k, v in pairs(data) do
            local info = {}
            info.m_id = v.id
            info.m_class = v.class
--            info.m_atkFormFlagTemp = 0
--            info.m_defFormFlagTemp = 0
            info.m_state = v.state
            info.m_star = ConfigHandler:getHeroStarCountOfId(v.id)
            info.m_sum = ConfigHandler:getHeroWuliId(v.id) + ConfigHandler:getHeroZhiliId(v.id) + ConfigHandler:getHeroTongyuId(v.id)
            if v.state == 1 then
                self.HeroIconDatas[#self.HeroIconDatas + 1] = info
            end
            self.PokedexDatas[#self.PokedexDatas + 1] = info
        end
        self:sort(self.PokedexDatas)
        self:sort(self.HeroIconDatas)
        self:card_fen_zhu()
        listener(event)
    end

    NetWork:addNetWorkListener({27,1}, Functions.createNetworkListener(onServerPokedex,true,"ret"))
    local msg = {idx = {27, 1}}
    NetWork:sendToServer(msg)
end
--排序
function PokedexData:sort(data)
    local comp = function(left , right)
    
        --星级
        if left.m_star > right.m_star then
            return true
        elseif left.m_star < right.m_star then
            return false
        end
        --三项属性和
        if left.m_sum > right.m_sum then
            return true
        elseif left.m_sum < right.m_sum then
            return false
        end
        --人物id
        if left.m_id > right.m_id then
            return true
        else
            return false
        end
    end
    table.sort(data,comp)
	
end
--分组
function PokedexData:card_fen_zhu()

    for k, v in pairs(self.PokedexDatas) do
        if ConfigHandler:getHeroCountryOfId(v.m_id) == 1 then
            self.shuHeroDatas[#self.shuHeroDatas + 1] = v
        elseif ConfigHandler:getHeroCountryOfId(v.m_id) == 2 then
            self.wuHeroDatas[#self.wuHeroDatas + 1] = v
        elseif ConfigHandler:getHeroCountryOfId(v.m_id) == 3 then
            self.weiHeroDatas[#self.weiHeroDatas + 1] = v
        elseif ConfigHandler:getHeroCountryOfId(v.m_id) == 4 then
            self.qunHeroDatas[#self.qunHeroDatas + 1] = v
        end
    end
end
--获取所有图鉴
function PokedexData:getPokedexDatas()
    return self.PokedexDatas
end

--获取所有图鉴
function PokedexData:getweiHeroDatas()
    return self.weiHeroDatas
end

--获取所有图鉴
function PokedexData:getshuHeroDatas()
    return self.shuHeroDatas
end

--获取所有图鉴
function PokedexData:getwuHeroDatas()
    return self.wuHeroDatas
end

--获取所有图鉴
function PokedexData:getqunHeroDatas()
    return self.qunHeroDatas
end

--获取君主头像
function PokedexData:getHeroIconDatas()
    return self.HeroIconDatas
end

--获取显示图鉴类型
function PokedexData:getcardState()
    return self.cardState
end

--图鉴已收集个数
function PokedexData:getPokedexNum(data)
    local sum = 0
    for k,v in pairs(data) do
        if v.m_state == 1 then
        	sum = sum + 1
        end
    end
    return sum
end

--图鉴是否点亮
function PokedexData:getLight(id)
    local switch = false
    for k,v in pairs(self.PokedexDatas) do
        if v.m_id == id then
            if v.m_state == 0 then
                v.m_state = 1
                --不管合成几张武将，只要点亮了一个图鉴，那么上个界面就要刷新
                self.Refresh = true
            end
            break
        end
    end
end

return PokedexData