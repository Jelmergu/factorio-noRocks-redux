
script.on_event(defines.events.on_chunk_generated, function(e)
     -- remove everything we don't want
     for key, entity in pairs(e.surface.find_entities(e.area)) do
        local doIt = false

        if entity.type == "decorative" or
           entity.type == "tree" or
           entity.name == "stone-rock" or
           entity.name == "red-desert-rock-huge-01" or
           entity.name == "red-desert-rock-huge-02" or
           entity.name == "red-desert-rock-big-01"
        then
            entity.destroy()
        end
     end
end)

script.on_event(defines.events.on_player_created, function(event)

    local player = game.players[event.player_index]
    --filters
    local inventory = player.get_inventory(defines.inventory.player_quickbar)
    player.insert{name="raw-wood", count = 200}
end)
