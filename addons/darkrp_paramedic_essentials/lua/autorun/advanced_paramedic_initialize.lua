-- INITIALIZE SCRIPT
if SERVER then
	for k, v in ipairs( file.Find( "ch_adv_medic/shared/*.lua", "LUA" ) ) do
		include( "ch_adv_medic/shared/" .. v )
		AddCSLuaFile( "ch_adv_medic/shared/" .. v )
	end
	
	for k, v in ipairs( file.Find( "ch_adv_medic/server/*.lua", "LUA" ) ) do
		include( "ch_adv_medic/server/" .. v )
	end
	
	for k, v in ipairs( file.Find( "ch_adv_medic/client/*.lua", "LUA" ) ) do
		AddCSLuaFile( "ch_adv_medic/client/" .. v )
	end
end

if CLIENT then
	for k, v in ipairs( file.Find( "ch_adv_medic/shared/*.lua", "LUA" ) ) do
		include( "ch_adv_medic/shared/" .. v )
	end
	
	for k, v in ipairs( file.Find( "ch_adv_medic/client/*.lua", "LUA" ) ) do
		include( "ch_adv_medic/client/" .. v )
	end
end