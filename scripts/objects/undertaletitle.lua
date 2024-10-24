local UndertaleTitle, super = Class(Object, "UndertaleTitle")

function UndertaleTitle:init()
    super:init(self)
    Game.lock_movement = true

    self.parallax_x = 0
    self.parallax_y = 0

    self.timer = 0

    self.can_click = true
    
    self.logo = Sprite("logo", 0, 0)
    self.logo:setOrigin(0, 0)
    self.logo.layer = WORLD_LAYERS["top"]
    self:addChild(self.logo)
    Assets.playSound("intronoise")

    Game.world.fader:fadeIn()
    Game.lock_movement = true
end

function UndertaleTitle:draw()
    super:draw(self)

    if self.timer > 80 then
        Draw.setColor(0.5,0.5,0.5)
        love.graphics.setFont(Assets.getFont("small"))
        love.graphics.printf("[PRESS Z OR ENTER]", 0, 360, SCREEN_WIDTH, "center")
    end
end

function UndertaleTitle:update()
    super.update(self)
    Game.lock_movement = true -- fuck you to whatever keeps turning this horrible garbage option to true when the intro is over.

    if self.timer >= 600 then
        if Game.utt ~= nil then
            local cutscene = Game.world.cutscene
            if cutscene then
                Mod:makeUTStory(cutscene)
            else
                Game.world:startCutscene(function(cutscene)
                    Mod:makeUTStory(cutscene)
                end)
            end
            self.can_click = false
            Game.utt = nil
            self:remove()
        end
    end

    self.timer = self.timer+DTMULT

    if self.can_click == true then
        if Input.pressed("confirm", false) then
            self.can_click = false
            Mod:loadMenus()
            Game.utt = nil
            self:remove()
        end
    end
end

return UndertaleTitle