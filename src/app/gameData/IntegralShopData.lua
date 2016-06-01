local BaseModel = require("app.baseMVC.BaseModel")

local IntegralShopData = class("IntegralShopData", BaseModel)

IntegralShopData.debug = false

IntegralShopData.SELL_UP = "SELL_UP"

IntegralShopData.eventAttr.m_isNewShop = false

function IntegralShopData:ctor()

    --积分商城道具属性
    self.m_DebrisIndex = 0             --碎片索引(因为有可能是二个相同的碎片,那么ID就是一样的，不能进行购买的判断)
    self.m_DebrisID = 0                --道具ID
    self.m_DebrisType = 0              --道具类型
    self.m_DebrisCount = 0             --购买数量
    self.m_DebrisPrice = 0             --道具价格
    self.b_DebrisBuy = 0               --是否购买过(0:没有购买过。1：购买过)

	self:init()
end


function IntegralShopData:init()
    self.super.init(self)

    --商城主数据
    self.IntegralShopDatas = {}
    
end

--清空申请数据
function IntegralShopData:clearIntegralShopData()
    self.IntegralShopDatas = {}
end

--数据存放
function IntegralShopData:addIntegralShopData(data)
    self.IntegralShopDatas[#self.IntegralShopDatas+1] = data
end

--获取主数据
function IntegralShopData:getIntegralShopData()
    return self.IntegralShopDatas
end

return IntegralShopData