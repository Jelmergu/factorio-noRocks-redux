
script.on_event(defines.events.on_chunk_generated, function(e)

     -- remove everything we don't want
    for key, entity in pairs(e.surface.find_entities(e.area)) do
        if (settings.global["noRocks_removeTrees"].value == false and entity.type == "decorative") or
            (entity.type == "tree" and settings.global["noRocks_removeTrees"].value == false) or
            (settings.global["noRocks_removeTrees"].value == false and
               (entity.name == "stone-rock" or
               entity.name == "red-desert-rock-huge-01" or
               entity.name == "red-desert-rock-huge-02" or
               entity.name == "red-desert-rock-big-01")
            )
        then
            entity.destroy()
        end
     end

    if settings.global["noRocks_layConcrete"].value == true then

        local pos = e.area.left_top
        local tiles = {}

        for y = 0,32 do

            for x = 0,32 do

                pos2 = {x=pos.x + x, y = pos.y+y}
                local tile = e.surface.get_tile(pos2.x, pos2.y)

                if tile.name ~= "water" and tile.name ~= "deepwater" then
                    table.insert(tiles, {position=pos2, name= "concrete"})
                end
            end

        end

        e.surface.set_tiles(tiles)

    end

end)

if settings.global["noRocks_giveWood"].value == true then

    script.on_event(defines.events.on_player_created, function(event)
        local player = game.players[event.player_index]
            --filters
        local inventory = player.get_inventory(defines.inventory.player_quickbar)
        player.insert{name="raw-wood", count = settings.global["noRocks_giveWoodAmount"].value}
    end)
end