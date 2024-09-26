--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
    Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]
DarkRP.createEntity("Printer", { 
    ent = "tierp_printer", 
    category = "Money Printing",
    model = "models/freeman/money_printer.mdl", 
    price = 10000, 
    max = 2, 
    cmd = "buytierprinter" 
}) 

DarkRP.createEntity("Printer Battery", { 
    ent = "tierp_battery", 
    category = "Money Printing",
    model = "models/freeman/giant_battery.mdl", 
    price = 500, 
    max = 2, 
    cmd = "buytierbattery" 
}) 

DarkRP.createEntity(".338 Lapua", { 
    ent = "cw_ammo_338lapua", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 1000, 
    max = 1, 
    cmd = "buy338lapuaammo" 
})

DarkRP.createEntity(".357 Magnum", { 
    ent = "cw_ammo_357magnum", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 500, 
    max = 1, 
    cmd = "buy357ammo" 
})

DarkRP.createEntity(".44 Magnum", { 
    ent = "cw_ammo_44magnum", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 700, 
    max = 1, 
    cmd = "buy44magnumammo" 
})

DarkRP.createEntity(".45 ACP", { 
    ent = "cw_ammo_45acp", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 500, 
    max = 1, 
    cmd = "buy45acpammo" 
})

DarkRP.createEntity(".50 AE", { 
    ent = "cw_ammo_50ae", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 500, 
    max = 1, 
    cmd = "buy50aeammo" 
})

DarkRP.createEntity("12 Gauge", { 
    ent = "cw_ammo_12gauge", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 400, 
    max = 1, 
    cmd = "buy12gaugeammo" 
})

DarkRP.createEntity("5.45x39MM", { 
    ent = "cw_ammo_545x39", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 600, 
    max = 1, 
    cmd = "buy545x39ammo" 
})

DarkRP.createEntity("5.56x45MM", { 
    ent = "cw_ammo_556x45", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 600, 
    max = 1, 
    cmd = "buy556x45ammo" 
})

DarkRP.createEntity("7.62x51MM", { 
    ent = "cw_ammo_762x51", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 600, 
    max = 1, 
    cmd = "buy762x51ammo" 
})

DarkRP.createEntity("9x17MM", { 
    ent = "cw_ammo_9x17", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 600, 
    max = 1, 
    cmd = "buy9x17ammo" 
})

DarkRP.createEntity("9x19MM", { 
    ent = "cw_ammo_9x19", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 600, 
    max = 1, 
    cmd = "buy9x19ammo" 
})

DarkRP.createEntity("9x39MM", { 
    ent = "cw_ammo_9x39", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 600, 
    max = 1, 
    cmd = "buy9x39ammo" 
})

DarkRP.createEntity("5.7x28MM", { 
    ent = "cw_ammo_fn57x28", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 600, 
    max = 1, 
    cmd = "buyfn57x28ammo" 
})

DarkRP.createEntity("Small Universal Ammo Kit", { 
    ent = "cw_ammo_kit_small", 
    category = "Ammo",
    model = "models/Items/BoxSRounds.mdl",
    price = 3000, 
    max = 1, 
    cmd = "buysmallammokit" 
})

DarkRP.createEntity("40mm Grenade", { 
    ent = "cw_ammo_40mm", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 10000, 
    max = 1, 
    cmd = "buy40mmammo" 
})

----VIP----

DarkRP.createEntity("[VIP] Regular Universal Ammo Kit", { 
    ent = "cw_ammo_kit_regular", 
    category = "Ammo",
    model = "models/Items/BoxMRounds.mdl",
    price = 5000, 
    max = 1, 
    cmd = "buyammokit",
        customCheck = function(ply) 
        return table.HasValue({"vip", "admin", "superadmin", "owner"}, ply:GetUserGroup()) 
    end,
    CustomCheckFailMsg = "This ammo is VIP only, sorry!",
})

DarkRP.createEntity("Rockets", {
    ent = "m9k_ammo_rockets",
    cmd = "rocketammo",
    model = "models/items/ammocrates/craterockets.mdl",
    price = 25000,
    max = 1,
    allowed = {
        TEAM_BMD
    },
    category = "Ammo",
})

DarkRP.createEntity("Grenade Launcher Ammo", {
    ent = "m9k_ammo_40mm",
    cmd = "glammo",
    model = "models/items/ammocrates/crate40mm.mdl",
    price = 17500,
    max = 1,
    allowed = {
        TEAM_BMD
    },
    category = "Ammo",
})