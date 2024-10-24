local OptionsMenu, super = Class(Object, "OptionsMenu")

function OptionsMenu:init(x, y, skip)
    super.init(self)
    Input.clear("confirm")

    Game.world.state = "MENU"
    local r = Rectangle(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
    r.color = {0,0,0}
    r.layer = 500
    self:addChild(r)
    self.extreme = 0
    self.extreme2 = 0

    Game.world.music:stop()

    self.rectile = 0
    self.siner = 0

    self.state = "INTRO" --MAIN, INTRO

    self.second = false

    self.font = Assets.getFont("main")
    self.font2 = Assets.getFont("small")

    self.messages = {
        -- ENGLISH
        {
            winter   = "cold outside\nbut stay warm\ninside of you",
            spring   = "spring time\nback to school",
            fall     = "sweep a leaf\nsweep away a\ntroubles",
            summer   = "try to withstand\nthe sun's life-\ngiving rays",
        },
    }

    self.weather = 0
    self.weathermusic = "none"
    if not skip then
        local month = os.date("*t").month
        if month >= 3 and month <= 5 then
            self.weather = 2
            self.weathermusic = "options_fall"
        elseif month >= 6 and month <= 8 then
            self.weather = 3
            self.weathermusic = "options_summer"
        elseif month >= 9 and month <= 11 then
            self.weather = 4
            self.weathermusic = "options_fall"
        elseif month >= 12 or month < 3 then
            self.weather = 1
            self.weathermusic = "options_winter"
        end
    end

    self.selected = 1
end

function OptionsMenu:draw()
    super.draw(self)
    love.graphics.setFont(self.font)
    self.siner = self.siner + 1

    if self.weather == 1 then
        local flake = obj_ct_fallobj(0,0)
        flake.layer = 900
        self:addChild(flake)
        love.graphics.setColor(0.5,0.5,0.5)
        love.graphics.printf(self.messages[1].winter, ((220-8) + math.sin((self.siner / 9))), ((120+40) + math.cos((self.siner / 9))), SCREEN_WIDTH, "center", 19.2)
        if not self.dog then
            self.dog = Sprite("ui/settings/tobdog_winter", 250*2, 218*2)
            self:addChild(self.dog)
        end
        self.dog:setScale(2)
        self.dog.layer = 1000
    elseif self.weather == 2 then
        local flake = obj_ct_fallobj(0,0,"ui/settings/fallleaf")
        flake.sprite.color = Utils.mergeColor({1,0,0}, {1,1,1}, 0.5)
        flake.layer = 900
        self:addChild(flake)
        love.graphics.setColor(0.5,0.5,0.5)
        love.graphics.printf(self.messages[1].spring, ((220-8) + math.sin((self.siner / 9))), ((120+40) + math.cos((self.siner / 9))), SCREEN_WIDTH, "center", 19.2)
        if not self.dog then
            self.dog = Sprite("ui/settings/tobdog_spring", 250*2, 218*2)
            self:addChild(self.dog)
            self.dog:play(0.5, true)
        end
        self.dog:setScale(2)
        self.dog.layer = 1000
    elseif self.weather == 3 then
        love.graphics.setColor(1,1,0)
        love.graphics.circle("fill", (258 + (math.cos((self.siner / 18)) * 6))*2, (40 + (math.sin((self.siner / 18)) * 6))*2, (28 + (math.sin((self.siner / 6)) * 4))*2)
        love.graphics.setColor(0.5,0.5,0.5)
        love.graphics.printf(self.messages[1].summer, ((220-8) + math.sin((self.siner / 9))), ((120+40) + math.cos((self.siner / 9))), SCREEN_WIDTH, "center", 19.2)

        self.extreme2 = self.extreme2 + 1
        if (self.extreme2 >= 240) then
            self.extreme = self.extreme + 1
            if ((self.extreme >= 1100) and (math.abs(math.sin(self.siner / 15)) < 0.1)) then
                self.extreme = 0
                self.extreme2 = 0
            end
        end
        
        if not self.dog then
            self.dog = Sprite("ui/settings/tobdog_summer", 250*2, 225*2)
            self:addChild(self.dog)
            self.dog:play(0.5, true)
        end
        self.dog:setOrigin(0.5,1)
        self.dog:setScale((2 + (math.sin(self.siner / 15) * (0.2 + (self.extreme / 800))))*2, (2 - (math.sin(self.siner / 15) * (0.2 + (self.extreme / 900))))*2)
        self.dog.layer = 1000
    elseif self.weather == 4 then
        local flake = obj_ct_fallobj(0,0,"ui/settings/fallleaf")
        flake.sprite.color = Utils.pick{{1,0,0}, {1, 161/255, 66/255}, {1,1,0}}
        flake.layer = 900
        self:addChild(flake)
        love.graphics.setColor(0.5,0.5,0.5)
        love.graphics.printf(self.messages[1].fall, ((220-8) + math.sin((self.siner / 9))), ((120+40) + math.cos((self.siner / 9))), SCREEN_WIDTH, "center", 19.2)
        love.graphics.setColor(1,1,1)
        if not self.dog then
            self.dog = Sprite("ui/settings/tobdog_autumn", 250*2, 218*2)
            self:addChild(self.dog)
        end
        self.dog:setScale(2)
        self.dog.layer = 1000
    end
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(Assets.getFont("main", 64))
    love.graphics.printf("SETTINGS", 0, 20, SCREEN_WIDTH, "center") 

    love.graphics.setFont(self.font)
    if self.selected == 1 then love.graphics.setColor(1,1,0) else love.graphics.setColor(1,1,1) end
    love.graphics.print("EXIT", 40, 80)
    if self.selected == 2 then love.graphics.setColor(1,1,0) else love.graphics.setColor(1,1,1) end
    love.graphics.print("LANGUAGE", 40, 140)
    love.graphics.print("ENGLISH", 184, 140)

    if self.weather ~= 0 then
        if self.state == "INTRO" then
            if (self.rectile == 16) then
                Assets.playSound("harpnoise")
            end
            self.rectile = self.rectile + 4
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle("fill", (-168+2 - self.rectile)*2, -10*2, 330*2, 250*2)
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle("fill", (164-2 + self.rectile)*2, -10*2, 330*2, 250*2)
            if (self.rectile >= 170) then
                Game.world.music:play(self.weathermusic, 0.8, 1)
                self.state = "MAIN"
            end
        end
    else
        self.state = "MAIN"
    end
end

function OptionsMenu:update()
    super.update(self)
    if self.state == "MAIN" then
        if Input.pressed("down") then
            Input.clear("down")
            if self.selected < 2 then
                self.selected = self.selected + 1
            end
        end
        if Input.pressed("up") then
            Input.clear("up")
            if self.selected > 1 then
                self.selected = self.selected - 1
            end
        end
        if Input.pressed("left") then
            Input.clear("left")
            if self.selected == 2 then
                -- No language system so just a placeholder
                --[[
                if Mod.language == "japanese" then
                    Mod.language = "english"
                elseif Mod.language == "english" then
                    Mod.language = "japanese"
                end
                ]]
            end
        end
        if Input.pressed("right") then
            Input.clear("right")
            if self.selected == 2 then
                -- No language system so just a placeholder
                --[[
                if Mod.language == "japanese" then
                    Mod.language = "english"
                elseif Mod.language == "english" then
                    Mod.language = "japanese"
                end
                ]]
            end
        end
        if Input.pressed("confirm") then
            Input.clear("confirm")
            if self.selected == 1 then
                if Kristal.hasSaveFile() then
                    local continueFile = ContinueFile()
                    continueFile.layer = WORLD_LAYERS["ui"]
                    Game.stage:addChild(continueFile)
                    self:remove()
                else
                    local newFile = NewFile()
                    newFile.layer = WORLD_LAYERS["ui"]
                    Game.stage:addChild(newFile)
                    self:remove()
                end
            elseif self.selected == 2 then
                if Mod.language == "engrish" then
                    Mod.language = "english"
                elseif Mod.language == "english" then
                    Mod.language = "spanish"
                elseif Mod.language == "spanish" then
                    Mod.language = "portuguese"
                elseif Mod.language == "portuguese" then
                    Mod.language = "engrish"
                end
            end
        end
    end
end

return OptionsMenu