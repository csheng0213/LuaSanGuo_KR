function LoadConfig(path, title, cb)
	if type(cb) ~= 'function' then return end
	
	local file = io.open(path, 'r')
	if file == nil then
		AddLog(string.format('Can`t open file(%s)', tostring(path)))
		return
	end
	
	file:read()  -- ��
	for line in file:lines() do
		local cells = string.split(line, '\t')
		local row = {}
		for k, v in ipairs(title) do
			row[v[1]] = v[2](cells[k])
		end
		cb(row)
	end
	file:close()
end

dofile('script/config/public/errorcode.lua')
dofile('script/config/public/csbaseconfig.lua')
dofile('script/config/public/starawardconfig.lua')
dofile('script/config/public/itemtargetcode.lua')
dofile('script/config/public/itemconfig.lua')
dofile('script/config/public/playerbaseconfig.lua')
dofile('script/config/public/storeconfig.lua')
dofile('script/config/public/sampleconfig.lua')
dofile('script/config/public/msgsystemconfig.lua')
dofile('script/config/public/pvpconfig.lua')
dofile('script/config/public/marketconfig.lua')
dofile('script/config/public/fragmentconfig.lua')
dofile('script/config/public/activityconfig.lua')
dofile('script/config/public/propcalculation.lua')
dofile('script/config/public/_out_put_formation.lua')
dofile('script/config/public/_out_put_formation_fast.lua')


