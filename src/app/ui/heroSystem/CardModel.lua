local BaseModel = require("app.baseMVC.BaseModel")

local CardModel = class("CardModel", BaseModel)

CardModel.debug = false

--事件属性
CardModel.eventAttr = {}

--事件名称
CardModel.HERO_SELECT_EVENT = "HERO_SELECT_EVENT"


--@params : { heroId, campType, viewType, dire, pos, veiwName, resId, hp,
--    mp, atk, num, round, atk_spd, atk_range, vis_field, mv_spd, cnotion, spells, passiveSkills } 
function CardModel:ctor()

    --parent init
    self:init()

end

function CardModel:init()
    self.super.init(self)
end

function CardModel:seleckHero()
    self:dispatchEvent({ name = CardModel.HERO_SELECT_EVENT })
end


return CardModel
