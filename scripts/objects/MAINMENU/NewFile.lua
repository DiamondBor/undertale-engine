local NewFile, super = Class(Object, "NewFile")

function NewFile:init(x, y)
    super.init(self)
    Input.clear("confirm")

    Game.world.state = "MENU"
    Game.world.music:play("menu_0", 0.6, 1)

    self.state = "MAIN" --MAIN, SETTINGS (currently doesn't exist)

    self.second = false

    self.font = Assets.getFont("main")
    self.font2 = Assets.getFont("small")

    self.selected = 1
end

function NewFile:draw()
    super.draw(self)
    love.graphics.setFont(self.font)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    love.graphics.setColor(192/255,192/255,192/255)
    love.graphics.setFont(self.font)
    love.graphics.printf("--- Instruction ---", 0, 40, SCREEN_WIDTH, "center")
    love.graphics.print("[Z or ENTER] - Confirm", 170, 100)
    love.graphics.print("[X or SHIFT] - Cancel", 170, 120+16)
    love.graphics.print("[C or CTRL] - Menu (In-game)", 170, 160+12)
    love.graphics.print("[F4] - Fullscreen", 170, 200+8)
    love.graphics.print("[Hold ESC] - Quit", 170, 240+4)
    love.graphics.print("When HP is 0, you lose.", 170, 280)

    if self.selected == 1 then
        love.graphics.setColor(1,1,0)
    else
        love.graphics.setColor(1,1,1)
    end
    love.graphics.print("Begin Game", 170, 350-6)
    if self.selected == 2 then
        love.graphics.setColor(1,1,0)
    else
        love.graphics.setColor(1,1,1)
    end
    love.graphics.print("Settings", 170, 390-6)

    love.graphics.setColor(128/255,128/255,128/255)
    love.graphics.setFont(self.font2)
    love.graphics.printf("UNDERTALE V1.08 (C) TOBY FOX 2015-2017", 0, 464, SCREEN_WIDTH, "center")
end

function NewFile:update()
    super.update(self)

    if Input.pressed("down") then
        self.selected = 2
    end
    if Input.pressed("up") then
        self.selected = 1
    end
    if Input.pressed("confirm") then
        if self.selected == 1 then
            local namingScreen = NamingScreen()
            namingScreen.layer = WORLD_LAYERS["ui"]
            if self.second then
                namingScreen.selected_row = 9
            end
            Game.stage:addChild(namingScreen)
            self:remove()
        else
            local optionsmenu = OptionsMenu(0,0,true)
            optionsmenu.layer = WORLD_LAYERS["ui"]
            Game.stage:addChild(optionsmenu)
            self:remove()
        end
    end
end

return NewFile