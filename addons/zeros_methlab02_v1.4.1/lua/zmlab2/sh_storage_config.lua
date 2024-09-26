/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

zmlab2 = zmlab2 or {}
zmlab2.config = zmlab2.config or {}
zmlab2.config.Storage = zmlab2.config.Storage or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

// Here are all the entities which can be bought from the storage
zmlab2.config.Storage.Shop = {
	[1] = {
		name = zmlab2.language["acid_title"],
		desc = zmlab2.language["acid_desc"],
		class = "zmlab2_item_acid",
		model = "models/zerochain/props_methlab/zmlab2_acid.mdl",
		price = 10,
		// Defines how many items of that class the player can spawn
		limit = 5,

		// Which rank is allowed to buy this?
		/*
		rank = {
			["vip"] = true,
		},
		*/
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575

		// Which job is allowed to buy this?
		/*
		job = {
			[TEAM_ZMLAB2_COOK] = true
		},
		*/
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477

		// You can use this to restrict this for any other reason
		/*
		customcheck = function(ply)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477

		end,
		*/
	},
	[2] = {
		name = zmlab2.language["methylamine_title"],
		desc = zmlab2.language["methylamine_desc"],
		class = "zmlab2_item_methylamine",
		model = "models/zerochain/props_methlab/zmlab2_methylamine.mdl",
		price = 10,
		limit = 3
	},
	[3] = {
		name = zmlab2.language["aluminum_title"],
		desc = zmlab2.language["aluminum_desc"],
		class = "zmlab2_item_aluminium",
		model = "models/zerochain/props_methlab/zmlab2_aluminium.mdl",
		price = 10,
		limit = 10
	},
	[4] = {
		name = zmlab2.language["lox_title"],
		desc = zmlab2.language["lox_desc"],
		class = "zmlab2_item_lox",
		model = "models/zerochain/props_methlab/zmlab2_lox.mdl",
		price = 10,
		limit = 3
	},
	[5] = {
		name = zmlab2.language["crate_title"],
		desc = zmlab2.language["crate_desc"],
		class = "zmlab2_item_crate",
		model = "models/zerochain/props_methlab/zmlab2_crate.mdl",
		price = 10,
		limit = 5
	},
	[6] = {
		name = zmlab2.language["palette_title"],
		desc = zmlab2.language["palette_desc"],
		class = "zmlab2_item_palette",
		model = "models/zerochain/props_methlab/zmlab2_palette.mdl",
		price = 10,
		limit = 1
	},
	[7] = {
		name = zmlab2.language["crusher_title"],
		desc = zmlab2.language["crusher_desc"],
		class = "zmlab2_item_autobreaker",
		model = "models/zerochain/props_methlab/zmlab2_autobreaker.mdl",
		price = 10000,
		limit = 1,
		/*
		rank = {
			["vip"] = true,
		},
		*/
	}
}
