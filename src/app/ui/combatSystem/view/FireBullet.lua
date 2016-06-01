local FireBullet = class("FireBullet", cc.Sprite)

function FireBullet:ctor()
	self.initAnimaHandler = Functions.playAnimaOfUI(self, "Ani_fireball",0)
end

--@param param { startPoint = 起点, endPoint = 终点 }
function FireBullet:excute(param)
    assert(param and param.endPoint and param.startPoint,"param is error!")
    
    local endP = param.endPoint
    local startP = param.startPoint

	local actions =
	{
		cc.MoveTo:create(0.6, endP),
		cc.CallFunc:create(function() self:stopAction(self.initAnimaHandler) end),
		"Ani_fireballB",
		cc.CallFunc:create(function() self.controller:removeBullet(self) end)
	}
	Functions.playActionsWithBackCall(self, actions)

	--修改初始坐标
    self:setPosition(startP)

    --修改初始方向
   local dir = { x = endP.x - startP.x, y = endP.y - startP.y }
   local angle = -1*Functions.getAngle(dir)*180/math.pi
   self:setRotation(angle)

end

function FireBullet:setController(ctl)
	self.controller = ctl
end

return FireBullet