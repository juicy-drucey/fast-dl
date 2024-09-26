AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local map = string.lower( game.GetMap() )

function CH_AdvMedic.SpawnTruckNPC()
	local PositionFile = file.Read( "craphead_scripts/medic_system/".. map .."/ambulancenpc_location.txt", "DATA" )
	
	local ThePosition = string.Explode( ";", PositionFile )
	
	local TheVector = Vector( ThePosition[1], ThePosition[2], ThePosition[3] )
	local TheAngle = Angle( tonumber( ThePosition[4]), ThePosition[5], ThePosition[6] )
	
	local AmbulanceNPC = ents.Create( "ch_npc_ambulance" )
	AmbulanceNPC:SetModel( CH_AdvMedic.Config.NPCModel )
	AmbulanceNPC:SetPos( TheVector )
	AmbulanceNPC:SetAngles( TheAngle )
	AmbulanceNPC:Spawn()
	AmbulanceNPC:SetMoveType( MOVETYPE_NONE )
	AmbulanceNPC:SetSolid( SOLID_BBOX )
	AmbulanceNPC:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	
	CH_AdvMedic.AmbulanceNPCEntity = AmbulanceNPC
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

local function CH_AdvMedic_SetTruckNPCSpawnPos( ply )
	if not ply:IsAdmin() then
		ply:ChatPrint( CH_AdvMedic.LangString( "Only administrators can perform this action!" ) )
		return
	end
	
	local HisVector = string.Explode(" ", tostring(ply:GetPos()))
	local HisAngles = string.Explode(" ", tostring(ply:GetAngles()))
	
	file.Write("craphead_scripts/medic_system/".. map .."/ambulancenpc_location.txt", ""..(HisVector[1])..";"..(HisVector[2])..";"..(HisVector[3])..";"..(HisAngles[1])..";"..(HisAngles[2])..";"..(HisAngles[3]).."", "DATA")
	ply:ChatPrint( "New position for the ambulance NPC has been succesfully set." )
	ply:ChatPrint( "The NPC will respawn in 5 seconds. Move out the way." )
	
	-- Respawn the ambulance npc
	local npc = CH_AdvMedic.AmbulanceNPCEntity
	if IsValid( npc ) then
		npc:Remove()
	end
	
	timer.Simple( 5, function()
		if IsValid( ply ) then
			CH_AdvMedic.SpawnTruckNPC()
			ply:ChatPrint( "The ambulance NPC has been respawned." )
		end
	end )
end
concommand.Add( "paramedic_ambulancenpc_setpos", CH_AdvMedic_SetTruckNPCSpawnPos )

function ENT:Use( ply )
	local cur_time = CurTime()
	if ( self.LastUsed or 0 ) > cur_time then
		return
	end
	self.LastUsed = cur_time + 1

	if ply:CH_AdvMedic_IsParamedic() then
		net.Start( "CH_AdvMedic_Net_AmbulanceMenu" )
		net.Send( ply )
	else
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Only paramedics can access this NPC!" ) )
	end
end