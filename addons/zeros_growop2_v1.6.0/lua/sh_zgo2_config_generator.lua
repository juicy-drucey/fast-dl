/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.config = zgo2.config or {}
zgo2.config.Generators = {}
zgo2.config.Generators_ListID = zgo2.config.Generators_ListID or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

local function AddGenerator(data)
	local PlantID = table.insert(zgo2.config.Generators,data)
	zgo2.config.Generators_ListID[data.uniqueid] = PlantID
	return PlantID
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

// Lets make a quick list of all the more advanced weed grower jobs
local NextLevelJobs = {}
table.Merge(NextLevelJobs,zgo2.config.Jobs.Pro)
table.Merge(NextLevelJobs,zgo2.config.Jobs.Basic)


AddGenerator({
	uniqueid = "4z24zhdafdasf",
	class = "zgo2_generator",
	name = zgo2.language[ "Generator - Small" ],
	mdl = "models/zerochain/props_growop2/zgo2_generator01.mdl",

	price = 2000,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	// How much fuel can it hold
	Capacity = 500,

	// How much energy does it produce per second
	PowerRate = 10,

	FuelConsumption = 1,

	UIPos = {
		vec = Vector(0, 16.1, 23.5),
		ang = Angle(0, 180, 90),
		scale = 0.05,
	},
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	jobs = NextLevelJobs,

	/*
	NOTE This can be used to add some custom check for the added shop item
	For a more generic way use the custom hook > zgo2.Shop.CanBuy
	canbuy = function(ply)
		return ply:Nick() == "Peter"
	end
	*/
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3


AddGenerator({
	uniqueid = "fkljfi4i4i33i",
	class = "zgo2_generator",
	name = zgo2.language[ "Generator - Large" ],
	mdl = "models/zerochain/props_growop2/zgo2_generator.mdl",
	price = 4000,
	Capacity = 1500,
	FuelConsumption = 2,
	PowerRate = 35,
	UIPos = {
		vec = Vector(0, 24.3, 33),
		ang = Angle(0, 180, 90),
		scale = 0.05,
	},
	jobs = zgo2.config.Jobs.Pro,
})
