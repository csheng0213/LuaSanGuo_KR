--运营相关配置

g_ITCode = 
{
	--获得物品
	UseItemGet = 1,				--使用物品获得
	PassGet = 2,				--关卡获得
	ConstructRes = 3,			--建筑资源存库获得
	CommonStore = 4,			--普通商店购买
	SecretStore = 5,			--神秘商店购买
	SampleGet = 6,				--抽卡奖励
	LoginRewards = 7,			--登陆奖励					--共有 登录领奖
	FragmentGet = 8,			--碎片合成
	VipGet = 9,					--VIP奖励
	ACTLVGet = 10,				--活动LV获得
	TrainGet = 11,				--培养获得
	StarRewardGet = 12,			--星星领奖	
	SystemInitGet = 13,			--建号初始化获得
	UseItemSysGet = 14,			--使用物品补偿获得
	SpeStarGet = 15,			--*********星星领奖获得特殊物品,金钱金币也对应这个15
	UpClassRCardGet = 16,	--武将进阶获得
	PVPAvengerGet = 17,		--pvp复仇
	PVPWinGet = 18,		--pvp胜利
	MissionGet = 19,	--任务获得
	Accumulate = 20,	--累计登陆
	BuyEnergy = 21, --购买体力
	LvlAddEnergy = 22, --升级增加体力
	XzlyGet = 23,		--血战获得
	SStoreGetFrag = 24,		--积分获得
    MailGet = 25,			--邮件获得
	PassStarGet = 26,			--关卡星星获得
	SysAddEnergy = 27, 	--自然增加体力
	GuildAddEnergy = 28, 	--膜拜增加体力
	PassRebackEnergy = 29,		--关卡退还体力
	StructureTask = 30,			--主城任务获得
	ShopGet = 31,				--商店获取
	GmGet = 32,                --gm发送						--共有
	EveryPay = 33,				--(活动)每日充值
	AllPay = 34,				--(活动)累计充值			--共有
	AllConsume = 35,			--(活动)累计消费			--共有
	NewPlayerReward = 36,		--新手礼包
	LevelUp = 37,				--升级获得			--共有
	ShiLianGet = 38,			--试炼获取
	OpenBoxGet = 39,			--开宝箱获得
	FirstPay = 40,				--(活动)首冲
	OnLineReward = 41,			--(活动)在线领奖
	strEngGet = 42,				--强化装备获得
	compoundGet = 43,			--合成装备增加
	gvgGet = 44,				--公会战获得

	--失去物品
	TrainLost = 200,			--培养白卡失去
	SampleLost = 201,			--抽卡失去
	SellLost = 202,				--出售失去
	ResolveLost = 203,			--分解失去
	SellExpend = 204,			--出售消耗
	TrainExpend = 205,			--培养消耗
	MarketLost = 206,			--人才市场出售
	FragmentLost = 207,			--碎片合成失去，作为合成条件
	UseItemLost = 208,			--使用物品失去
	ScoreStoreLost	= 209,			--积分商城刷新扣除
	ClassUpLost = 210,			--升阶失去
	StrengSoldierLost = 211,		--强化士兵 
	StrengRoleCard = 212,		--强化武将卡
	SystemLost = 213, --新手教程系统删除
	ShopLost = 214,				--商店使用刷新令
	MopTokenLost = 215,			--扫荡关卡扣除扫荡令
	BuyShopLost = 216,			--商店购买失去
	AlterLost = 217,	--七星坛
	PVELost = 218, 	--pve较少体力
	PVPLost = 219, 	--pvp减少体力
	GuildLostMoney = 220,	--英雄试炼减铜钱
	strEngLost = 221,		--强化装备失去
	compoundLost = 222,		--合成装备失去
	RefreshLost = 223,		--洗练装备失去
	SellItem = 224,			--贩卖道具
	ExpMove = 225,			--经验转移失去
	
}

g_GMCode =
{
	--获得金钱
	MoneyBegin = 400,
	PassGetMoney = 401,				--关卡获得
	MarketGetMoney = 402,				--人才市场获得
	ACTLVGetMoney = 403,				--活动LV获得
	LoginRewardGetM = 404,		--登陆领奖
	--SpeStarGet = 15,				--*********星星领奖获得特殊物品,金钱金币也对应这个15
	StructureADDMoney = 406,		-- 主城任务获得
	
	DisbandGet = 407,		--遣散士兵获得
	TaxGetMoney = 408,			--主城税收
	SellCardGetM = 409,			--卖卡
	UseItemGetM = 410,			--使用物品
	MissionGetM = 411,	--任务获得
	XzlyGetM = 412,		--血战
	MissionMainGetM = 413,	--主线任务获得
	GuildPass = 414,	--行会关卡
    BuyMoneyGetM = 415,  -- 购买金币
	SellEquipGetM = 416,			--卖装备卡
	UseBoxGetMoney = 417,			--开宝箱
	ShopGetMoney = 418,				--商店获取
	LevelUpGetMoney = 419,			--升级获取
	SellItemM = 420,				--卖道具
	
	--失去金钱
	TrainLostMoney = 500,			--培养白卡失去
	ConstructLevelUp = 501,			--建筑升级失去
	CommonStore = 502,				--普通商店购买
	SecretStore = 503,				--神秘商店购买
	MarketLostMoney= 504,			--人才市场刷新扣钱
	StrengSLost = 505,				--强化士兵 
	
	GetSoldierLM = 506,			--招募士兵 
	StrengthenCardLM = 507,		--强化角色卡
	strengEquipLostM = 508,		--装备强化
	CompoundEquipLostM = 509,   --合成装备
	RefreshEquipLostM = 510,	--洗练装备
	ActifLostM = 511,			--公会捐献

	--获得元宝
	--SpeStarGet = 15,				--*********星星领奖获得特殊物品,金钱金币也对应这个15
	GoldBegin = 600,
	PassGetGold = 601,				--关卡获得
	MarketGetGold = 602,			--人才市场获得
	ACTLVGetGold = 603,				--活动LV获得
	LoginRewardGetG = 604,		--登陆领奖
	TaxGetGold = 605,			--主城税收
	UseItemGetG = 606,			--使用物品
	MissionGetG = 607,	--任务获得
	PassStarGetG = 608,	--副本通关获得星星奖励
	MissionMainGetG = 609,	--主线任务获得
	Recharge = 610,			--充值
	MonthVip = 611,			--充值月卡
	StructureADDGold = 612,		-- 主城任务获得
	UseBoxGetGold		 = 613,		-- 开宝箱
	GrowUpGet				 = 614,		-- 成长计划获取
	LevelUpGetGold = 615,				-- 升级获取
	XzlyGetGold	= 616,					-- 血战洛阳获取
	OnlineGetGold = 617,				-- 在线领奖获取
	ShopGetGold = 618,					-- 商店获得
	payFavorableGet = 619,				--充值优惠
	
	--失去元宝
	SampleLost = 700,				--抽卡失去
	MarketLostGold = 701,			--人才市场刷新扣钱
	TianTiLostGold = 702,			--购买天梯次数
	TaxLostGold = 703,				--强制收税
	BuyEnergyLostG = 704,	--购买体力
	AlterLostG = 705,	--七星坛
	ScoreStoreLG = 706,	--积分商城刷新扣除
    ChatLost = 707,     -- 聊天
    BuyMoneyLostG = 708,    -- 购买钱币
	StructureLostGold = 709,		--主城加速任务
	BuyGrowUp = 710,		--购买成长计划
	RefreshFB = 711,		--刷新副本
	BuyPVP = 712,			--购买pvp挑战次数
	CreateGuild = 713,		--创建公会
	GuildJumpItem = 714,	--公会插队失去元宝
	BuyGoodsLostGold = 715,	--普通商品购买物品 
	ResetPass = 716,		--重置精英副本
	strengEquipLostG = 717,	--装备强化
	CompoundEquipLostG = 718, --合成装备
	RefreshEquipLostG = 719,  --洗练装备
	ActifLostG		  = 720,  --公会捐献
	gvgBugLive 		  = 721,  --公会战复活
	

	
	--获得武魂
	MissionGetS = 800,	--任务获得
	PassGetS = 801, --关卡获得
	XzlyGetS = 802,		--血战
	MissionMainGetS =  803,	--主线任务获得
	UseBoxGetS = 804,  --使用宝箱获得
	ShopGetS = 805,    --商店获取
	ExpMove = 806,	   --经验转移
	--失去武魂
	strengEquipLostS = 850,	--装备强化
	CompoundEquipLostS = 851, --合成装备
	RefreshEquipLostS = 852,  --洗练装备
	--失去魂晶
	BuyGoodsLostHunjing = 900,	--刷新商店
	strengEquipLostH= 901,		--装备强化
	CompoundEquipLostH = 902,	--合成装备
	RefreshEquipLostH = 903,    --洗练装备
	
	--获得魂晶
	UseBoxGetH = 950,			--开宝箱获得
	--事件
	OnlineGet = 910,			--在线领奖
	
	
	
}

g_evtCode =
{
	Login = 1,	--玩家登陆事件
	Logout = 2,	--玩家登出事件
	Pending = 3,		--玩家掉线挂起
	Reconnect = 4,		--玩家掉线重连
	PlayerCount = 5,	--玩家数量
	LevelUp = 6,	--玩家升级
	Recharge = 7,	--玩家充值
	RevEmail = 8,	--玩家收到邮件
	DelEmail = 9,	--玩家删除邮件
	Guide = 10,	--新手指引
	PVEPass = 11,	--关卡事件
	PVPTianTi = 12, --天梯
	PVEElitePass = 13,	--精英关卡事件
	PVESweepPass = 14,	--扫荡关卡事件
	PVESweepElitePass = 15,	--扫荡精英关卡事件
	PVEXzly = 16,	--血战事件
	AddRoleCardExp = 17, --增加角色卡经验
	SellRoleCard = 18,	--卖卡
	AddRoleCardClass = 19,	--武将进阶
	AddSoldierExp = 20,	--士兵强化
	AddSoldierClass = 21,	--士兵进阶
	UseItem = 22,	--道具使用
	FragCompound = 23, --碎片合成
	MissionReward = 24,--任务领奖
	BuyEnergy = 25,	--购买体力
	MakeFormation = 26,	--布阵
	RefreshAlter = 27,	--七星坛
	GetTax = 28,	--收税
	SampleCard = 29,	--抽卡
	BuyGoods = 30,	--购买物品
	BuyFrag = 31,	--（积分商城）购买碎片
	RefreshScoreStore = 32,	--刷新积分商城
	GuildPass = 33,	--行会关卡
	GMSendEmail = 34,	--gm发送邮件
	XssjAddScore = 35,	--限时神将增加积分
	XssjSample = 36,	--限时神将抽卡
	TTZBbalance = 37,	--天梯争霸结算奖励
	TTbalance = 38,		--天梯结算奖励
	XZLYbalance = 39,	--血战洛阳结算奖励
	structurebalance = 40,	--领取主城任务奖励
	heroTrail = 41,		--领取英雄试炼奖励
	xssjbalance = 42,	--限时神将结算
	payFavorable = 43,		--充值优惠活动结算
	strengEquip = 44,		--强化装备
	CompoundEquip = 45,		--合成装备
	RefreshEquip = 46,		--洗练装备
	bugplayer = 47,			--有bug的地方 0、while 1 公会相关
	useCDkey = 48,			--使用兑换码
	chairmanTransfer = 49,	--会长转让
	gvgEnd = 50,			--公会战结束
	gvgGetreward = 51,		--公会战领取奖励
	reduceGuildActif = 52,	--减少公会资金
	returnGuildActif = 53,	--失败方返回公会资金
	ExpMove = 54,			--经验转移
	AddRoleCardExpToJJD = 55,	--增加角色经验卡 通过经验丹
}