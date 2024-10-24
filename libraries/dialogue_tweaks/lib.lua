local lib = {}

function lib:init()
    -- TODO: Make blinking animations
    Utils.hook(Actor, "init", function(orig, self)
        orig(self)

        -- Path to this actor's body portrait below dialogue image (optional)
        self.body_portrait_path = nil
        -- Offset position for this actor's body portrait (optional)
        self.body_portrait_offset = nil
    end)

    Utils.hook(Actor, "getBodyPortraitPath", function(orig, self)
        return self.body_portrait_path
    end)

    Utils.hook(Actor, "getBodyPortraitOffset", function(orig, self)
        return unpack(self.body_portrait_offset or {0, 0})
    end)

    -- Sorry but I didn't know how to make this init hook work properly with magical glass without doing this
    if not Mod.libs["magical-glass"] then
        Utils.hook(Textbox, "init", function(orig, self, x, y, width, height, default_font, default_font_size, battle_box)
            orig(self, x, y, width, height)
    
            self.body = Sprite(nil, self.face_x, self.face_y + 60, nil, nil)
            self.body:setScale(2, 2)
            self:addChild(self.body)
    
            self.text:registerCommand("face", function(text, node, dry)
                if self.actor and self.actor:getPortraitPath() then
                    self.face.path = self.actor:getPortraitPath()
                end
                if self.actor and self.actor:getBodyPortraitPath() then
                    self.body.path = self.actor:getBodyPortraitPath()
                end
                self:setFace(node.arguments[1], tonumber(node.arguments[2]), tonumber(node.arguments[3]), tonumber(node.arguments[4]), tonumber(node.arguments[5]))
            end)
            self.text:registerCommand("facec", function(text, node, dry)
                self.face.path = "face"
                local ox,  oy  = tonumber(node.arguments[2]), tonumber(node.arguments[3])
                local ox2, oy2 = tonumber(node.arguments[4]), tonumber(node.arguments[5])
                if self.actor then
                    local actor_ox, actor_oy = self.actor:getPortraitOffset()
                    ox = (ox or 0) - actor_ox
                    oy = (oy or 0) - actor_oy
                    local body_ox, body_oy = self.actor:getBodyPortraitOffset()
                    ox2 = (ox2 or 0) + body_ox
                    oy2 = (oy2 or 0) + 60 + body_oy
                end
                self:setFace(node.arguments[1], ox, oy, ox2, oy2)
            end)
        end)
    else
        Utils.hook(Textbox, "init", function(orig, self, x, y, width, height, default_font, default_font_size, battle_box)
            Textbox.__super.init(self, x, y, width, height)
    
            self.box = UIBox(0, 0, width, height)
            self.box.layer = -1
            self.box.debug_select = false
            self:addChild(self.box)
        
            self.battle_box = battle_box
            if battle_box then
                self.box.visible = false
            end
    
            if battle_box then
                if Game.battle.light then
                    self.face_x = 6
                    self.face_y = -2
            
                    self.text_x = 0
                    self.text_y = -2 
                else
                    self.face_x = -4
                    self.face_y = 2
            
                    self.text_x = 0
                    self.text_y = -2 -- TODO: This was changed 2px lower with the new font, but it was 4px offset. Why? (Used to be 0)
                end
            elseif Game:isLight() then
                self.face_x = 13
                self.face_y = 6
        
                self.text_x = 2
                self.text_y = -4
            else
                self.face_x = 18
                self.face_y = 6
        
                self.text_x = 2
                self.text_y = -4  -- TODO: This was changed with the new font but it's accurate anyways
            end
        
            self.actor = nil
        
            self.default_font = default_font or "main_mono"
            self.default_font_size = default_font_size
        
            self.font = self.default_font
            self.font_size = self.default_font_size
        
            self.face = Sprite(nil, self.face_x, self.face_y, nil, nil, "face")
            self.face:setScale(2, 2)
            self.face.getDebugOptions = function(self2, context)
                context = super.getDebugOptions(self2, context)
                if Kristal.DebugSystem then
                    context:addMenuItem("Change", "Change this portrait to a different one", function()
                        Kristal.DebugSystem:setState("FACES", self)
                    end)
                end
                return context
            end
            self:addChild(self.face)
            
            self.body = Sprite(nil, self.face_x, self.face_y + 60, nil, nil)
            self.body:setScale(2, 2)
            self:addChild(self.body)
        
            -- Added text width for autowrapping
            self.wrap_add_w = battle_box and 0 or 14
        
            self.text = DialogueText("", self.text_x, self.text_y, width + self.wrap_add_w, SCREEN_HEIGHT)
            self:addChild(self.text)
        
            self.reactions = {}
            self.reaction_instances = {}
        
            self.text:registerCommand("face", function(text, node, dry)
                if self.actor and self.actor:getPortraitPath() then
                    self.face.path = self.actor:getPortraitPath()
                end
                if self.actor and self.actor:getBodyPortraitPath() then
                    self.body.path = self.actor:getBodyPortraitPath()
                end
                self:setFace(node.arguments[1], tonumber(node.arguments[2]), tonumber(node.arguments[3]), tonumber(node.arguments[4]), tonumber(node.arguments[5]))
            end)
            self.text:registerCommand("facec", function(text, node, dry)
                self.face.path = "face"
                local ox,  oy  = tonumber(node.arguments[2]), tonumber(node.arguments[3])
                local ox2, oy2 = tonumber(node.arguments[4]), tonumber(node.arguments[5])
                if self.actor then
                    local actor_ox, actor_oy = self.actor:getPortraitOffset()
                    ox = (ox or 0) - actor_ox
                    oy = (oy or 0) - actor_oy
                    local body_ox, body_oy = self.actor:getBodyPortraitOffset()
                    ox2 = (ox2 or 0) + body_ox
                    oy2 = (oy2 or 0) + 60 + body_oy
                end
                self:setFace(node.arguments[1], ox, oy, ox2, oy2)
            end)
        
            self.text:registerCommand("react", function(text, node, dry)
                local react_data
                if #node.arguments > 1 then
                    react_data = {
                        text = node.arguments[1],
                        x = tonumber(node.arguments[2]) or (self.battle_box and self.REACTION_X_BATTLE[node.arguments[2]] or self.REACTION_X[node.arguments[2]]),
                        y = tonumber(node.arguments[3]) or (self.battle_box and self.REACTION_Y_BATTLE[node.arguments[3]] or self.REACTION_Y[node.arguments[3]]),
                        face = node.arguments[4],
                        actor = node.arguments[5] and Registry.createActor(node.arguments[5]),
                    }
                else
                    react_data = tonumber(node.arguments[1]) and self.reactions[tonumber(node.arguments[1])] or self.reactions[node.arguments[1]]
                end
                local reaction = SmallFaceText(react_data.text, react_data.x, react_data.y, react_data.face, react_data.actor)
                reaction.layer = 0.1 + (#self.reaction_instances) * 0.01
                self:addChild(reaction)
                table.insert(self.reaction_instances, reaction)
            end, {instant = false})
        
            self.advance_callback = nil
        end)
    end

    Utils.hook(Textbox, "setFace", function(orig, self, face, ox, oy, ox2, oy2)
        self.face:setSprite(face)
        self.face:play(4/30)

        if self.actor then
            if self.body then
                self.body:setSprite(self.actor:getBodyPortraitPath())
            end
            local actor_ox, actor_oy = self.actor:getPortraitOffset()
            ox = (ox or 0) + actor_ox
            oy = (oy or 0) + actor_oy
            local body_ox, body_oy = self.actor:getBodyPortraitOffset()
            ox2 = (ox2 or 0) + body_ox
            oy2 = (oy2 or 0) + 60 + body_oy
        end
        self.face:setPosition(self.face_x + (ox or 0), self.face_y + (oy or 0))
        if self.body then
            self.body:setPosition(self.face_x + (ox or 0) + (ox2 or 0), self.face_y + (oy or 0) + (oy2 or 0))
        end

        self:updateTextBounds()
    end)

end

return lib