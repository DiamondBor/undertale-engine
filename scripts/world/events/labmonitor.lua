local LabMonitor, super = Class(Event, "labmonitor")

function LabMonitor:init(data)
	super.init(self, data.x, data.y, data.width, data.height)

    self.draw_callback = Callback{draw = function()
        if not self.manager then return end
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("fill", 0,0,120,80)
        love.graphics.setColor(1,1,1)
        if self.draw_type == "player" then
            love.graphics.draw(Mod.screenshot_canvas, -self.manager.player_x + 60, -self.manager.player_y + 80)
        end
    end}
    self.draw_callback.layer = -1
    self.draw_callback:addFX(ScissorFX(2, 2, 116, 76, -1))
    self:addChild(self.draw_callback)
    
end

return LabMonitor