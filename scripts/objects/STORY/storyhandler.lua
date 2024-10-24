local StoryHandler, super = Class(Object, "StoryHandler")

function StoryHandler:init()
    super:init(self)

    self.parallax_x = 0
    self.parallax_y = 0

    self.layers = {
        ["panel"]   = 5,
        ["cover"]   = 15,
        ["fade" ]   = 20,
        ["text" ]   = 25
    }

    self.cover = self:addChild(Sprite("intro/cover"))
    self.cover.layer = self.layers["cover"]

    self.cover:setOrigin(0, 0)
    self.cover:setScale(1)

    self.cover.visible = true

    self.panel = self:addChild(Sprite())
    self.panel.layer = self.layers["panel"]

    self.panel:setOrigin(0, 0)
    self.panel:setScale(2)

    self.fade = self:addChild(Rectangle(0, 0, 640, 480))
    self.fade:setColor(0, 0, 0)
    self.fade.layer = self.layers["fade"]
    self.fade.alpha = 0

    self.fade:setOrigin(0, 0)

    self.music = Music("story", 1, 0.91)
    self.music.source:setLooping(false)

    self.timer = Timer()
    self:addChild(self.timer)
    
    self.can_click = true

    self.y_timer = 0

    self.slide = 0

    self.y_offset = 0

    self.panel_alpha = 0

    self.done = false
end

function StoryHandler:fadePanel(img)
    Game.stage.timer:script(function(wait)
        Game.stage.timer:tween(0.5, self.fade, {alpha = 1})
        wait(0.5)
        self.panel:set(img)
        Game.stage.timer:tween(0.5, self.fade, {alpha = 0})
    end)
end

function StoryHandler:onAddToStage(stage)
    self.music:play()

    self.cutscene = StoryCutscene((function(cutscene) self:handleCutscene(cutscene) end), self.can_skip, self)
end

function StoryHandler:update()
    if self.cutscene then
        if not self.cutscene.ended then
            self.cutscene:update()
            if self.stage == nil then
                return
            end
        else
            self.cutscene = nil
        end
    end

    if self.slide == 1 then
        --self.panel.y = (28 + self.y_offset) * 2
        self.panel.y = (-211 - self.y_offset) * 2
        self.y_timer = self.y_timer + DTMULT

        if (self.y_timer >= 4) and (self.panel.y < 34) then
            self.y_timer = self.y_timer - 4
            self.y_offset = self.y_offset - 2

            if self.panel.y > 34 then
                self.panel.y = 34
            end
        end
    end

    if not Kristal.DebugSystem:isMenuOpen() then
        if self.can_click == true then
            if Input.pressed("confirm", false) then
                Input.clear("confirm")
                self.can_click = false
                if self.cutscene then self.cutscene:removeText() end    
                self.music:fade(0, 0.75)
                Game.world.fader:fadeOut(nil, {speed = 0.75, color = COLORS.black})
                Game.world.timer:after(0.75+0.25, function()
                    self.done = true
                    Game.utt = UndertaleTitle()
                    Game.world:addChild(Game.utt)
                    Game.utt.layer = WORLD_LAYERS["top"]
                    self:remove()
                end)
            end
        end
    end

    super:update(self)
end

function StoryHandler:draw()
    love.graphics.setColor(COLORS.black)
    love.graphics.rectangle("fill", 0, 0, 640, 480)
    super:draw(self)
end

function StoryHandler:isOver()
    return self.done
end

function StoryHandler:setPanelPos(type)
    local x, y = 0, 0
    if type == "small" then
        x, y = 60 * 2, 28 * 2
    elseif type == "top_left" then
        x, y = 0, 0
    end
    self.panel.x = x
    self.panel.y = y
end

function StoryHandler:handleCutscene(cutscene)
    self.panel:set("intro/image_1")
    cutscene:wait(6/30)
    cutscene:setSpeed(0.5)
    local text1 = cutscene:text("Long ago,[wait:5] two races\nruled over Earth:[wait:5]\nHUMANS and MONSTERS.", "far_left")
    --local text1 = cutscene:text("Long ago,[wait:5] two races\nruled.", "far_left")
    cutscene:wait(function() return not text1:isTyping() end)
    cutscene:wait(1.5)
    self:fadePanel("intro/image_2")
    cutscene:wait(0.6)
    cutscene:removeText()
    local text2 = cutscene:text("One day,[wait:5] war broke\nout between the two\nraces.", "far_left")
    cutscene:wait(function() return not text2:isTyping() end)
    cutscene:wait(1.75)
    self:fadePanel("intro/image_3")
    cutscene:wait(0.6)
    cutscene:removeText()
    local text2 = cutscene:text("After a long battle,[wait:5]\nthe humans were\nvictorious.", "far_left")
    cutscene:wait(function() return not text2:isTyping() end)
    cutscene:wait(1.75)
    self:fadePanel("intro/image_4")
    cutscene:wait(0.6)
    cutscene:removeText()
    local text2 = cutscene:text("They sealed the monsters\nunderground with a magic\nspell.", "far_left")
    cutscene:wait(function() return not text2:isTyping() end)
    cutscene:wait(1.75)
    self:fadePanel("intro/image_5")
    cutscene:wait(0.6)
    cutscene:removeText()
    local text2 = cutscene:text("Many years later.[wait:20].[wait:20].", "far_left")
    cutscene:wait(function() return not text2:isTyping() end)
    cutscene:wait(1.75)
    self:fadePanel("intro/image_6")
    cutscene:wait(0.6)
    cutscene:removeText()
    local text2 = cutscene:text("MT. EBOTT[wait:5]\n   201X", "center")
    cutscene:wait(function() return not text2:isTyping() end)
    cutscene:wait(1.75)
    self:fadePanel("intro/image_7")
    cutscene:wait(0.6)
    cutscene:removeText()
    local text2 = cutscene:text("Legends say that those\nwho climb the mountain\nnever return.", "far_left")
    cutscene:wait(function() return not text2:isTyping() end)
    cutscene:wait(1.5)
    self:fadePanel("intro/image_8")
    cutscene:wait(0.6)
    cutscene:removeText()
    cutscene:wait(5.75)
    self:fadePanel("intro/image_9")
    cutscene:wait(0.6)
    cutscene:wait(5.75)
    self:fadePanel("intro/image_10")
    cutscene:wait(0.6)
    cutscene:wait(5.75)
    Game.stage.timer:tween(0.5, self.fade, { alpha = 1 })
    Game.stage.timer:tween(0.5, self.panel, { alpha = 0 })
    cutscene:wait(0.5)
    self.panel:set("intro/image_12")
    Game.stage.timer:tween(0.5, self.fade, { alpha = 0 })
    Game.stage.timer:tween(0.5, self.panel, { alpha = 1 })
    self.panel.y = (-211 - self.y_offset) * 2
    cutscene:wait(0.6)
    cutscene:wait(3)
    self.slide = 1
    cutscene:wait(20)
    self.music:fade(0, 50/30)
    Game.world.fader:fadeOut(nil, {speed = 50/30, color = COLORS.black})
    cutscene:wait((50/30)+0.25)
    self.done = true
    Game.utt = UndertaleTitle()
    Game.world:addChild(Game.utt)
    Game.utt.layer = WORLD_LAYERS["top"]
    self:remove()
end

return StoryHandler