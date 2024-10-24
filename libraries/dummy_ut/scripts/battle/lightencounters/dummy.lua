local Dummy, super = Class(LightEncounter)

function Dummy:init()
    super:init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* You encountered the Dummy."

    -- Battle music ("battleut" is undertale)
    self.music = "prebattle1ut"

    -- Add the dummy enemy to the encounter
    self:addEnemy("dummy")

end

return Dummy