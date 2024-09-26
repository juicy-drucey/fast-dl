AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/craphead_scripts/paramedic_essentials/weapons/w_medpack.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
   
	self:PhysWake()
end

function ENT:Use( ply )
	local cur_time = CurTime()
	if ( self.LastUsed or 0 ) > cur_time then
		return
	end
	self.LastUsed = cur_time + 1
	
	if ply:Health() >= ply:GetMaxHealth() then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You've reached the maximum amount of health that you can have!" ) )
		return
	end
	
	if ply:Health() + 50 >= ply:GetMaxHealth() then
		ply:SetHealth( ply:GetMaxHealth() )
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your health has been filled to the maximum!" ) )
	else
		ply:SetHealth( ply:Health() + 50 )
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, "+50 ".. CH_AdvMedic.LangString( "Health" ) )
	end
	
	-- Check to fixs injuries
	if ply:Health() >= CH_AdvMedic.Config.MinHealthFixInjury then
		if ply:CH_AdvMedic_HasInjury() then
			CH_AdvMedic.FixPlayerInjuries( ply, true )
		end
	end
	
	self:Remove()
end