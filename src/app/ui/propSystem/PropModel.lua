local BaseModel = require("app.baseMVC.BaseModel")

local PropModel = class("PropModel", BaseModel)

PropModel.debug = false
--事件属性
PropModel.eventAttr = {}
PropModel.eventAttr.m_count = 0

--事件名称


function PropModel:ctor(param)
    --parent init
    self.index = param.index
    self.m_id = param.m_id 
    self.m_count = param.m_count
    PropModel.eventAttr.m_count = param.m_count
    self.script = param.script
    self:init()  
end

function PropModel:init()
    self.super.init(self)
end


return PropModel