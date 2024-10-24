local EncGroup, super = Class(EncounterGroup, "ruins")

function EncGroup:init()
    super.init(self)
    self.initial_steps = 20
    self.initial_population = 20
    
    self.encounters = {"froggit", "froggit2"}
    self.light = true
end

function EncGroup:resetSteps()
    if not self:nobodyCame() then
        local pop_factor = 15 / (15 - Game:getFlag("##test_kills", 0))
        if pop_factor > 8 then
            pop_factor = 8
        end
        local steps = math.ceil(30 + (Utils.round(Utils.random(15))) * pop_factor)
        MagicalGlassLib.steps_until_encounter = steps
    else
        MagicalGlassLib.steps_until_encounter = 20
    end
end

function EncGroup:nobodyCame()
    if Game:getFlag("##test_kills", 0) > 5 then
        return true
    end
    return false
end

return EncGroup