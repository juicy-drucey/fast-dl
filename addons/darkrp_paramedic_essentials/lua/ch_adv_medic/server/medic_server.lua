local function CH_AdvMedic_GiveWeapons( ply, before, after )
	timer.Simple( 0.5, function()
		if not IsValid( ply ) then
			return
		end
		
		if ply:HasWeapon( "med_kit" ) then -- Strip default darkrp health kit.
			ply:StripWeapon( "med_kit" )
		end
		
		if ply:CH_AdvMedic_IsParamedic() then -- Give new medkit to medic teams
			ply:Give( "med_kit_advanced" )
			ply:Give( "defibrillator_advanced" )
		end
	end )
end
hook.Add( "OnPlayerChangedTeam", "CH_AdvMedic_GiveWeapons", CH_AdvMedic_GiveWeapons ) -- DarkRP Special Hook (2.5.0+ Only)
hook.Add( "PlayerSpawn", "CH_AdvMedic_GiveWeapons", CH_AdvMedic_GiveWeapons )

local function CH_AdvMedic_PostCleanupMap()
	print( "[Paramedic Essentials] - Map cleaned up. Respawning entities..." )

	timer.Simple( 1, function()
		CH_AdvMedic.SpawnRechargeStations()
		CH_AdvMedic.SpawnHealthNPC()
		CH_AdvMedic.SpawnTruckNPC()
	end )
end
hook.Add( "PostCleanupMap", "CH_AdvMedic_PostCleanupMap", CH_AdvMedic_PostCleanupMap )