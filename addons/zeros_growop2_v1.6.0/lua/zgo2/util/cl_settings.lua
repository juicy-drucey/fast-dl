/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

if SERVER then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

hook.Add("AddToolMenuCategories", "zgo2_CreateCategories", function()
	spawnmenu.AddToolCategory("Options", "zgo2_options", "GrowOP 2")
end)

local PrimaryColor = Color(82, 117, 71)
local SecondaryColor = Color(54, 77, 47) // zclib.colors[ "ui02" ]

hook.Add("PopulateToolMenu", "zgo2_PopulateMenus", function()
	spawnmenu.AddToolMenuOption("Options", "zgo2_options", "zgo2_Admin_Settings", "Admin Settings", "", "", function(CPanel)
		zclib.Settings.OptionPanel("Public Grow Setup", nil, PrimaryColor, SecondaryColor, CPanel, {
			[ 1 ] = {
				name = "Save",
				class = "DButton",
				cmd = "zgo2_public_save",
			},
			[ 2 ] = {
				name = "Remove",
				class = "DButton",
				cmd = "zgo2_public_remove",
			},
		})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

		zclib.Settings.OptionPanel("Plant", nil, PrimaryColor, SecondaryColor, CPanel, {
			[ 1 ] = {
				name = "Open Editor",
				class = "DButton",
				cmd = "zgo2_plant_editor",
			},
			[ 2 ] = {
				name = "Factory Reset Config",
				class = "DButton",
				cmd = "zgo2_plant_factory_reset",
			},
		})

		zclib.Settings.OptionPanel("Bong", nil, PrimaryColor, SecondaryColor, CPanel, {
			[ 1 ] = {
				name = "Open Editor",
				class = "DButton",
				cmd = "zgo2_bong_editor",
			},
			[ 2 ] = {
				name = "Factory Reset Config",
				class = "DButton",
				cmd = "zgo2_bong_factory_reset",
			},
		})

		zclib.Settings.OptionPanel("Pot", nil, PrimaryColor, SecondaryColor, CPanel, {
			[ 1 ] = {
				name = "Open Editor",
				class = "DButton",
				cmd = "zgo2_pot_editor",
			},
			[ 2 ] = {
				name = "Factory Reset Config",
				class = "DButton",
				cmd = "zgo2_pot_factory_reset",
			},
		})

		zclib.Settings.OptionPanel("NPC", nil, PrimaryColor, SecondaryColor, CPanel, {
			[ 1 ] = {
				name = "Save",
				class = "DButton",
				cmd = "zgo2_npc_save",
			},
			[ 2 ] = {
				name = "Remove",
				class = "DButton",
				cmd = "zgo2_npc_remove",
			},
			[ 3 ] = {
				name = "Remove all DropZones",
				class = "DButton",
				cmd = "zgo2_DropZone_remove",
			},
		})

		zclib.Settings.OptionPanel("Commands", nil, PrimaryColor, SecondaryColor, CPanel, {
			[ 1 ] = {
				name = "Spawn Seeds",
				class = "DButton",
				cmd = "zgo2_spawn_seed",
			},
			[ 2 ] = {
				name = "Spawn Plants",
				class = "DButton",
				cmd = "zgo2_spawn_plants",
			},
			[ 3 ] = {
				name = "Spawn Weedbranches",
				class = "DButton",
				cmd = "zgo2_spawn_weedbranch",
			},
			[ 4 ] = {
				name = "Spawn Jars",
				class = "DButton",
				cmd = "zgo2_spawn_jars",
			},
			[ 5 ] = {
				name = "Spawn Baggies",
				class = "DButton",
				cmd = "zgo2_spawn_baggies",
			},
			[ 6 ] = {
				name = "Spawn Joints",
				class = "DButton",
				cmd = "zgo2_spawn_joints",
			},
			[ 7 ] = {
				name = "Spawn Weedblocks",
				class = "DButton",
				cmd = "zgo2_spawn_weedblocks",
			},
			[ 8 ] = {
				name = "Spawn Contract",
				class = "DButton",
				cmd = "zgo2_spawn_contract",
			},
			[ 9 ] = {
				name = "Spawn Edibles",
				class = "DButton",
				cmd = "zgo2_spawn_edibles",
			},
		})
	end)

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

	spawnmenu.AddToolMenuOption("Options", "zgo2_options", "zgo2_Client_Settings", "Client Settings", "", "", function(CPanel)
		zclib.Settings.OptionPanel("Lamp", "", PrimaryColor, SecondaryColor, CPanel, {
			[ 1 ] = {
				name = "DynamicLight",
				class = "DCheckBoxLabel",
				cmd = "zgo2_cl_dynlight",
			},
			[ 2 ] = {
				name = "Light Sprites",
				class = "DCheckBoxLabel",
				cmd = "zgo2_cl_lightsprite",
			},
			[ 3 ] = {
				name = "Light Beams",
				class = "DCheckBoxLabel",
				cmd = "zgo2_cl_lightbeam",
			},
		})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

		zclib.Settings.OptionPanel("Plant", "", PrimaryColor, SecondaryColor, CPanel, {
			[ 1 ] = {
				name = "Smooth Grow",
				class = "DCheckBoxLabel",
				cmd = "zgo2_cl_smoothgrow",
				desc = "Makes the plants grow smoothly."
			},
			[ 2 ] = {
				name = "Skank Effect",
				class = "DCheckBoxLabel",
				cmd = "zgo2_cl_drawskank",
				desc = "Draws the Skank Effect when the plant is harvest ready."
			},
		})
	end)
end)
