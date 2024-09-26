local map = string.lower( game.GetMap() )

-- Spawn and save recharge stations
function CH_AdvMedic.SpawnRechargeStations()
	for k, v in ipairs( file.Find( "craphead_scripts/medic_system/".. map .."/recharge_stations/recharge_station_*.txt", "DATA" ) ) do
		local PositionFile = file.Read( "craphead_scripts/medic_system/".. map .."/recharge_stations/".. v, "DATA" )
	
		local ThePosition = string.Explode( ";", PositionFile )
		
		local TheVector = Vector( ThePosition[1], ThePosition[2], ThePosition[3] )
		local TheAngle = Angle( ThePosition[4], ThePosition[5], ThePosition[6] )

		local Recharge_Station = ents.Create( "ch_recharge_station" )
		Recharge_Station:SetPos( TheVector )
		Recharge_Station:SetAngles( TheAngle )
		Recharge_Station:Spawn()
	end
end

local function CH_AdvMedic_RechargeStationSavePos( ply, cmd, args )
	if not ply:IsAdmin() then
		ply:ChatPrint( CH_AdvMedic.LangString( "Only administrators can perform this action!" ) )
		return
	end
	
	for k, v in ipairs( file.Find( "craphead_scripts/medic_system/".. map .."/recharge_stations/recharge_station_*.txt", "DATA" ) ) do
		file.Delete( "craphead_scripts/medic_system/".. map .."/recharge_stations/".. v )
	end
	
	for k, ent in ipairs( ents.FindByClass( "ch_recharge_station" ) ) do
		local pos = string.Explode( " ", tostring( ent:GetPos() ) )
		local ang = string.Explode( " ", tostring( ent:GetAngles() ) )
		
		file.Write( "craphead_scripts/medic_system/".. map .."/recharge_stations/recharge_station_".. math.random( 1, 9999999 ) ..".txt", ""..(pos[1])..";"..(pos[2])..";"..(pos[3])..";"..(ang[1])..";"..(ang[2])..";"..(ang[3]).."", "DATA" )
	end
	
	ply:ChatPrint( "All recharge stations have been saved!" )
end
concommand.Add( "paramedic_rechargestation_savepos", CH_AdvMedic_RechargeStationSavePos )

-- Regain Charges Timer
function CH_AdvMedic.RegainChargesTimer()
	timer.Create( "MEDIC_RechargeRegain", CH_AdvMedic.Config.RegainTime * 60, 0, function()
		for k, ent in ipairs( ents.FindByClass( "ch_recharge_station" ) ) do
			ent:SetRechargesLeft( math.Clamp( ent:GetRechargesLeft() + CH_AdvMedic.Config.RegainCharges, 0, CH_AdvMedic.Config.DefaultCharges ) )
		end
		
		if not CH_AdvMedic.Config.NotifyMedics then
			return
		end
		
		-- Notify medics if enabled
		for k, ply in ipairs( player.GetAll() ) do
			if ply:CH_AdvMedic_IsParamedic() then
				DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "The recharge stations has been refilled with new charges!" ) )
			end
		end
	end )
end