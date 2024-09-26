/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

zrush = zrush or {}
zrush.Holes = {}
local function AddOilSource(data) return table.insert(zrush.Holes, data) end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22

// Oil Hole Settings
///////////////////////
// OilSource Registration
/*
	Values for this are
	Chance (1-100)	     : The Chance of getting this Hole
	Depth			     : How many pipes it will need
	Burnchance (1-100)   : how high the chance is that it needs to be burned after hitting the oil
    oil_amount			 : how much oil is in the Hole
	gas_amount           : how much gas is in the Hole
	chaos_chance         : The Chance of the Machine do have a OverHeat/Jam -Event when working on this OilSource (This gets added do the Base OverHeat/Jam -Chance of the machine)
*/
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2


AddOilSource({
    chance = 50,
    depth = 25,
    burnchance = 50,
    oil_amount = math.Round(math.random(300, 1000)),
    gas_amount = math.Round(math.random(100, 500)),
    chaos_chance = 5
})

AddOilSource({
    chance = 30,
    depth = 40,
    burnchance = 50,
    oil_amount = math.Round(math.random(600, 2000)),
    gas_amount = math.Round(math.random(500, 800)),
    chaos_chance = 10
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354

AddOilSource({
    chance = 20,
    depth = 45,
    burnchance = 75,
    oil_amount = math.Round(math.random(1500, 4000)),
    gas_amount = math.Round(math.random(500, 1000)),
    chaos_chance = 20
})
///////////////////////
