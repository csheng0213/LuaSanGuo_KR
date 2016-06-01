--
-- AdbirxIntent = require("app.sdk.IGAWorksAdbrixIntent") 

--初始化玩家相关数据
PlayerData = require("app.gameData.PlayerData")
PlayerData:init()

--加载新手引导模块
GuideManager = require("app.common.GuideManager")
GuideManager:init()

--初始化任务数据
TaskData = require("app.gameData.TaskData")
TaskData:init()


--初始化广播数据
SpeakerData = require("app.gameData.SpeakerData")
SpeakerData:init()

--初始化领奖数据
RewardData = require("app.gameData.RewardData")
RewardData:init()

--初始化领奖状态数据
RewardStateData = require("app.gameData.RewardStateData")
RewardStateData:init()
--初始化Vip数据
VipData = {}
if G_SDKType == 2 then 
    VipData = require("app.gameData.Tstore_VipData")
elseif G_SDKType == 3 then 
    VipData = require("app.gameData.Cstore_VipData")
elseif G_SDKType == 4 then 
    VipData = require("app.gameData.Gplay_VipData")
elseif G_SDKType == 5 then 
    VipData = require("app.gameData.Astore_VipData")
else
    VipData = require("app.gameData.VipData")
end
VipData:init()
--初始化活动数
ActivityData = require("app.gameData.ActivityData")
ActivityData:init()
--初始化道具数据
PropData = require("app.gameData.PropData")
PropData:init()

--初始化装备数据
EquipmentData = require("app.gameData.EquipmentData")
EquipmentData:init()

--初始化战斗配置表
ConfigHandler = require("app.common.ConfigHandler")
ConfigHandler:init()

--初始化工会
UnionData = require("app.gameData.UnionData")
UnionData:init()

--初使化武将
HeroCardData = require("app.gameData.HeroCardData")
HeroCardData:init()

--初始化商店数据
ShopData = require("app.gameData.ShopData")
ShopData:init()

--初始化七星坛数据
SevenStarData = require("app.gameData.SevenStarData")
SevenStarData:init()

--初始化布阵数据
EmbattleData = require("app.gameData.EmbattleData")
EmbattleData:init()

--初始化天梯数据
TianTiData = require("app.gameData.TianTiData")
TianTiData:init()

--初始化试炼数据
HeroShiLianData = require("app.gameData.HeroShiLianData")
HeroShiLianData:init()

--初始化血战数据
XueZhanData = require("app.gameData.XueZhanData")
XueZhanData:init()

--初始化合成
CompoundData = require("app.gameData.CompoundData")
CompoundData:init()

--初始化积分商城
IntegralShopData = require("app.gameData.IntegralShopData")
IntegralShopData:init()

--初始化世界聊天
ChatData = require("app.gameData.ChatData")
ChatData:init()

--初始化充值优惠
DiscountData = require("app.gameData.DiscountData")
DiscountData:init()

--初始化招募
EnlistData = require("app.gameData.EnlistData")
EnlistData:init()

--初始化升级
EnhanceData = require("app.gameData.EnhanceData")
EnhanceData:init()

--士兵培养
SoldiersData = require("app.gameData.SoldiersData")
SoldiersData:init()

--主城任务
CityData = require("app.gameData.CityData")
CityData:init()

--初使化图鉴
PokedexData = require("app.gameData.PokedexData")
PokedexData:init()

--初使化邮件
MailData = require("app.gameData.MailData")
MailData:init()

--初使化排行
RankData = require("app.gameData.RankData")
RankData:init()

--初始化公会战
GuildBattleData = require("app.gameData.GuildBattleData")
GuildBattleData:init()

--初始化经验转移
ExpTransferData = require("app.gameData.ExpTransferData")
ExpTransferData:init()

--初始化战斗中心
CombatCenter = require("app.ui.combatSystem.model.CombatCenter")



---------
--初始化战斗数据
BiographyData = require("app.gameData.BiographyData")
BiographyData:init()


--调试，输出内存信息
local sharedScheduler = cc.Director:getInstance():getScheduler()
if DEBUG_MEM then
    local sharedTextureCache = cc.Director:getInstance():getTextureCache()
    --[[--
    @ignore
    ]]
    local function showMemoryUsage()
        printf(string.format("LUA VM MEMORY USED: %0.2f KB", collectgarbage("count")))
        printf(sharedTextureCache:getCachedTextureInfo())
        printf("---------------------------------------------------")
    end
    sharedScheduler:scheduleScriptFunc(showMemoryUsage, DEBUG_MEM_INTERVAL or 10.0, false)
end
--ui 扩展
require("app.common.UiExtend")


return true


