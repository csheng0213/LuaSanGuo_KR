--[[
-- 
AFCL_ALL,       = 0             -- 
AFCL_ANY,       = 1             -- ������

-- ��Ӣ��
AFCH_NONE,
AFCH_MAIN_HERO		= 1,    -- ����
AFCH_VICE_HERO1		= 2,    -- ����1
AFCH_VICE_HERO2		= 4,    -- ����2
AFCH_SELF			= 0,    -- �Լ�
--����+2����=7

-- ����Ӫ
0       -- 
1       -- 

-- ���ȼ�
��


��Ϣ
-- 
AFCT_PID_RANGE,        = 1      -- Ӣ�۵�id��Χ
AFCT_FRAME_LEAST,      = 2      -- ��֡
AFCT_FRAME_MOST,       = 3      -- ��֡
AFCT_HP_LEAST,         = 4      -- 70%ʱ����70%
AFCT_HP_MOST,          = 5      -- 30%ʱ����30%�ܣ�
AFCT_HP_MAX_LEAST,     = 6      -- ����
AFCT_HP_MAX_MOST,      = 7      -- ��
AFCT_MP_LEAST,         = 8      -- ������
AFCT_MP_MOST,          = 9      -- ������
AFCT_MP_MAX_LEAST,     = 10     -- ��
AFCT_MP_MAX_MOST,      = 11     -- ��
AFCT_ATK_LEAST,        = 12     -- 
AFCT_ATK_MOST,         = 13     -- ������
AFCT_ATK_RANGE_LEAST,  = 14     -- ����
AFCT_ATK_RANGE_MOST,   = 15     -- ��
AFCT_ATK_SPD_LEAST,    = 16     -- ����
AFCT_ATK_SPD_MOST,     = 17     -- ��
AFCT_MV_SPD_LEAST,     = 18     -- ����
AFCT_MV_SPD_MOST,      = 19     -- ��

-- ֡
1����Ϊ60֡

-- ֵ
ֵ

-- 
hp��mp��

-- pid����


-- pid����
Ӣ��
--]]

--
--
--
-- ��ͷ
local data = {}

local SkillConditionAlwaysTrue = {}
for i=1, 10 do
	SkillConditionAlwaysTrue[i] = {
		logic = 0,
		[1] = { condtype = 2, checkhero = 0, friendly = 1, frame = 10,   val = 0, val_pct = 0, pid_low = 0, pid_high = 0 },
	}
	SkillConditionAlwaysTrue[i].prior = i
end

-- Ӣ��id
for i=1, 741 do
	data[1] = SkillConditionAlwaysTrue
end

AutoFightConfig = data

AddLog("OK!")
