local BaseModel = require("app.baseMVC.BaseModel")

local ShopModel = class("ShopModel", BaseModel)

ShopModel.debug = false

--事件属性
ShopModel.eventAttr = {}
ShopModel.eventAttr.m_BuyCount = 0

function ShopModel:ctor()
    --parent init
    self:init()
end

function ShopModel:init()
    self.super.init(self)
end

return ShopModel