local FileParser = {}


function FileParser:parserFile(filePath, isIndex , splitStr)
    
    print(filePath)
    local fileContext = cc.FileUtils:getInstance():getStringFromFile(filePath)
    --    print(fileContext) 

    local lines = string.split(fileContext, "\n")
    local keys = string.split(lines[1], splitStr)

    local datas = {}
    for i=2, #lines do

        if lines[i] == "" then break end

        --解析数据
        local data = {}
        local values = {}
        self:handleLines_(lines[i], splitStr, values)
        
        for i=1, #keys do
            if values[i] ~= "" then
                if Functions.isNumber(values[i]) then
                    data[keys[i]] = tonumber(values[i])
                else
                    data[keys[i]] = values[i] 
                end
            end
        end

        --添加索引
        if isIndex then
            if type(isIndex) == "number" then
                if Functions.isNumber(values[isIndex]) then
                    datas[tonumber(values[isIndex])] = data
                else
                    datas[values[isIndex]] =  data
                end
            else
                if Functions.isNumber(values[1]) then
                    datas[tonumber(values[1])] = data
                else
                    datas[values[1]] =  data
                end
            end
        else
            datas[#datas + 1] = data
        end
        
    end

    return datas
end

function FileParser:handleLines_(line, splitStr, values)
    local isStr = false
    local oldIndex = 1
    for i=1, string.len(line) do
        local ch = string.sub(line, i,i)
        if ch == splitStr then
			if not isStr then
                values[#values+1] = string.sub(line, oldIndex, i-1)
                oldIndex = i+1
			end
		end
		
        if ch == "\"" then
            isStr = not isStr
        end 
        
        if i == string.len(line) then
            values[#values+1] = string.sub(line, oldIndex, i)
        end
        
	end
end


return FileParser