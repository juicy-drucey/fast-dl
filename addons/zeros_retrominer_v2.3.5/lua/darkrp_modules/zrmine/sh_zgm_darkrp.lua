/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

TEAM_ZRMINE_MINER = DarkRP.createJob("Retro Miner", {
	color = Color(0, 128, 255, 255),
	model = {
     "models/player/miner_m.mdl",
     "models/player/miner_f.mdl"
},
	description = [[
You mine ores and melt them into metal bars.
    
Roleplay guidelines:
- Can not raid or mug
- Do not steal other players mining equipment or entities
- Do not block off ores
- Your mines must remain on the ore entity during use at all times. You are not to have 'sky mines' setup. You can use conveyors to move your product around, but the processing equipment must remain on the ground.
]],
	weapons = {"zrms_pickaxe","zrms_builder"},
	command = "zrmine_retrominer01",
	max = 4,
	salary = 15,
	admin = 0,
	vote = false,
	category = "Citizens",
	hasLicense = false
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

DarkRP.createCategory{
	name = "RetroMiner",
	categorises = "entities",
	startExpanded = true,
	color = Color(255, 107, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 104
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6

DarkRP.createEntity("Gravel - Crate", {
	ent = "zrms_gravelcrate",
	model = "models/zerochain/props_mining/zrms_refiner_basket.mdl",
	price = 250,
	max = 6,
	cmd = "buyzrms_gravelcrate",
	allowed = TEAM_ZRMINE_MINER,
	category = "RetroMiner"
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

DarkRP.createEntity("Refiner - Crate", {
	ent = "zrms_basket",
	model = "models/zerochain/props_mining/zrms_refiner_basket.mdl",
	price = 250,
	max = 12,
	cmd = "buyzrms_basket",
	allowed = TEAM_ZRMINE_MINER,
	category = "RetroMiner"
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

DarkRP.createEntity("Storagecrate", {
	ent = "zrms_storagecrate",
	model = "models/zerochain/props_mining/zrms_storagecrate.mdl",
	price = 25,
	max = 6,
	cmd = "buyzrms_storagecrate",
	allowed = TEAM_ZRMINE_MINER,
	category = "RetroMiner"
})

DarkRP.createEntity("Mine Entrance", {
	ent = "zrms_mineentrance_base",
	model = "models/zerochain/props_mining/mining_entrance.mdl",
	price = 150000,
	max = 3,
	cmd = "buyzrms_mineentrance_base",
	allowed = TEAM_ZRMINE_MINER,
	category = "RetroMiner"
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

DarkRP.createEntity("Melter", {
	ent = "zrms_melter",
	model = "models/zerochain/props_mining/zrms_melter.mdl",
	price = 7500,
	max = 2,
	cmd = "buyzrms_melter",
	allowed = TEAM_ZRMINE_MINER,
	category = "RetroMiner"
})
