local obj_hotlandrock_bg, super = Class(Object, "obj_hotlandrock_bg")

function obj_hotlandrock_bg:init(type, y, al)
    super.init(self, 0, y or 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    
    self.parallax_x = 1
    self.parallax_y = 1

    self.al = al or 1
    self.type = type

    self.siner = 0
    self.i = 0

    if self.type == "rocks" then
        local backdrop = Sprite("world/bg/hotlandrock", 0, self.y)
        backdrop:setScale(2)
        backdrop:setWrap(true)
        self:addChild(backdrop)
    end
end

function obj_hotlandrock_bg:draw()
    super.draw(self)
    
    if self.type == "dark" then
        
        self.siner = self.siner + 1
        Draw.setColor(0,0,0,1)
        self.maximum = (Game.world.height / 40)
        Draw.setColor(0,0,0, (0.3 + (math.sin((self.siner / 15)) * 0.1)))

        love.graphics.rectangle("fill", -10, -10, (Game.world.width + 10), (Game.world.height + 10))

        while (self.i < self.maximum) do
            Draw.setColor(0,0,0, (self.i/self.maximum))

            love.graphics.rectangle("fill", -10, (self.i * 40), (Game.world.width + 10), ((self.i * 40) + 40))

            self.i = self.i + 1
        end
        
        Draw.setColor(0,0,0,1)

    end

end

return obj_hotlandrock_bg