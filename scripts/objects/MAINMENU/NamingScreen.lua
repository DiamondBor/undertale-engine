local NamingScreen, super = Class(Object, "NamingScreen")

function NamingScreen:init(x, y)
    super.init(self)
    Input.clear("confirm")

    Game.world.state = "MENU"

    self.state = "NAMEENTRY" --NAMEENTRY, NAMECONFIRM, NAMEOUTRO
    self.timer = 0
    self.fadetimer = 0
    self.sintimer = 0
    self.shaketimer = 0
    self.shake = 0.8

    self.font = Assets.getFont("main")

    self.selected_row = 1
    self.selected_col = 1

    self.fade = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	self.fade.color = {1,1,1}
    self.fade.alpha = 0
    self.fade.layer = WORLD_LAYERS["top"]
	Game.stage:addChild(self.fade)
    
    self.draw_bg = true

    self.upper_keys = {
        {"A","B","C","D","E","F","G"},
        {"H","I","J","K","L","M","N"},
        {"O","P","Q","R","S","T","U"},
        {"V","W","X","Y","Z"}
    }
    self.lower_keys = {
        {"a","b","c","d","e","f","g"},
        {"h","i","j","k","l","m","n"},
        {"o","p","q","r","s","t","u"},
        {"v","w","x","y","z"}
    }

    self.name = ""
    self.nametext = "Is this name correct?"
    self.can_use_name = true
end

function NamingScreen:draw()
    super.draw(self)
    love.graphics.setFont(self.font)
    love.graphics.setColor(0,0,0)
    if self.draw_bg then
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    end

    love.graphics.setFont(self.font)
    if self.state == "NAMEENTRY" then
        love.graphics.setColor(1,1,1)
        love.graphics.printf("Name the human.", 0, 60, SCREEN_WIDTH, "center")
        love.graphics.print(self.name, 280, 110)

        -- Uppercase
        for i, v in ipairs(self.upper_keys[1]) do
            local last_shake = 0
            local offset_x = 0
            local offset_y = 0
            if self.shake > 0 then
                if self.shaketimer - last_shake >= (1 * DTMULT) then
                    last_shake = self.timer
                    offset_x = Utils.round(Utils.random(-self.shake, self.shake))
                    offset_y = Utils.round(Utils.random(-self.shake, self.shake))
                end
            end
            if self.selected_row == 1 and self.selected_col == i then
                love.graphics.setColor(1,1,0)
            else
                love.graphics.setColor(1,1,1)
            end
            love.graphics.print(v, 75 + (i * 60) + offset_x, (150 + offset_y))
        end
        for i, v in ipairs(self.upper_keys[2]) do
            local last_shake = 0
            local offset_x = 0
            local offset_y = 0
            if self.shake > 0 then
                if self.shaketimer - last_shake >= (1 * DTMULT) then
                    last_shake = self.timer
                    offset_x = Utils.round(Utils.random(-self.shake, self.shake))
                    offset_y = Utils.round(Utils.random(-self.shake, self.shake))
                end
            end
            
            if self.selected_row == 2 and self.selected_col == i then
                love.graphics.setColor(1,1,0)
            else
                love.graphics.setColor(1,1,1)
            end
            love.graphics.print(v, 75 + (i * 60) + offset_x, (180 + offset_y) - 4)
        end
        for i, v in ipairs(self.upper_keys[3]) do
            local last_shake = 0
            local offset_x = 0
            local offset_y = 0
            if self.shake > 0 then
                if self.shaketimer - last_shake >= (1 * DTMULT) then
                    last_shake = self.timer
                    offset_x = Utils.round(Utils.random(-self.shake, self.shake))
                    offset_y = Utils.round(Utils.random(-self.shake, self.shake))
                end
            end
            
            if self.selected_row == 3 and self.selected_col == i then
                love.graphics.setColor(1,1,0)
            else
                love.graphics.setColor(1,1,1)
            end
            love.graphics.print(v, 75 + (i * 60) + offset_x, (210 + offset_y) - 6)
        end
        for i, v in ipairs(self.upper_keys[4]) do
            local last_shake = 0
            local offset_x = 0
            local offset_y = 0
            if self.shake > 0 then
                if self.shaketimer - last_shake >= (1 * DTMULT) then
                    last_shake = self.timer
                    offset_x = Utils.round(Utils.random(-self.shake, self.shake))
                    offset_y = Utils.round(Utils.random(-self.shake, self.shake))
                end
            end
            
            if self.selected_row == 4 and self.selected_col == i then
                love.graphics.setColor(1,1,0)
            else
                love.graphics.setColor(1,1,1)
            end
            love.graphics.print(v, 75 + (i * 60) + offset_x, (240 + offset_y) - 8)
        end

        -- Lowercase
        for i, v in ipairs(self.lower_keys[1]) do
            local last_shake = 0
            local offset_x = 0
            local offset_y = 0
            if self.shake > 0 then
                if self.shaketimer - last_shake >= (1 * DTMULT) then
                    last_shake = self.timer
                    offset_x = Utils.round(Utils.random(-self.shake, self.shake))
                    offset_y = Utils.round(Utils.random(-self.shake, self.shake))
                end
            end
            
            if self.selected_row == 5 and self.selected_col == i then
                love.graphics.setColor(1,1,0)
            else
                love.graphics.setColor(1,1,1)
            end
            love.graphics.print(v, 75 + (i * 60) + offset_x, (280 + offset_y) - 10)
        end
        for i, v in ipairs(self.lower_keys[2]) do
            local last_shake = 0
            local offset_x = 0
            local offset_y = 0
            if self.shake > 0 then
                if self.shaketimer - last_shake >= (1 * DTMULT) then
                    last_shake = self.timer
                    offset_x = Utils.round(Utils.random(-self.shake, self.shake))
                    offset_y = Utils.round(Utils.random(-self.shake, self.shake))
                end
            end
            
            if self.selected_row == 6 and self.selected_col == i then
                love.graphics.setColor(1,1,0)
            else
                love.graphics.setColor(1,1,1)
            end
            love.graphics.print(v, 75 + (i * 60) + offset_x, (310 + offset_y) - 12)
        end
        for i, v in ipairs(self.lower_keys[3]) do
            local last_shake = 0
            local offset_x = 0
            local offset_y = 0
            if self.shake > 0 then
                if self.shaketimer - last_shake >= (1 * DTMULT) then
                    last_shake = self.timer
                    offset_x = Utils.round(Utils.random(-self.shake, self.shake))
                    offset_y = Utils.round(Utils.random(-self.shake, self.shake))
                end
            end
            
            if self.selected_row == 7 and self.selected_col == i then
                love.graphics.setColor(1,1,0)
            else
                love.graphics.setColor(1,1,1)
            end
            love.graphics.print(v, 75 + (i * 60) + offset_x, (340 + offset_y) - 14)
        end
        for i, v in ipairs(self.lower_keys[4]) do
            local last_shake = 0
            local offset_x = 0
            local offset_y = 0
            if self.shake > 0 then
                if self.shaketimer - last_shake >= (1 * DTMULT) then
                    last_shake = self.timer
                    offset_x = Utils.round(Utils.random(-self.shake, self.shake))
                    offset_y = Utils.round(Utils.random(-self.shake, self.shake))
                end
            end
            
            if self.selected_row == 8 and self.selected_col == i then
                love.graphics.setColor(1,1,0)
            else
                love.graphics.setColor(1,1,1)
            end
            love.graphics.print(v, 75 + (i * 60) + offset_x, (370 + offset_y) - 16)
        end

        -- Misc
        if self.selected_row == 9 and self.selected_col == 1 then
            love.graphics.setColor(1,1,0)
        else
            love.graphics.setColor(1,1,1)
        end
        love.graphics.print("Quit", 120, 400)
        if self.selected_row == 9 and self.selected_col == 2 then
            love.graphics.setColor(1,1,0)
        else
            love.graphics.setColor(1,1,1)
        end
        love.graphics.print("Backspace", 240, 400)
        if self.selected_row == 9 and self.selected_col == 3 then
            love.graphics.setColor(1,1,0)
        else
            love.graphics.setColor(1,1,1)
        end
        love.graphics.print("Done", 440, 400)
    elseif self.state == "NAMECONFIRM" then
        local last_shake = 0
        local offset_x = 0
        local offset_y = 0
        if self.shake > 0 then
            if self.timer - last_shake >= (1 * DTMULT) then
                last_shake = self.timer
                offset_x = Utils.round(Utils.random(-2, 2))
                offset_y = Utils.round(Utils.random(-2, 2))
            end
        end
        love.graphics.setColor(1,1,1)
        love.graphics.printf(self.nametext, 180, 60, SCREEN_WIDTH, "left")
        love.graphics.printf(self.name, (0 - (self.timer*8.1)) + offset_x, (110 + (self.timer*1.25)) + offset_y, SCREEN_WIDTH, "center", 0, 1 + (self.timer/40))

        if self.selected_col == 1 then
            love.graphics.setColor(1,1,0)
        else
            love.graphics.setColor(1,1,1)
        end
        love.graphics.print("No", 150-4, 400)
        if self.selected_col == 2 then
            love.graphics.setColor(1,1,0)
        else
            love.graphics.setColor(1,1,1)
        end
        love.graphics.print("Yes", 460, 400)
    elseif self.state == "BADNAME" then
        local last_shake = 0
        local offset_x = 0
        local offset_y = 0
        if self.shake > 0 then
            if self.timer - last_shake >= (1 * DTMULT) then
                last_shake = self.timer
                offset_x = Utils.round(Utils.random(-2, 2))
                offset_y = Utils.round(Utils.random(-2, 2))
            end
        end
        love.graphics.setColor(1,1,1)
        love.graphics.printf(self.nametext, 180, 60, SCREEN_WIDTH, "left")
        love.graphics.printf(self.name, (0 - (self.timer*8.1)) + offset_x, (110 + (self.timer*1.25)) + offset_y, SCREEN_WIDTH, "center", 0, 1 + (self.timer/40))

        love.graphics.setColor(1,1,0)
        love.graphics.print("Go back", 120-4, 400)
    else
        local last_shake = 0
        local offset_x = 0
        local offset_y = 0
        if self.shake > 0 then
            if self.timer - last_shake >= (1 * DTMULT) then
                last_shake = self.timer
                offset_x = Utils.round(Utils.random(-2, 2))
                offset_y = Utils.round(Utils.random(-2, 2))
            end
        end
        love.graphics.setColor(1,1,1)
        love.graphics.printf(self.name, (0 - (self.timer*8.1)) + offset_x, (110 + (self.timer*1.25)) + offset_y, SCREEN_WIDTH, "center", 0, 1 + (self.timer/40))
    end
end

function NamingScreen:update()
    super.update(self)
    self.shaketimer = self.shaketimer + DTMULT
    if self.state == "NAMEENTRY" then
        if Input.pressed("down") then
            if self.selected_row < 9 then
                if self.selected_row == 8 then
                    if self.selected_col < 3 then
                        self.selected_col = 1
                    elseif self.selected_col < 6 then
                        self.selected_col = 2
                    end
                elseif self.selected_row == 7 then
                    if self.selected_col > 5 then
                        self.selected_col = 3
                        self.selected_row = self.selected_row + 1
                    end
                end
                self.selected_row = self.selected_row + 1
            else
                self.selected_row = 1
                if self.selected_col == 1 then
                    self.selected_col = 1
                elseif self.selected_col == 2 then
                    self.selected_col = 3
                elseif self.selected_col == 3 then
                    self.selected_col = 6
                end
            end
        end
        if Input.pressed("up") then
            if self.selected_row > 1 then
                if self.selected_row == 9 then
                    if self.selected_col == 2 then
                        self.selected_col = 3
                    elseif self.selected_col == 3 then
                        self.selected_col = 6
                        self.selected_row = self.selected_row - 1
                    end
                end
                self.selected_row = self.selected_row - 1
            else
                self.selected_row = 9
                if self.selected_col < 3 then
                    self.selected_col = 1
                elseif self.selected_col < 6 then
                    self.selected_col = 2
                else
                    self.selected_col = 3
                end
            end
        end
        if Input.pressed("left") then
            self.selected_col = self.selected_col - 1
            if self.selected_row < 9 then
                if self.selected_col < 1 then
                    self.selected_col = 7
                    self.selected_row = self.selected_row - 1
                end
            else
                if self.selected_col <= 0 then
                    self.selected_col = 3
                end
            end
            if self.selected_row == 0 then self.selected_row = 1 self.selected_col = 1 end
        end
        if Input.pressed("right") then
            self.selected_col = self.selected_col + 1
            if self.selected_row < 9 then
                if self.selected_col > 7 then
                    self.selected_col = 1
                    self.selected_row = self.selected_row + 1
                elseif self.selected_row == 4 then
                    if self.selected_col > 5 then
                        self.selected_col = 1
                        self.selected_row = self.selected_row + 1
                    end
                end
            else
                if self.selected_col >= 4 then
                    self.selected_col = 1
                end
            end
        end
        if Input.pressed("confirm") then
            Input.clear("confirm")
            if self.selected_row < 9 then
                if #self.name < 6 then
                    if self.selected_row < 5 then
                        self.name = self.name..self.upper_keys[self.selected_row][self.selected_col]
                    else
                        self.name = self.name..self.lower_keys[self.selected_row-4][self.selected_col]
                    end
                end
            end
            if self.selected_row == 9 then
                if self.selected_col == 1 then
                    if Game:getFlag("notanewsave") then
                        -- Do nothing for now
                    else
                        local newFile = NewFile()
                        newFile.layer = WORLD_LAYERS["ui"]
                        newFile.second = true
                        Game.stage:addChild(newFile)
                        self.layer = WORLD_LAYERS["ui"]+1
                        self.draw_bg = false
                        Game.world.timer:after(1/30, function()
                            self:remove()
                        end)
                    end
                elseif self.selected_col == 2 then
                    if #self.name > 0 then
                        self.name = self.name:sub(1, #self.name - 1)
                    end
                else
                    if #self.name > 0 then
                        self:check()
                        if self.can_use_name then
                            self.state = "NAMECONFIRM"
                        else
                            self.state = "BADNAME"
                        end
                        self.selected_col = 1
                        self.sintimer = 0
                    end
                end
            end
            self:check()
        end
        if Input.pressed("cancel") then
            if #self.name > 0 then
                self.name = self.name:sub(1, #self.name - 1)
            end
        end
        if self.selected_row == 4 and self.selected_col > 5 then
            self.selected_col = 5
        end
        if self.selected_row == 8 and self.selected_col > 5 then
            self.selected_col = 5
        end
        if self.selected_row == 9 and self.selected_col > 3 then
            self.selected_col = 3
        end
    elseif self.state == "NAMECONFIRM" then
        if Input.pressed("confirm") then
            Input.clear("confirm")
            if self.selected_col == 1 then
                self.state = "NAMEENTRY"
                self.selected_col = 3
                self.timer = 0
            else
                Game.save_name = self.name
                Game:setFlag("notanewsave", true)
                Assets.stopAndPlaySound("cymbal", 0.8, 0.95)
                Game.world.music.volume = 0
                self.state = "NAMEOUTRO"
                Kristal.utengine_in_main_menu = false
            end
        end
        --[[
        if Input.pressed("cancel") then
            self.state = "NAMEENTRY"
            self.selected_col = 3
            self.timer = 0
        end
        --]]
        if Input.pressed("left") then
            self.selected_col = 1
        end
        if Input.pressed("right") then
            self.selected_col = 2
        end
        if self.timer < 100 then
            self.timer = self.timer + (1*DTMULT)
        end
        self.sintimer = self.sintimer + (1*DTMULT)
    elseif self.state == "BADNAME" then
        if Input.pressed("confirm") then
            Input.clear("confirm")
            self.state = "NAMEENTRY"
            self.selected_col = 3
            self.timer = 0
        end
        if self.timer < 100 then
            self.timer = self.timer + (1*DTMULT)
        end
        self.sintimer = self.sintimer + (1*DTMULT)
    else
        if self.timer < 100 then
            self.timer = self.timer + (1*DTMULT)
        end
        if self.fadetimer < 180 then
            self.fadetimer = self.fadetimer + (1*DTMULT)
            if self.fadetimer < 156 then
                self.fade.alpha = self.fade.alpha + (1*DTMULT)/156
            end
        end
        if self.fadetimer >= 180 then
            Game.world:loadMap(Kristal.getModOption("map"))
            Game.playtime = 0
            self.fade:remove()
            self:remove()
            Game.world.state = "GAMEPLAY"
            Game.lock_movement = false
            Game.world.music:play(Game.world.map.music)
        end
        self.sintimer = self.sintimer + (1*DTMULT)
    end
end

function NamingScreen:check()
    if self.name:lower() == "aaaaaa" then
        self.can_use_name = true
        self.nametext = "Not very creative...?"
    elseif self.name:lower() == "asgore" then
        self.can_use_name = false
        self.nametext = "You cannot."
    elseif self.name:lower() == "toriel" then
        self.can_use_name = false
        self.nametext = "I think you should\nthink of your own\nname, my child."
    elseif self.name:lower() == "sans" then
        self.can_use_name = false
        self.nametext = "nope."
    elseif self.name:lower() == "undyne" then
        self.can_use_name = false
        self.nametext = "Get your OWN name!"
    elseif self.name:lower() == "flowey" then
        self.can_use_name = false
        self.nametext = "I already CHOSE\nthat name."
    elseif self.name:lower() == "chara" then
        self.can_use_name = true
        self.nametext = "The true name."
    elseif self.name:lower() == "alphys" then
        self.can_use_name = false
        self.nametext = "D-don't do that."
    elseif self.name:lower() == "alphy" then
        self.can_use_name = true
        self.nametext = "Uh... OK?"
    elseif self.name:lower() == "papyru" then
        self.can_use_name = true
        self.nametext = "I'LL ALLOW IT!!!!"
    elseif self.name:lower() == "napsta" or self.name:lower() == "blooky" then
        self.can_use_name = true
        self.nametext = "...........\n(They're powerless to\nstop you.)"
    elseif self.name:lower() == "murder" or self.name:lower() == "mercy" then
        self.can_use_name = true
        self.nametext = "That's a little on-\nthe nose, isn't it...?"
    elseif self.name:lower() == "asriel" then
        self.can_use_name = false
        self.nametext = "..."
    elseif self.name:lower() == "catty" then
        self.can_use_name = true
        self.nametext = "Bratty! Bratty!\nThat's MY name!"
    elseif self.name:lower() == "bratty" then
        self.can_use_name = true
        self.nametext = "Like, OK I guess."
    elseif self.name:lower() == "mtt" or self.name:lower() == "metta" or self.name:lower() == "mett" then
        self.can_use_name = true
        self.nametext = "OOOOH!!! ARE YOU\nPROMOTING MY BRAND?"
    elseif self.name:lower() == "gerson" then
        self.can_use_name = true
        self.nametext = "Wah ha ha! Why not?"
    elseif self.name:lower() == "shyren" then
        self.can_use_name = true
        self.nametext = "...?"
    elseif self.name:lower() == "aaron" then
        self.can_use_name = true
        self.nametext = "Is this name correct? ; )"
    elseif self.name:lower() == "temmie" then
        self.can_use_name = true
        self.nametext = "hOI!"
    elseif self.name:lower() == "woshua" then
        self.can_use_name = true
        self.nametext = "Clean name."
    elseif self.name:lower() == "jerry" then
        self.can_use_name = true
        self.nametext = "Jerry."
    elseif self.name:lower() == "bpants" then
        self.can_use_name = true
        self.nametext = "You are really scraping the\nbottom of the barrel."
    elseif self.name:lower() == "gaster" then
        self.can_use_name = false
        if not Game.world.cutscene then
            Game.world:startCutscene(function(cutscene)
                cutscene:wait(1/15)
                self.name = self.name:sub( 1, #self.name - 1 )
                cutscene:wait(1/15)
                Kristal.quickReload("none")
            end)
        end
    else
        self.can_use_name = true
        self.nametext = "Is this name correct?"
    end
end

return NamingScreen