modRequire("scripts/main/undertale_init")

function Mod:init()
    self:initUT()

    -- Disable Kristal-specific keybinds (For example, take a screenshot with F9, reloading, Debug Menu, Console, etc.
    -- You can always do this yourself by editing the source code but eh, here's an option that'll do it for you.
    -- Useful for mods you're going to release to the public and don't want people using those keybinds.)
    -- Set to 'true' to disable these keybinds.
    self.disable_kristal_keybinds = false
    
    self:loadHooks()
end

function Mod:postInit(new_file)
    self:postInitUT(new_file)
end

function Mod:load()
    self:loadUT()
end

function Mod:unload()
    self:unloadUT()
end

function Mod:loadHooks()
end

function Mod:preUpdate()
end

function Mod:postUpdate()
end