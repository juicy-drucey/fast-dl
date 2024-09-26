/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

zrush = zrush or {}
zrush.FuelTypes = {}
local function AddFuel(data) return table.insert(zrush.FuelTypes, data) end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

// Fuel Settings
///////////////////////
// Fuel Registration
/*
	Values for this are
	Name			   : The Name of the Fuel
	FuelColor		   : The Color of the Fuel
	VCmodfuel (0||1)   : What VC Mod fuel is it (Petrol or Diesel) (Only usefull if you have VCMod installed!)
	RefineOutput	   : How much Fuel do we get from the refined Oil (0.5 = 50%)
	BasePrice		   : The Start Sell Price of the Fuel per Unit (Liter,etc..)
	Ranks			   : The Ranks which are allowed do refine this Fuel
	Jobs			   : The Jobs which are allowed to refine this Fuel
*/


local vip_ranks = {
	["VIP"] = true,
	["superadmin"] = true
}

AddFuel({
	name = "Regular Petrol",
	color = Color(211,190,255),
	vcmodfuel = 0,
	refineoutput = 0.55,
	price = 15,
	ranks = {},
	/*
	jobs = {
		["Fuel Refiner"] = true,
		["Gangster"] = true,
	}
	*/
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354

AddFuel({
	name = "Premium Petrol",
	color = Color(255,236,110),
	vcmodfuel = 0,
	refineoutput = 0.25,
	price = 125,
	ranks = {},
	jobs = {}
})

AddFuel({
	name = "Premium Ultra Petrol",
	color = Color(211,255,149),
	vcmodfuel = 0,
	refineoutput = 0.1,
	price = 2400,
	ranks = vip_ranks,
	jobs = {}
})

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821


AddFuel({
	name = "Regular Diesel",
	color = Color(255,227,190),
	vcmodfuel = 1,
	refineoutput = 0.55,
	price = 20,
	ranks = {},
	jobs = {}
})

AddFuel({
	name = "Premium Diesel",
	color = Color(248,154,53),
	vcmodfuel = 1,
	refineoutput = 0.25,
	price = 150,
	ranks = {},
	jobs = {}
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2

AddFuel({
	name = "Premium Ultra Diesel",
	color = Color(255,68,31),
	vcmodfuel = 1,
	refineoutput = 0.1,
	price = 2500,
	ranks = vip_ranks,
	jobs = {}
})
///////////////////////
