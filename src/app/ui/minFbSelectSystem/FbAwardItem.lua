local BaseModel = require("app.baseMVC.BaseModel")
local FbAwardItem = class("FbAwardItem", BaseModel)

FbAwardItem.eventAttr = {}
FbAwardItem.eventAttr.isApply = false
FbAwardItem.eventAttr.requestCount = 0

function FbAwardItem:init(data)
    self.super.init(self)
    
	self.itype    = data.itype 
	self.id       = data.id
	
    self.name     = Functions.getPartAttrs({ type = self.itype, id = self.id })["name"]
	
	self.count    = data.count
	self.requests = data.requests

	self.eventAttr.requestCount = #data.requests
    
end





return FbAwardItem