local character, super = Class(PartyMember, "frisk")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Frisk"

    -- Use Undertale movement
    self.undertale_movement = true
    
    -- Actor (handles overworld/battle sprites)
    self:setActor("frisk")

    -- Light world LV (saved to the save file)
    self.lw_lv = 1
    -- Light world EXP (saved to the save file)
    self.lw_exp = 0

    -- Current light world health (saved to the save file)
    self.lw_health = 20
    -- Light world stats (saved to the save file)
    self.lw_stats = {
        health = 20,
        attack = 10,
        defense = 10,
        magic = 0
    }

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 2
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = true
    self.has_spells = false

    -- Whether the party member can use their X-Action
    self.has_xact = false

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "mg_item/stick"
    self.lw_armor_default = "mg_item/bandage"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/cut"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1

end

return character