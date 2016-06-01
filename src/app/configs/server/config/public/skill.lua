--[[
-- 
AFCL_ALL,       = 0             -- 
AFCL_ANY,       = 1             -- 个条件

-- 的英雄
AFCH_NONE,
AFCH_MAIN_HERO		= 1,    -- 主将
AFCH_VICE_HERO1		= 2,    -- 副将1
AFCH_VICE_HERO2		= 4,    -- 副将2
AFCH_SELF			= 0,    -- 自己
--主将+2副将=7

-- 的阵营
0       -- 
1       -- 

-- 优先级
发


信息
-- 
AFCT_PID_RANGE,        = 1      -- 英雄的id范围
AFCT_FRAME_LEAST,      = 2      -- 少帧
AFCT_FRAME_MOST,       = 3      -- 少帧
AFCT_HP_LEAST,         = 4      -- 70%时，在70%
AFCT_HP_MOST,          = 5      -- 30%时，在30%能）
AFCT_HP_MAX_LEAST,     = 6      -- 多少
AFCT_HP_MAX_MOST,      = 7      -- 过
AFCT_MP_LEAST,         = 8      -- 蓝条）
AFCT_MP_MOST,          = 9      -- 不超过
AFCT_MP_MAX_LEAST,     = 10     -- 】
AFCT_MP_MAX_MOST,      = 11     -- 过
AFCT_ATK_LEAST,        = 12     -- 
AFCT_ATK_MOST,         = 13     -- 不超过
AFCT_ATK_RANGE_LEAST,  = 14     -- 多少
AFCT_ATK_RANGE_MOST,   = 15     -- 过
AFCT_ATK_SPD_LEAST,    = 16     -- 多少
AFCT_ATK_SPD_MOST,     = 17     -- 过
AFCT_MV_SPD_LEAST,     = 18     -- 多少
AFCT_MV_SPD_MOST,      = 19     -- 过

-- 帧
1秒钟为60帧

-- 值
值

-- 
hp及mp上

-- pid下限


-- pid上限
英雄
--]]

--
--
--
-- 表头
local data = {}

local SkillConditionAlwaysTrue = {}
for i=1, 10 do
	SkillConditionAlwaysTrue[i] = {
		logic = 0,
		[1] = { condtype = 2, checkhero = 0, friendly = 1, frame = 10,   val = 0, val_pct = 0, pid_low = 0, pid_high = 0 },
	}
	SkillConditionAlwaysTrue[i].prior = i
end

-- 英雄id
for i=1, 741 do
	data[1] = SkillConditionAlwaysTrue
end

AutoFightConfig = data

AddLog("OK!")
