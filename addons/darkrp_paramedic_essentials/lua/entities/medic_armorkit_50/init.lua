AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/Items/battery.mdl" )
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
	
	if ply:Armor() >= CH_AdvMedic.Config.MaximumArmor then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You've reached the maximum amount of armor that you can have!" ) )
		return
	end

	if ply:Armor() + 50 >= CH_AdvMedic.Config.MaximumArmor then
		ply:SetArmor( CH_AdvMedic.Config.MaximumArmor )
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your armor has been filled to the maximum!" ) )
	else
		ply:SetArmor( ply:Armor() + 50 )
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, "+50 ".. CH_AdvMedic.LangString( "Armor" ) )
	end
	
	self:Remove()
end