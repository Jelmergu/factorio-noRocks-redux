local entityNamesToRemove = {
    "sand-rock-big",
    "sand-rock-medium",
    "sand-rock-smal",
    "rock-big",
    "rock-huge",
    "rock-medium"
}


--(
--entity.name == "sand-rock-big" or
--        entity.name == "sand-rock-medium" or
--        entity.name == "sand-rock-smal" or
--        entity.name == "rock-big" or
--        entity.name == "rock-huge" or
--        entity.name == "rock-medium")

function in_table(table, item)
    for _,v in pairs(table) do
--        game.print("in_table function checking: " ..item.." == "..v)
        if v == item then
--            game.print(item.." present in table")
            return true
        end
    end
--    game.print(item.." not present in table")
    return false
end

script.on_event(defines.events.on_chunk_generated, function(e)

     -- remove everything we don't want
    for key, entity in pairs(e.surface.find_entities(e.area)) do
        if  entity.type == "decorative" or
            (entity.type == "tree" and settings.startup["noRocks_removeTrees"].value == true) or
            (settings.startup["noRocks_removeRocks"].value == true and in_table(entityNamesToRemove, entity.name) == true)
        then
            entity.destroy()
        end
     end

    if settings.startup["noRocks_layConcrete"].value == true then

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

if settings.startup["noRocks_giveWood"].value == true then

    script.on_event(defines.events.on_player_created, function(event)
        local player = game.players[event.player_index]
            --filters
        local inventory = player.get_inventory(defines.inventory.player_quickbar)
        player.insert{name="raw-wood", count = settings.startup["noRocks_giveWoodAmount"].value}
    end)
end