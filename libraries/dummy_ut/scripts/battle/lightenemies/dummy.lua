local Enemy, super = Class(LightEnemyBattler)

function Enemy:init()
    super.init(self)

    self.name = "Dummy"
    self:setActor("dummy_ut")

    self:registerAct("Talk")

    self.max_health = 15
    self.health = 15
    self.attack = 0
    self.defense = -5
    self.money = 0
    self.experience = 0
    
    self.run_on_defeat = true
    self.can_freeze = true

    self.count_as_kill = false
    
    self.check = "ATK 0 DEF 0[wait:10]\n* A cotton heart and button eye[wait:10]\n* You are the apple of my eye"

    self.text = {
        "* Dummy stands around\nabsentmindedly.",
        "* The dummy looks like it's\nabout to fall over."
    }
    self.low_health_text = "* The dummy looks like it's\nabout to fall over."

    self.dialogue = {
        "[wave:3][speed:0.1]....."
    }
    self.flip_dialogue = true

    self.gauge_size = 150
    self.damage_offset = {5, -70}
end

function Enemy:onAct(battler, name)
    if name == "Talk" then
        self:addMercy(100)
        self.dialogue_override = "[wave:3][speed:0.1]... ^^"

        return {
            "* You talked to the dummy.",
            "* You feel like a certain\nperson is proud of you."
        }

    elseif name == "Standard" then
        self:addMercy(100)
        self.dialogue_override = "[wave:3][speed:0.1]... ^^"

        return {
            "* "..battler.chara:getName().." talked to the dummy.",
            "* You feel like a certain\nperson is proud of you."
        }

    end

    return super:onAct(self, battler, name)
end

return Enemy