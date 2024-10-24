local StoryCutscene, super = Class(Cutscene, "StoryCutscene")

function StoryCutscene:init(scene, can_skip, handler, ...)

    self.handler = handler

    self.text_objects = {
    }

    Game.lock_movement = true
    Game.cutscene_active = true

    self.can_skip = can_skip

    self.text_positions = {
        ["far_left"       ] = {118 , 320},
        ["center"         ] = {118+108 , 320},
        ["far_right"      ] = {440, 320},
        ["left"           ] = {160, 320},
        ["top_left"       ] = {80 , 160},
        ["middle_bottom"  ] = {160, 370},
        ["left_bottom"    ] = {120, 370},
        ["far_left_bottom"] = {80 , 370},
        ["text_human"     ] = {40 , 370},
        ["text_monster"   ] = {220, 370},
        ["text_prince"    ] = {400, 370}
    }

    self.speed = 1

    super:init(self, scene, ...)
end

function StoryCutscene:update()

    super:update(self)
end

function StoryCutscene:onEnd()
    Game.lock_movement = true
    Game.cutscene_active = false

    self:removeText()

    super:onEnd(self)
end

function StoryCutscene:removeText()
    for i, v in ipairs(self.text_objects) do
        v:remove()
    end
end

function StoryCutscene:setSpeed(speed)
    self.speed = speed
end

function StoryCutscene:text(text, pos)
    local x, y = unpack(self.text_positions[pos])
    local dialogue = self.handler:addChild(DialogueText("[spacing:2]"..text, x, y, nil, nil, {style = "none", font = "main_mono"}))

    function dialogue:playTextSound(current_node)
        if self.state.skipping and (Input.down("cancel") or self.played_first_sound) then
            return
        end
    
        if current_node.type ~= "character" then
            return
        end
    
        local no_sound = { "\n" }
    
        if (Utils.containsValue(no_sound, current_node.character)) then
            return
        end
    
        if (self.state.typing_sound ~= nil) and (self.state.typing_sound ~= "") then
            self.played_first_sound = true
            if Kristal.callEvent("onTextSound", self.state.typing_sound, current_node) then
                return
            end
            Assets.playSound("voice/" .. self.state.typing_sound)
        end
    end

    dialogue.state.speed = self.speed
    dialogue.state.typing_sound = "ut"
    dialogue.layer = self.handler.layers["text"]
    dialogue.parallax_x = 0
    dialogue.parallax_y = 0
    dialogue.skippable = false
    table.insert(self.text_objects, dialogue)
    return dialogue
end

return StoryCutscene