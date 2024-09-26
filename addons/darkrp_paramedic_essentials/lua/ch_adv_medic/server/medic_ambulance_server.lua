local CurAmbulances = 0
local map = string.lower( game.GetMap() )

local function CH_AdvMedic_AddSpawnPos( ply )
	if not ply:IsAdmin() then
		ply:ChatPrint( CH_AdvMedic.LangString( "Only administrators can perform this action!" ) )
		return
	end
	
	local HisVector = string.Explode( " ", tostring( ply:GetPos() ) )
	local HisAngles = string.Explode( " ", tostring( ply:GetAngles() ) )
	
	file.Write( "craphead_scripts/medic_system/".. map .."/ambulance_spawn/ambulance_location_".. math.random( 1, 9999999 ) ..".txt", ""..(HisVector[1])..";"..(HisVector[2])..";"..(HisVector[3])..";"..(HisAngles[1])..";"..(HisAngles[2])..";"..(HisAngles[3]).."", "DATA")
	ply:ChatPrint( CH_AdvMedic.LangString( "Added a new spawn point for ambulances. The new position is now in effect!" ) )
end
concommand.Add( "ambulance_addspawnpos", CH_AdvMedic_AddSpawnPos )

local function CH_AdvMedic_ClearAllSpawnPos( ply )
	if not ply:IsAdmin() then
		ply:ChatPrint( CH_AdvMedic.LangString( "Only administrators can perform this action!" ) )
		return
	end
	
	for k, v in ipairs( file.Find( "craphead_scripts/medic_system/".. map .."/ambulance_spawn/ambulance_location_*.txt", "DATA" ) ) do
		file.Delete( "craphead_scripts/medic_system/".. map .."/ambulance_spawn/".. v )
	end
	
	ply:ChatPrint( CH_AdvMedic.LangString( "All ambulance spawn positions have been cleared." ) )
	ply:ChatPrint( CH_AdvMedic.LangString( "Type ambulance_addspawnpos to start adding new ones!" ) )
end
concommand.Add( "ambulance_clearallspawns", CH_AdvMedic_ClearAllSpawnPos )

net.Receive( "CH_AdvMedic_Net_SpawnAmbulance", function( length, ply )
	local cur_time = CurTime()
	
	if ( ply.CH_AdvMedic_NetRateLimit or 0 ) > cur_time then
		ply:ChatPrint( "You're running the command too fast. Slow down champ!" )
		return
	end
	ply.CH_AdvMedic_NetRateLimit = cur_time + 1.5
	
	if not ply:CH_AdvMedic_IsParamedic() then
		return
	end
	
	if ply.CH_AdvMedic_HasAmbulance then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You already own an ambulance!" ) )
		return
	end
	
	if CurAmbulances == CH_AdvMedic.Config.MaxTrucks then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "The limitation of maximum ambulances has been reached!" ) )
		return
	end
	
	-- Check for ambulance spawns
	CH_AdvMedic.AmbulanceSpawns = {}
	for k, v in ipairs( file.Find( "craphead_scripts/medic_system/".. map .."/ambulance_spawn/ambulance_location_*.txt", "DATA" ) ) do
		table.insert( CH_AdvMedic.AmbulanceSpawns, v )
	end
	
	local RandomFile = table.Random( CH_AdvMedic.AmbulanceSpawns )
	
	if table.IsEmpty( CH_AdvMedic.AmbulanceSpawns ) then
		DarkRP.notify( ply, 1, 5, CH_AdvMedic.LangString( "The server owner has not configured any ambulance spawn positions!" ) )
		return
	end
	
	DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You have succesfully retrieved an ambulance! It's parked right outside the building." ) )
	
	-- Spawn ambulance truck
	local PositionFile = file.Read( "craphead_scripts/medic_system/".. map .."/ambulance_spawn/".. RandomFile, "DATA" )
	local ThePosition = string.Explode( ";", PositionFile )
	local TheVector = Vector(ThePosition[1], ThePosition[2], ThePosition[3])
	local TheAngle = Angle(tonumber(ThePosition[4]), ThePosition[5], ThePosition[6])
	
	local AmbulanceTruck = ents.Create( "prop_vehicle_jeep" )
	AmbulanceTruck:SetKeyValue( "vehiclescript", CH_AdvMedic.Config.VehicleScript )
	AmbulanceTruck:SetPos( TheVector )
	AmbulanceTruck:SetAngles( TheAngle )
	AmbulanceTruck:SetRenderMode( RENDERMODE_TRANSADDFRAMEBLEND )
	AmbulanceTruck:SetModel( CH_AdvMedic.Config.VehicleModel )
	AmbulanceTruck:Spawn()
	AmbulanceTruck:SetSkin( CH_AdvMedic.Config.VehicleSkin )
	AmbulanceTruck:Activate()
	AmbulanceTruck:SetHealth( CH_AdvMedic.Config.AmbulanceHealth )
	AmbulanceTruck:keysOwn( ply )
	
	-- Auto enter
	if CH_AdvMedic.Config.AutoEnterAmbulance then
		ply:EnterVehicle( AmbulanceTruck )
	end
	
	-- Update variables
	ply.CH_AdvMedic_HasAmbulance = true
	ply.CH_AdvMedic_CurAmbulance = AmbulanceTruck
	
	CurAmbulances = CurAmbulances + 1
	
	-- Run hook
	hook.Run( "PlayerSpawnedVehicle", ply, AmbulanceTruck )
end )

net.Receive( "CH_AdvMedic_Net_RemoveAmbulance", function( length, ply )
	local cur_time = CurTime()
	
	if ( ply.CH_AdvMedic_NetRateLimit or 0 ) > cur_time then
		ply:ChatPrint( "You're running the command too fast. Slow down champ!" )
		return
	end
	ply.CH_AdvMedic_NetRateLimit = cur_time + 1.5
	
	if not ply:CH_AdvMedic_IsParamedic() then
		return
	end
	
	if ply.CH_AdvMedic_HasAmbulance then
		CH_AdvMedic.RemoveCurrentAmbulance( ply )
	else
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You don't have an ambulance!" ) )
	end
end )

function CH_AdvMedic.EntityRemoved( ent )
	if ent:CH_AdvMedic_IsAmbulance() then
		local owner = ent:CPPIGetOwner()
		
		CurAmbulances = CurAmbulances - 1
		
		if IsValid( owner ) then
			owner.CH_AdvMedic_HasAmbulance = false
		end
	end
end
hook.Add( "EntityRemoved", "CH_AdvMedic.EntityRemoved", CH_AdvMedic.EntityRemoved )

function CH_AdvMedic.JobChange( ply, before, after )
	if not ply:CH_AdvMedic_IsParamedic() then
		CH_AdvMedic.RemoveCurrentAmbulance( ply )
	end
end
hook.Add( "OnPlayerChangedTeam", "CH_AdvMedic.JobChange", CH_AdvMedic.JobChange )

function CH_AdvMedic.RemoveCurrentAmbulance( ply )
	if ply.CH_AdvMedic_HasAmbulance then
		local ambulance = ply.CH_AdvMedic_CurAmbulance
		
		if IsValid( ambulance ) then
			ambulance:Remove()
			
			ply.CH_AdvMedic_CurAmbulance = nil
			
			DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your current ambulance has been removed!" ) )
		end
	end
end