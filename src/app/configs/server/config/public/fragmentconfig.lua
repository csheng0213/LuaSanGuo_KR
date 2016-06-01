--碎片配置

--[[
碎片配置需要满足道具配置，才能完全接入道具系统：
目前还需要处理的工作：修改配置表的配置，使其等同道具表的结构和使用方式；修改itemmanager，支持碎片处理。
--]]

--------------------------
--碎片表
g_FragmentCfg = {}
g_FragmentCfg.roleCfg = {}
g_FragmentCfg.equipCfg = {}
g_FragmentCfg.skillCfg = {}
g_FragmentCfg.itemCfg = {}

--读取配置表
local function ReadFragmentConfig ()
	local title = {
		{'id', tonumber},				-- 序号
		--{'quality', tonumber},			--品质
		--{'name', tostring},				--姓名ID
		--{'script', tonumber},			--使用脚本
		--{'describe', tostring},			--道具描述
		--{'imgID', tonumber},			--icon图片id
		--{'sordID', tonumber},			--排序编号
		{'number', tonumber},			-- 合成所需碎片数量
		{'mtype', tonumber},			-- 所需钱币类型
		{'mcount', tonumber},			-- 所需钱币
		{'gid', tonumber},				-- 所需物品ID
		{'gtype', tonumber},			-- 所需物品类型
		{'gcount', tonumber},			-- 所需物品数量
	}

	local count
	count = 0
	LoadConfig('data/rolefragconfig.txt', title,
		function (row)
			count = count + 1
			--[[
			local itemtbl = {}
			if row.gcount > 0 then
				itemtbl = {row.gid,row.gtype,row.gcount,}
			end
			local moneytbl = {}
			if row.mcount > 0 then
				moneytbl = {row.mtype,row.mcount}
			end
			g_FragmentCfg.roleCfg[row.id] = { [1]=row.number, [2]={ [1]=itemtbl, }, [3]=moneytbl, imgID=row.imgID, }
			--]]
			g_FragmentCfg.roleCfg[row.id] = row
		end)
	AddLog("Load rolefragconfig Count: " .. tostring(count))
	
	count = 0
	LoadConfig('data/equipfragconfig.txt', title,
		function (row)
			count = count + 1
			--[[
			local itemtbl = {}
			if row.gcount > 0 then
				itemtbl = {row.gid,row.gtype,row.gcount,}
			end
			local moneytbl = {}
			if row.mcount > 0 then
				moneytbl = {row.mtype,row.mcount}
			end
			g_FragmentCfg.equipCfg[row.id] = { [1]=row.number, [2]={ [1]=itemtbl, }, [3]=moneytbl,  imgID=row.imgID, }
			--]]
			g_FragmentCfg.equipCfg[row.id] = row
		end)
	AddLog("Load equipfragconfig Count: " .. tostring(count))
	
	count = 0
	LoadConfig('data/skillfragconfig.txt', title,
		function (row)
			count = count + 1
			--[[
			local itemtbl = {}
			if row.gcount > 0 then
				itemtbl = {row.gid,row.gtype,row.gcount,}
			end
			local moneytbl = {}
			if row.mcount > 0 then
				moneytbl = {row.mtype,row.mcount}
			end
			g_FragmentCfg.skillCfg[row.id] = { [1]=row.number, [2]={ [1]=itemtbl, }, [3]=moneytbl,  imgID=row.imgID, }
			--]]
			g_FragmentCfg.skillCfg[row.id] = row
		end)
	AddLog("Load skillfragconfig Count: " .. tostring(count))
	
	count = 0
	LoadConfig('data/itemfragconfig.txt', title,
		function (row)
			count = count + 1
			--[[
			local itemtbl = {}
			if row.gcount > 0 then
				itemtbl = {row.gid,row.gtype,row.gcount,}
			end
			local moneytbl = {}
			if row.mcount > 0 then
				moneytbl = {row.mtype,row.mcount}
			end
			g_FragmentCfg.itemCfg[row.id] = { [1]=row.number, [2]={ [1]=itemtbl, }, [3]=moneytbl,  imgID=row.imgID, }
			--]]
			g_FragmentCfg.itemCfg[row.id] = row
		end)
	AddLog("Load itemfragconfig Count: " .. tostring(count))
end

--ReadFragmentConfig()