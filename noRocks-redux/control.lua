local function removeRocks(e)
    local entities = e.surface.find_entities_filtered({ area = e.area, type = 'simple-entity' })
    for _, entity in pairs(entities) do
        if entity.prototype.count_as_rock_for_filtered_deconstruction then
            entity.destroy()
        end
    end
end

local function removeEntitiesOfType(e, type)
    local entities = e.surface.find_entities_filtered({ area = e.area, type = type })
    local count = 0
    for _, entity in pairs(entities) do
        count = count + 1
        entity.destroy()
    end
end

local function layConcrete(e)
    local pos = e.area.left_top
    local tiles = {}
    for y = 0, 32 do
        for x = 0, 32 do
            pos2 = { x = pos.x + x, y = pos.y + y }
            local tile = e.surface.get_tile(pos2.x, pos2.y)
            if tile.name ~= "water" and tile.name ~= "deepwater" then
                table.insert(tiles, { position = pos2, name = "concrete" })
            end
        end
    end
    e.surface.set_tiles(tiles)
end


script.on_event(
        defines.events.on_chunk_generated,
        function(e)
            e.surface.destroy_decoratives(e.area)
            if settings.startup["noRocks_removeTrees"].value == true then removeEntitiesOfType(e, 'tree') end
            if settings.startup["noRocks_removeRocks"].value == true then removeRocks(e) end
            if settings.startup["noRocks_layConcrete"].value == true then layConcrete(e) end
        end
)

if settings.startup["noRocks_giveWood"].value == true then
    script.on_event(defines.events.on_player_created,
            function(event)
                local player = game.players[event.player_index]
                --filters
                local inventory = player.get_inventory(defines.inventory.player_main)
                player.insert { name = "wood", count = settings.startup["noRocks_giveWoodAmount"].value }
            end
    )
end