local BaseModel = class("BaseModel")

BaseModel.debug = true

BaseModel.storeAttr = {}
BaseModel.eventAttr = {}

function BaseModel:ctor(data)
	self:init(data)
end

function BaseModel:init()
    
    cc.bind(self, "event")

    --转换cocos的事件分发函数，添加事件监听，返回一个handler
    local addEventListener_ = self.addEventListener
    self.addEventListener = function(...)
        local _, handler = addEventListener_(...)
        return handler
    end
    
    --存储属性表元表设置
    local strorAttr = clone(self.storeAttr)
    self.storeAttr = {}
    local stroeMt = {
        __index = function(t, k)
            Functions.printInfo(self.debug, "access to element " .. tostring(k))
            
            local keyType = tostring(k)
            keyType = string.sub(keyType, #keyType, #keyType)
            if keyType == "b" then
                return cc.UserDefault:getInstance():getBoolForKey(k, false)
            elseif keyType == "f" then
                return cc.UserDefault:getInstance():getDoubleForKey(k, 0)
            elseif keyType == "s" then
                return cc.UserDefault:getInstance():getStringForKey(k, "")
            else
                assert(false,"storeAttr input error")
            end
        end
        ,
        __newindex = function(t, k, v)
            Functions.printInfo(self.debug, "update of element " .. tostring(k) .. " to " .. tostring(v))
                        
            local keyType = tostring(k)
            keyType = string.sub(keyType, #keyType, #keyType)
            if keyType == "b" then
                cc.UserDefault:getInstance():setBoolForKey(k, v)
                local eventName = string.upper(self.__cname) .. "_" .. string.upper(tostring(k)) .. "_" .. "CHANGE_EVENT"
                self:dispatchEvent({ name =  eventName, data = v })   
            elseif keyType == "f" then
                cc.UserDefault:getInstance():setDoubleForKey(k, v)
                local eventName = string.upper(self.__cname) .. "_" .. string.upper(tostring(k)) .. "_" .. "CHANGE_EVENT"
                self:dispatchEvent({ name =  eventName, data = v })   
            elseif keyType == "s" then
                cc.UserDefault:getInstance():setStringForKey(k, v)
                local eventName = string.upper(self.__cname) .. "_" .. string.upper(tostring(k)) .. "_" .. "CHANGE_EVENT"
                self:dispatchEvent({ name =  eventName, data = v })   
            else
                assert(false,"storeAttr input error")
            end
        end
    }
    
    setmetatable(self.storeAttr, stroeMt)
    --事件属性元表设置
    self._eventAttr = clone(self.eventAttr)
    self.eventAttr = {}
    local eventMt = {
        __index = function(t, k)
            Functions.printInfo(self.debug, "access to element " .. tostring(k))
            return self._eventAttr[k]
        end
        ,
        __newindex = function(t, k, v)
            Functions.printInfo(self.debug, "update of element " .. tostring(k) .. " to " .. tostring(v))

            if self._eventAttr[k] ~= v then
                self._eventAttr[k] = v
                local eventName = string.upper(self.__cname) .. "_" .. string.upper(tostring(k)) .. "_" .. "CHANGE_EVENT"
                self:dispatchEvent({ name =  eventName, data = v })
            end

        end
    }

    setmetatable(self.eventAttr, eventMt)
    
end

return BaseModel