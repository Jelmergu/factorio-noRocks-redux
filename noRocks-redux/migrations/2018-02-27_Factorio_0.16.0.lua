for _, v in pairs(game.surfaces) do
    for c in v.get_chunks() do
        -- remove everything we don't want
        for _, entity in pairs(v.find_entities(c)) do
            if entity.type == "decorative" or
                (entity.type == "tree" and settings.startup["noRocks_removeTrees"].value == true) or
                (settings.startup["noRocks_removeRocks"].value == true and entity.prototype.count_as_rock_for_filtered_deconstruction) then
                entity.destroy()
            end
        end
        if settings.startup["noRocks_layConcrete"].value == true then
            local pos = c
            local tiles = {}
            for y = 0, 32 do
                for x = 0, 32 do
                    pos2 = { x = pos.x + x, y = pos.y + y }
                    local tile = v.get_tile(pos2.x, pos2.y)
                    if tile.name ~= "water" and tile.name ~= "deepwater" then
                        table.insert(tiles, { position = pos2, name = "concrete" })
                    end
                end
            end
            v.set_tiles(tiles)
        end
    end
end