--AddLog = print

math.randomseed(os.time())

function LoadConfig(path, title, cb)

    if path == "data/itemconfig.txt" then 
        print("sf")
    end
    if type(cb) ~= 'function' then return end

    local fileContext = cc.FileUtils:getInstance():getStringFromFile(path)
    --    print(fileContext) 

    if fileContext == "" then
        print(string.format('Can`t open file(%s)', tostring(path)))
        return
    end

    local lines = string.split(fileContext, "\n")

    for i=2, #lines  do

        local cells = string.split(lines[i], '\t')
        if #cells < 2 then return end

        local row = {}
        for k, v in ipairs(title) do
            row[v[1]] = v[2](cells[k])
        end
        cb(row)
    end
end

AddLog = print

--加载config文件夹中的配置文件
require("app.configs.server.config.public.errorcode")
require("app.configs.server.common")
require("app.configs.server.config.public.skill")
require("app.configs.server.config.public.itemconfig")
require("app.configs.server.config.public.csbaseconfig")
require("app.configs.server.config.public.propcalculation")
print("load server config file finish!")
