local GuideConfig = 
{
	[1] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "text", guideData = "10001" },
            { ctlName = "MainViewController", type = "button", btName = "SignRewardBt", guideData = LanguageConfig["guide_1_1"] },
            { ctlName = "MainViewController", type = "button", btName = "prizeBt", guideData = LanguageConfig["guide_1_2"], isFinish = true },
            { ctlName = "MainViewController", type = "button", btName = "closeBt" },
        }
    },
    [2] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
                { ctlName = "MainViewController", type = "text", guideData = "10002" },
                { ctlName = "MainViewController", type = "button", btName = "zhaomuBt", guideData = LanguageConfig["guide_2_1"] },
                { ctlName = "EnlistViewController", type = "button", btName = "Button_bao_1", guideData = LanguageConfig["guide_2_2"], isFinish = true },
                { ctlName = "EnlistViewController", type = "button", btName = "Button_back_1", guideData = LanguageConfig["guide_2_3"], delay = 2.0  },
        }
    },
    
    [3] = 
    {
        startCtlName = "EnlistViewController",
        guideDatas = {
            { ctlName = "EnlistViewController", type = "button", btName = "Button_mianFei_1", guideData = LanguageConfig["guide_3_1"], isFinish = true },
            { ctlName = "EnlistViewController", type = "button", btName = "Button_back_1", guideData = LanguageConfig["guide_3_2"],delay = 2.0 },
            { ctlName = "EnlistViewController", type = "button", btName = "Button_back", guideData = LanguageConfig["guide_3_2"] },
        },
        startCtlName_def = "MainViewController",
        guideDatas_def = {
                { ctlName = "MainViewController", type = "button", btName = "zhaomuBt", guideData = LanguageConfig["guide_2_1"] },
        }
    },
    [4] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "text", guideData = "10003" },--布阵引导
            { ctlName = "MainViewController", type = "button", btName = "buzhenBt", guideData = LanguageConfig.guide_4_1 },
            { ctlName = "EmbattleViewController", type = "button", btName = "mainHeroBt", guideData = LanguageConfig.guide_4_2 },
            -- { ctlName = "SelectHeroViewController", type = "text", guideData = "10004" },--选择一个武将
            { ctlName = "SelectHeroViewController", type = "button", btName = "hero1Bt",  delay = 0.1, guideData = LanguageConfig.guide_4_3 },
            { ctlName = "SelectHeroViewController", type = "button", btName = "shangzhenBt", guideData = LanguageConfig.guide_4_4 },
            { ctlName = "EmbattleViewController", type = "button", btName = "viceHero1Bt", guideData = LanguageConfig.guide_4_5 },
            { ctlName = "SelectHeroViewController", type = "button", btName = "hero2Bt",  delay = 0.1, guideData = LanguageConfig.guide_4_6 },
            { ctlName = "SelectHeroViewController", type = "button", btName = "shangzhenBt", guideData = LanguageConfig.guide_4_7 },
            { ctlName = "EmbattleViewController", type = "button", btName = "onKeyBt", guideData = LanguageConfig.guide_4_8 },
            { ctlName = "EmbattleViewController", type = "button", btName = "saveBt", guideData = LanguageConfig.guide_4_9,isFinish = true },
            { ctlName = "EmbattleViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_4_10 },
        }
    },
    [5] = 
	{
		startCtlName = "MainViewController",
		guideDatas = {
            { ctlName = "MainViewController", type = "button", btName = "outFightBt", guideData = LanguageConfig.guide_5_1 },
            { ctlName = "FbSelectViewController", type = "button", btName = "firstGk1", guideData = LanguageConfig.guide_5_2 },
            { ctlName = "MinFbSelectViewController", type = "button", btName = "fightBt", guideData = LanguageConfig.guide_5_3 },
            { ctlName = "CombatViewController", type = "button", btName = "startBt", guideData = LanguageConfig.guide_5_4, delay = 0.2},
            { ctlName = "CombatViewController", type = "button", btName = "winSureBt", delay = 1.2},
            { ctlName = "CombatViewController", type = "button", btName = "surt_bt", delay = 1.5},
            { ctlName = "MinFbSelectViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_5_6 },
            { ctlName = "FbSelectViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_5_7 },
		}
	},
	
	[6] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
                { ctlName = "MainViewController", type = "text", guideData = "10005" },
                { ctlName = "MainViewController", type = "button", btName = "upLevelBt", guideData = LanguageConfig["guide_6_1"] },
                { ctlName = "EnhanceViewController", type = "button", btName = "Button_jinjie_2", guideData = LanguageConfig["guide_6_2"]},
                { ctlName = "EnhanceViewController", type = "button", btName = "Button_card8", guideData = LanguageConfig["guide_6_3"]},
                { ctlName = "HeroViewController", type = "button", btName = "guidCard", guideData = LanguageConfig["guide_6_4"],delay = 0.3 },
                { ctlName = "EnhanceViewController", type = "button", btName = "Button_up_ladder", guideData = LanguageConfig["guide_6_5"], isFinish = true},
                { ctlName = "EnhanceViewController", type = "button", btName = "Button_up_close", guideData = LanguageConfig["guide_6_6"],delay = 3.7 },
                { ctlName = "EnhanceViewController", type = "text", guideData = "10006"},
                { ctlName = "EnhanceViewController", type = "button", btName = "Button_back", guideData = LanguageConfig["guide_6_7"] },
        }
    },
    [7] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "button", btName = "outFightBt", guideData = LanguageConfig.guide_7_1 },
            { ctlName = "FbSelectViewController", type = "button", btName = "firstGk1", guideData = LanguageConfig.guide_7_2 },
            { ctlName = "MinFbSelectViewController", type = "button", btName = "fightBt", guideData = LanguageConfig.guide_7_3 },
            { ctlName = "CombatViewController", type = "button", btName = "startBt", guideData = LanguageConfig.guide_7_4, delay = 0.2 },
        }
    },
    [8] = 
    {
        startCtlName = "MinFbSelectViewController",
        guideDatas = {
            { ctlName = "MinFbSelectViewController", type = "button", btName = "fightBt", guideData = LanguageConfig.guide_8_1 },
            { ctlName = "CombatViewController", type = "button", btName = "bzBt", guideData = LanguageConfig.guide_8_2, delay = 0.2 }, --新手中士兵引导
            { ctlName = "EmbattleViewController", type = "button", btName = "cheJunBt", guideData = LanguageConfig.guide_8_3}, --新手中士兵引导
            { ctlName = "EmbattleViewController", type = "button", btName = "soldier2", guideData = LanguageConfig.guide_8_4 },
            { ctlName = "EmbattleViewController", type = "button", btName = "gird_6_0", guideData = "" },
            { ctlName = "EmbattleViewController", type = "button", btName = "gird_5_1", guideData = "" },
            { ctlName = "EmbattleViewController", type = "button", btName = "gird_4_2", guideData = "" },
            { ctlName = "EmbattleViewController", type = "button", btName = "gird_6_8", guideData = "" },
            { ctlName = "EmbattleViewController", type = "button", btName = "gird_5_7", guideData = "" },
            { ctlName = "EmbattleViewController", type = "button", btName = "gird_4_6", guideData = "" },
            { ctlName = "EmbattleViewController", type = "button", btName = "soldier3", guideData = LanguageConfig.guide_8_5 },
            { ctlName = "EmbattleViewController", type = "button", btName = "gird_3_3", guideData = "" },
            { ctlName = "EmbattleViewController", type = "button", btName = "gird_3_5", guideData = "" },
            { ctlName = "EmbattleViewController", type = "button", btName = "gird_2_4", guideData = "" },
            { ctlName = "EmbattleViewController", type = "button", btName = "saveBt", guideData = "" },
            { ctlName = "EmbattleViewController", type = "button", btName = "backBt", guideData = "" },
            { ctlName = "CombatViewController", type = "button", btName = "startBt", guideData = LanguageConfig.guide_8_6, delay = 0.2 },
            { ctlName = "MinFbSelectViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_8_7 },
            { ctlName = "FbSelectViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_8_8 },
        },
        startCtlName_def = "MainViewController",
        guideDatas_def = {
            { ctlName = "MainViewController", type = "button", btName = "outFightBt", guideData = LanguageConfig.guide_7_1 },
            { ctlName = "FbSelectViewController", type = "button", btName = "firstGk1", guideData = LanguageConfig.guide_7_2 },
        }
    },
    [9] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "text", guideData = "10007" },--布阵引导
            { ctlName = "MainViewController", type = "button", btName = "upLevelBt", guideData = LanguageConfig["guide_9_1"] },
            { ctlName = "EnhanceViewController", type = "button", btName = "Button_shengji_1", guideData = LanguageConfig["guide_9_2"]},
            { ctlName = "EnhanceViewController", type = "button", btName = "Button_card1", guideData = LanguageConfig["guide_9_3"]},
            { ctlName = "HeroViewController", type = "button", btName = "guidCard", guideData = LanguageConfig["guide_9_4"],delay = 0.3 },
            { ctlName = "EnhanceViewController", type = "button", btName = "Button_auto_add", guideData = LanguageConfig["guide_9_5"]},
            { ctlName = "EnhanceViewController", type = "button", btName = "Button_up_level", guideData = LanguageConfig["guide_9_6"], isFinish = true},
            { ctlName = "EnhanceViewController", type = "text", guideData = "10008"},
            { ctlName = "EnhanceViewController", type = "button", btName = "Button_sheng_ji_close"},
            { ctlName = "EnhanceViewController", type = "button", btName = "Button_back"},
        }
    },
    [10] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "text", guideData = "10009" },--装备引导
            { ctlName = "MainViewController", type = "button", btName = "PropitemBt", guideData = LanguageConfig.guide_10_1 },
            { ctlName = "PropViewController", type = "button", btName = "equipBt", guideData =  LanguageConfig.guide_10_2},
            { ctlName = "PropViewController", type = "button", btName = "useBt", guideData =  LanguageConfig.guide_10_3, isFinish = true},
            { ctlName = "PropViewController", type = "button", btName = "okbt",delay = 0.4, guideData = LanguageConfig.guide_10_4},
            { ctlName = "PropViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_10_5 },
        }
    },
    [11] =
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "text", guideData = "10010" },--装备界面
            { ctlName = "MainViewController", type = "button", btName = "zhuangbeiBt", guideData = LanguageConfig.guide_11_1 },
            { ctlName = "EquipmentViewController", type = "button", btName = "equip1Bt", guideData = LanguageConfig.guide_11_2 },
            { ctlName = "EquipmentViewController", type = "button", btName = "firstEquipBt", guideData = LanguageConfig.guide_11_3 },
            { ctlName = "EquipmentViewController", type = "button", btName = "bt", guideData = LanguageConfig.guide_11_4 ,isFinish = true},
            { ctlName = "EquipmentViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_11_5 },
        }
    },
    [12] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "button", btName = "outFightBt", guideData = LanguageConfig.guide_12_1},
            { ctlName = "FbSelectViewController", type = "button", btName = "firstGk1", guideData = LanguageConfig.guide_12_2 },
            { ctlName = "MinFbSelectViewController", type = "button", btName = "fightBt", guideData = LanguageConfig.guide_12_3},
            { ctlName = "CombatViewController", type = "button", btName = "startBt", guideData = LanguageConfig.guide_7_4, delay = 0.2 },
        }
    },

    [13] = 
    {
        startCtlName = "MinFbSelectViewController",
        guideDatas = {
            { ctlName = "MinFbSelectViewController", type = "button", btName = "gkBt4", guideData = LanguageConfig.guide_105_1},
            { ctlName = "MinFbSelectViewController", type = "button", btName = "shaodangBt", guideData = LanguageConfig.guide_105_2},
            { ctlName = "MinFbSelectViewController", type = "button", btName = "okBt", guideData = LanguageConfig.guide_105_8, isFinish = true },
            { ctlName = "MinFbSelectViewController", type = "button", btName = "sweepSucOkBt", guideData = LanguageConfig.guide_105_4},
            { ctlName = "MinFbSelectViewController", type = "button", btName = "surt_bt", delay = 1.5},
            { ctlName = "MinFbSelectViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_105_5 },
            { ctlName = "FbSelectViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_105_6 },
        },
        startCtlName_def = "MainViewController",
        guideDatas_def = {
            { ctlName = "MainViewController", type = "button", btName = "outFightBt"},
            { ctlName = "FbSelectViewController", type = "button", btName = "firstGk1"},
        }
    },
    [14] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "button", btName = "chengjiuBt", guideData = LanguageConfig.guide_14_1 },
            { ctlName = "ChengJiuViewController", type = "button", btName = "chengJiuBox1", guideData = LanguageConfig.guide_14_2, pos = { x = 330, y = 0 }},
            { ctlName = "ChengJiuViewController", type = "button", btName = "okbt", delay = 0.3 , isFinish = true },
            { ctlName = "ChengJiuViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_14_3 },
        },
    },
    [15] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "button", btName = "taskBt", guideData = LanguageConfig.guide_15_1 },
            { ctlName = "TaskViewController", type = "text", guideData = "10011" },
            { ctlName = "TaskViewController", type = "button", btName = "stageBt_1", guideData = LanguageConfig.guide_15_2 },
            { ctlName = "TaskViewController", type = "button", btName = "rewardBt", delay = 0.5 ,isFinish = true },
            { ctlName = "TaskViewController", type = "button", btName = "closeBt" },
        },
    },
    [16] = 
    {
        startCtlName = "TaskViewController",
        guideDatas = {
            { ctlName = "TaskViewController", type = "text", guideData = "10012" },
            { ctlName = "TaskViewController", type = "button", btName = "taskBt", guideData = LanguageConfig.guide_16_1, isFinish = true},
        },
        startCtlName_def = "MainViewController",
        guideDatas_def = {
            { ctlName = "MainViewController", type = "button", btName = "taskBt", guideData = LanguageConfig.guide_15_1 },
        }
    },
    
    [100] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
                { ctlName = "MainViewController", type = "button", btName = "shopBt", guideData = LanguageConfig["guide_100_1"] },
                { ctlName = "ShopViewController", type = "button", btName = "shopWidget", guideData = LanguageConfig["guide_100_2"]},
                { ctlName = "ShopViewController", type = "button", btName = "Button_Pop_buy", isFinish = true},
                { ctlName = "ShopViewController", type = "text",  guideData = "10013"},
                { ctlName = "ShopViewController", type = "button", btName = "Button_back"},
        }
    },
    
    [101] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "button", btName = "hechengBt", guideData = LanguageConfig["guide_101_1"] },
            { ctlName = "CompoundViewController", type = "button", btName = "heChenWidget", guideData = LanguageConfig["guide_101_2"], isFinish = true},
            { ctlName = "CompoundViewController", type = "button", btName = "Button_back", guideData = LanguageConfig["guide_101_3"],delay = 3 },
        }
    },
    
    [200] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
                { ctlName = "MainViewController", type = "text",  guideData = "10014" },
            { ctlName = "MainViewController", type = "button", btName = "upLevelBt", guideData = LanguageConfig["guide_200_1"] },
            { ctlName = "EnhanceViewController", type = "button", btName = "Button_Soldiers", guideData = LanguageConfig["guide_200_2"]},
                { ctlName = "EnhanceViewController", type = "text",  guideData = "10015",delay = 0.4 },
            { ctlName = "EnhanceViewController", type = "button", btName = "Button_up_level", guideData = LanguageConfig["guide_200_3"], isFinish = true},
            { ctlName = "EnhanceViewController", type = "button", btName = "Button_close_1", guideData = LanguageConfig["guide_200_4"] },
            { ctlName = "EnhanceViewController", type = "button", btName = "Button_back", guideData = LanguageConfig["guide_200_5"] },
        }
    },
    [300] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "text", guideData = "10016" },--偏将引导
            { ctlName = "MainViewController", type = "button", btName = "buzhenBt", guideData = LanguageConfig.guide_300_1 },
            { ctlName = "EmbattleViewController", type = "button", btName = "pianJiangBt", guideData = LanguageConfig.guide_300_2},
            { ctlName = "PartHeroViewController", type = "button", btName = "partHero1Bt", guideData = LanguageConfig.guide_300,isFinish = true},
            --{ ctlName = "SelectHeroViewController", type = "button", btName = "hero4Bt",  delay = 0.2, guideData = LanguageConfig.guide_101_4 },
           -- { ctlName = "SelectHeroViewController", type = "button", btName = "shangzhenBt", guideData = LanguageConfig.guide_101_5},
           -- { ctlName = "PartHeroViewController", type = "button", btName = "backBt_2", guideData = LanguageConfig.guide_101_6 },
           -- { ctlName = "EmbattleViewController", type = "button", btName = "saveBt", guideData = LanguageConfig.guide_101_7,isFinish = true },
           -- { ctlName = "EmbattleViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_101_8 },

        }
    },
    [400] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
                { ctlName = "MainViewController", type = "text",  guideData = "10021" },
            { ctlName = "MainViewController", type = "button", btName = "mainCityBt", guideData = LanguageConfig["guide_400_1"] },
                { ctlName = "CityViewController", type = "text",  guideData = "10022",delay = 0.2 },
                { ctlName = "CityViewController", type = "text",  guideData = "10023"},
            { ctlName = "CityViewController", type = "button", btName = "Panel_hero_1", guideData = LanguageConfig["guide_400_2"]},
            { ctlName = "SelectHeroViewController", type = "button", btName = "hero1Bt", guideData = LanguageConfig["guide_400_3"], delay = 0.2},
            { ctlName = "SelectHeroViewController", type = "button", btName = "shangzhenBt", guideData = LanguageConfig["guide_400_7"]},
            { ctlName = "CityViewController", type = "button", btName = "Button_hero_OK_1", guideData = LanguageConfig["guide_400_5"], isFinish = true},
                { ctlName = "CityViewController", type = "text",  guideData = "10024"},
                { ctlName = "CityViewController", type = "text",  guideData = "10025"},
            { ctlName = "CityViewController", type = "button", btName = "Button_back" ,guideData = LanguageConfig["guide_400_6"]},
            
        }
    },
    [500] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "text", guideData = "10017" },--天梯引导
            { ctlName = "MainViewController", type = "button", btName = "tiantiBt", guideData = LanguageConfig.guide_500_1 },
            { ctlName = "TianTiViewController", type = "button", btName = "tiaozhanBt1", guideData = LanguageConfig.guide_500_2},
            { ctlName = "CombatViewController", type = "button", btName = "startBt", guideData = LanguageConfig.guide_500_3, delay = 0.2,isFinish = true },
            
        }
    },

    [501] = 
    {
        startCtlName = "TianTiViewController",
        guideDatas = {
            { ctlName = "TianTiViewController", type = "text", guideData = "10018" },
            { ctlName = "TianTiViewController", type = "button", btName = "defentBt", guideData = LanguageConfig.guide_500_4},
            { ctlName = "EmbattleViewController", type = "text", guideData = "10019" ,isFinish = true},
            -- { ctlName = "EmbattleViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_500_5 },
        },
        startCtlName_def = "MainViewController",
        guideDatas_def = {
            { ctlName = "MainViewController", type = "button", btName = "tiantiBt" },
        }
    },
    
    [502] = 
    {
        startCtlName = "TianTiViewController",
        guideDatas = {
            { ctlName = "TianTiViewController", type = "button", btName = "taskBt", guideData = LanguageConfig["guide_502_1"] },
            { ctlName = "IntegralShopViewController", type = "text",  guideData = "10020", isFinish = true},
            { ctlName = "IntegralShopViewController", type = "button", btName = "Button_back", guideData = LanguageConfig["guide_502_2"]},
            { ctlName = "TianTiViewController", type = "button", btName = "backBt_8"},
            },
        startCtlName_def = "MainViewController",
        guideDatas_def = {
            { ctlName = "MainViewController", type = "button", btName = "tiantiBt", guideData = LanguageConfig["guide_502_3"] },
        }
    },
    
    [600] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "text", guideData = "10026" },--七星坛引导
            { ctlName = "MainViewController", type = "button", btName = "sevenStarBt", guideData = LanguageConfig.guide_600_1},
            { ctlName = "SevenStarViewController", type = "button", btName = "card", guideData = LanguageConfig.guide_600_2 },
            { ctlName = "SelectHeroViewController", type = "button", btName = "hero1Bt",  delay = 0.2, guideData = LanguageConfig.guide_600_3 },
            { ctlName = "SelectHeroViewController", type = "button", btName = "shangzhenBt", guideData = LanguageConfig.guide_600_4},
            { ctlName = "SevenStarViewController", type = "button", btName = "zhenBt", guideData = LanguageConfig.guide_600_5},
            { ctlName = "SevenStarViewController", type = "button", btName = "refrashBt", guideData = LanguageConfig.guide_600_6},
            -- { ctlName = "SevenStarViewController", type = "button", btName = "affirmBt", delay = 0.2,guideData = LanguageConfig.guide_600_7,isFinish = true},
            { ctlName = "SevenStarViewController", type = "button", btName = "backBt", guideData = LanguageConfig.guide_600_8,isFinish = true},
        }
    },
    
    
    [700] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "text",  guideData = "10027"},
            { ctlName = "MainViewController", type = "button", btName = "tinkerBt", guideData = LanguageConfig["guide_700_1"], isFinish = true },
        }
    },
    [800] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "button", btName = "heroTrialsBt", guideData = LanguageConfig.guide_800_1},
            { ctlName = "ShiLianViewController", type = "button", btName = "shilianBt", guideData = LanguageConfig.guide_800_2},
            { ctlName = "HeroShiLianViewController", type = "text", guideData = "10028" ,isFinish = true},
        },
    },

    [900] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "text", guideData = "10029"},
            { ctlName = "MainViewController", type = "button", btName = "xuezhanBt", guideData = LanguageConfig.guide_900_1},
            { ctlName = "XueZhanViewController", type = "text", guideData = "10030"},
            { ctlName = "XueZhanViewController", type = "button", btName = "tiaoZhanBt1", guideData = LanguageConfig.guide_900_2,isFinish = true},
        },
    },
        
        
    [1000] = 
    {
        startCtlName = "XueZhanViewController",
        guideDatas = {
            { ctlName = "XueZhanViewController", type = "text",  guideData = "10031" },
        },
    },
    [1001] = 
    {
        startCtlName = "MainViewController",
        guideDatas = {
            { ctlName = "MainViewController", type = "text",  guideData = "10032" },
        },
    },
    [1002] = 
    {
        startCtlName = "MinFbSelectViewController",
        guideDatas = {
            { ctlName = "MinFbSelectViewController", type = "button", btName = "jyTab", guideData = LanguageConfig.guide_1002_1 },
            { ctlName = "MinFbSelectViewController", type = "text",  guideData = "10033" },
        },
    }
}



return GuideConfig