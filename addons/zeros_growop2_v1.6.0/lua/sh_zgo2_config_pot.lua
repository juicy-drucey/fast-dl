/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.config = zgo2.config or {}
zgo2.config.Pots = {}
zgo2.config.Pots_ListID = zgo2.config.Pots_ListID or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

local function AddPot(data)

	// Convert the Job commands to job ids
	data = zgo2.util.ConvertJobCommandToJobID(data)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	local PlantID = table.insert(zgo2.config.Pots,data)

	zgo2.config.Pots_ListID[data.uniqueid] = PlantID
	return PlantID
end

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	This pot config can be edited using the ingame editor
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

*/
AddPot({
	scale = 0.8,
	jobs = {},
	uniqueid = "fsk48ffsf588",
	style = {
		blendmode = 0,
		scale = 1,
		phongtint = Color(255, 255, 255, 255),
		color = Color(200, 158, 124, 255),
		phongexponent = 15,
		pos_y = 0,
		fresnel = 1,
		url = "",
		img_color = Color(255, 255, 255, 255),
		pos_x = 0,
		phongboost = 0.5,
	},
	ranks = {},
	boost_time = 1,
	boost_amount = 1,
	water_capacity = 500,
	type = 4,
	class = "zgo2_pot",
	name = "Basic Pot",
	price = 500,
})

AddPot({
	boost_amount = 1,
	boost_time = 1,
	[ "hose" ] = true,
	uniqueid = "7697hvhvbvhg",
	style = {
		blendmode = 0,
		scale = 1.16,
		phongtint = Color(89, 89, 89, 255),
		color = Color(103, 103, 103, 255),
		phongexponent = 2,
		pos_y = 0,
		fresnel = 0.01,
		url = "",
		img_color = Color(255, 255, 255, 255),
		pos_x = 0,
		phongboost = 5,
	},
	ranks = {},
	jobs = {
		[ "zgo2_pro" ] = true,
		[ "zgo2_basic" ] = true,
	},
	class = "zgo2_pot",
	scale = 1,
	type = 1,
	water_capacity = 200,
	name = "Auto Pot",
	price = 1500,
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

AddPot({
	scale = 1.25,
	water_capacity = 1000,
	uniqueid = "fd9e90ba2a",
	style = {
		blendmode = 0,
		scale = 1,
		phongtint = Color(255, 255, 255, 255),
		color = Color(110, 159, 200, 255),
		phongexponent = 15,
		pos_y = 0,
		fresnel = 1,
		url = "",
		img_color = Color(255, 255, 255, 255),
		pos_x = 0,
		phongboost = 0.5,
	},
	ranks = {},
	boost_time = 1,
	jobs = {},
	price = 2000,
	type = 2,
	class = "zgo2_pot",
	name = "Jumbo Pot",
	boost_amount = 2,
})

AddPot({
	price = 300,
	boost_time = 1,
	uniqueid = "dbab8a6f17",
	style = {
		blendmode = 0,
		scale = 1,
		phongtint = Color(255, 255, 255, 255),
		color = Color(172, 206, 176, 255),
		phongexponent = 15,
		pos_y = 0,
		fresnel = 1,
		url = "",
		img_color = Color(255, 255, 255, 255),
		pos_x = 0,
		phongboost = 0.5,
	},
	ranks = {},
	water_capacity = 300,
	jobs = {},
	scale = 0.5,
	type = 1,
	class = "zgo2_pot",
	name = "Macro Pot",
	boost_amount = 1,
})

AddPot({
	scale = 1.25,
	water_capacity = 500,
	class = "zgo2_pot",
	style = {
		blendmode = 0,
		scale = 1,
		phongtint = Color(245, 194, 65, 255),
		color = Color(203, 167, 75, 255),
		phongexponent = 5,
		pos_y = 0,
		fresnel = 3,
		url = "",
		img_color = Color(255, 255, 255, 255),
		pos_x = 0,
		phongboost = 15,
	},
	ranks = {},
	jobs = {},
	boost_amount = 3,
	uniqueid = "108f9d76a9",
	type = 3,
	price = 1000,
	name = "Valhalla",
	boost_time = 1,
})

AddPot({
	price = 1000,
	water_capacity = 500,
	uniqueid = "e522a6e88d",
	style = {
		blendmode = 0,
		scale = 1,
		phongtint = Color(255, 255, 255, 255),
		color = Color(155, 155, 155, 255),
		phongexponent = 5,
		pos_y = 0,
		fresnel = 3,
		url = "",
		img_color = Color(255, 255, 255, 255),
		pos_x = 0,
		phongboost = 15,
	},
	ranks = {},
	boost_amount = 1,
	jobs = {},
	class = "zgo2_pot",
	type = 5,
	boost_time = 2,
	name = "Steel",
	scale = 1,
})

AddPot({
	scale = 1,
	boost_time = 1,
	class = "zgo2_pot",
	style = {
		blendmode = "Multiply",
		scale = 1.93,
		phongtint = Color(255, 255, 255, 255),
		color = Color(203, 190, 181, 255),
		phongexponent = 1,
		pos_y = 0.12,
		fresnel = 0.1,
		url = "Voh7Apg",
		img_color = Color(255, 255, 255, 255),
		pos_x = 0,
		phongboost = 1,
	},
	ranks = {},
	price = 500,
	boost_amount = 1,
	water_capacity = 500,
	type = 6,
	uniqueid = "18bd29f248",
	name = "Jute Bag",
	jobs = {},
})
