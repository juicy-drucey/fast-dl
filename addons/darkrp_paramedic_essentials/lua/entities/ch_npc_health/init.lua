AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local map = string.lower( game.GetMap() )

function CH_AdvMedic.SpawnHealthNPC()	
	local PositionFile = file.Read("craphead_scripts/medic_system/".. map .."/healthnpc_location.txt", "DATA")

	local ThePosition = string.Explode( ";", PositionFile )

	local TheVector = Vector( ThePosition[1], ThePosition[2], ThePosition[3] )
	local TheAngle = Angle( tonumber(ThePosition[4]), ThePosition[5], ThePosition[6] )
	
	local HealthNPC = ents.Create( "ch_npc_health" )
	HealthNPC:SetModel( CH_AdvMedic.Config.HealthNPCModel )
	HealthNPC:SetPos( TheVector )
	HealthNPC:SetAngles( TheAngle )
	HealthNPC:Spawn()
	HealthNPC:SetMoveType( MOVETYPE_NONE )
	HealthNPC:SetSolid( SOLID_BBOX )
	HealthNPC:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	
	CH_AdvMedic.HealthNPCEntity = HealthNPC
end

function ENT:Initialize()
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:CapabilitiesAdd( CAP_TURN_HEAD )
	self:DropToFloor()
	self:SetMaxYawSpeed( 90 )
	self:SetCollisionGroup( 1 )
end

function ENT:OnTakeDamage( dmg )
	return 0
end

local function MEDIC_HealthNPC_Position( ply )
	if not ply:IsAdmin() then
		ply:ChatPrint( CH_AdvMedic.LangString( "Only administrators can perform this action!" ) )
		return
	end
	
	local HisVector = string.Explode(" ", tostring(ply:GetPos()))
	local HisAngles = string.Explode(" ", tostring(ply:GetAngles()))
	
	file.Write("craphead_scripts/medic_system/".. map .."/healthnpc_location.txt", ""..(HisVector[1])..";"..(HisVector[2])..";"..(HisVector[3])..";"..(HisAngles[1])..";"..(HisAngles[2])..";"..(HisAngles[3]).."", "DATA")
	ply:ChatPrint( "New position for the health/armor NPC has been succesfully set." )
	ply:ChatPrint( "The NPC will respawn in 5 seconds. Move out the way." )
	
	-- Respawn the ambulance npc
	local npc = CH_AdvMedic.HealthNPCEntity
	if IsValid( npc ) then
		npc:Remove()
	end
	
	timer.Simple( 5, function()
		if IsValid( ply ) then
			CH_AdvMedic.SpawnHealthNPC()
			ply:ChatPrint( "The health/armor NPC has been respawned." )
		end
	end )
end
concommand.Add( "paramedic_healthnpc_setpos", MEDIC_HealthNPC_Position )

function ENT:Use( ply )
	local cur_time = CurTime()
	if ( self.LastUsed or 0 ) > cur_time then
		return
	end
	self.LastUsed = cur_time + 1

	local RequiredTeamsCount = 0
	local RequiredPlayersCounted = 0

	for k, v in ipairs( player.GetAll() ) do
		RequiredPlayersCounted = RequiredPlayersCounted + 1
		
		if v:CH_AdvMedic_IsParamedic() then
			RequiredTeamsCount = RequiredTeamsCount + 1
		end
		
		if RequiredPlayersCounted == #player.GetAll() then
			if not CH_AdvMedic.Config.OnlyWorkIfNoMedics then
				if RequiredTeamsCount < CH_AdvMedic.Config.RequiredMedics then
					DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "The minimum required paramedics for this service to be available is" ).. " ".. CH_AdvMedic.Config.RequiredMedics )
					return
				end
			else
				if RequiredTeamsCount > 0 then
					DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, "You can only use this service if there are no paramedics on duty!" )
					return
				end
			end
		end
	end

	net.Start( "CH_AdvMedic_Net_HealthMenu" )
	net.Send( ply )
end

net.Receive( "CH_AdvMedic_Net_PurchaseHealth", function( length, ply )
	local cur_time = CurTime()
	
	if ( ply.CH_AdvMedic_NetRateLimit or 0 ) > cur_time then
		ply:ChatPrint( "You're running the command too fast. Slow down champ!" )
		return
	end
	ply.CH_AdvMedic_NetRateLimit = cur_time + 1.5
	
	if not CH_AdvMedic.Config.NPCSellHealth then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "The server has disabled this feature!" ) )
		return
	end
	
	-- Distance check
	local npc = CH_AdvMedic.HealthNPCEntity
	if ply:GetPos():DistToSqr( npc:GetPos() ) > 10000 then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You are too far away from the NPC!" ) )
		return
	end
	
	-- Check if health is full
	if ply:Health() >= ply:GetMaxHealth() then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your health is already at maximum." ) )
		return
	end
	
	-- All good heal player!
	if ply:getDarkRPVar("money") >= CH_AdvMedic.Config.HealthPrice then
		ply:SetHealth( ply:GetMaxHealth() )
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your health has been refilled. You have been charged" ).. " ".. DarkRP.formatMoney( CH_AdvMedic.Config.HealthPrice ) )
		ply:addMoney( CH_AdvMedic.Config.HealthPrice * - 1 )
		
		-- Check to fixs injuries
		if ply:Health() >= CH_AdvMedic.Config.MinHealthFixInjury then
			if ply:CH_AdvMedic_HasInjury() then
				CH_AdvMedic.FixPlayerInjuries( ply, true )
			end
		end
	else
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You cannot afford this" ) )
	end
end )

net.Receive( "CH_AdvMedic_Net_PurchaseArmor", function( length, ply )
	local cur_time = CurTime()
	
	if ( ply.CH_AdvMedic_NetRateLimit or 0 ) > cur_time then
		ply:ChatPrint( "You're running the command too fast. Slow down champ!" )
		return
	end
	ply.CH_AdvMedic_NetRateLimit = cur_time + 1.5
	
	if not CH_AdvMedic.Config.NPCSellArmor then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "The server has disabled this feature!" ) )
		return
	end
	
	-- Distance check
	local npc = CH_AdvMedic.HealthNPCEntity
	if ply:GetPos():DistToSqr( npc:GetPos() ) > 10000 then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You are too far away from the NPC!" ) )
		return
	end
	
	-- Check if armor is full
	if ply:Armor() >= 100 then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your armor is already at maximum." ) )
		return
	end
	
	-- All good heal player!
	if ply:getDarkRPVar( "money" ) >= CH_AdvMedic.Config.ArmorPrice then
		ply:SetArmor( 100 )
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your armor has been refilled. You have been charged" ).. " ".. DarkRP.formatMoney( CH_AdvMedic.Config.ArmorPrice ) )
		ply:addMoney( CH_AdvMedic.Config.ArmorPrice * - 1 )
	else
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You cannot afford this!" ) )
	end
end )