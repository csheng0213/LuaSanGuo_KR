local ColorLabel = {} 
ColorLabel.__index = ColorLabel

function ColorLabel:create(width,height,fontSize)
    local instance = {}
    setmetatable( instance , ColorLabel )
    instance.mSize = cc.size(width,height)
    instance.mPoint =  cc.p(0,height) 
    instance.rt = cc.RenderTexture:create( width , height )
    instance.fontSize = fontSize
    instance.layer = cc.Sprite:create() 
    instance.layer:setContentSize( cc.size( width , height ) )
    instance.layer:addChild( instance.rt )
    return instance
end

function ColorLabel:addString( str , fontName , fontColor )
    local pos = 1
    local fontSize = self.fontSize
    local width = self.fontSize
    local point = self.mPoint
    while pos <= str:len() do
        local l = 2
        if string.byte(str, pos) > 0x80 then
            l=3
            width = fontSize
        else
            l=1
            width = fontSize / 2
        end
        local label = cc.Label:createWithSystemFont(str:sub(pos , pos+l-1),fontName,fontSize)
        label:setColor(fontColor)
        label:setAnchorPoint( cc.p(0,1) )
        self.rt:begin()
        label:setPosition( point )
        label:visit()
        self.rt:endToLua()
        pos = pos + l
        point.x = point.x + width
        if point.x > self.mSize.width - width then
            point.x = 0
            point.y = point.y - fontSize
        end
    end
    self.mPoint = point
end

return ColorLabel