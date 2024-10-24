local actor, super = Class(Actor, "toriel")

function actor:init()
    super:init(self)

    -- Display name (optional)
    self.name = "Toriel"

    -- Width and height for this actor, used to determine its center
    self.width = 25
    self.height = 52

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 33, 25, 19}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/toriel"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    self.indent_string = ""

    -- Sound to play when this actor speaks (optional)
    self.voice = "toriel"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/toriel"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {1,0}
    -- Path to this actor's body portrait below dialogue image (optional)
    self.body_portrait_path = "face/toriel/body"
    -- Offset position for this actor's body portrait (optional)
    self.body_portrait_offset = {-18, -6}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {}

    -- Tables of sprites to change into in mirrors
    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["walk/down"] = {0, 0},
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
    }
end

return actor