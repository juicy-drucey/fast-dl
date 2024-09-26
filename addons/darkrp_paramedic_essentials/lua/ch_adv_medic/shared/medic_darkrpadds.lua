function CH_AdvMedic.DarkRPAdds()
	-- Adding entities to the F4 menu
	DarkRP.createCategory{
		name = "Paramedic - Kits",
		categorises = "entities",
		startExpanded = true,
		color = Color(107, 0, 0, 255),
		canSee = function(ply) return true end,
		sortOrder = 51,
	}
	
	DarkRP.createEntity( CH_AdvMedic.LangString( "Health Kit" ).." +25", {
		ent = "medic_healthkit_25",
		model = "models/craphead_scripts/paramedic_essentials/weapons/w_medpack.mdl",
		price = 1000,
		max = 5,
		category = "Paramedic - Kits",
		cmd = "buyhealth25",
		--allowed = {TEAM_MEDIC, TEAM_PARAMEDIC},
	})
	
	DarkRP.createEntity( CH_AdvMedic.LangString( "Health Kit" ).." +50", {
		ent = "medic_healthkit_50",
		model = "models/craphead_scripts/paramedic_essentials/weapons/w_medpack.mdl",
		price = 1750,
		max = 5,
		category = "Paramedic - Kits",
		cmd = "buyhealth50",
		--allowed = {TEAM_MEDIC, TEAM_PARAMEDIC},
	})
	
	DarkRP.createEntity( CH_AdvMedic.LangString( "Armor Kit" ).." +25", {
		ent = "medic_armorkit_25",
		model = "models/Items/battery.mdl",
		price = 2000,
		max = 5,
		category = "Paramedic - Kits",
		cmd = "buyarmor25",
		--allowed = {TEAM_MEDIC, TEAM_PARAMEDIC},
	})
	
	DarkRP.createEntity( CH_AdvMedic.LangString( "Armor Kit" ).." +50", {
		ent = "medic_armorkit_50",
		model = "models/Items/battery.mdl",
		price = 3500,
		max = 5,
		category = "Paramedic - Kits",
		cmd = "buyarmor50",
		--allowed = {TEAM_MEDIC, TEAM_PARAMEDIC},
	})
	
	if not CH_AdvMedic.Config.AutoLifeAlert then
	
		DarkRP.createEntity( CH_AdvMedic.LangString( "Life Alert" ), {
			ent = "ch_medic_lifealert",
			model = "models/craphead_scripts/paramedic_essentials/props/alarm.mdl",
			price = 3500,
			max = 1,
			category = "Paramedic - Kits",
			cmd = "buylifealert",
			--allowed = {TEAM_MEDIC, TEAM_PARAMEDIC},
		})
		
	end
end
hook.Add( "loadCustomDarkRPItems", "CH_AdvMedic.DarkRPAdds", CH_AdvMedic.DarkRPAdds )