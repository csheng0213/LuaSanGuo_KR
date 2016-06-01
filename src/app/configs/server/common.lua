function table.serialize(t)
	local mark = {}
	local assign = {}
	
	local function ser_table(tbl, parent)
		mark[tbl] = parent
		local tmp = {}
		for k, v in pairs(tbl) do
			local tp_k = type(k)
			local tp_v = type(v)
			local key = (tp_k == 'number') and ('['..k..']') or k
			if tp_v == 'table' then
				local dotkey = parent..((tp_k == 'number') and key or ("."..key))
				if mark[v] then
					table.insert(assign, dotkey..'='..mark[v])
				else
					table.insert(tmp, key..'='..ser_table(v, dotkey))
				end
			else
				if tp_v == 'string' then
					table.insert(tmp, key..'=\''..v..'\'')
				elseif tp_v ~= 'userdata' and tp_v ~= 'lightuserdata' then
					table.insert(tmp, key..'='..tostring(v))
				end
			end
		end
		return '{'..table.concat(tmp, ',')..'}'
	end
	
	return 'do local ret='..ser_table(t, 'ret')..table.concat(assign, ' ')..' return ret end'
end

function table.unserialize(s)
	return loadstring(s)()
end

function table.merge(t1, t2, cover, sub)
	if type(t1) ~= 'table' then
		return
	end
	
	if type(t2) ~= 'table' then
		return
	end
	
	-- table.merge(t1, t2, true, true)
	local function tm1(t1, t2)
		for k, v2 in pairs(t2) do
			local v1 = t1[k]
			if type(v1) == 'table' and type(v2) == 'table' then
				tm1(v1, v2)
			else
				t1[k] = v2
			end
		end
	end
	-- table.merge(t1, t2, true, false)
	local function tm2(t1, t2)
		for k, v2 in pairs(t2) do
			t1[k] = v2
		end
	end
	-- table.merge(t1, t2, false, true)
	local function tm3(t1, t2)
		for k, v2 in pairs(t2) do
			local v1 = t1[k]
			if type(v1) == 'table' and type(v2) == 'table' then
				tm3(v1, v2)
			elseif v1 == nil then
				t1[k] = v2
			end
		end
	end
	-- table.merge(t1, t2, false, false)
	local function tm4(t1, t2)
		for k, v2 in pairs(t2) do
			if t1[k] == nil then
				t1[k] = v2
			end
		end
	end
	
	if cover == nil then cover = true end
	if sub == nil then sub = true end
	if cover then
		if sub then
			tm1(t1, t2)
		else
			tm2(t1, t2)
		end
	else
		if sub then
			tm3(t1, t2)
		else
			tm4(t1, t2)
		end
	end
end

function table.empty(t)
	if type(t) ~= 'table' then
		return false
	end

	for k, v in pairs(t) do
		return false
	end
	return true
end

function table.show(t, func, indent, hasShowed)
	if type(t) ~= 'table' then
		return
	end

	func = func or io.write
	indent = indent or '  '
	hasShowed = hasShowed or {}
	hasShowed[t] = true

	func('self : ')
	func(tostring(t))
	func('\n')

	if table.empty(t) then
		func(indent)
		func('table is empty')
		func('\n')
		return
	end

	for k, v in pairs(t) do
		func(indent)
		func(tostring(k))
		func(' = ')
		if type(v) == 'table' and not hasShowed[v] then
			table.show(v, func, indent..'  ', hasShowed)
		else
			func(tostring(v))
			func('\n')
		end
	end
end

function string.split(s, delim)
	if type(s) ~= 'string' then
		return
	end
	
	local i, j, k
	local t = { }
	local k = 1
	while true do
		local i, j = string.find(s, delim, k)
		if not i then
			t[#t + 1] = string.sub(s, k)
			return t
		end
		t[#t + 1] = string.sub(s, k, i - 1)
		k = j + 1
	end
end

--浅拷贝，针对简单数据类型，只能做一层拷贝
function table.shallowcopy(ori_tab)
    if (type(ori_tab) ~= "table") then
        return nil
    end
    local new_tab = {}
    for i,v in pairs(ori_tab) do
        local vtyp = type(v)
        if (vtyp == "table") then
            new_tab[i] = table.shallowcopy(v)
        elseif (vtyp == "thread") then
            -- TODO:  just point to?
        elseif (vtyp == "userdata") then
            -- TODO:  just point to?
        else
            new_tab[i] = v
        end
    end
    return new_tab
end
--自需求浅拷贝，指定遍历最大值,只能做一层拷贝
function table.shallowcopy_max(ori_tab, maxCount)
	if (type(ori_tab) ~= "table") then
        return nil
    end
    local new_tab = {}
    for i=1,maxCount do
		if ori_tab[i] == nil then
			break
		end
        local vtyp = type(ori_tab[i])
        if (vtyp == "table") then
            new_tab[i] = table.shallowcopy(ori_tab[i])
        elseif (vtyp == "thread") then
            -- TODO:  just point to?
        elseif (vtyp == "userdata") then
            -- TODO:  just point to?
        else
            new_tab[i] = ori_tab[i]
        end
    end
    return new_tab
end

function FixRangeVal(_min, _max, _val)
	if _min > _max then
		_min, _max = _max, _min
	end
	return math.max(_min, math.min(_max, _val))
end

function GenAutoIncCounter()
	local i = 0
	return function () i = i + 1 return i end
end

function GetSysDiffTick()
	local tm = os.time()
	while os.time() == tm do end
	
	local tick = os.clock()
	return tick - math.floor(tick)
end

function g_RoundOff(num, n)
    if n >= 0 then
        local scale = math.pow(10, n)
        return (math.floor(num * scale + 0.5) / scale)
    else
        return math.floor(num)
    end
end
