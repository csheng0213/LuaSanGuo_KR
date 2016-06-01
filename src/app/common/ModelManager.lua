local ModelManager = {}

require("app.configs.server.config.public.csbaseconfig")

ModelManager.modelLevelMap = {}
ModelManager.ruleLevel = {}

function ModelManager:init()
    --根据配置数据，初始化 控制器模块 
    self.modelLevelMap["xueZhan"] = g_csOpen.XZLYOpen.level
    self.modelLevelMap["shop"] = g_csOpen.ShopOpen.level
    self.modelLevelMap["sevenStar"] = g_csOpen.AlterOpen.level
    self.modelLevelMap["tianTi"] = g_csOpen.TianTiOpen.level
    self.modelLevelMap["shiLian"] = g_csOpen.heroShilianOpen.level
    self.modelLevelMap["union"] = g_csOpen.GonghuiOpen.level
    self.modelLevelMap["city"] = g_csOpen.ZhuChengOpen.level
    
    self:_init()
end

function ModelManager:_init()
    self._modelLevelMap = {}
    for k, v in pairs(self.modelLevelMap) do
        local firstCha = string.sub(k, 1, 1)
        local lastStr  = string.sub(k, 2, #k)
        
        local new_k = "app.ui." .. string.lower(firstCha) .. lastStr .. "System." 
        .. string.upper(firstCha) .. lastStr .. "ViewController"
        self._modelLevelMap[new_k] = v
    end

    self._models = {}
    Functions.map(self.modelLevelMap, function(k, v)
            self._models[string.upper(k)] = v
        end)

    self._ruleLevel = {}
    Functions.map(self.ruleLevel, function(k, v)
            self._ruleLevel[string.upper(k)] = v
        end)
end

function ModelManager:isModelOpenOfController(controllerName)

    if not self._modelLevelMap[controllerName] then
        return true
    end

    if PlayerData.eventAttr.m_level >= self._modelLevelMap[controllerName] then
        return true
    else
        return false
    end
end

function ModelManager:isModelOpenOfName(modelName)

    if not self._models[string.upper(modelName)] then
        return true
    end

    if PlayerData.eventAttr.m_level >= self._models[string.upper(modelName)] then
        return true
    else
        return false
    end
end

function ModelManager:getModelOpenLevel(controllerName)
    return self._modelLevelMap[controllerName]
end

return ModelManager