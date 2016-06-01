local ShopData = {}

ShopData.debug = false

ShopData.BUY_DATA = "BUY_DATA"

ShopData.BUY_REFRESH_CHANGE = "BUY_REFRESH_CHANGE"

ShopData.REFRESH_CHANGE = "REFRESH_CHANGE"

function ShopData:init()

    --商城主数据
    self.shopDatas = {}
    --商城刷新次数
    self.shopRefreshCount = 0
    self.nextFreshTime = 0
    
    local onRefreshShop = function (event)
        local data = event.data
        self:clearShopData()--清空商城数据
        for k, v in pairs(data) do
            self:addShopData(v,k)
        end
        self.nextFreshTime = event.nextFreshTime
        --购买后数据更新监听
        GameEventCenter:dispatchEvent({ name = ShopData.REFRESH_CHANGE, data = {} })
    end
    NetWork:addNetWorkListener({ 5, 20 }, onRefreshShop)
    
--    --倒计时
--    local onCountdown = function (event)
--        local data = event.data
--
--    end
--    NetWork:addNetWorkListener({ 5, 20 }, onCountdown)
    
end

--清空申请数据
function ShopData:clearShopData()
    self.shopDatas = {}
end

--数据存放
function ShopData:addShopData(data,k)
    
    local shopInfo         = Factory.createShopModel()
    shopInfo.m_Idx = k                      --物品索引
    shopInfo.m_ItemID = data[1]             --道具ID
    shopInfo.m_ItemType = data[2]           --道具类型(1为卡片，4为道具,5-武将碎片)                    
    shopInfo.m_MoneyType = data[3]          --金钱类型（1-元宝，2-普通钱币,3-魂晶）
    shopInfo.m_ItemPrice = data[4]          --道具价格
    shopInfo.m_ItemNum = data[5]            --道具数量
    shopInfo.m_ItemState = data[6]          --道具状态（1－可以买，0－不可以买）

    
    
--    shopInfo.m_ItemClassify = data[5]       --道具显示分类
--    shopInfo.m_LimitCount = data[6]         --每天限制购买数
--    shopInfo.m_LimitIndex = data[7]         --限制索引
    --shopInfo.eventAttr.m_BuyCount = data[8]           --现在已经购买个数
    
    self.shopDatas[#self.shopDatas+1] = shopInfo
end

--获取主数据
function ShopData:getShopDatas()
    return self.shopDatas
end

--获取倒计时
function ShopData:getCountdown()
    return self.nextFreshTime
end

return ShopData