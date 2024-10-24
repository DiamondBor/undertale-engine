BordersLib = {}
local lib = BordersLib

function lib:init()
    self.flower_positions = {
        {34, 679},
        {94, 939},
        {269, 489},
        {0, 319},
        {209, 34},
        {1734, 0},
        {1829, 359},
        {1789, 709},
        {1584, 1049}
    }
    self.idle_time = (RUNTIME * 1000)
    self.idle = false
end

function lib:preUpdate(dt)
end

function lib:postUpdate(dt)
    if Input.down("left") or Input.down("right") or Input.down("up") or Input.down("down") or Input.down("confirm") or Input.down("cancel") or Input.down("menu") then
        self.idle_time = 0
        self.idle = false
    else
        if not self.idle then
            self.idle_time = RUNTIME * 1000
        end
        self.idle = true
    end
end

function lib:onBorderDraw(border_sprite)
    if border_sprite == "undertale/sepia" then

        local idle_min = 300000
        local idle_time = 0
        local current_time = RUNTIME * 1000
        if (self.idle and current_time >= (self.idle_time + idle_min)) then
            idle_time = (current_time - (self.idle_time + idle_min))
        end

        local idle_frame = (math.floor((idle_time / 100)) % 3)

        if idle_frame > 0 then
            for index, pos in pairs(self.flower_positions) do
                local x, y = (pos[1] * BORDER_SCALE), (pos[2] * BORDER_SCALE) - 1
                local round = Utils.round
                love.graphics.setBlendMode("replace")
                local flower = Assets.getTexture("borders/undertale/sepia/" .. tostring(index) .. ((idle_frame == 1) and "a" or "b"))
                love.graphics.setColor(1, 1, 1, BORDER_ALPHA)
                love.graphics.draw(flower, round(x), round(y), 0, BORDER_SCALE, BORDER_SCALE)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setBlendMode("alpha")
            end
        end
    end
end

function lib:registerDebugOptions(debug)
    debug:registerOption("main", "Borders", "Enter the border editor menu.", function() debug:enterMenu("border_menu", 1) end)

    debug:registerMenu("border_menu", "Borders")

    local borders = {
        "undertale/anime",
        "undertale/casino",
        "undertale/castle",
        "undertale/dog",
        "undertale/fire",
        "undertale/rad",
        "undertale/ruins",
        "undertale/sepia",
        "undertale/truelab",
        "undertale/tundra",
        "undertale/water"
    }

    for _,border in ipairs(borders) do
        debug:registerOption("border_menu", border, "Switch to the border \"" .. border .. "\".", function() Game:setBorder(border) end)
    end
end


return lib