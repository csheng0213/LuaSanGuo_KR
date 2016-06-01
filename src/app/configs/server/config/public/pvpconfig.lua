g_PVPConfig = {

	MaxPVPCount = 10,  -- ��
	MaxUnbrokenCount = 10,  -- ����
	RefreshCD = 5,  -- ˢ��CD(��)
	ChallengeCD = 10,  -- ��սCD(��)
	FightRatio = {  -- ��(��Ӧ3)
		Attack = 1 / 2.5,  -- ��ϵ��
		Defense = 1 / 1.5,  -- ��ϵ��
		HP = 1 / 13,  -- Ѫϵ��
		AttackSpeed = 1000 / 360,  -- 
		CounterRatio = 1000 / 480 / (9.6 / 6.6),  -- 
		HitRatio = 1000 / 400 / (9.6 / 3.6),  -- 
		GasSpeed = 1000 / 2 / (9.6 / 1.64),  -- 
		GasDamage = 1000 / 280 / (9.6 / 2.3),  -- 
	},
	MatchRule = {  -- 
		BaseFightRatio = 1,  -- ��ϵ��(�� = ս���� * ϵ��)
		DecrementRatioAfterWin = 0.1,  -- ֵ
		FightRangeRatio = 0.7,  -- Χϵ��(�� = �� * (1 + )������)
		MaxPlayerCount = 3,  -- ����
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
	Award = {  -- ʤ��x����(0)
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
	AvengerAward = {  -- ����
		{12,4,2},
	},
}