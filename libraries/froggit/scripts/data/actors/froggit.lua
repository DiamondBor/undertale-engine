local actor, super = Class(Actor, "froggit")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Froggit"

    -- Width and height for this actor, used to determine its center
    self.width = 20
    self.height = 20
    
    self.use_light_battler_sprite = true

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 0, 16, 16}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/froggit"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["lightbattle_hurt"]   = {"battle/hurt", 1, true},
        ["lightbattle_defeat"] = {"battle/hurt", 1, true}
    }

    self.light_enemy_sprite = true
    
    self.light_enemy_width = 55
    self.light_enemy_height = 55

    self:addLightEnemyPart("legs", function()
        local sprite = Sprite(self.path.."/battle/legs")
        sprite:play(1, true)
        return sprite
    end)
    
    self:addLightEnemyPart("head", function()
        local sprite = Sprite(self.path.."/battle/head", -2, 3)
        sprite.layer = 500
        sprite:play(2, true)
        -- local path = {{264, 300}, {272, 296}, {280, 300}, {272, 304}, {272, 292}}
        local path =    {{0, 0},     {2, -2},    {4, -1},    {2, 0},    {1, -3},   {0, 0}} -- still not accurate
        sprite:slidePath(path, {speed = 0.25, loop = true, relative = true})
        return sprite
    end)
end

return actor