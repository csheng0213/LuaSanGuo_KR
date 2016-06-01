g_errorCode = 
    {
        OK = 1,                         --执行操作成功
        Error = 2,                      --系统错误
        GFalse = 3,                     --不允许执行该操作

        --培养系统
        BlankCardValid = 4,             --白卡已在培养中
        BlankCardInvalid = 5,           --白卡进入培养中
        BlankCardTrained = 6,           --白卡已在培养中，已被培养过
        ForeverLoopError = 7,           --循环意外出错
        TrainedCD = 8,                  --培养CD中
        TrainedOver = 9,                --培养次数已经用完
        ConfigError = 10,               --配置错误
        PropertyMaxValue = 11,          --培养属性到达最大值
        SingleTrainMaxCount = 12,       --属性到达最大培养次数
        TrainedCountLack = 13,          --培养次数不够鉴定
        DailyTrainedCountMax = 14,      --每日培养数到达上限 

        --玩家数据相关
        LevelMax = 15,                  --等级达到最高
        LackGold = 16,                  --缺少金币
        LackMoney = 17,                 --缺少金钱
        LackEnergy = 18,                --缺少体力
        PassLimit = 19,                 --关联关卡未通过
        LackFight = 20,                 --缺少战斗力
        LackItem = 21,                  --缺少物品

        --卡片相关
        FighterAmountMax = 22,          --可装备战斗角色卡数量达到最大
        FighterSoltFull = 23,           --战斗位置已有角色卡
        LackFighterSlot = 24,           --缺少可用角色卡位置
        FighterSlotEmpty = 25,          --战斗位置为空
        EquipSlotEmpty = 26,            --装备位置为空
        SkillSlotEmpty = 27,            --技能位置为空
        LackEquipSlot = 28,             --缺少可用装备卡位置
        LackSkillSlot = 29,             --缺少可用技能卡位置
        EquipAmountMax = 30,            --可装备装备卡数量达到最大
        SkillAmountMax = 31,            --可装备技能卡数量达到最大

        --通用
        CardIDInvalid = 40,             --卡片id无效，卡牌配置表无对于id

        --关卡
        DailyLimit = 50,                --每日限制
        LevelLimit = 51,                --等级限制
        TimeLimit = 52,                 --时间限制
        FightLimit = 53,                --战斗力限制

        --背包物品
        BagTypeError = 60,              --背包类型错误，只有四种背包类型
        ItemSlotError = 61,             --物品位置错误，该位置超出了最大背包数
        SlotHasNoItem = 62,             --Slot位置上没有物品
        SlotHasItem = 63,               --该位置上已有物品
        AboveItemOverlap = 64,          --超出物品最大叠加数
        BagFull = 65,                   --背包已满  
        BagNotEnough = 66,              --背包不够
        GoodsNotEnough = 67,            --物品不够
        ItemNoUseFunc = 68,             --物品没有配置使用函数
        NotDeleteItem = 69,             --使用物品后不用删除物品
        IndexOutOfRange = 70,           --索引超出范围
        LevelFull = 71,                 --满级
        ItemDailyLimitFull = 72,        --该道具每日使用次数已满
        ItemDailyLimitFullVip = 73,     --该道具每日使用次数已满，提升vip等级可以增加每日使用次数
        ItemLimitLevel = 74,            --等级


        --建筑系统相关
        PlayerLevelLack = 80,           --玩家等级不够
        BuildingNotExist = 81,          --没有该建筑
        BuildingUpgrading = 82,         --建筑正在升级
        BuildingLevelMax = 83,          --建筑达到最高等级
        BuildingUpgradingMax = 84,      --同时升级建筑数达到最大值
        BuildingNotOpened = 85,         --建筑还未打开
        BuildingResNotEnough = 86,      --资源不够
        BuildingLevelNotEnough = 87,    --相关建筑等级不够

        --强化
        StudyCountFull = 100,           --当日可学习次数已满
        SchoolLevelLimit = 101,         --受学校等级限制
        StrenthenTypeLimit = 102,       --强化操作类型限制
        CannotStrengthen = 103,         --无法强化(系统不允许)
        LevelNotEnough = 104,           --等级不足以进行该操作

        --商城
        GoodsInfoNotRight = 130,        --购买物品与服务器不一致，要求客户端重新打开商城面板进行购买
        GoodsBuyFull = 131,             --物品购买数量已满
        GoodsNotBuyNext = 132,          --等级或者vip等级不够，不允许购买下一级物品
        GoodsLackVip = 133,             --vip等级不够，不允许购买物品

        -- 帮派相关
        TongExist = 151,            -- 帮派已存在
        TongNotExist = 152,         -- 帮派不存在
        JoinedTong = 153,           -- 已经加入一个帮派
        NotJoinedTong = 154,        -- 还没有加入帮派
        MemberExist = 155,          -- 帮派成员已存在
        MemberNotExist = 156,       -- 帮派成员不存在
        MemberFull = 157,           -- 帮派成员已满

        -- PVP相关
        PVPPlayerNotExists = 181,   -- 玩家不存在
        PVPInFight = 182,           -- 玩家正在被攻击

        --培养系统扩展
        TrainInFreeCD = 200,            --免费刷新在CD中
        TrainFreeCountFull = 201,       --免费刷新次数满了

        --好友系统
        FrdNoPlayer = 250,                  --没有这个玩家
        FrdRequestFull = 251,               --玩家好友请求已满
        FrdRequestRepeat = 252,             --玩家好友请求已有
        FrdUpdateDataFailed = 253,          --更新好友数据失败
        FrdDataError = 254,                 --玩家好友数据错误，或者玩家传过来的玩家id错误
        FrdFriendRepeat = 255,              --已经添加了该玩家
        FrdFriendFull = 256,                --玩家好友已满
        FrdNoThisFriend = 257,              --玩家没有该好友
        FrdNoThisFrdRequest = 258,          --玩家没有该好友请求
        FrdFrdepeat = 259,                  --玩家已有该好友
        FrdRequestRev = 260,                --玩家已经收到过该玩家的加友请求
        FrdBeSelf = 261,                    --不能添加自己为好友

        --出售分解等相关
        SellRoleAlreadyEquip = 280,             --角色卡已上阵
        SellRoleAlreadySee = 281,               --角色卡已监工
        SellEquipAlreadyEquip = 282,            --装备已装备不能分解

        --人才市场
        MktFreeCountFull = 300,                 --免费刷新次数到达上限
        MktFreeCD = 301,                        --免费刷新cd中
        MktSellCountFull = 302,                 --出售次数到达当日上限
        MktQualityError = 303,                  --卡片品质不对
        MktUseFlagError = 304,                  --卡片已上阵
        MktSeeFlagError = 305,                  --卡片已监工

        --碎片
        FragLack = 320,                         --碎片数量不够合成
        FragIDToSlotInvalid = 321,              --碎片ID无对应的图鉴slot

        --VIP
        VipPassCountFull = 340,                 --当日vip刷新关卡数已满
        VipLackRecharge = 341,                  --没有充值过
        VipPvpCountFull = 342,                  --当日vip刷新pvp数已满
        VipRechargeNotEnough = 343,             --充值不足
        VipAlreadyGet = 344,                    --已经领取过奖励

        --活动
        ACTAlreadyGetLV = 360,                  --已经领取了 送vip
        ACTAlreadyGetTE = 361,                  --已经领取了 体力
        ACTTimeOutTE = 362,                     --不在领取时间
        ACTRefreshFullEM = 363,                 --金币刷新次数满了
        ACTRefreshFullEG = 364,                 --元宝刷新次数满了
        ACTRefreshCDEM = 365,                   --金币刷新cd
        ACTRefreshCDEG = 366,                   --元宝刷新cd
        ACTExchangeFullEM = 367,                --金币兑换次数满了
        ACTExchangeFullEG = 368,                --元宝兑换次数满了
        ACTLackRefreshEM = 369,                 --还未刷新
        ACTLackRefreshEG = 370,                 --还未刷新
        ACTLackLv = 371,                    


        --其他
        FuncNotOpenTrain = 400,                     --培养功能未开放
        FuncNotOpenBuildRes = 401,                  --收资源功能暂未开放
        FuncNotOpenPVP = 402,                       --pvp功能暂未开放
        FuncNotOpenBuildLevelUp = 403,              --升级建筑功能暂未开放
        FuncNotOpenLoginSample = 404,               --登陆领奖活动功能暂未开放
        FuncNotOpenSampleCard = 405,                --抽卡活动功能暂未开放
        FuncNotOpenRoleLevelUp = 406,               --角色卡强化等级活动功能暂未开放
        FuncNotOpenExchangeGold = 407,              --元宝兑换功能暂未开放
        FuncNotOpenGetEnergy = 408,                 --领取体力功能暂未开放
        FuncNotOpenMarket = 409,                    --人才市场功能暂未开放
        FuncNotOpenFriend = 410,                    --好友功能暂未开放
        FuncNotOpen = 411,      --该功能未到达开启等级

        AutoFightLackLevel = 420,                   --自动战斗等级不够
        LackSampleType1Level = 421,                 --低级抽卡等级不够
        EnergyFull = 422,                           --体力已满

        --
        SoldierFull = 500,      --招募士兵已满
        SoldierLevelFull = 501,     --士兵强化等级已满不能升级
        SoldierLevelNotFull = 502,  --士兵强化等级未满不能升阶
        SoldierNoOne = 503, --没有士兵不能遣散士兵

        LackSoul = 504, --缺少武魂
        ClassFull = 505, --阶数已满
        QualityNotLegal = 506, --卡牌品质不合法
        SoldierFreeFull = 507,  --每天免费招兵次数已满

        LackTaxCount = 508, --主城税收次数已完毕
        FuncNotOpen = 509,  --当前功能暂未开放
        LackTianTiCount = 510,  --缺少天梯挑战次数
        LackTianTiVipCount = 511,   --缺少天梯挑战VIP购买次数
        LackLevel = 512,            --缺少等级

        NameRepeat = 513,   --重名
        NameIllegal = 514,  --名字不合法

        --天梯
        AltarFull = 515,    --天梯已满
        AltarLackOfEvo = 516, --进化数不够
        AltarBoxNotOpen = 517, --对应的印没有开启
        AltarNoBox = 518, --没有印

        MsnAwardHadGot = 519, --任务已经领奖
        MsnLackOfScore = 520, --活力值不足，不能领取这个奖励

        AwardAlreadyGet = 521, --已经领取过奖励
        LackOfAward = 522, --领取奖励条件还不够

        SSGoodsOver = 523, --物品已经购买完毕
        SSLackScore = 524, --缺少积分

        -- 邮件
        AlreadyFetched = 550,   -- 物品已经领取
        InvalidIndex   = 551,   -- 无效的索引

        -- 英雄试练
        NotAvailableToday = 560,    -- 此类型英雄试练在今天无效
        RoleCardAwarded   = 561,    -- 此卡片已获得
        TrailEnergyLack   = 562,    -- 体力不足

        LackCount = 570,    -- 操作次数不够

        -- 公会系统
        GuildAlreadyRequestGuild        = 580,      -- 已经申请加入该公会
        GuildNotExists                  = 581,      -- 公会不存在
        GuildCannotJoin                 = 582,      -- 不能加入该公会
        GuildRequestCountMax            = 583,      -- 公会请求人数已满
        GuildThisDayRequestMax          = 584,      -- 当天请求加入公会数量已满
        GuildAlreadyJoinedGuild         = 585,      -- 已经加入公会
        GuildCannotFindGuild            = 586,      -- 无法找到指定公会
        GuildNameLengthOverFlow         = 587,      -- 会公名字过长
        GuildNotEnoughGold              = 588,      -- 元宝不足
        GuildDidNotJoinGuild            = 589,      -- 没有加入任何公会
        GuildNotEnoughAuth              = 590,      -- 没有足够的权限
        GuildHasOtherMember             = 591,      -- 还有其他的公会成员
        GuildMailTitleLengthOverFlow    = 592,      -- 邮件标题过长
        GuildMailContentLengthOverFlow  = 593,      -- 邮件内容过长
        GuildNoticeLengthOverFlow       = 594,      -- 公告内容过长
        GuildChatSoFast                 = 595,      -- 聊天速度过快
        GuildChatMessageLengthOverFlow  = 596,      -- 聊天信息过长
        GuildPlayerNotInRequestList     = 597,      -- 不在请求列表之中
        GuildPlayerNotInGuild           = 598,      -- 不在公会之中
        GuildCannotDoOnSelf             = 599,      -- 不能操作自己
        GuildElderCountMax              = 600,      -- 公会长老数量已满
        GuildCannotWorshipSelf          = 601,      -- 不能膜拜自己
        GuildCannotWorshipLowLevel      = 602,      -- 膜拜的大神等级必须高于自己
        GuildTargetPlayerNotInGuild     = 603,      -- 目标玩家不在公会之中
        GuildWorshipCountMax            = 604,      -- 膜拜次数超过限制
        GuildNameExists                 = 605,      -- 公会名字已经存在
        GuildMemberCountMax             = 606,      -- 公会人数已满
        GuildNoRewards                  = 607,      -- 没有奖励
        GuildWorshipMoneyLack           = 608,      -- 金币不足
        GuildTeamCopyOutRange           = 609,      -- 该关卡未开放
        GuildTeamCopyAlreadyOpen        = 610,      -- 副本已开启
        GuildTeamCopyEliteNotPass       = 611,      -- 对应精英副本未通关
        GuildTeamCopyGuildAcitivyLack   = 612,      -- 公会活跃度不足
        GuildTeamCopyPrevLevelNotPassed = 613,      -- 前一关未通关
        GuildTeamCopyNotPurchased       = 614,      -- 副本未购买
        GuildTeamCopyLocked             = 615,      -- 副本已通关
        GuildTeamCopyTimesOverFlow      = 616,      -- 副本挑战次数已满
        GuildTeamCopyPlayerInBattle     = 617,      -- 有其他玩家正在战斗
        GuildAlreadyRequestItem         = 618,      -- 已经申请了该物品
        GuildPlayerNotInItemReqList     = 619,      -- 该玩家不在物品请求列表
        GuildDistributeTimesMax         = 620,      -- 分配物品次数超过最大值
        GuildNotInItemRequestList       = 621,      -- 还未申请副本物品
        GuildNotEnoughMoney             = 622,      -- 金币不足
        GuildAlreadyFistPlace           = 623,      -- 已经在第一的位置
        GuildTeamCopyPrevLevelNotBuy    = 624,      -- 前一关未购买
        GuildTeamCopyItemNotExists      = 625,      -- 物品不存在
        GuildTeamCopyItemLack           = 626,      -- 物品不足

        SoldierLvlTooBig                = 700,      -- 士兵等级不能超过主公等级！

        ChatSendMsgTooFast              = 800,      -- 消息发送速度过快
    }

g_csErrorString = {}
function g_csMakeErrorStr()
    g_csErrorString =
        {
            [g_errorCode.OK] = "执行操作成功",
            [g_errorCode.Error] = "对不起，出现错误了，请尝试其他操作或者重新登录游戏再继续吧。",
            [g_errorCode.GFalse] = "不允许执行该操作",

            --培养系统
            [g_errorCode.BlankCardValid] = "白卡已在培养中",
            [g_errorCode.BlankCardInvalid] = "白卡进入培养中",
            [g_errorCode.BlankCardTrained] = "白卡已在培养中，已被培养过",
            [g_errorCode.ForeverLoopError] = "循环意外出错",
            [g_errorCode.TrainedCD] = "培养CD中",
            [g_errorCode.TrainedOver] = "培养次数已经用完",
            [g_errorCode.ConfigError] = "配置错误",
            [g_errorCode.PropertyMaxValue] = "培养属性到达最大值",
            [g_errorCode.SingleTrainMaxCount] = "属性到达最大培养次数",
            [g_errorCode.TrainedCountLack] = "培养次数不够鉴定",
            [g_errorCode.DailyTrainedCountMax] = "每日培养数到达上限",

            --玩家数据相关
            [g_errorCode.LevelMax] = "等级达到最高",
            [g_errorCode.LackGold] = "缺少元宝",
            [g_errorCode.LackMoney] = "缺少铜钱",
            [g_errorCode.LackEnergy] = "缺少体力",
            [g_errorCode.PassLimit] = "关联关卡未通过",
            [g_errorCode.LackFight] = "缺少战斗力",
            [g_errorCode.LackItem] = "缺少物品",

            --卡片相关
            [g_errorCode.FighterAmountMax] = "可装备战斗角色卡数量达到最大",
            [g_errorCode.FighterSoltFull] = "战斗位置已有角色卡",
            [g_errorCode.LackFighterSlot] = "缺少可用角色卡位置",
            [g_errorCode.FighterSlotEmpty] = "战斗位置为空",  
            [g_errorCode.EquipSlotEmpty] = "装备位置为空",
            [g_errorCode.SkillSlotEmpty] = "技能位置为空",
            [g_errorCode.LackEquipSlot] = "缺少可用装备卡位置",
            [g_errorCode.LackSkillSlot] = "缺少可用技能卡位置",
            [g_errorCode.EquipAmountMax] = "可装备装备卡数量达到最大",
            [g_errorCode.SkillAmountMax] = "可装备技能卡数量达到最大",

            --通用
            [g_errorCode.CardIDInvalid] = "卡片id无效，卡牌配置表无对于id",

            --关卡
            [g_errorCode.DailyLimit] = "每日限制",
            [g_errorCode.LevelLimit] = "等级限制",
            [g_errorCode.TimeLimit] = "时间限制",
            [g_errorCode.FightLimit] = "战斗力限制",

            --背包物品
            [g_errorCode.BagTypeError] = "背包类型错误，只有四种背包类型",
            [g_errorCode.ItemSlotError] = "物品位置错误，该位置超出了最大背包数",
            [g_errorCode.SlotHasNoItem] = "Slot位置上没有物品",
            [g_errorCode.SlotHasItem] = "该位置上已有物品",
            [g_errorCode.AboveItemOverlap] = "超出物品最大叠加数",
            [g_errorCode.BagFull] = "背包已满   ",
            [g_errorCode.BagNotEnough] = "背包不够",
            [g_errorCode.GoodsNotEnough] = "物品不够",
            [g_errorCode.ItemNoUseFunc] = "物品没有配置使用函数",
            [g_errorCode.NotDeleteItem] = "使用物品后不用删除物品",
            [g_errorCode.IndexOutOfRange] = "索引超出范围",
            [g_errorCode.LevelFull] = "满级",
            [g_errorCode.ItemDailyLimitFull] = "该道具每日使用次数已满",
            [g_errorCode.ItemDailyLimitFullVip] = "该道具每日使用次数已满，提升vip等级可以增加每日使用次数",
            [g_errorCode.ItemLimitLevel] = "等级",


            --建筑系统相关
            [g_errorCode.PlayerLevelLack] = "玩家等级不够",
            [g_errorCode.BuildingNotExist] = "没有该建筑",
            [g_errorCode.BuildingUpgrading] = "建筑正在升级",
            [g_errorCode.BuildingLevelMax] = "建筑达到最高等级",
            [g_errorCode.BuildingUpgradingMax] = "同时升级建筑数达到最大值",
            [g_errorCode.BuildingNotOpened] = "建筑还未打开",
            [g_errorCode.BuildingResNotEnough] = "资源不够",
            [g_errorCode.BuildingLevelNotEnough] = "相关建筑等级不够",

            --强化
            [g_errorCode.StudyCountFull] = "当日可学习次数已满",
            [g_errorCode.SchoolLevelLimit] = "受学校等级限制",
            [g_errorCode.StrenthenTypeLimit] = "强化操作类型限制",
            [g_errorCode.CannotStrengthen] = "无法强化(系统不允许)",
            [g_errorCode.LevelNotEnough] = "等级不足以进行该操作",

            --商城
            [g_errorCode.GoodsInfoNotRight] = "购买物品与服务器不一致，要求客户端重新打开商城面板进行购买",
            [g_errorCode.GoodsBuyFull] = "物品购买数量已满",
            [g_errorCode.GoodsNotBuyNext] = "等级或者vip等级不够，不允许购买下一级物品",
            [g_errorCode.GoodsLackVip] = "vip等级不够，不允许购买物品",

            --帮派相关
            [g_errorCode.TongExist] = "帮派已存在",
            [g_errorCode.TongNotExist] = "帮派不存在",
            [g_errorCode.JoinedTong] = "已经加入一个帮派",
            [g_errorCode.NotJoinedTong] = "还没有加入帮派",
            [g_errorCode.MemberExist] = "帮派成员已存在",
            [g_errorCode.MemberNotExist] = "帮派成员不存在",
            [g_errorCode.MemberFull] = "帮派成员已满",

            -- PVP相关
            [g_errorCode.PVPPlayerNotExists] = "玩家不存在",
            [g_errorCode.PVPInFight] = "玩家正在被攻击",

            --培养系统扩展
            [g_errorCode.TrainInFreeCD] = "免费刷新在CD中",
            [g_errorCode.TrainFreeCountFull] = "免费刷新次数满了",

            --好友系统
            [g_errorCode.FrdNoPlayer] = "没有这个玩家",
            [g_errorCode.FrdRequestFull] = "玩家好友请求已满",
            [g_errorCode.FrdRequestRepeat] = "玩家好友请求已有",
            [g_errorCode.FrdUpdateDataFailed] = "更新好友数据失败",
            [g_errorCode.FrdDataError] = "玩家好友数据错误，或者玩家传过来的玩家id错误",
            [g_errorCode.FrdFriendRepeat] = "已经添加了该玩家",
            [g_errorCode.FrdFriendFull] = "玩家好友已满",
            [g_errorCode.FrdNoThisFriend] = "玩家没有该好友",
            [g_errorCode.FrdNoThisFrdRequest] = "玩家没有该好友请求",
            [g_errorCode.FrdFrdepeat] = "玩家已有该好友",
            [g_errorCode.FrdRequestRev] = "玩家已经收到过该玩家的加友请求",
            [g_errorCode.FrdBeSelf] = "不能添加自己为好友",

            --出售分解等相关
            [g_errorCode.SellRoleAlreadyEquip] = "角色卡已上阵",
            [g_errorCode.SellRoleAlreadySee] = "角色卡已监工",
            [g_errorCode.SellEquipAlreadyEquip] = "装备已装备不能分解",

            --人才市场
            [g_errorCode.MktFreeCountFull] = "免费刷新次数到达上限",
            [g_errorCode.MktFreeCD] = "免费刷新cd中",
            [g_errorCode.MktSellCountFull] = "出售次数到达当日上限",
            [g_errorCode.MktQualityError] = "卡片品质不对",
            [g_errorCode.MktUseFlagError] = "卡片已上阵",
            [g_errorCode.MktSeeFlagError] = "卡片已监工",

            --碎片
            [g_errorCode.FragLack] = "碎片数量不够合成",
            [g_errorCode.FragIDToSlotInvalid] = "碎片ID无对应的图鉴slot",

            --VIP
            [g_errorCode.VipPassCountFull] = "当日vip刷新关卡数已满",
            [g_errorCode.VipLackRecharge] = "没有充值过",
            [g_errorCode.VipPvpCountFull] = "当日vip刷新pvp数已满",
            [g_errorCode.VipRechargeNotEnough] = "充值不足",
            [g_errorCode.VipAlreadyGet] = "已经领取过奖励",

            --活动
            [g_errorCode.ACTAlreadyGetLV] = "已经领取了vip",
            [g_errorCode.ACTAlreadyGetTE] = "已经领取了体力",
            [g_errorCode.ACTTimeOutTE] = "不在领取时间",
            [g_errorCode.ACTRefreshFullEM] = "金币刷新次数满了",
            [g_errorCode.ACTRefreshFullEG] = "元宝刷新次数满了",
            [g_errorCode.ACTRefreshCDEM] = "金币刷新cd",
            [g_errorCode.ACTRefreshCDEG] = "元宝刷新cd",
            [g_errorCode.ACTExchangeFullEM] = "金币兑换次数满了",
            [g_errorCode.ACTExchangeFullEG] = "元宝兑换次数满了",
            [g_errorCode.ACTLackRefreshEM] = "还未刷新",
            [g_errorCode.ACTLackRefreshEG] = "还未刷新",
            [g_errorCode.ACTLackLv] = "活动等级不到",                 


            --其他
            [g_errorCode.FuncNotOpenTrain] = "培养功能未开放",
            [g_errorCode.FuncNotOpenBuildRes] = "收资源功能暂未开放",
            [g_errorCode.FuncNotOpenPVP] = "pvp功能暂未开放",
            [g_errorCode.FuncNotOpenBuildLevelUp] = "升级建筑功能暂未开放",
            [g_errorCode.FuncNotOpenLoginSample] = "登陆领奖活动功能暂未开放",
            [g_errorCode.FuncNotOpenSampleCard] = "抽卡活动功能暂未开放",
            [g_errorCode.FuncNotOpenRoleLevelUp] = "角色卡强化等级活动功能暂未开放",
            [g_errorCode.FuncNotOpenExchangeGold] = "元宝兑换功能暂未开放",
            [g_errorCode.FuncNotOpenGetEnergy] = "领取体力功能暂未开放",
            [g_errorCode.FuncNotOpenMarket] = "人才市场功能暂未开放",
            [g_errorCode.FuncNotOpenFriend] = "好友功能暂未开放",
            [g_errorCode.FuncNotOpen] = "该功能未到达开启等级",

            [g_errorCode.AutoFightLackLevel] = "自动战斗等级不够",
            [g_errorCode.LackSampleType1Level] = "低级抽卡等级不够",
            [g_errorCode.EnergyFull] = "体力已满",

            --
            [g_errorCode.SoldierFull] = "招募士兵已满",
            [g_errorCode.SoldierLevelFull] = "士兵强化等级已满不能升级",
            [g_errorCode.SoldierLevelNotFull] = "士兵强化等级未满不能升阶",
            [g_errorCode.SoldierNoOne] = "没有士兵不能遣散士兵",

            [g_errorCode.LackSoul] = "缺少武魂",
            [g_errorCode.ClassFull] = "阶数已满",
            [g_errorCode.QualityNotLegal] = "卡牌品质不合法",
            [g_errorCode.SoldierFreeFull] = "每天免费招兵次数已满",

            [g_errorCode.LackTaxCount] = "主城税收次数已用完",
            [g_errorCode.FuncNotOpen] = "当前功能暂未开放",
            [g_errorCode.LackTianTiCount] = "缺少天梯挑战次数",
            [g_errorCode.LackTianTiVipCount] = "缺少天梯挑战VIP购买次数",
            [g_errorCode.LackLevel] = "缺少等级",

            [g_errorCode.NameRepeat] = "重名",
            [g_errorCode.NameIllegal] = "名字不合法",

            --天梯
            [g_errorCode.AltarFull] = "天梯已满",
            [g_errorCode.AltarLackOfEvo] = "进化数不够",
            [g_errorCode.AltarBoxNotOpen] = "对应的印没有开启",
            [g_errorCode.AltarNoBox] = "等级不足，没有可刷的印位",

            [g_errorCode.MsnAwardHadGot] = "任务已经领奖",
            [g_errorCode.MsnLackOfScore] = "活力值不足，不能领取这个奖励",

            [g_errorCode.AwardAlreadyGet] = "已经领取过奖励",
            [g_errorCode.LackOfAward] = "领取奖励条件还不够",

            [g_errorCode.SSGoodsOver] = "物品已经购买完毕",
            [g_errorCode.SSLackScore] = "缺少积分",

            -- 邮件
            [g_errorCode.AlreadyFetched] = "物品已经领取",
            [g_errorCode.InvalidIndex]   = "无效的索引",

            -- 英雄试练
            [g_errorCode.NotAvailableToday] = "此类型英雄试练在今天无效",
            [g_errorCode.RoleCardAwarded]   = "此卡片已获得",
            [g_errorCode.TrailEnergyLack]   = "体力不足",

            [g_errorCode.LackCount] = "操作次数不够",

            -- 公会系统
            [g_errorCode.GuildAlreadyRequestGuild        ] = "已经申请加入该公会",
            [g_errorCode.GuildNotExists                  ] = "公会不存在",
            [g_errorCode.GuildCannotJoin                 ] = "不能加入该公会",
            [g_errorCode.GuildRequestCountMax            ] = "公会请求人数已满",
            [g_errorCode.GuildThisDayRequestMax          ] = "当天请求加入公会数量已满",
            [g_errorCode.GuildAlreadyJoinedGuild         ] = "已经加入公会",
            [g_errorCode.GuildCannotFindGuild            ] = "无法找到指定公会",
            [g_errorCode.GuildNameLengthOverFlow         ] = "会公名字过长",
            [g_errorCode.GuildNotEnoughGold              ] = "元宝不足",
            [g_errorCode.GuildDidNotJoinGuild            ] = "没有加入任何公会",
            [g_errorCode.GuildNotEnoughAuth              ] = "没有足够的权限",
            [g_errorCode.GuildHasOtherMember             ] = "还有其他的公会成员",
            [g_errorCode.GuildMailTitleLengthOverFlow    ] = "邮件标题过长",
            [g_errorCode.GuildMailContentLengthOverFlow  ] = "邮件内容过长",
            [g_errorCode.GuildNoticeLengthOverFlow       ] = "公告内容过长",
            [g_errorCode.GuildChatSoFast                 ] = "聊天速度过快",
            [g_errorCode.GuildChatMessageLengthOverFlow  ] = "聊天信息过长",
            [g_errorCode.GuildPlayerNotInRequestList     ] = "不在请求列表之中",
            [g_errorCode.GuildPlayerNotInGuild           ] = "不在公会之中",
            [g_errorCode.GuildCannotDoOnSelf             ] = "不能操作自己",
            [g_errorCode.GuildElderCountMax              ] = "公会长老数量已满",
            [g_errorCode.GuildCannotWorshipSelf          ] = "不能膜拜自己",
            [g_errorCode.GuildCannotWorshipLowLevel      ] = "膜拜的大神等级必须高于自己",
            [g_errorCode.GuildTargetPlayerNotInGuild     ] = "目标玩家不在公会之中",
            [g_errorCode.GuildWorshipCountMax            ] = "膜拜次数超过限制",
            [g_errorCode.GuildNameExists                 ] = "公会名字已经存在",
            [g_errorCode.GuildMemberCountMax             ] = "公会人数已满",
            [g_errorCode.GuildNoRewards                  ] = "没有奖励",
            [g_errorCode.GuildWorshipMoneyLack           ] = "金币不足",
            [g_errorCode.GuildTeamCopyOutRange           ] = "该关卡未开放",
            [g_errorCode.GuildTeamCopyAlreadyOpen        ] = "副本已开启",
            [g_errorCode.GuildTeamCopyEliteNotPass       ] = "对应精英副本未通关",
            [g_errorCode.GuildTeamCopyGuildAcitivyLack   ] = "公会活跃度不足",
            [g_errorCode.GuildTeamCopyPrevLevelNotPassed ] = "前一关未通关",
            [g_errorCode.GuildTeamCopyNotPurchased       ] = "副本未购买",
            [g_errorCode.GuildTeamCopyLocked             ] = "副本已通关",
            [g_errorCode.GuildTeamCopyTimesOverFlow      ] = "副本挑战次数已满",
            [g_errorCode.GuildTeamCopyPlayerInBattle     ] = "有其他玩家正在战斗",
            [g_errorCode.GuildAlreadyRequestItem         ] = "已经申请了该物品",
            [g_errorCode.GuildPlayerNotInItemReqList     ] = "该玩家不在物品请求列表",
            [g_errorCode.GuildDistributeTimesMax         ] = "分配物品次数超过最大值",
            [g_errorCode.GuildNotInItemRequestList       ] = "还未申请副本物品",
            [g_errorCode.GuildNotEnoughMoney             ] = "金币不足",
            [g_errorCode.GuildAlreadyFistPlace           ] = "已经在第一的位置",
            [g_errorCode.GuildTeamCopyPrevLevelNotBuy    ] = "前一关未购买",
            [g_errorCode.GuildTeamCopyItemNotExists      ] = "物品不存在",
            [g_errorCode.GuildTeamCopyItemLack           ] = "物品不足",

            [g_errorCode.SoldierLvlTooBig                ] = "士兵等级不能超过主公等级！",


            [g_errorCode.ChatSendMsgTooFast              ] = "消息发送速度过快",
        }
end
