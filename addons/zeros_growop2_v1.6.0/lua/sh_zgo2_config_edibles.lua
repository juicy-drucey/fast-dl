/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.config = zgo2.config or {}

zgo2.config.Edibles = {}
zgo2.config.Edibles_ListID = zgo2.config.Edibles_ListID or {}

local function AddEdible(data)
	local PlantID = table.insert(zgo2.config.Edibles,data)
	zgo2.config.Edibles_ListID[data.uniqueid] = PlantID
	zclib.CacheModel(data.edible_model)
	return PlantID
end

AddEdible({
	uniqueid = "fjh48shs38def",
	name = "Muffin",
	backmix_model = "models/zerochain/props_growop2/zgo2_backmix_muffin.mdl",
	edible_model = "models/zerochain/props_growop2/zgo2_food_muffin.mdl",

	// How much health does the player gets when eaten
	health = 5,

	// How much health can he gets at max when eating this?
	healthcap = 100,

	// How much does the backmix cost
	backmix_price = 100,

	// How much weed will be needed?
    // NOTE This defines both the requiered weed amount and effect duration
	weed_capacity = 30,

    // How long does the dough need to be mixed
    mix_duration = 30,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

    // How long does the dough need to be baked
    bake_duration = 30,
})

AddEdible({
	uniqueid = "ckjf291111df",
	name = "Brownie",
	backmix_model = "models/zerochain/props_growop2/zgo2_backmix_brownie.mdl",
	edible_model = "models/zerochain/props_growop2/zgo2_food_brownie.mdl",
	health = 10,
	healthcap = 100,
	backmix_price = 100,
	weed_capacity = 60,
    mix_duration = 25,
    bake_duration = 15,
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

AddEdible({
	uniqueid = "1231jf255111df",
	name = "Patty",
	backmix_model = "models/zerochain/props_growop2/zgo2_backmix_patty.mdl",
	edible_model = "models/zerochain/props_growop2/zgo2_food_burger.mdl",
	health = 10,
	healthcap = 100,
	backmix_price = 100,
	weed_capacity = 35,
    mix_duration = 25,
    bake_duration = 35,
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

AddEdible({
	uniqueid = "ufvg56453",
	name = "Cookie",
	backmix_model = "models/zerochain/props_growop2/zgo2_backmix_cookie.mdl",
	edible_model = "models/zerochain/props_growop2/zgo2_food_cookie.mdl",
	health = 10,
	healthcap = 100,
	backmix_price = 100,
	weed_capacity = 5,
    mix_duration = 25,
    bake_duration = 10,
})

AddEdible({
	uniqueid = "gmeg2353efr",
	name = "Cinnamon Roll",
	backmix_model = "models/zerochain/props_growop2/zgo2_backmix_cinnamon.mdl",
	edible_model = "models/zerochain/props_growop2/zgo2_food_roll.mdl",
	health = 10,
	healthcap = 100,
	backmix_price = 100,
	weed_capacity = 15,
    mix_duration = 25,
    bake_duration = 45,
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

AddEdible({
	uniqueid = "fkfk32023",
	name = "Donut",
	backmix_model = "models/zerochain/props_growop2/zgo2_backmix_donut.mdl",
	edible_model = "models/zerochain/props_growop2/zgo2_food_donut.mdl",
	health = 10,
	healthcap = 100,
	backmix_price = 100,
	weed_capacity = 25,
    mix_duration = 35,
    bake_duration = 45,
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
