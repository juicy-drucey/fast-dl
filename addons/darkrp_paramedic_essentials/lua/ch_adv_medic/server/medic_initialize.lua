print( "[Paramedic Essentials] - Initializing addon..." )
-- Resources
resource.AddWorkshop( "343729375" ) -- [LW] Ford F350 Ambulance
resource.AddWorkshop( "1980971647" ) -- Script Content

-- Net messages
util.AddNetworkString( "CH_AdvMedic_Net_DefibUpdateSeconds" )

util.AddNetworkString( "CH_AdvMedic_Net_AmbulanceMenu" )

util.AddNetworkString( "CH_AdvMedic_Net_SpawnAmbulance" )
util.AddNetworkString( "CH_AdvMedic_Net_RemoveAmbulance" )

util.AddNetworkString( "CH_AdvMedic_Net_HealthMenu" )
util.AddNetworkString( "CH_AdvMedic_Net_PurchaseHealth" )
util.AddNetworkString( "CH_AdvMedic_Net_PurchaseArmor" )

local map = string.lower( game.GetMap() )

-- Initialize script
local function CH_AdvMedic_InitializeAddon()
	-- Default file locations
	if not file.IsDir( "craphead_scripts", "DATA" ) then
		file.CreateDir( "craphead_scripts", "DATA" )
	end
	
	if not file.IsDir( "craphead_scripts/medic_system/".. map .."", "DATA" ) then
		file.CreateDir( "craphead_scripts/medic_system/".. map .."", "DATA" )
	end
	
	-- Ambulance NPC
	if not file.Exists( "craphead_scripts/medic_system/".. map .."/ambulancenpc_location.txt", "DATA" ) then
		file.Write("craphead_scripts/medic_system/".. map .."/ambulancenpc_location.txt", "0;-0;-0;0;0;0", "DATA" )
	end
	
	-- Create ambulance spawn pos file
	if not file.IsDir( "craphead_scripts/medic_system/".. map .."/ambulance_spawn", "DATA" ) then
		file.CreateDir( "craphead_scripts/medic_system/".. map .."/ambulance_spawn", "DATA" )
	end
	
	-- Recharge Station
	if not file.IsDir( "craphead_scripts/medic_system/".. map .."/recharge_stations/", "DATA" ) then
		file.CreateDir( "craphead_scripts/medic_system/".. map .."/recharge_stations/", "DATA" )
	end
	
	-- Health NPC
	if not file.Exists( "craphead_scripts/medic_system/".. map .."/healthnpc_location.txt", "DATA" ) then
		file.Write( "craphead_scripts/medic_system/".. map .."/healthnpc_location.txt", "0;-0;-0;0;0;0", "DATA" )
	end
	
	CH_AdvMedic.SpawnRechargeStations()
	CH_AdvMedic.RegainChargesTimer()
	
	-- Spawn NPCs
	CH_AdvMedic.SpawnHealthNPC()
	CH_AdvMedic.SpawnTruckNPC()
end
hook.Add( "InitPostEntity", "CH_AdvMedic_InitializeAddon", CH_AdvMedic_InitializeAddon )

print( "[Paramedic Essentials] - Addon successfully initialized!" )