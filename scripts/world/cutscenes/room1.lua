return {
    wall = function(cutscene, event)
        -- Open textbox and wait for completion
        cutscene:text("* The wall seems off.")
        -- Ask what the player wishes to do with the wall
        local choice = cutscene:textChoicer("* Punch it for no apparent\nreason?", {"No", "     Yes"})
        if choice == 1 then
            cutscene:text("* Let's not.")
        else
            cutscene:text("* You punched the wall.")

            -- Damage the player
            Assets.playSound("hurt")
            Game.party[1].lw_health = Game.party[1].lw_health - 5

            -- owie
            cutscene:text("* Ouch.")
            cutscene:text("* Congratulations,[wait:5] you have successfully started the inanimate object genocide route.")

            Game:setFlag("wall_hit", true)
        end
    end,

    sans = function(cutscene, event)
        -- Get the current playback position of the music
        local sourcepos = Game.world.music:tell()

        -- Change the music
        Game.world.music:play("sans")

        -- Begin character text
        cutscene:text("[font:sans]* sup,[wait:5] kid?", "neutral", "sans")

        -- Show two choices
        local choice = cutscene:textChoicer("* so,[wait:5] weather.[wait:10]\n* nice topic,[wait:5] huh?", {" yes", "         no"}, "look_left", "sans", {font = "sans"})
        if choice == 1 then
            cutscene:text("[font:sans]* wow,[wait:5] you're,[wait:5] uh...[wait:10]\n* pretty enthusiastic\nabout it.", "neutral", "sans")
            cutscene:text("[font:sans]* i mean,[wait:5] doesn't it get\nboring after seeing it\nevery day of your life?", "joking", "sans")
            cutscene:text("[font:sans]* ...", "joking", "sans")
            cutscene:text("[font:sans]* oh,[wait:5] right,[wait:5] we don't\nhave that in the ruins.", "neutral", "sans")
        else
            -- If you haven't interacted with Sans yet, do spoooooky sans stuff.
            if event.used_once then
                cutscene:text("[font:sans]* so,[wait:5] you're one\nof them.", "eyes_closed", "sans")
            else
                Game.world.music:stop()
                for i,v in pairs(Game.world.children) do
                    v:addFX(ColorMaskFX({0,0,0}), "dark_overlay")
                end
                cutscene:getCharacter(Game.party[1].id):removeFX("dark_overlay")
                cutscene:getCharacter("sans"):removeFX("dark_overlay")
                cutscene:wait(3)
                cutscene:text("[noskip][font:sans]*[spacing:5] so,[wait:20] you're one\nof them.", "eyes_closed", "sans")
                cutscene:wait(0.04)
                cutscene:text("[noskip][font:sans][speed:0.1]*[spacing:30] ...", "eyes_closed", "sans")
                cutscene:text("[noskip][font:sans][voice:none]           [next]", "serious", "sans")
                for i,v in pairs(Game.world.children) do
                    v:removeFX("dark_overlay")
                end
                Game.world.music:play("sans")
            end
            cutscene:text("[font:sans]* one of those people who prefer how it is around here in the ruins.", "joking", "sans")
            cutscene:text("[font:sans]* dark,[wait:5] hot,[wait:5] and dark.[wait:10]\n* did i mention hot?", "wink", "sans")
            cutscene:text("[font:sans]* don't sweat it,[wait:5] kid.", "neutral", "sans")
            cutscene:text("[font:sans]* snowdin is bright,[wait:5] cold,[wait:5] bright...[wait:10]\n* did i mention cold?", "wink", "sans")
            cutscene:text("[font:sans]* change is nice sometimes.[wait:10]\n* i like it.", "neutral", "sans")
        end

        -- Set a variable to true
        event.used_once = true

        -- Play the previous song at the same position it originally was
        Game.world.music:play("ruins")
        Game.world.music:seek(sourcepos)
    end,

    toriel = function(cutscene)
        cutscene:text("* I am [color:blue]TORIEL[color:reset],\n  caretaker of the\n  [color:red]RUINS[color:reset].", "neutral", "toriel")
        cutscene:text("* Howdy![wait:10]\n* I'm [color:yellow]TORIEL[color:reset].[wait:10]\n* [color:yellow]TORIEL[color:reset] the [color:yellow]TORIEL[color:reset]!", "neutral", "toriel")
        cutscene:text("[font:sans]* i'm toriel.[wait:10]\n* toriel the toriel.", "neutral", "toriel")
        cutscene:text("[font:papyrus]I,[wait:5] THE GREAT\nTORIEL,[wait:5] WILL\nSTOP YOU!!!", "neutral", "toriel")
        cutscene:text("[shake:1][speed:0.25]* I,[wait:5] TORIEL,[wait:5] will\n  strike you down!", "neutral", "toriel")
        cutscene:text("* I'm Dr. Toriel.[wait:10]\n* I'm THE RUINS's royal\n  caretaker!", "neutral", "toriel")
        cutscene:text("[wave:1][voice:ut]...")
        cutscene:text("[wave:1][voice:ut]i ran out of introduction\ndialogs")
    end
}
