data:extend({
    {
        type = "bool-setting",
        name = "noRocks_removeRocks",
        setting_type = "startup",
        default_value = true,
        order = "a"
    },
    {
        type = "bool-setting",
        name = "noRocks_removeTrees",
        setting_type = "startup",
        default_value = true,
        order = "b",
    },

    {
        type = "bool-setting",
        name = "noRocks_giveWood",
        setting_type = "startup",
        default_value = true,
        order = "c",
    },
    {
        type = "int-setting",
        name = "noRocks_giveWoodAmount",
        default_value = 100,
        minimum_value = 0,
        maximum_value = 5000,
        setting_type = "startup",
        order = "d",
    },
    {
        type = "bool-setting",
        name = "noRocks_layConcrete",
        setting_type = "startup",
        default_value = false,
        order = "e",
    },
})