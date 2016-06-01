g_PVPConfig = {

	MaxPVPCount = 10,  -- 数
	MaxUnbrokenCount = 10,  -- 次数
	RefreshCD = 5,  -- 刷新CD(秒)
	ChallengeCD = 10,  -- 挑战CD(秒)
	FightRatio = {  -- 数(对应3)
		Attack = 1 / 2.5,  -- 攻系数
		Defense = 1 / 1.5,  -- 防系数
		HP = 1 / 13,  -- 血系数
		AttackSpeed = 1000 / 360,  -- 
		CounterRatio = 1000 / 480 / (9.6 / 6.6),  -- 
		HitRatio = 1000 / 400 / (9.6 / 3.6),  -- 
		GasSpeed = 1000 / 2 / (9.6 / 1.64),  -- 
		GasDamage = 1000 / 280 / (9.6 / 2.3),  -- 
	},
	MatchRule = {  -- 
		BaseFightRatio = 1,  -- 力系数(力 = 战斗力 * 系数)
		DecrementRatioAfterWin = 0.1,  -- 值
		FightRangeRatio = 0.7,  -- 围系数(限 = 力 * (1 + )无下限)
		MaxPlayerCount = 3,  -- 家数
		WeakerRatioAfterWin = {  -- 
			[1] = 0.2,
			[2] = 0.15,
			[3] = 0.1,
			[4] = 0.05,
			[5] = 0.01,
			[6] = 0.002,
			[7] = 0.002,
			[8] = 0.002,
			[9] = 0.002,
			[10] = 0.002,
		}
	},
	Award = {  -- 胜利x奖励(0)
		--[[
			[x] = {{id, num}, {id, num}, ...}
		]]
			[0] = {{12,4,2},},
			[1] = {{12,4,4},},
			[2] = {{12,4,5},},
			[3] = {{12,4,6},},
			[4] = {{12,4,7},},
			[5] = {{12,4,8},},


	},
	AvengerAward = {  -- 奖励
		{12,4,2},
	},
}