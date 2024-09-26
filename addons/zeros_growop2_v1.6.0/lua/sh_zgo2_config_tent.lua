/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.config = zgo2.config or {}
zgo2.config.Tents = {}
zgo2.config.Tents_ListID = zgo2.config.Tents_ListID or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

local function AddTent(data)
	local PlantID = table.insert(zgo2.config.Tents,data)
	zgo2.config.Tents_ListID[data.uniqueid] = PlantID
	return PlantID
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

AddTent({
	uniqueid = "4624vcsvfhfgv",
	class = "zgo2_tent",
	name = zgo2.language[ "Tent - Small" ],
	mdl = "models/zerochain/props_growop2/zgo2_tent01.mdl",
	price = 1000,
	lamps = {
		{Vector(0,0,69),Angle(0,0,0)}
	},

	pots = {
		{Vector(0,0,1),Angle(0,-90,0)}
	},

	battery_bg = {
		[1] = 0
	}
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

AddTent({
	uniqueid = "4621zhfhss",
	class = "zgo2_tent",
	name = zgo2.language[ "Tent - Big" ],
	mdl = "models/zerochain/props_growop2/zgo2_tent02.mdl",
	price = 2500,

	lamps = {
		{Vector(30,0,69),Angle(0,0,0)},
		{Vector(-29,0,69),Angle(0,0,0)},
	},

	pots = {
		{Vector(30,0,1),Angle(0,-90,0)},
		{Vector(-30,0,1),Angle(0,-90,0)},
	},
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	battery_bg = {
		[1] = 1,
		[2] = 0,
	}
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b
