local Bouncer, super = Class(Event, "bouncer")

function Bouncer:init(data)
	super.init(self, data.x, data.y, data.width, data.height)

    local properties = data.properties or {}

    self.direction = properties["direction"] or "down"

    self.sprite = Sprite("world/events/vent/"..self.direction)
    self.sprite:play(0.15)
    self.sprite:setScale(2)
    self:addChild(self.sprite)
    self:setHitbox(10,0,20,40)

    --self:spawnSmoke()
    Game.world.timer:every(3, function()
        --self:spawnSmoke()
    end)
end

function Bouncer:spawnSmoke()
    local obj = obj_bouncersteam()
    obj.layer = WORLD_LAYERS["below_ui"]
    self:addChild(obj)
    Game.world.timer:after(5, function()
        obj:remove()
    end)
end

function Bouncer:onCollide(chara)
    chara:setState("BOUNCE")
end

return Bouncer