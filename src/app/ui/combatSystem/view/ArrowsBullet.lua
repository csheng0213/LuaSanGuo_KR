local ArrowsBullet = class("ArrowsBullet", cc.Sprite)

ArrowsBullet.speed = 500
  
function ArrowsBullet:ctor()
    Functions.loadImageWithSprite(self, "cs/ui_res/CombatUI/combat_arrow.png")
    self:setScale(0.5)
end

--@param param { startPoint = 起点, endPoint = 终点 }
function ArrowsBullet:excute(param)
    assert(param and param.endPoint and param.startPoint,"param is error!")
    
    local endP = param.endPoint
    local startP = param.startPoint
    local time = math.abs(Functions.getDistance(startP, endP))/ArrowsBullet.speed
 
    local m_BeziercfgScall = 9/16
    local weight = endP.x - startP.x
    local controlPointY = math.abs(weight)*m_BeziercfgScall
    local controlPointX = 0
    if weight > 0 then
        controlPointX = controlPointY*math.tan(30*math.pi / 180)
    else
        controlPointX = -controlPointY*math.tan(30*math.pi / 180);
    end

    local  bezierCfg = {}
    
    bezierCfg[#bezierCfg+1] = { x = startP.x + controlPointX, y = startP.y + controlPointY }
    bezierCfg[#bezierCfg+1] = { x = endP.x - controlPointX, y = endP.y + controlPointY }
    bezierCfg[#bezierCfg+1] = { x = endP.x, y = endP.y }

    local actions =
    {
        cc.BezierTo:create(time, bezierCfg),
        cc.CallFunc:create(function() self.controller:removeBullet(self) end)
    }
    Functions.playActionsWithBackCall(self, actions)
    
    --修改初始坐标
    self:setPosition(startP)
    self.oldPos = startP
    
    self:runAction(UIActionTool:createLoopFunc(0.03, handler(self, self.updateAngle)))

end

function ArrowsBullet:updateAngle(target)

    local curPos = { x = self:getPositionX(), y = self:getPositionY() }
    if curPos.x ~= self.oldPos.x or curPos.y ~= self.oldPos.y then
        --修改箭方向
        local dir   = { x = curPos.x - self.oldPos.x, y = curPos.y - self.oldPos.y }
        local angle = -1*Functions.getAngle(dir)*180/math.pi
        self:setRotation(angle)
        
        self.oldPos = curPos
    end

end

function ArrowsBullet:setController(ctl)
    self.controller = ctl
end

return ArrowsBullet