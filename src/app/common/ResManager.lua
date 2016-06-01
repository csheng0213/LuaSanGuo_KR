local ResManager = {}

local Scheduler = require("app.common.scheduler")
local CsvReader = require("app.common.CsvReader")


ResManager.RES_LOAD_BEGIN_EVENT = "RES_LOAD_BEGIN_EVENT"
ResManager.RES_LOAD_FINISH_EVENT = "RES_LOAD_FINISH_EVENT"
ResManager.RES_LOADING_EVENT = "RES_LOADING_EVENT"

--@public data
ResManager.RES_CONFIG = {
    "app.configs.ResConfig_cs",
    "app.configs.ResConfig_tyj",
    "app.configs.ResConfig_lk",
    "app.configs.StudioResConfig"
}

ResManager.ANIMA_PLIST_CONFIG = {
    "configs/uiAnimaConfig.csv",
    "data/skillAnimaConfig.csv",
    "data/heroUnitAnimaConfig.csv",
    "data/soldierUnitAnimaConfig.csv",
-- "tyj/skillAnimaConfig.csv"
}

ResManager.debug = false

function ResManager:loadCommonRes(callBack)
    local commonAnima =
    {
        "An_loading","An_point",
    }
    local commonSpriteFrames = 
    {
        "icons","gameRes","CC_commonText","CBO_combatdbar","CBO_noviceKuang","CBO_tipsTwo","CB_bar","CB_board","CC_comCard","propRes"
    }
    Functions.tableSeqFunc(commonAnima, handler(self, self.loadAnimaFunc_), function()
        Functions.tableSeqFunc(commonSpriteFrames, handler(self, self.loadSpriteFrameResFunc_),callBack)
    end)
end

function ResManager:removeCommonRes()
    local commonAnima =
    {
        "An_loading","An_point",
    }
    local commonSpriteFrames = 
    {
        "icons","gameRes","CC_commonText","CBO_combatdbar","CBO_noviceKuang","CBO_tipsTwo","CB_bar","CB_board","CC_comCard","propRes"
    }

    ResManager:removeAnimations(commonAnima)
    ResManager:removeSpriteFrames(commonSpriteFrames)
end

--@public func
function ResManager:loadAnimations(animaNames, backCall)
    if #animaNames > 4 then
        self.isShowLoading = true
    end
    self:resLoopLoadHandle_(animaNames, backCall, handler(self, self.loadAnimaFunc_))
end

function ResManager:removeAnimations(animaNames)

    if not animaNames then return end

    for i=1, #animaNames do
        self:removeAnimaFunc_(animaNames[i])
    end
end

function ResManager:loadSpriteFrames(spriteFrames, backCall)
    if #spriteFrames > 4 then
        self.isShowLoading = true
    end
    self:resLoopLoadHandle_(spriteFrames, backCall, handler(self, self.loadSpriteFrameResFunc_))
end

function ResManager:removeSpriteFrames(spriteFrames)

    if not spriteFrames then return end

    for i=1, #spriteFrames do
        self:removeSpriteFrameResFunc_(spriteFrames[i])
    end
end

--同步加载精灵帧
function ResManager:synloadSpriteFrames(spriteFrames)
    for k,v in pairs(spriteFrames) do
        --获取加载资源配置信息
        local resConfig = assert(ResManager._spriteFrameConfig_t[v], "没有找到精灵帧资源:" .. v .. "的配置表") 

        --根据格式配置，修改图片加载方式
        if resConfig.format ~= nil and resConfig.format == "RGBA4444" then
            display.setTexturePixelFormat(resConfig.resPath
                ,kCCTexture2DPixelFormat_RGBA4444)
        end

        spriteFrameCache:addSpriteFrames(dataFilename, imageFilename)
    end
end

function ResManager:loadAnimaOfPlist(plistFile)
    Functions.printInfo(self.debug, "load animas plist : " .. plistFile)

    self:loadAnimaFunc_(plistFile)
end

function ResManager:removeAnimaOfPlist(plistFile)
    self:removeAnimaFunc_(plistFile)
end

function ResManager:clear()

    --移除动画缓存
    for k, v in pairs(self._animaRef_t) do
        self._animaRef_t[k] = 1
        self:removeAnimaFunc_(k)
    end

    --移除精灵帧缓存
    for k, v in pairs(self._spriteFrameRef_t) do
        self._spriteFrameRef_t[k] = 1
        self:removeSpriteFrameResFunc_(k)
    end

end


--@private func 
ResManager._spriteFrameConfig_t = {}
ResManager._spriteFrameRef_t = {}

ResManager._animaConfig_t = {}
ResManager._animaRef_t = {}

ResManager._plistAnimaConfig_t = {}
ResManager._animaPlistRef_t = {}


--@init 精灵帧 和 普通动画 配置
for i=1, #ResManager.RES_CONFIG do
    local resConfig = require(ResManager.RES_CONFIG[i])

    --添加spriteframe配置
    if resConfig.spriteFrameRes and type(resConfig.spriteFrameRes) == "table" then
        for k, v in pairs(resConfig.spriteFrameRes) do
            assert(ResManager._spriteFrameConfig_t[k] == nil , ResManager.RES_CONFIG[i] .. " 精灵帧配置重名,请修改！")
            ResManager._spriteFrameConfig_t[k] = clone(v)
        end
    end

    if resConfig.animationRes and type(resConfig.animationRes) == "table" then
        for k, v in pairs(resConfig.animationRes) do
            assert(ResManager._animaConfig_t[k] == nil , ResManager.RES_CONFIG[i] .. " 动画配置重名,请修改！")
            ResManager._animaConfig_t[k] = clone(v)
        end
    end

end

--@init plist 动画 配置
for k, v in ipairs(ResManager.ANIMA_PLIST_CONFIG) do
    local resConfig = CsvReader.parserFile(v, 2)

    for k, v in pairs(resConfig) do
        assert(ResManager._plistAnimaConfig_t[k] == nil , tostring(k) .. " plist动画 配置重名,请修改！")
        ResManager._plistAnimaConfig_t[k] = v
    end
end

function ResManager:resLoopLoadHandle_(resNames, backCall, loadFunc)
    assert(#resNames > 0,"resNames is error")

    -- if self.isShowLoading then
    --     PromptManager:openCircelPrompt()  --打开资源加载界面
    -- end
    self._count = 0
    local isloading = false
    local loadRes = function()
        if not isloading then
            isloading = true
            self._count = self._count + 1
            local resName = tostring(resNames[self._count])
            DebugHoldTime("ResManager--- " ..  resName)

            if self._count == #resNames then
                -- if self.isShowLoading then
                --     PromptManager:closeCircelPrompt() --关闭资源加载界面
                -- end
                --加载完成，停止加载动作
                Scheduler.unscheduleGlobal( self.loadAction )
                --判断资源类型 根据类型加载资源
                loadFunc(resNames[self._count], function()
                        DebugDelayTime("ResManager--- " ..  resName)
                        if backCall then
                            backCall(self._count/(#resNames))
                        end
                        isloading = false
                    end)
            elseif self._count < #resNames then
                --加载资源
                loadFunc(resNames[self._count], function()
                        DebugDelayTime("ResManager--- " ..  resName)
                        --单个资源加载完成回调
                        if backCall then
                            GameEventCenter:dispatchEvent({ name = ResManager.RES_LOADING_EVENT, data = self._count/(#resNames) })
                            backCall(self._count/(#resNames))
                        end
                        isloading = false
                    end)
            end
        end
    end

    self.loadAction = Scheduler.scheduleUpdateGlobal( loadRes )

end

function ResManager:loadAnimaFunc_(resName, backCall)

    local strs = string.split(resName, "_")
    if #strs > 1 and strs[2] == "plist" then
        self:loadAnimaOfPlistFunc_(resName, backCall)
    else
        self:loadAnimaOfConFunc_(resName, backCall)
    end

end

function ResManager:loadAnimaOfPlistFunc_(resName, backCall)
    Functions.printInfo(self.debug, "load animas plist : " .. resName)

    local resConfig = assert(ResManager._plistAnimaConfig_t[resName], "没有找到动画资源:" .. resName .. "的配置表") 
    assert(type(resConfig), resName .. " 动画资源配置错误，该配置必须为表")

    if self._animaPlistRef_t[resName] then
        self._animaPlistRef_t[resName] = self._animaPlistRef_t[resName] + 1
        backCall() --添加完成，调用回调函数
    else
        self._animaPlistRef_t[resName] = 1

        --查找精灵帧纹理
        local spriteMap = cc.FileUtils:getInstance():getValueMapFromFile(resConfig["精灵帧路径"])
        local textureFileName = nil
        if spriteMap and spriteMap.metadata and spriteMap.metadata.textureFileName then
            textureFileName = cc.FileUtils:getInstance():fullPathFromRelativeFile(spriteMap.metadata.textureFileName, resConfig["精灵帧路径"]);
        end
        assert(textureFileName, "remove anima plist not textureFileName!")
        Functions.loadSpriteFramesAnsy(resConfig["精灵帧路径"], textureFileName, function() --资源异步加载完成，回调函数

                local valueMap = cc.FileUtils:getInstance():getValueMapFromFile(resConfig["动画资源路径"])    
                --添加动画
                for k, v in pairs(valueMap.animations) do

                    local frames = {}
                    for i=1, #v.frames do
                        frames[#frames + 1] = assert(cc.SpriteFrameCache:getInstance():getSpriteFrame(v.frames[i]), "miss spriteFrame : " .. v.frames[i])
                    end

                    local time = 1 / v.frameTime
                    local animation1 = display.newAnimation(frames, time)

                    local temp = string.split(resName, "_") 
                    if k == temp[1] .. "_default" then
                        display.setAnimationCache(resName, animation1)
                    else
                        display.setAnimationCache(k, animation1)
                    end
                end
                backCall() --添加完成，调用回调函数

            end)
    end

end

function ResManager:loadAnimaOfConFunc_(resName, backCall)

    local resConfig = assert(ResManager._animaConfig_t[resName], "没有找到动画资源:" .. resName .. "的配置表") 
    assert(type(resConfig), resName .. " 动画资源配置错误，该配置必须为表")

    if self._animaRef_t[resName] then
        self._animaRef_t[resName] = self._animaRef_t[resName] + 1
        backCall()
    else
        --加载精灵帧文件
        self:loadSpriteFrameResFunc_(resConfig.spriteFrameResName, function()
                --缓存动画资源
                local frames = display.newFrames(resConfig.spriteFrameName, 1, resConfig.endIndex)
                local animation1 = display.newAnimation(frames, resConfig.time)
                display.setAnimationCache(resName, animation1)    
                self._animaRef_t[resName] = 1
                backCall()
            end)
    end

    if self.debug then
        dump(self._animaRef_t,"ResManager._animaRef_t",3)
    end

end

function ResManager:removeAnimaFunc_(resName)

    local strs = string.split(resName, "_")
    if #strs > 1 and strs[2] == "plist" then
        self:removeAnimaOfPlistFunc_(strs[1])
    else
        self:removeAnimaOfConFunc_(resName)
    end

end

function ResManager:removeAnimaOfConFunc_(resName)
    if not self._animaRef_t[resName] then return end

    self._animaRef_t[resName] = self._animaRef_t[resName] - 1

    if self._animaRef_t[resName] == 0 then
        local resConfig = assert(ResManager._animaConfig_t[resName], "没有找到精灵帧资源:" .. resName .. "的配置表") 
        display.removeAnimationCache(resName)
        self:removeSpriteFrameResFunc_(resConfig.spriteFrameResName)
        self._animaRef_t[resName] = nil
    end

    if self.debug then
        dump(self._animaRef_t,"ResManager._animaRef_t",3)
    end
end

function ResManager:removeAnimaOfPlistFunc_(resName)

    local plistResName = resName .. "_plist"
    assert(self._animaPlistRef_t[plistResName], "removeAnima: " .. plistResName .. " is null")
    -- if not self._animaPlistRef_t[plistResName] then return end
    
    self._animaPlistRef_t[plistResName] = self._animaPlistRef_t[plistResName] - 1

    if self._animaPlistRef_t[plistResName] == 0 then
        local resConfig = ResManager._plistAnimaConfig_t[plistResName]

        local valueMap = cc.FileUtils:getInstance():getValueMapFromFile(resConfig["动画资源路径"])    
        --添加动画
        for k, v in pairs(valueMap.animations) do
            display.removeAnimationCache(k)
            if k == resName .. "_default" then
                display.removeAnimationCache(plistResName)
            else
                display.removeAnimationCache(k)
            end
        end

        --查找精灵帧纹理
        local spriteMap = cc.FileUtils:getInstance():getValueMapFromFile(resConfig["精灵帧路径"])
        local textureFileName = nil
        if spriteMap and spriteMap.metadata and spriteMap.metadata.textureFileName then
            textureFileName = cc.FileUtils:getInstance():fullPathFromRelativeFile(spriteMap.metadata.textureFileName, resConfig["精灵帧路径"]);
        end
        assert(textureFileName, "remove anima plist not textureFileName!")

        --移除精灵帧文件
        display.removeSpriteFrames(resConfig["精灵帧路径"], textureFileName)

        self._animaPlistRef_t[plistResName] = nil
    end

    if self.debug then
        dump(self._animaPlistRef_t,"ResManager._animaPlistRef_t",3)
    end
end

function ResManager:loadSpriteFrameResFunc_(resName, backCall)

    --获取加载资源配置信息
    local resConfig = assert(ResManager._spriteFrameConfig_t[resName], "没有找到精灵帧资源:" .. resName .. "的配置表") 

    --根据格式配置，修改图片加载方式
    if resConfig.format ~= nil and resConfig.format == "RGBA4444" then
        display.setTexturePixelFormat(resConfig.resPath
            ,kCCTexture2DPixelFormat_RGBA4444)
    end

    --引用缓存
    if self._spriteFrameRef_t[resName] then
        self._spriteFrameRef_t[resName] = self._spriteFrameRef_t[resName] + 1
        backCall()
    else
        Functions.loadSpriteFramesAnsy(resConfig.plistPath, resConfig.imagePath, function()
                self._spriteFrameRef_t[resName] = 1
                backCall()
            end)
    end

    if self.debug then
        dump(self._spriteFrameRef_t,"ResManager._spriteFrameRef_t",3)
    end
end

function ResManager:removeSpriteFrameResFunc_(resName)

    assert(self._spriteFrameRef_t[resName], "removeSpriteFrame: " .. resName .. " is null")
    -- if not self._spriteFrameRef_t[resName] then return end

    self._spriteFrameRef_t[resName] = self._spriteFrameRef_t[resName] - 1
    if self._spriteFrameRef_t[resName] == 0 then
        local resConfig = assert(ResManager._spriteFrameConfig_t[resName], "没有找到精灵帧资源:" .. resName .. "的配置表") 
        display.removeSpriteFrames(resConfig.plistPath,resConfig.imagePath)
        self._spriteFrameRef_t[resName] = nil
    end

    if self.debug then
        dump(self._spriteFrameRef_t,"ResManager._spriteFrameRef_t",3)
    end

end

function ResManager:reLoadCurRes()
    for k,v in pairs(self._spriteFrameRef_t) do
        if v > 0 then
            local resConfig = assert(ResManager._spriteFrameConfig_t[k], "没有找到精灵帧资源:" .. resName .. "的配置表") 
            display.removeSpriteFrames(resConfig.plistPath, resConfig.imagePath)
            display.loadSpriteFrames(resConfig.plistPath, resConfig.imagePath)
        end
    end
end

return ResManager