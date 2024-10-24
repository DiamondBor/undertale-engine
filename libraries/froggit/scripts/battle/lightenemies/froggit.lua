local Froggit, super = Class(LightEnemyBattler)

function Froggit:init()
    super.init(self)

    self.name = "Froggit"
    self:setActor("froggit")

    self:registerAct("Compliment")
    self:registerAct("Threaten")

    self.max_health = 30
    self.health = 30
    self.attack = 4
    self.defense = 4
    self.money = 2
    self.experience = 3
    
    self.run_on_defeat = false
    self.can_freeze = true

    self.count_as_kill = true
    
    self.check = "ATK 4 DEF 5\n* Life is difficult for\nthis enemy."

    self.text = {
        "* Froggit doesn't seem to\nknow why it's here.",
        "* Froggit hops to and fro.",
        "* The battlefield is filled\nwith the smell of mustard\nseed.",
        "* You are intimidated by\nFroggit's raw strength.[wait:40]\n* Only kidding."
    }
    self.low_health_text = "* Froggit is trying to\nrun away."
    self.spareable_text = "* Froggit seems reluctant\nto fight you."

    self.dialogue = {
        "[wave:2]Ribbit,\nribbit.",
        "[wave:2]Croak,\ncroak.",
        "[wave:2]Hop,\nhop.",
        "[wave:2]Meow."
    }
    self.flip_dialogue = true

    self.waves = {
        "froggit/leapfrog",
        "froggit/flies"
        --"froggit/splinter"
    }

    self.damage_offset = {0, -16}
end

function Froggit:onAct(battler, name)
    if name == "Compliment" then
        self:addMercy(100)
        self.dialogue_override = "[wave:2](Blushes\ndeeply.)\nRibbit.."

        return "* Froggit didn't understand\nwhat you said,[wait:5] but was\nflattered anyway."
    elseif name == "Threaten" then
        self:addMercy(100)
        self.dialogue_override = "[wave:2]Shiver,\nshiver."

        return "* Froggit didn't understand\nwhat you said,[wait:5] but was\nscared anyway."
    elseif name == "Standard" then
        self:addMercy(100)
        self.dialogue_override = "[wave:2](Blushes\ndeeply.)\nRibbit.."

        return "* Froggit didn't understand\nwhat "..battler.chara:getName().." did,[wait:5] but was\nsated anyway."
    end

    return super:onAct(self, battler, name)
end

function Froggit:getMoney()
    if self.health >= self.max_health and self.mercy >= 100 then
        return self.money + 2
    else
        return self.money
    end
end

function Froggit:selectWave()
    local waves = self:getNextWaves()

    if waves and #waves > 0 then
        local wave = Utils.pick(waves)
        if #Game.battle.enemies > 1 and wave == "froggit/leapfrog" then
            wave = "froggit/flies"
        end

        if #Game.battle.enemies > 1 and wave == "froggit/flies" then
            local picker = Utils.random(0, 1, 1)
            if picker == 1 then
                wave = "froggit/splinter"
            end
        end
        self.selected_wave = wave
        return wave
    end
end

function Froggit:getDamageVoice()
    return "ehurt1"
end

return Froggit