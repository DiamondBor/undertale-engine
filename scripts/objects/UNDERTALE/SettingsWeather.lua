local obj_ct_fallobj, super = Class(Object, "obj_ct_fallobj")

function obj_ct_fallobj:init(x, y, sprite)
    super.init(self)

    self:setSprite(sprite or "ui/settings/christmasflake")
    self:setOrigin(0.5,0.5)
    self.x = Utils.random(SCREEN_WIDTH)
    self.physics.gravity = 0.02
    self.physics.speed_y = 1
    self.alpha = 0.5
    self.rotspeed = ((Utils.pick{1, -1} * (2 + Utils.random(4))) * 2) * math.pi/180
    self.physics.speed_x = (Utils.pick{1, -1} * (1 + Utils.random(1)))
    self.siner = 0
    self.sinerfactor = (Utils.pick{1, -1} * Utils.random(1))
end

function obj_ct_fallobj:draw()
    super.draw(self)
end

function obj_ct_fallobj:setSprite(texture, speed, use_size)
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

function obj_ct_fallobj:update()
    super.update(self)
    if (self.y > 490) then
        self:remove()
    end
    self.siner = self.siner + 1
    self.x = self.x + (math.sin((self.siner / 5)) * self.sinerfactor)
    self.y = self.y + (math.cos((self.siner / 6)) * self.sinerfactor)
    self.rotation = self.rotation + self.rotspeed
end

return obj_ct_fallobj