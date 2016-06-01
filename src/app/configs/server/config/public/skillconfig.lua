--[[
-- 
]]

g_SkillConfig = {}
g_SkillUpgrade = {}
g_SkillExp = {}

local function ReadSkillConfig ()
	-- lua表
	local function loadtable(str)
		local func = loadstring(string.format('do return {%s} end', str))
		if not func then return nil end
		return pcall(func)
	end
	-- 表
	local ratio = {}
	local function getRatioTbl(id)
		local tmp = ratio[id]
		
		if not tmp then
			tmp = {}
			LoadConfig(
				'data/skillconfig/skillratio/'..id..'.txt',
				{
					{'lv', tonumber},
					{1, tonumber},
					{2, tonumber},
					{3, tonumber},
					{4, tonumber},
					{5, tonumber},
				},
				function (row)
					tmp[row.lv] = row
					row.lv = nil
				end
			)
			
			if table.empty(tmp) then
				return nil
			end
			
			ratio[id] = tmp
		end
		
		return tmp
	end
	-- 表
	local attrib = {}
	local function getAttribTbl(id)
		local tmp = attrib[id]
		
		if not tmp then
			tmp = {}
			LoadConfig(
				'data/skillconfig/skilleffect/'..id..'.txt',
				{
					{'lv', tonumber},
					-- 例
					{1, tonumber}, {6, tonumber},
					{2, tonumber}, {7, tonumber},
					{3, tonumber}, {8, tonumber},
					{4, tonumber}, {9, tonumber},
					{5, tonumber}, {10, tonumber},
					-- 
					{11, tonumber}, {16, tonumber},
					{12, tonumber}, {17, tonumber},
					{13, tonumber}, {18, tonumber},
					{14, tonumber}, {19, tonumber},
					{15, tonumber}, {20, tonumber},
				},
				function (row)
					-- { ratio = {, }, value = {基础值, 值系数} }
					tmp[row.lv] = {
						{ ratio = {row[1], row[6]}, value = {row[11], row[16]} },
						{ ratio = {row[2], row[7]}, value = {row[12], row[17]} },
						{ ratio = {row[3], row[8]}, value = {row[13], row[18]} },
						{ ratio = {row[4], row[9]}, value = {row[14], row[19]} },
						{ ratio = {row[5], row[10]}, value = {row[15], row[20]} },
					}
				end
			)
			
			if table.empty(tmp) then
				return nil
			end
			
			attrib[id] = tmp
		end
		
		return tmp
	end
	-- 
	g_SkillConfig = {}
	local count = 0
	LoadConfig(
		'data/skillconfig/skillconfig.txt',
		{
			{'id', tonumber},				-- 技能ID
			{'name', tostring},				-- 
			{'skillType', tonumber},		-- 
			{'maxLevel', tonumber},			-- 
			{'condType', loadtable},		-- 
			{'condParam', loadtable},		-- 
			{'ratioID', tonumber},			-- 几率表ID
			{'effectType', loadtable},		-- 
			{'effectParam', loadtable},		-- 效果表ID
			{'gas', tonumber},				-- 
		},
		function (row)
			-- 
			local condType, condParam = row.condType, row.condParam
			if not condType then
				error('Can`t parse skill condition types [id:'..row.id..']')
			end
			if not condParam then
				error('Can`t parse skill condition parameters [id:'..row.id..']')
			end
			if #condType ~= #condParam then
				error('The number of skill condition types and parameters is not the same [id:'..row.id..']')
			end
			local tmp = {}
			for k, v in ipairs(condType) do
				if v ~= 0 then
					tmp[v] = condParam[k]
				end
			end
			row.condition, row.condType, row.condParam = tmp, nil, nil
			-- 效果
			local effectType, effectParam = row.effectType, row.effectParam
			if not effectType then
				error('Can`t parse skill effect types [id:'..row.id..']')
			end
			if not effectParam then
				error('Can`t parse skill effect parameters [id:'..row.id..']')
			end
			if #effectType ~= #effectParam then
				error('The number of skill effect types and parameters is not the same [id:'..row.id..']')
			end
			local tmp = {}
			for k, v in ipairs(effectType) do
				local param = getAttribTbl(effectParam[k])
				if not param then
					error('Can`t load skill effect config [id:'..row.id..'][effect:'..effectParam[k]..']')
				end
				table.insert(tmp, {Type = v, Param = param})
			end
			row.effect, row.effectType, row.effectParam = tmp, nil, nil
			-- 表
			row.ratio = getRatioTbl(row.ratioID)
			if not row.ratio then
				error('Can`t load skill ratio config [id:'..row.id..']')
			end
			row.ratioID = nil
			g_SkillConfig[row.id] = row
			count = count + 1
		end)
	AddLog('Load skill count: '..count)
	
	-- 表
	g_SkillUpgrade = {}
	LoadConfig(
		'data/skillconfig/skillupgrade.txt',
		{
			{'lv', tonumber},
			{1, tonumber},
			{2, tonumber},
			{3, tonumber},
			{4, tonumber},
			{5, tonumber},
		},
		function (row)
			g_SkillUpgrade[row.lv] = row
			row.lv = nil
		end
	)
	
	-- 验表
	g_SkillExp = {}
	LoadConfig(
		'data/skillconfig/skillexp.txt',
		{
			{'lv', tonumber},
			{1, tonumber},
			{2, tonumber},
			{3, tonumber},
			{4, tonumber},
			{5, tonumber},
		},
		function (row)
			g_SkillExp[row.lv] = row
			row.lv = nil
		end
	)
end

--ReadSkillConfig()