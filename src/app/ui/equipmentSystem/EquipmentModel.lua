local BaseModel = require("app.baseMVC.BaseModel")

local EquipmentModel = class("EquipmentModel", BaseModel)

EquipmentModel.debug = false
--事件属性
EquipmentModel.eventAttr = {}
--事件名称


function EquipmentModel:ctor(param)
    --parent init
    self.index = param.index
    self.m_id = param.m_id 
    self.mark = param.mark
    if param.defFormFlag ~= nil then
        self.defFormFlag = param.defFormFlag
    else
        self.defFormFlag = 0 
    end
    if param.atkFormFlag ~= nil then
        self.atkFormFlag = param.atkFormFlag
    else
        self.atkFormFlag = 0
    end
    if param.rdAttrType ~= nil then
        self.rdAttrType = param.rdAttrType
    else
        self.rdAttrType = 0
    end
    if param.rdAttrPercent ~= nil then
        self.rdAttrPercent = param.rdAttrPercent
    else
        self.rdAttrPercent = 0
    end
    self:init()  
end

function EquipmentModel:init()
    self.super.init(self)
end


return EquipmentModel