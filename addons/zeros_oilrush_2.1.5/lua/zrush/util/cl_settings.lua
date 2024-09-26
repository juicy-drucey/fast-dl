/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

if (not CLIENT) then return end

hook.Add("AddToolMenuCategories", "zrush_CreateCategories", function()
	spawnmenu.AddToolCategory("Options", "zrush_options", "OilRush")
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

hook.Add("PopulateToolMenu", "zrush_PopulateMenus", function()
	spawnmenu.AddToolMenuOption("Options", "zrush_options", "zrush_Admin_Settings", "Admin Settings", "", "", function(CPanel)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

		zclib.Settings.OptionPanel("OilSpot Zones", nil, Color(215, 47, 29), zclib.colors["ui02"], CPanel, {
			[1] = {
				name = "Remove All",
				class = "DButton",
				cmd = "zrush_OilSpotZone_remove"
			}
		})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2

		zclib.Settings.OptionPanel("NPC", nil, Color(215, 47, 29), zclib.colors["ui02"], CPanel, {
			[1] = {
				name = "Save",
				class = "DButton",
				cmd = "zrush_npc_save"
			},
			[2] = {
				name = "Remove",
				class = "DButton",
				cmd = "zrush_npc_remove"
			}
		})

		zclib.Settings.OptionPanel("Commands", nil, Color(215, 47, 29), zclib.colors["ui02"], CPanel, {
			[1] = {
				name = "Random Fuel Barrel",
				class = "DButton",
				cmd = "zrush_debug_spawn_fuel"
			},
			[2] = {
				name = "Oil Barrel",
				class = "DButton",
				cmd = "zrush_debug_spawn_oil"
			}
		})
	end)
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
