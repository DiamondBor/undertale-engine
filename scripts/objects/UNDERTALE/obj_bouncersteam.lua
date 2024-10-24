local obj_bouncersteam, super = Class(Object)

function obj_bouncersteam:init(x, y, sprite)
    super.init(self)

    self:setSprite("world/events/vent/bouncersteam")
    self:setScale(0.4)
    self:setOrigin(0.5,0.5)
    self.x = 0 --10
    self.y = 0 --10
    self.physics.friction = 0.1
    self.size = 0.4
    self.physics.direction = (80 + Utils.random(20))
    self.rotation = Utils.random(360) * math.pi/180
    self.physics.speed = 3
    self.siner = 0
    self.sinerfactor = (Utils.pick{1, -1} * Utils.random(1))


    --self.x += 10
    --self.y += 10
    --self.image_angle = random(360)
    --self.image_xscale = 0.4
    --self.image_yscale = 0.4
    --self.size = 0.4
    --self.alarm[0] = 0
    --self.direction = (80 + random(20))
    --self.speed = 3
    --self.friction = 0.1

end

function obj_bouncersteam:draw()
    super.draw(self)
end

function obj_bouncersteam:setSprite(texture, speed, use_size)
    if texture then
        if self.sprite then
            self:removeChild(self.sprite)
        end
        self.sprite = Sprite(texture)
        self.sprite:setScale(2)
        if speed then
            self.sprite:play(speed)
        end
        self:addChild(self.sprite)
        if not self.collider or self.collider == self._default_collider then
            self.collider = Hitbox(self, 0, 0, self.sprite.width * 2, self.sprite.height * 2)
        end
        if use_size or use_size == nil then
            self:setSize(self.sprite.width*2, self.sprite.height*2)
        end
        self.sprite.alpha = 0.5
    elseif self.sprite then
        self:removeChild(self.sprite)
        self.sprite = nil
    end
end

function obj_bouncersteam:update()
    super.update(self)
    self.size = self.size + 0.08/2 * DTMULT
    self:setScale(self.size)
    self.alpha = self.alpha - 0.07/2 * DTMULT
    if (self.alpha < 0.1) then
        self:remove()
    end
    self.rotation = self.rotation + 6/2 * DTMULT

	self.size = self.size + 0.08
    self:setScale(self.size)
	self.alpha = self.alpha - 0.07
    if (self.alpha < 0.1) then
        self:remove()
    end
	self.rotation = self.rotation + 6
end

return obj_bouncersteam