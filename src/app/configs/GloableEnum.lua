
CombatType = 
{
    RB_Down = 0,
    RB_PVPPlayerList = 1, -- pvp
    RB_PVPPlayerData = 2,
    RB_PVPHistory= 3,  -- zhanbao
    RB_PVPHistoryData = 4, -- pvp history data
    
    RB_PVE = 5, -- pve
    RB_ElitePVE = 6,
    RB_BloodyBattle = 7, -- xuezhan
    RB_HeroTrial = 8,
    RB_Tandui = 9, -- tuandui
    RB_guide = 10,
}

UIZOrder = 
{
    ZOrder_UI = 0,
    ZOrder_Common = 1,
    ZOrder_qiandao = 2,
    ZOrder_mail = 2,
    ZOrder_GameSet = 2,
    ZOrder_herosInfo = 4,
    ZOrder_prompt_box = 5,
    ZOrder_Speaker = 6 ,
    ZOrder_prompt_Tips = 7,
}

ErrorCode = 
{
    OK = 1,     --执行操作成功
    Error = 2,  -- 系统错误
    GFalse = 3, -- 执行操作失败
    -- 兵营
    SoldierFull = 500, --招募士兵已满
    SoldierLevelFull = 501, --士兵强化等级已满不能升级
    SoldierLevelNotFull = 502, --士兵强化等级未满不能升阶
    SoldierNoOne = 503, --没有士兵不能遣散士兵
    -- 强化
    LackSoul = 504, --缺少武魂
    ClassFull = 505, --阶数已满
    QualityNotLegal = 506, --卡牌品质不合法
    SoldierFreeFull = 507, --每天免费招兵次数已满
    -- 主城税收
    LackTaxCount = 508, --主城税收次数已完毕
    FuncNotOpen = 509, --当前功能暂未开放
    LackTianTiCount = 510, --缺少天梯挑战次数
    LackTianTiVipCount = 511, --缺少天梯挑战VIP购买次数
    LackLevel = 512, --缺少等级
    -- 玩家名字
    NameRepeat = 513, --重名
    NamEillegal = 514, --名字不合法
}

ItemType =
{
    HeroCard = 1,
    Prop = 4,
    CardFragment = 5
}


--登陆类型
LoginType = 
{
    Local_Login = 0,
    Sdk_Login = 1,
}

--资源图片
ResImageTable = 
{
    [-2] = "yuanbao",
    [-3] = "jinbi",
    [-4] = "jitui",
    [-5] = "soul",
    [-6] = "hunjin",
    [-7] = "jifen",
}

--tyj start
--场景跳转类型
JumpType = 
{
   EmbattleToSelectHero = 0, --布阵<>选将
   PartHeroToSelectHero = 1, --偏将<>选将
   SevenStarToSelectHero = 2, --七星坛<>选将
   MainCityToSelectHero = 3,--主城<>选将
   equipToEmbattle = 4, --装备<>布阵
   ExpChangeToSelectHero = 5, --经验转移<>选将
      
   ExpChangeToProp = 6, --经验转移<>道具
   HeroUpgradeToSelectHero = 7, --英雄升级<>道具
}

--tyj end