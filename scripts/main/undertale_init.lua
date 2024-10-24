function Mod:initUT()
    love.mouse.setVisible(true)

    Game.lock_movement = true
    self:loadUTHooks()
end

function Mod:loadUT()
    if Kristal.getModOption("encounter") then
        Game.save_name = Game.save_name or Kristal.Config["defaultName"] or Kristal.getLibConfig("magical-glass", "default_name") or "CHARA"
    end
    Kristal.Overlay.quit_frames = {
        Assets.getTexture("ui/quitut_1"),
        Assets.getTexture("ui/quitut_2"),
        Assets.getTexture("ui/quitut_3"),
    }
end

function Mod:unloadUT()
    Kristal.Overlay.quit_frames = {
        Assets.getTexture("ui/quit_1"),
        Assets.getTexture("ui/quit_2"),
        Assets.getTexture("ui/quit_3"),
        Assets.getTexture("ui/quit_4"),
        Assets.getTexture("ui/quit_5")
    }
end

function Mod:postInitUT(new_file)
    love.window.setTitle("UNDERTALE")
    love.window.setIcon(Assets.getTextureData("icon"))
    if not Kristal.is_temp_reload then
        Game.lock_movement = true
        Game.world:loadMap("empty")
        Game.world.music:stop()
        if Kristal.getSaveFile() == nil then
            Game:setBorder("none")
        end
        Game.world:startCutscene(function(cutscene)
            Kristal.utengine_in_main_menu = true
            local logo = Sprite("logo", 0, 0)
            logo:setOrigin(0, 0)
            Game.stage:addChild(logo)
            logo.layer = WORLD_LAYERS["top"]
            cutscene:wait(1.25)
            logo:remove()
            self:makeUTStory(cutscene)
        end)
    else
        if Kristal.utengine_in_main_menu then
            local data = Kristal.getSaveFile()
            if data then
                Game.world:loadMap(data.room_id)
            else
                Game.world:loadMap(Kristal.getModOption("map"))
            end
        end
    end
end

function Mod:makeUTStory(cutscene)
    Game.story = StoryHandler()
    Game.world:addChild(Game.story)
    Game.story.layer = WORLD_LAYERS["above_ui"] - 50
    cutscene:wait(function() return Game.story:isOver() end)
    Game.story:remove()
end

function Mod:loadMenus()
    if Kristal.getSaveFile() == nil then
        Game.lw_money = 0
        Game:setFlag("has_cell_phone", false)
        local newFile = NewFile()
        newFile.layer = WORLD_LAYERS["ui"]
        Game.stage:addChild(newFile)
    else
        Game:setFlag("##playtime", Game.playtime)
        local continueFile = ContinueFile()
        continueFile.layer = WORLD_LAYERS["ui"]
        Game.stage:addChild(continueFile)
    end
end

function Mod:loadUTHooks()
    -- Save name stuff

    --[[
    Utils.hook(LightMenu, "draw", function(orig, self)
        LightMenu.__super.draw(self)
        local offset = 0
        if self.top then
            offset = 270
        end
    
        local chara = Game.party[1]

        love.graphics.setFont(self.font)
        Draw.setColor(PALETTE["world_text"])
        if Kristal.getModOption("use_save_name") then
            love.graphics.print(Game.save_name, 46, 60 + offset)
        else
            love.graphics.print(chara:getName(), 46, 60 + offset)
        end
        love.graphics.setFont(self.font_small)
        love.graphics.print("LV  "..chara:getLightLV(), 46, 100 + offset)
        love.graphics.print("HP  "..chara:getHealth().."/"..chara:getStat("health"), 46, 118 + offset)
        -- pastency when -sam, to sam
        love.graphics.print(Game:getConfig("lightCurrencyShort"), 46, 136 + offset)
        love.graphics.print(Game.lw_money, 82, 136 + offset)
        
        love.graphics.setFont(self.font)
        if Game.inventory:getItemCount(self.storage, false) <= 0 then
            Draw.setColor(PALETTE["world_gray"])
        else
            Draw.setColor(PALETTE["world_text"])
        end
        love.graphics.print("ITEM", 84, 188 + (36 * 0))
        Draw.setColor(PALETTE["world_text"])
        love.graphics.print("STAT", 84, 188 + (36 * 1))
    
        if not Kristal.getLibConfig("magical-glass", "hide_cell") then
            if Game:getFlag("has_cell_phone") and #Game.world.calls > 0 then
                Draw.setColor(PALETTE["world_text"])
            else
                Draw.setColor(PALETTE["world_gray"])
            end
            love.graphics.print("CELL", 84, 188 + (36 * 2))
        else
            if Game:getFlag("has_cell_phone") then
                if #Game.world.calls > 0 then
                    Draw.setColor(PALETTE["world_text"])
                else
                    Draw.setColor(PALETTE["world_gray"])
                end
                love.graphics.print("CELL", 84, 188 + (36 * 2))
            end
        end
    
        if self.state == "MAIN" then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, 56, 160 + (36 * self.current_selecting), 0, 2, 2)
        end
    end)

    Utils.hook(LightStatMenu, "draw", function(orig, self)
        love.graphics.setFont(self.font)
        Draw.setColor(PALETTE["world_text"])
        if self.party_selecting == 1 then
            if Kristal.getModOption("use_save_name") then
                love.graphics.print("\"" .. Game.save_name .. "\"", 4, 8)
            else
                love.graphics.print("\"" .. Game.party[self.party_selecting]:getName() .. "\"", 4, 8)
            end
        else
            love.graphics.print("\"" .. Game.party[self.party_selecting]:getName() .. "\"", 4, 8)
        end

        local chara = Game.party[self.party_selecting]

        if self.style == "deltatraveler" then
            local ox, oy = chara.actor:getPortraitOffset()
            if chara:getLightPortrait() then
                Draw.draw(Assets.getTexture(chara:getLightPortrait()), 180 + ox, 7 + oy, 0, 2, 2)
            end
            if #Game.party > 1 then
                Draw.setColor(Game:getSoulColor())
                Draw.draw(self.heart_sprite, 212, 124, 0, 2, 2)
                Draw.setColor(PALETTE["world_text"])
                love.graphics.print("<                >", 162, 116)
            end
        elseif self.style == "magical_glass" then
            local ox, oy = chara.actor:getPortraitOffset()
            if chara:getLightPortrait() then
                Draw.draw(Assets.getTexture(chara:getLightPortrait()), 180 + ox, 50 + oy, 0, 2, 2)
            end
            if #Game.party > 1 then
                Draw.setColor(Game:getSoulColor())
                Draw.draw(self.heart_sprite, 213, 12 + 4, 0, 2, 2)
                
                if self.rightpressed == true then
                    Draw.setColor({1,1,0})
                    Draw.draw(Assets.getTexture("kristal/menu_arrow_right"), 268 + 4, 13, 0, 2, 2)
                else
                    Draw.setColor(PALETTE["world_text"])
                    Draw.draw(Assets.getTexture("kristal/menu_arrow_right"), 268, 13, 0, 2, 2)
                end
                if self.leftpressed == true then
                    Draw.setColor({1,1,0})
                    Draw.draw(Assets.getTexture("kristal/menu_arrow_left"), 160 - 4, 13, 0, 2, 2)
                else
                    Draw.setColor(PALETTE["world_text"])
                    Draw.draw(Assets.getTexture("kristal/menu_arrow_left"), 160, 13, 0, 2, 2)
                end
            end
        end
        Draw.setColor(PALETTE["world_text"])
        local exp_needed = math.max(0, chara:getLightEXPNeeded(chara:getLightLV() + 1) - chara:getLightEXP())
    
        local at = chara:getBaseStats()["attack"]
        local df = chara:getBaseStats()["defense"]
        
        if self.undertale_stat_display then
            at = at - 10
            df = df - 10
        end
        local offset = 0
        local show_magic = false
        for _,party in pairs(Game.party) do
            if party.lw_stats.magic > 0 then
                show_magic = true
            end
        end
        if self.always_show_magic or show_magic then
            offset = 18
            love.graphics.print("MG  ", 4, 228 - offset)
            love.graphics.print(chara:getBaseStats()["magic"]   .. " ("..chara:getEquipmentBonus("magic")   .. ")", 44, 228 - offset)
        end
        love.graphics.print("LV  "..chara:getLightLV(), 4, 68 - offset)
        love.graphics.print("HP  "..chara:getHealth().." / "..chara:getStat("health"), 4, 100 - offset)
        love.graphics.print("AT  "  .. at  .. " ("..chara:getEquipmentBonus("attack")  .. ")", 4, 164 - offset)
        love.graphics.print("DF  "  .. df  .. " ("..chara:getEquipmentBonus("defense") .. ")", 4, 196 - offset)
        love.graphics.print("EXP: " .. chara:getLightEXP(), 172, 164)
        love.graphics.print("NEXT: ".. exp_needed, 172, 196)
    
        local weapon_name = "None"
        local armor_name = "None"
        if chara:getWeapon() then
            weapon_name = chara:getWeapon():getEquipDisplayName() or chara:getWeapon():getName()
        end
        if chara:getArmor(1) then
            armor_name = chara:getArmor(1):getEquipDisplayName() or chara:getArmor(1):getName()
        end
        
        love.graphics.print("WEAPON: "..weapon_name, 4, 256)
        love.graphics.print("ARMOR: "..armor_name, 4, 288)
    
        love.graphics.print(Game:getConfig("lightCurrency"):upper()..": "..Game.lw_money, 4, 328)
        if MagicalGlassLib.kills > 20 then
            love.graphics.print("KILLS: "..MagicalGlassLib.kills, 172, 328)
        end
    end)

    Utils.hook(LightSaveMenu, "draw", function(orig, self)
        love.graphics.setFont(self.font)
        if self.state == "SAVED" then
            Draw.setColor(PALETTE["world_text_selected"])
        else
            Draw.setColor(PALETTE["world_text"])
        end
    
        local data      = self.saved_file        or {}
        local mg        = data.magical_glass     or {}

        local name      = data.name              or Game.save_name
        local level     = mg.lw_save_lv          or 0
        local playtime  = data.playtime          or 0
        local room_name = data.room_name         or "--"
    
        love.graphics.print(name,         self.box.x + 8,        self.box.y - 10 + 8)
        love.graphics.print("LV "..level, self.box.x + 210 - 42, self.box.y - 10 + 8)
    
        local minutes = math.floor(playtime / 60)
        local seconds = math.floor(playtime % 60)
        local time_text = string.format("%d:%02d", minutes, seconds)
        love.graphics.printf(time_text, self.box.x - 280 + 148, self.box.y - 10 + 8, 500, "right")
    
        love.graphics.print(room_name, self.box.x + 8, self.box.y + 38)
    
        if self.state == "MAIN" then
            love.graphics.print("Save",   self.box.x + 30  + 8, self.box.y + 98)
            love.graphics.print("Return", self.box.x + 210 + 8, self.box.y + 98)
    
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, self.box.x + 10 + (self.selected_x - 1) * 180, self.box.y + 96 + 8, 0, 2, 2)
        elseif self.state == "SAVED" then
            love.graphics.print("File saved.", self.box.x + 30 + 8, self.box.y + 98)
        end
    
        Draw.setColor(1, 1, 1)
    
        Object.draw(self)
    end)

    Utils.hook(LightActionBox, "drawStatusStrip", function(orig, self)
        if not Game.battle.multi_mode then
            local x, y = 10, 130
            
            local name = self.battler.chara:getName()
            if self.index == 1 then
                if Kristal.getModOption("use_save_name") then
                    name = Game.save_name
                else
                    name = self.battler.chara:getName()
                end
            end
            local level = Game:isLight() and self.battler.chara:getLightLV() or self.battler.chara:getLevel()
            
            local current = self.battler.chara:getHealth()
            local max = self.battler.chara:getStat("health")
    
            love.graphics.setFont(Assets.getFont("namelv", 24))
            love.graphics.setColor(COLORS["white"])
            love.graphics.print(name .. "   LV " .. level, x, y)
    
            love.graphics.draw(Assets.getTexture("ui/lightbattle/hp"), x + 214, y + 5)
            
            local limit = self:getHPGaugeLengthCap()
            if limit == true then
                limit = 99
            end
            local size = max
            if limit and size > limit then
                size = limit
                limit = true
            end
    
            love.graphics.setColor(COLORS["red"])
            love.graphics.rectangle("fill", x + 245, y, size * 1.25, 21)
            love.graphics.setColor(COLORS["yellow"])
            love.graphics.rectangle("fill", x + 245, y, limit == true and math.ceil((Utils.clamp(current, 0, max + 10) / max) * size) * 1.25 or Utils.clamp(current, 0, max + 10) * 1.25, 21)
    
            if max < 10 and max >= 0 then
                max = "0" .. tostring(max)
            end
    
            if current < 10 and current >= 0 then
                current = "0" .. tostring(current)
            end
    
            local color = COLORS.white
            if self.battler.chara:getHealth() > 0 and not Game.battle.forced_victory then
                if self.battler.sleeping then
                    color = {0,0,1}
                elseif Game.battle:getActionBy(self.battler) and Game.battle:getActionBy(self.battler).action == "DEFEND" then
                    color = COLORS.aqua
                end
            end
            love.graphics.setColor(color)
            love.graphics.print(current .. " / " .. max, x + 245 + size * 1.25 + 14, y)
        else
            local x, y = 2 + (3 - #Game.battle.party) * 101 + (self.index - 1) * 101 * 2, 130
            
            local name = self.battler.chara:getShortName()
            if self.index == 1 then
                if Kristal.getModOption("use_save_name") then
                    name = Game.save_name
                else
                    name = self.battler.chara:getShortName()
                end
            end
            local level = Game:isLight() and self.battler.chara:getLightLV() or self.battler.chara:getLevel()
            
            local current = self.battler.chara:getHealth()
            local max = self.battler.chara:getStat("health")
            
            love.graphics.setFont(Assets.getFont("namelv", 24))
            love.graphics.setColor(COLORS["white"])
            love.graphics.print(name, x, y - 7)
            love.graphics.setFont(Assets.getFont("namelv", 16))
            love.graphics.print("LV " .. level, x, y + 13)
            
            if not Kristal.getLibConfig("magical-glass", "multi_neat_ui") then
                love.graphics.draw(Assets.getTexture("ui/lightbattle/hp"), x + 64, y + 15)
            end
            
            local small = false
            for _,party in ipairs(Game.battle.party) do
                if party.chara:getStat("health") >= 100 then
                    small = true
                end
            end
            love.graphics.setColor(COLORS["red"])
            love.graphics.rectangle("fill", x + 90, y, (small and 20 or 32) * 1.25, 21)
            love.graphics.setColor(COLORS["yellow"])
            love.graphics.rectangle("fill", x + 90, y, math.ceil((Utils.clamp(current, 0, max) / max) * (small and 20 or 32)) * 1.25, 21)
            
            love.graphics.setFont(Assets.getFont("namelv", 16))
            if max < 10 and max >= 0 then
                max = "0" .. tostring(max)
            end
    
            if current < 10 and current >= 0 then
                current = "0" .. tostring(current)
            end
            
            local color = COLORS.white
            if not Game.battle.forced_victory then
                if self.battler.is_down then 
                    color = {1,0,0}
                elseif self.battler.sleeping then
                    color = {0,0,1}
                elseif Game.battle:getActionBy(self.battler) and Game.battle:getActionBy(self.battler).action == "DEFEND" then
                    color = COLORS.aqua
                end
            end
            love.graphics.setColor(color)
            -- love.graphics.print(current .. "/" .. max, x + (small and 117 or 137), y + 3)
            love.graphics.printf(current .. "/" .. max, x + 195 - 500, y + 3, 500, "right")
            
            if Game.battle.current_selecting == self.index or DEBUG_RENDER and Input.alt() then
                love.graphics.setColor(self.battler.chara:getLightColor())
                love.graphics.setLineWidth(2)
                love.graphics.line(x - 3, y - 7, x - 3, y + 28)
                love.graphics.line(x - 3 - 1, y - 7, x + 196 + 1, y - 7)
                love.graphics.line(x + 196, y - 7, x + 196, y + 28)
                love.graphics.line(x - 3 - 1, y + 28, x + 196 + 1, y + 28)
            end
        end
    end)
    --]]

    Utils.hook(Kristal, "quickReload", function(orig, mode)
        Kristal.is_temp_reload = false
        if mode == "temp" then
            Kristal.is_temp_reload = true
        end
        orig(mode)
    end)

    Utils.hook(Game, "load", function(orig, self, data, index, fade)
        orig(self, data, index, fade)
        self.fader.alpha = 0
    end)

    Utils.hook(Kristal, "returnToMenu", function(orig)
        orig()
        Kristal.is_temp_reload = nil
    end)

    Utils.hook(Kristal.Overlay, "update", function(orig, self)
        if self.loading then
            if self.load_alpha < 1 then
                self.load_alpha = math.min(1, self.load_alpha + DT / 0.25)
            end
            self.load_timer = self.load_timer + DT
        else
            if self.load_alpha > 0 then
                self.load_alpha = math.max(0, self.load_alpha - DT / 0.25)
            end
            self.load_timer = 0
        end
    
        if love.keyboard.isDown("escape") and not self.quit_release then
            if self.quit_timer > 0.05 then
                if self.quit_alpha < 1 then
                    self.quit_alpha = math.min(1, self.quit_alpha + DT / 0.25)
                end
            end
            self.quit_timer = self.quit_timer + DT
            if self.quit_timer > 1 then
                if Mod ~= nil then
                    self.quit_release = true
                    if Kristal.getModOption("hardReset") then
                        love.event.quit("restart")
                    else
                        Kristal.returnToMenu()
                    end
                else
                    love.event.quit()
                end
            end
        else
            self.quit_timer = 0
            if self.quit_alpha > 0 then
                self.quit_alpha = math.max(0, self.quit_alpha - DT / 0.1)
            end
        end
    
        if self.quit_release and not love.keyboard.isDown("escape") then
            self.quit_release = false
        end
    end)

    Utils.hook(Kristal.Overlay, "draw", function(orig, self)
        -- Draw the quit text
        love.graphics.push()
        love.graphics.scale(1)
        Draw.setColor(1, 1, 1, self.quit_alpha)
        local quit_frame = (math.floor(self.quit_timer / 0.5) % #self.quit_frames) + 1
        Draw.draw(self.quit_frames[quit_frame], 1,1)
        love.graphics.pop()

        -- Draw the load text
        love.graphics.push()
        love.graphics.translate(0, SCREEN_HEIGHT)
        love.graphics.scale(2)
        Draw.setColor(1, 1, 1, self.load_alpha)
        local load_frame = (math.floor(self.load_timer / 0.25) % #self.load_frames) + 1
        local load_texture = self.load_frames[load_frame]
        Draw.draw(load_texture, 0, -load_texture:getHeight())
        love.graphics.pop()

        -- Draw the loader messages
        if Kristal.Loader.message ~= "" then
            love.graphics.setFont(self.font)
            local text = Kristal.Loader.message
            local x = SCREEN_WIDTH - self.font:getWidth(text) - 2
            local y = SCREEN_HEIGHT - self.font:getHeight() - 4
            Draw.setColor(0, 0, 0)
            for ox = -1, 1 do
                for oy = -1, 1 do
                    if ox ~= 0 or oy ~= 0 then
                        love.graphics.print(text, x + (ox * 2), y + (oy * 2))
                    end
                end
            end
            Draw.setColor(1, 1, 1)
            love.graphics.print(text, x, y)
        end

        -- Draw the FPS counter text
        if Kristal.Config and Kristal.Config["showFPS"] then
            love.graphics.setFont(self.font)
            local text = FPS .. " FPS"
            local x = SCREEN_WIDTH - self.font:getWidth(text) - 2
            local y = -4
            Draw.setColor(0, 0, 0)
            for ox = -1, 1 do
                for oy = -1, 1 do
                    if ox ~= 0 or oy ~= 0 then
                        love.graphics.print(text, x + (ox * 2), y + (oy * 2))
                    end
                end
            end
            Draw.setColor(1, 1, 1)
            love.graphics.print(text, x, y)
        end

        -- Reset the color
        Draw.setColor(1, 1, 1, 1)
    end)
    
    Utils.hook(Kristal, "onKeyPressed", function(orig, key, is_repeat)
        if self.disable_kristal_keybinds then
        
            if not TextInput.active and not (Input.gamepad_locked and Input.isGamepad(key)) then
                if not Utils.startsWith(key, "gamepad:") then
                    Input.active_gamepad = nil
                end
        
                local state = Kristal.getState()
                if state.onKeyPressed and not OVERLAY_OPEN then
                    state:onKeyPressed(key, is_repeat)
                end
            end
        
            local console_open = Kristal.Console and Kristal.Console.is_open
        
            if not is_repeat and Input.shouldProcess(key) then
                if key == "f4" or (key == "return" and Input.alt()) then
                    Kristal.Config["fullscreen"] = not Kristal.Config["fullscreen"]
                    love.window.setFullscreen(Kristal.Config["fullscreen"])
                end
            end
        
            if not is_repeat then
                TextInput.onKeyPressed(key)
            end

        else
            orig(key, is_repeat)
        end
    end)
end