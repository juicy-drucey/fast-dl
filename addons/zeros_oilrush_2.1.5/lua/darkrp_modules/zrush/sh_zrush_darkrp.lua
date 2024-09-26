/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

TEAM_ZRUSH_FUELPRODUCER = DarkRP.createJob("Fuel Refiner", {
    color = Color(225, 75, 75, 255),
    model = {
        "models/worker2/construction_worker_2_11.mdl", 
		"models/worker2/construction_worker_2_10.mdl", 
		"models/worker2/construction_worker_2_09.mdl", 
		"models/worker2/construction_worker_2_08.mdl", 
		"models/worker2/construction_worker_2_07.mdl", 
		"models/worker2/construction_worker_2_06.mdl", 
		"models/worker2/construction_worker_2_05.mdl", 
		"models/worker2/construction_worker_2_04.mdl", 
		"models/worker2/construction_worker_2_03.mdl", 
		"models/worker2/construction_worker_2_02.mdl", 
		"models/worker2/construction_worker_2_01.mdl"
},
    description = [[
You are making Fuel!
        
Roleplay Guidelines:
- Do not block off oil spots.
- Do not steal other people's equipment or barrels
]],
    weapons = {},
    command = "zrush_fuelrefiner",
    max = 4,
    salary = 15,
    admin = 0,
    vote = false,
    category = "Citizens",
    hasLicense = false
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

DarkRP.createCategory{
    name = "FuelRefiner",
    categorises = "entities",
    startExpanded = true,
    color = Color(255, 107, 0, 255),
    canSee = function(ply) return true end,
    sortOrder = 104
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

DarkRP.createEntity("BuildKit", {
    ent = "zrush_machinecrate",
    model = "models/zerochain/props_oilrush/zor_machinecrate.mdl",
    price = 250,
    max = 8,
    cmd = "buyzrushmachinecrate",
    allowed = TEAM_ZRUSH_FUELPRODUCER,
    category = "FuelRefiner"
})

DarkRP.createEntity("Barrel", {
    ent = "zrush_barrel",
    model = "models/zerochain/props_oilrush/zor_barrel.mdl",
    price = 100,
    max = 10,
    cmd = "buyzrushbarrel",
    allowed = TEAM_ZRUSH_FUELPRODUCER,
    category = "FuelRefiner"
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

DarkRP.createEntity("10x Pipes", {
    ent = "zrush_drillpipe_holder",
    model = "models/zerochain/props_oilrush/zor_drillpipe_holder.mdl",
    price = 100,
    max = 10,
    cmd = "buyzrushdrillpipeholder",
    allowed = TEAM_ZRUSH_FUELPRODUCER,
    category = "FuelRefiner"
})

DarkRP.createEntity("Palette", {
    ent = "zrush_palette",
    model = "models/props_junk/wood_pallet001a.mdl",
    price = 100,
    max = 2,
    cmd = "buyzrush_palette",
    allowed = TEAM_ZRUSH_FUELPRODUCER,
    category = "FuelRefiner"
})
