-- g_errorCode = 
-- {
	-- OK = 1,							--执行操作成功
	-- Error = 2,						--系统错误
	-- GFalse = 3,						--不允许执行该操作
	-- ForeverLoopError = 7,			--循环意外出错
	-- ConfigError = 10,				--配置错误
	--ChatNotEnoughGold					
	-- --玩家数据相关
	-- LevelMax = 15,					--等级达到最高
	-- LackGold = 16,					--缺少元宝
	-- LackMoney = 17,					--缺少铜钱
	-- LackEnergy = 18,				--缺少体力
	-- PassLimit = 19,					--关联关卡未通过
	-- LackFight = 20,					--缺少战斗力
	-- LackItem = 21,					--缺少物品
	
	-- --卡片相关
	-- FighterAmountMax = 22,			--可装备战斗角色卡数量达到最大
	-- FighterSoltFull = 23,			--战斗位置已有角色卡
	-- LackFighterSlot = 24,			--缺少可用角色卡位置
	-- FighterSlotEmpty = 25,			--战斗位置为空
	-- EquipSlotEmpty = 26,			--装备位置为空
	-- SkillSlotEmpty = 27,			--技能位置为空
	-- LackEquipSlot = 28,				--缺少可用装备卡位置
	-- LackSkillSlot = 29,				--缺少可用技能卡位置
	-- EquipAmountMax = 30,			--可装备装备卡数量达到最大
	-- SkillAmountMax = 31,			--可装备技能卡数量达到最大
	
	-- --通用
	-- CardIDInvalid = 40,				--卡片id无效，卡牌配置表无对于id
	
	-- --关卡
	-- DailyLimit = 50,				--每日限制
	-- LevelLimit = 51,				--等级限制
	-- TimeLimit = 52,					--时间限制
	-- FightLimit = 53,				--战斗力限制
	-- MopTokenLack = 54,				--扫荡令不足
	
	-- --背包物品
	-- BagTypeError = 60,				--背包类型错误，只有四种背包类型
	-- ItemSlotError = 61,				--物品位置错误，该位置超出了最大背包数
	-- SlotHasNoItem = 62,				--Slot位置上没有物品
	-- SlotHasItem = 63,				--该位置上已有物品
	-- AboveItemOverlap = 64,			--超出物品最大叠加数
	-- BagFull = 65,					--背包已满	
	-- BagNotEnough = 66,				--背包不够
	-- GoodsNotEnough = 67,			--物品不够
	-- ItemNoUseFunc = 68,				--物品没有配置使用函数
	-- NotDeleteItem = 69,				--使用物品后不用删除物品
	-- IndexOutOfRange = 70,			--索引超出范围
	-- LevelFull = 71,					--满级
	-- ItemDailyLimitFull = 72,		--该道具每日使用次数已满
	-- ItemDailyLimitFullVip = 73,		--该道具每日使用次数已满，提升vip等级可以增加每日使用次数
	-- ItemLimitLevel = 74,			--等级
	
	
	-- --建筑系统相关
	-- PlayerLevelLack = 80,			--玩家等级不够
	-- BuildingResNotEnough = 86,		--资源不够
	-- CannotStrengthen = 103,			--无法强化(系统不允许)
	-- LevelNotEnough = 104,			--等级不足以进行该操作
	-- CardLack = 105,					--角色卡强化(卡片不足)
	
	-- --商城
	-- GoodsInfoNotRight = 130,		--购买物品与服务器不一致，要求客户端重新打开商城面板进行购买
	-- GoodsBuyFull = 131,				--物品购买数量已满
	-- GoodsNotBuyNext = 132,			--等级或者vip等级不够，不允许购买下一级物品
	-- GoodsLackVip = 133,				--vip等级不够，不允许购买物品
	-- GoodsRefreshNoEnough = 134,		--刷新令不足
	-- GoodsRefreshLack = 135,			--刷新次数不足
	
	-- -- PVP相关
	-- PVPPlayerNotExists = 181,		-- 玩家不存在
	-- PVPInFight = 182,				-- 玩家正在被攻击
	-- SellRoleAlreadyEquip = 280,		--角色卡已上阵
	
	-- --碎片
	-- FragLack = 320,							--碎片数量不够合成
	-- FragIDToSlotInvalid = 321,				--碎片ID无对应的图鉴slot
	
	-- --VIP
	-- VipPassCountFull = 340,					--当日vip刷新关卡数已满
	-- VipLackRecharge = 341,					--没有充值过
	-- VipPvpCountFull = 342,					--当日vip刷新pvp数已满
	-- VipRechargeNotEnough = 343,				--充值不足
	-- VipAlreadyGet = 344,					--已经领取过奖励
	
	-- --活动
	-- ACTAlreadyGetLV = 360,					--已经领取了 送vip
	-- ACTAlreadyGetTE = 361,					--已经领取了 体力
	-- ACTTimeOutTE = 362,						--不在领取时间
	-- ACTRefreshFullEM = 363,					--金币刷新次数满了
	-- ACTRefreshFullEG = 364,					--元宝刷新次数满了
	-- ACTRefreshCDEM = 365,					--金币刷新cd
	-- ACTRefreshCDEG = 366,					--元宝刷新cd
	-- ACTExchangeFullEM = 367,				--金币兑换次数满了
	-- ACTExchangeFullEG = 368,				--元宝兑换次数满了
	-- ACTLackRefreshEM = 369,					--还未刷新
	-- ACTLackRefreshEG = 370,					--还未刷新
	-- ACTLackLv = 371,					
	-- ACTNOOPEN = 372,						--活动未开启
	
	
	-- FuncNotOpenLoginSample = 404,				--登陆领奖活动功能暂未开放
	-- FuncNotOpenSampleCard = 405,				--抽卡活动功能暂未开放
	-- FuncNotOpen = 411,							--该功能未到达开启等级

	-- AutoFightLackLevel = 420,					--自动战斗等级不够
	-- EnergyFull = 422,							--体力已满
	
	-- SoldierLevelFull = 501,						--士兵强化等级已满不能升级
	-- SoldierLevelNotFull = 502,					--士兵强化等级未满不能升阶
	
	-- LackSoul = 504,	--缺少武魂
	-- ClassFull = 505, --阶数已满
	-- QualityNotLegal = 506, --卡牌品质不合法
	-- FuncNotOpen = 509,	--当前功能暂未开放
	-- LackTianTiCount = 510,	--缺少天梯挑战次数
	-- LackTianTiVipCount = 511,	--缺少天梯挑战VIP购买次数
	-- LackLevel = 512,			--缺少等级
	
	-- NameRepeat = 513,	--重名
	-- NameIllegal = 514,	--名字不合法
	
	-- --天梯
	-- AltarFull = 515,	--天梯已满
	-- AltarBoxNotOpen = 517, --对应的印没有开启
	-- AltarNoBox = 518, --没有印
	
	-- MsnAwardHadGot = 519, --任务已经领奖
	-- MsnLackOfScore = 520, --活力值不足，不能领取这个奖励
	
	-- AwardAlreadyGet = 521, --已经领取过奖励
	-- LackOfAward = 522, --领取奖励条件还不够
	
	-- SSGoodsOver = 523, --物品已经购买完毕
	-- SSLackScore = 524, --缺少积分
    
    -- -- 邮件
    -- AlreadyFetched = 550,   -- 物品已经领取
    -- InvalidIndex   = 551,   -- 无效的索引
    
    -- -- 英雄试练
    -- NotAvailableToday = 560,    -- 此类型英雄试练在今天无效
    -- RoleCardAwarded   = 561,    -- 此卡片已获得
    -- TrailEnergyLack   = 562,    -- 体力不足
	
	-- --
	-- StrenthSFail = 563,	--强化士兵失败
	
	-- LackCount = 570,	-- 操作次数不够

    -- -- 公会系统
    -- GuildAlreadyRequestGuild        = 580,      -- 已经申请加入该公会
    -- GuildNotExists                  = 581,      -- 公会不存在
    -- GuildCannotJoin                 = 582,      -- 不能加入该公会
    -- GuildRequestCountMax            = 583,      -- 公会请求人数已满
    -- GuildThisDayRequestMax          = 584,      -- 当天请求加入公会数量已满
    -- GuildAlreadyJoinedGuild         = 585,      -- 已经加入公会
    -- GuildCannotFindGuild            = 586,      -- 无法找到指定公会
    -- GuildNameLengthOverFlow         = 587,      -- 会公名字过长
    -- GuildNotEnoughGold              = 588,      -- 元宝不足
    -- GuildDidNotJoinGuild            = 589,      -- 没有加入任何公会
    -- GuildNotEnoughAuth              = 590,      -- 没有足够的权限
    -- GuildHasOtherMember             = 591,      -- 还有其他的公会成员
    -- GuildMailTitleLengthOverFlow    = 592,      -- 邮件标题过长
    -- GuildMailContentLengthOverFlow  = 593,      -- 邮件内容过长
    -- GuildNoticeLengthOverFlow       = 594,      -- 公告内容过长
    -- GuildChatSoFast                 = 595,      -- 聊天速度过快
    -- GuildChatMessageLengthOverFlow  = 596,      -- 聊天信息过长
    -- GuildPlayerNotInRequestList     = 597,      -- 不在请求列表之中
    -- GuildPlayerNotInGuild           = 598,      -- 不在公会之中
    -- GuildCannotDoOnSelf             = 599,      -- 不能操作自己
    -- GuildElderCountMax              = 600,      -- 公会长老数量已满
    -- GuildCannotWorshipSelf          = 601,      -- 不能膜拜自己
    -- GuildCannotWorshipLowLevel      = 602,      -- 膜拜的大神等级必须高于自己
    -- GuildTargetPlayerNotInGuild     = 603,      -- 目标玩家不在公会之中
    -- GuildWorshipCountMax            = 604,      -- 膜拜次数超过限制
    -- GuildNameExists                 = 605,      -- 公会名字已经存在
    -- GuildMemberCountMax             = 606,      -- 公会人数已满
    -- GuildNoRewards                  = 607,      -- 没有奖励
    -- GuildWorshipMoneyLack           = 608,      -- 金币不足
    -- GuildTeamCopyOutRange           = 609,      -- 该关卡未开放
    -- GuildTeamCopyAlreadyOpen        = 610,      -- 副本已开启
    -- GuildTeamCopyEliteNotPass       = 611,      -- 对应精英副本未通关
    -- GuildTeamCopyGuildAcitivyLack   = 612,      -- 公会活跃度不足
    -- GuildTeamCopyPrevLevelNotPassed = 613,      -- 前一关未通关
    -- GuildTeamCopyNotPurchased       = 614,      -- 副本未购买
    -- GuildTeamCopyLocked             = 615,      -- 副本已通关
    -- GuildTeamCopyTimesOverFlow      = 616,      -- 副本挑战次数已满
    -- GuildTeamCopyPlayerInBattle     = 617,      -- 有其他玩家正在战斗
    -- GuildAlreadyRequestItem         = 618,      -- 已经申请了该物品
    -- GuildPlayerNotInItemReqList     = 619,      -- 该玩家不在物品请求列表
    -- GuildDistributeTimesMax         = 620,      -- 分配物品次数超过最大值
    -- GuildNotInItemRequestList       = 621,      -- 还未申请副本物品
    -- GuildNotEnoughMoney             = 622,      -- 金币不足
    -- GuildAlreadyFistPlace           = 623,      -- 已经在第一的位置
    -- GuildTeamCopyPrevLevelNotBuy    = 624,      -- 前一关未购买
    -- GuildTeamCopyItemNotExists      = 625,      -- 物品不存在
    -- GuildTeamCopyItemLack           = 626,      -- 物品不足
    -- GuildAlreadyJoinedGuildToday    = 627,      -- 今天已加入过公会
	-- GuildCountLack					= 628,		-- 团队副本挑战次数不足
	-- GuildNotItems					= 629,		-- 该物品不存在
	-- GuildActifFull					= 630,		-- 捐献次数已满

	-- SoldierLvlTooBig				= 700,		-- 士兵等级不能超过主公等级！
    
    -- ChatSendMsgTooFast              = 800,      -- 消息发送速度过快
    -- ChatNoFreeChatCount             = 801,      -- 免费次数已经用完
    -- ChatNotEnoughGold               = 802,      -- 元宝不足
	-- ChatBan							= 803,		-- 用户被禁言
    
    -- BuyMoneyNotEnoughGold           = 850,      -- 金币不足
	
	-- --主城系统
	-- StructureDoed					= 900,		-- 该武将已经做过任务了
	-- StructureGoldLack				= 901,		-- 元宝不足
	-- StructureNumError				= 902,		-- 今日任务次数以达到上限	
	-- StructureDoing					= 903,		-- 武将正在执行任务
	-- StructureFinish					= 904,		-- 任务已经完成
	-- StructureNoFinish				= 905,		-- 任务未完成
	
	-- --抽卡系统
	-- CardMaxLack						= 950,		-- 免费抽卡次数已达上限
	
	-- --vip相关						
	-- VipGetPass						= 1000,		-- vip礼包已经领取过了 
	-- VipLevelLack					= 1001,		-- vip等级不足
	-- GrowUpBuyed						= 1002,		-- vip成长计划已经购买过了
	-- LevelLack						= 1003,		-- 等级不够
	-- BuyMoneyLack					= 1004,		-- 购买金币次数以达上限
	-- BuyEnergyLack					= 1005,	    -- 购买体力次数以达上限	
	-- ResetPassLack					= 1006,		-- 重置关卡次数不足
	-- ResetTiantiLack					= 1007,		-- 重置PVP次数已达上限
	-- VipGrowUpNoBuy					= 1008,		-- 未购买成长计划

	
	-- --宝箱系统						
	-- BoxNoNeedGrid					= 1050,		-- 开出宝箱的物品不需占要格子
	-- LackHunjing                     = 1051,		-- 缺少魂晶
	
	-- LackTTScore						= 1060,		-- 缺少天梯积分
	
	-- --兑换码相关
	-- CDKeyNotExist					= 1071,		-- 兑换码不存在
	-- CDKeyNoNum						= 1072,		-- 兑换码使用次数已用完
	-- CDKeyOutData					= 1073,		-- 兑换码已过期
	-- CDKeyNonData					= 1074,		-- 兑换码未到使用时间
	-- CDKeyUsed						= 1075,		-- 兑换码已使用过了
	
-- }

--g_csErrorString = {}
 function g_csMakeErrorStr()
 end
	-- g_csErrorString =
	-- {
		-- [g_errorCode.OK] = "执行操作成功",
		-- [g_errorCode.Error] = "对不起，出现错误了，请尝试其他操作或者重新登录游戏再继续吧。",
		-- [g_errorCode.GFalse] = "不允许执行该操作",
		-- [g_errorCode.ForeverLoopError] = "循环意外出错",
		-- [g_errorCode.ConfigError] = "配置错误",
		
		-- --玩家数据相关
		-- [g_errorCode.LevelMax] = "等级达到最高",
		-- [g_errorCode.LackGold] = "缺少元宝",
		-- [g_errorCode.LackMoney] = "缺少铜钱",
		-- [g_errorCode.LackEnergy] = "缺少体力",
		-- [g_errorCode.PassLimit] = "关联关卡未通过",
		-- [g_errorCode.LackFight] = "缺少战斗力",
		-- [g_errorCode.LackItem] = "缺少物品",
		
		-- --卡片相关
		-- [g_errorCode.FighterAmountMax] = "可装备战斗角色卡数量达到最大",
		-- [g_errorCode.FighterSoltFull] = "战斗位置已有角色卡",
		-- [g_errorCode.LackFighterSlot] = "缺少可用角色卡位置",
		-- [g_errorCode.FighterSlotEmpty] = "战斗位置为空",  
		-- [g_errorCode.EquipSlotEmpty] = "装备位置为空",
		-- [g_errorCode.SkillSlotEmpty] = "技能位置为空",
		-- [g_errorCode.LackEquipSlot] = "缺少可用装备卡位置",
		-- [g_errorCode.LackSkillSlot] = "缺少可用技能卡位置",
		-- [g_errorCode.EquipAmountMax] = "可装备装备卡数量达到最大",
		-- [g_errorCode.SkillAmountMax] = "可装备技能卡数量达到最大",
		
		-- --通用
		-- [g_errorCode.CardIDInvalid] = "卡片id无效，卡牌配置表无对于id",
		
		-- --关卡
		-- [g_errorCode.DailyLimit] = "每日限制",
		-- [g_errorCode.LevelLimit] = "等级限制",
		-- [g_errorCode.TimeLimit] = "时间限制",
		-- [g_errorCode.FightLimit] = "战斗力限制",
		-- [g_errorCode.MopTokenLack] = "扫荡令不足",
		
		-- --背包物品
		-- [g_errorCode.BagTypeError] = "背包类型错误，只有四种背包类型",
		-- [g_errorCode.ItemSlotError] = "物品位置错误，该位置超出了最大背包数",
		-- [g_errorCode.SlotHasNoItem] = "Slot位置上没有物品",
		-- [g_errorCode.SlotHasItem] = "该位置上已有物品",
		-- [g_errorCode.AboveItemOverlap] = "超出物品最大叠加数",
		-- [g_errorCode.BagFull] = "背包已满	",
		-- [g_errorCode.BagNotEnough] = "武将已满，请清理",
		-- [g_errorCode.GoodsNotEnough] = "物品不够",
		-- [g_errorCode.ItemNoUseFunc] = "物品没有配置使用函数",
		-- [g_errorCode.NotDeleteItem] = "使用物品后不用删除物品",
		-- [g_errorCode.IndexOutOfRange] = "索引超出范围",
		-- [g_errorCode.LevelFull] = "满级",
		-- [g_errorCode.ItemDailyLimitFull] = "该道具每日使用次数已满",
		-- [g_errorCode.ItemDailyLimitFullVip] = "该道具每日使用次数已满，提升vip等级可以增加每日使用次数",
		-- [g_errorCode.ItemLimitLevel] = "等级",
		
		
		-- --建筑系统相关
		-- [g_errorCode.PlayerLevelLack] = "武将等级不足",
		-- [g_errorCode.BuildingResNotEnough] = "资源不够",
		-- [g_errorCode.CannotStrengthen] = "无法强化(系统不允许)",
		-- [g_errorCode.LevelNotEnough] = "等级不足以进行该操作",
		-- [g_errorCode.CardLack] = "武将不足",
		
		-- --商城
		-- [g_errorCode.GoodsInfoNotRight] = "购买物品与服务器不一致，要求客户端重新打开商城面板进行购买",
		-- [g_errorCode.GoodsBuyFull] = "物品购买数量已满",
		-- [g_errorCode.GoodsNotBuyNext] = "等级或者vip等级不够，不允许购买下一级物品",
		-- [g_errorCode.GoodsLackVip] = "vip等级不够，不允许购买物品",
		-- [g_errorCode.GoodsRefreshNoEnough] = "刷新令不足",
		-- [g_errorCode.GoodsRefreshLack]	= "刷新次数不足",
		
		
		-- -- PVP相关
		-- [g_errorCode.PVPPlayerNotExists] = "玩家不存在",
		-- [g_errorCode.PVPInFight] = "玩家正在被攻击",
		-- [g_errorCode.SellRoleAlreadyEquip] = "角色卡已上阵",
		-- --碎片
		-- [g_errorCode.FragLack] = "碎片数量不够合成",
		-- [g_errorCode.FragIDToSlotInvalid] = "碎片ID无对应的图鉴slot",
		
		-- --VIP
		-- [g_errorCode.VipPassCountFull] = "当日vip刷新关卡数已满",
		-- [g_errorCode.VipLackRecharge] = "没有充值过",
		-- [g_errorCode.VipPvpCountFull] = "当日vip刷新pvp数已满",
		-- [g_errorCode.VipRechargeNotEnough] = "充值不足",
		-- [g_errorCode.VipAlreadyGet] = "已经领取过奖励",
		
		-- --活动
		-- [g_errorCode.ACTAlreadyGetLV] = "已经领取了vip",
		-- [g_errorCode.ACTAlreadyGetTE] = "已经领取了体力",
		-- [g_errorCode.ACTTimeOutTE] = "不在领取时间",
		-- [g_errorCode.ACTRefreshFullEM] = "金币刷新次数满了",
		-- [g_errorCode.ACTRefreshFullEG] = "元宝刷新次数满了",
		-- [g_errorCode.ACTRefreshCDEM] = "金币刷新cd",
		-- [g_errorCode.ACTRefreshCDEG] = "元宝刷新cd",
		-- [g_errorCode.ACTExchangeFullEM] = "金币兑换次数满了",
		-- [g_errorCode.ACTExchangeFullEG] = "元宝兑换次数满了",
		-- [g_errorCode.ACTLackRefreshEM] = "还未刷新",
		-- [g_errorCode.ACTLackRefreshEG] = "还未刷新",
		-- [g_errorCode.ACTLackLv] = "活动等级不到",	
		-- [g_errorCode.ACTNOOPEN] = "活动未开启",

		
		-- [g_errorCode.FuncNotOpenLoginSample] = "登陆领奖活动功能暂未开放",
		-- [g_errorCode.FuncNotOpenSampleCard] = "抽卡活动功能暂未开放",
		-- [g_errorCode.FuncNotOpen] = "该功能未到达开启等级",
		-- [g_errorCode.AutoFightLackLevel] = "自动战斗等级不够",
		-- [g_errorCode.EnergyFull] = "体力已满",
		
		-- [g_errorCode.SoldierLevelFull] = "士兵强化等级已满不能升级",
		-- [g_errorCode.SoldierLevelNotFull] = "士兵强化等级未满不能升阶",
		
		-- [g_errorCode.LackSoul] = "缺少武魂",
		-- [g_errorCode.ClassFull] = "阶数已满",
		-- [g_errorCode.QualityNotLegal] = "卡牌品质不合法",
		
		
		
		-- [g_errorCode.FuncNotOpen] = "当前功能暂未开放",
		-- [g_errorCode.LackTianTiCount] = "缺少天梯挑战次数",
		-- [g_errorCode.LackTianTiVipCount] = "缺少天梯挑战VIP购买次数",
		-- [g_errorCode.LackLevel] = "缺少等级",
		
		-- [g_errorCode.NameRepeat] = "重名",
		-- [g_errorCode.NameIllegal] = "名字不合法",
		
		-- --天梯
		-- [g_errorCode.AltarFull] = "天梯已满",
		-- [g_errorCode.AltarBoxNotOpen] = "对应的印没有开启",
		-- [g_errorCode.AltarNoBox] = "等级不足，没有可刷的印位",
		
		-- [g_errorCode.MsnAwardHadGot] = "任务已经领奖",
		-- [g_errorCode.MsnLackOfScore] = "活力值不足，不能领取这个奖励",
		
		-- [g_errorCode.AwardAlreadyGet] = "已经领取过奖励",
		-- [g_errorCode.LackOfAward] = "领取奖励条件还不够",
		
		-- [g_errorCode.SSGoodsOver] = "物品已经购买完毕",
		-- [g_errorCode.SSLackScore] = "缺少积分",
		
		-- -- 邮件
		-- [g_errorCode.AlreadyFetched] = "物品已经领取",
		-- [g_errorCode.InvalidIndex]   = "无效的索引",
		
		-- -- 英雄试练
		-- [g_errorCode.NotAvailableToday] = "此类型英雄试练在今天无效",
		-- [g_errorCode.RoleCardAwarded]   = "此卡片已获得",
		-- [g_errorCode.TrailEnergyLack]   = "体力不足",
		
		-- [g_errorCode.StrenthSFail]   = "强化士兵失败",
		-- [g_errorCode.LackCount] = "您暂时不满足该操作的条件",

        -- -- 公会系统
        -- [g_errorCode.GuildAlreadyRequestGuild        ] = "已经申请加入该公会",
        -- [g_errorCode.GuildNotExists                  ] = "公会不存在",
        -- [g_errorCode.GuildCannotJoin                 ] = "不能加入该公会",
        -- [g_errorCode.GuildRequestCountMax            ] = "公会请求人数已满",
        -- [g_errorCode.GuildThisDayRequestMax          ] = "当天请求加入公会数量已满",
        -- [g_errorCode.GuildAlreadyJoinedGuild         ] = "已经加入公会",
        -- [g_errorCode.GuildCannotFindGuild            ] = "无法找到指定公会",
        -- [g_errorCode.GuildNameLengthOverFlow         ] = "会公名字过长",
        -- [g_errorCode.GuildNotEnoughGold              ] = "元宝不足",
        -- [g_errorCode.GuildDidNotJoinGuild            ] = "没有加入任何公会",
        -- [g_errorCode.GuildNotEnoughAuth              ] = "没有足够的权限",
        -- [g_errorCode.GuildHasOtherMember             ] = "还有其他的公会成员",
        -- [g_errorCode.GuildMailTitleLengthOverFlow    ] = "邮件标题过长",
        -- [g_errorCode.GuildMailContentLengthOverFlow  ] = "邮件内容过长",
        -- [g_errorCode.GuildNoticeLengthOverFlow       ] = "公告内容过长",
        -- [g_errorCode.GuildChatSoFast                 ] = "聊天速度过快",
        -- [g_errorCode.GuildChatMessageLengthOverFlow  ] = "聊天信息过长",
        -- [g_errorCode.GuildPlayerNotInRequestList     ] = "不在请求列表之中",
        -- [g_errorCode.GuildPlayerNotInGuild           ] = "不在公会之中",
        -- [g_errorCode.GuildCannotDoOnSelf             ] = "不能操作自己",
        -- [g_errorCode.GuildElderCountMax              ] = "公会长老数量已满",
        -- [g_errorCode.GuildCannotWorshipSelf          ] = "不能膜拜自己",
        -- [g_errorCode.GuildCannotWorshipLowLevel      ] = "膜拜的大神等级必须高于自己",
        -- [g_errorCode.GuildTargetPlayerNotInGuild     ] = "目标玩家不在公会之中",
        -- [g_errorCode.GuildWorshipCountMax            ] = "膜拜次数超过限制",
        -- [g_errorCode.GuildNameExists                 ] = "公会名字已经存在",
        -- [g_errorCode.GuildMemberCountMax             ] = "公会人数已满",
        -- [g_errorCode.GuildNoRewards                  ] = "没有奖励",
        -- [g_errorCode.GuildWorshipMoneyLack           ] = "金币不足",
        -- [g_errorCode.GuildTeamCopyOutRange           ] = "该关卡未开放",
        -- [g_errorCode.GuildTeamCopyAlreadyOpen        ] = "副本已开启",
        -- [g_errorCode.GuildTeamCopyEliteNotPass       ] = "对应精英副本未通关",
        -- [g_errorCode.GuildTeamCopyGuildAcitivyLack   ] = "公会活跃度不足",
        -- [g_errorCode.GuildTeamCopyPrevLevelNotPassed ] = "前一关未通关",
        -- [g_errorCode.GuildTeamCopyNotPurchased       ] = "副本未购买",
        -- [g_errorCode.GuildTeamCopyLocked             ] = "副本已通关",
        -- [g_errorCode.GuildTeamCopyTimesOverFlow      ] = "团队副本总挑战次数已达上限",
        -- [g_errorCode.GuildTeamCopyPlayerInBattle     ] = "有其他玩家正在战斗",
        -- [g_errorCode.GuildAlreadyRequestItem         ] = "已经申请了该物品",
        -- [g_errorCode.GuildPlayerNotInItemReqList     ] = "该玩家不在物品请求列表",
        -- [g_errorCode.GuildDistributeTimesMax         ] = "分配物品次数超过最大值",
        -- [g_errorCode.GuildNotInItemRequestList       ] = "还未申请副本物品",
        -- [g_errorCode.GuildNotEnoughMoney             ] = "金币不足",
        -- [g_errorCode.GuildAlreadyFistPlace           ] = "已经在第一的位置",
        -- [g_errorCode.GuildTeamCopyPrevLevelNotBuy    ] = "前一关未购买",
        -- [g_errorCode.GuildTeamCopyItemNotExists      ] = "物品不存在",
        -- [g_errorCode.GuildTeamCopyItemLack           ] = "物品不足",
        -- [g_errorCode.GuildAlreadyJoinedGuildToday    ] = "今天已加入过公会",
		-- [g_errorCode.GuildCountLack					 ] = "副本挑战次数不足",
		-- [g_errorCode.GuildNotItems                   ] = "该物品不存在",
		-- [g_errorCode.SoldierLvlTooBig                ] = "士兵等级不能超过主公等级！",
        
        
        -- [g_errorCode.ChatSendMsgTooFast              ] = "消息发送速度过快",
        -- [g_errorCode.ChatNoFreeChatCount             ] = "免费次数已经用完",
        -- [g_errorCode.ChatNotEnoughGold               ] = "元宝不足",
		-- [g_errorCode.ChatBan						 ] = "用户被禁言",
        -- [g_errorCode.BuyMoneyNotEnoughGold           ] = "金币不足",
		
		
		-- --主城任务系统
		-- [g_errorCode.StructureDoed					 ] = "该武将已经做过任务了",			--900
		-- [g_errorCode.StructureGoldLack				 ] = "元宝不足",						--901
		-- [g_errorCode.StructureNumError				 ] = "今日任务次数以达到上限",			--902
		-- [g_errorCode.StructureDoing					 ] = "武将正在执行任务",				--903
		-- [g_errorCode.StructureFinish                 ] = "任务已经完成",						--904
		-- [g_errorCode.StructureNoFinish				 ] = "任务未完成",						--905
		-- --抽卡系统
		-- [g_errorCode.CardMaxLack					 ] = "免费次数已达上限或免费抽取正在CD中",	--950
		-- --vip系统
		-- [g_errorCode.VipGetPass						 ] = '礼包已领取或未到达领取要求',		--1000
		-- [g_errorCode.VipLevelLack					 ] = 'vip等级不足',						--1001	
		-- [g_errorCode.GrowUpBuyed					 ] = 'vip成长计划已经购买过了',				--1002	
		-- [g_errorCode.LevelLack						 ] = '等级不够',						--1003
		-- [g_errorCode.BuyMoneyLack					 ] = '购买金币次数以达上限',			--1004
		-- [g_errorCode.BuyEnergyLack					 ] = '购买体力次数已达上限',			--1005
		-- [g_errorCode.ResetPassLack					 ] = '重置关卡次数不足',				--1006
		-- [g_errorCode.ResetTiantiLack				 ] = '购买pvp次数以达上限',			  		--1007	
		-- [g_errorCode.VipGrowUpNoBuy					 ] = '未购买成长计划',					--1008
		-- --宝箱系统
		-- [g_errorCode.BoxNoNeedGrid					 ] = '开出宝箱的物品不占格子',			--1050				
		-- [g_errorCode.LackHunjing					 ] = '缺少魂晶',						--1051
		-- [g_errorCode.LackTTScore					 ] = '缺少天梯积分',					--1052
		
		-- --兑换码相关
		-- [g_errorCode.CDKeyNotExist					 ] = '兑换码不存在',					--1070
		-- [g_errorCode.CDKeyNoNum						 ] = '兑换码使用次数已用完',			--1071
		-- [g_errorCode.CDKeyOutData					 ] = '兑换码已过期',					--1072
		-- [g_errorCode.CDKeyNonData					 ] = '兑换码未到使用时间',				--1073
		-- [g_errorCode.CDKeyUsed						 ] = '兑换码已使用过了',				--1074
    -- }
-- end
