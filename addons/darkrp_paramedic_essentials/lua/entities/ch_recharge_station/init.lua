AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:SpawnFunction( ply, tr )
	if not tr.Hit then
		return
	end
	
	local SpawnPos = tr.HitPos + tr.HitNormal
	
	local ent = ents.Create( "ch_recharge_station" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( ply:GetAngles() + Angle( 0, 180, 0 ) )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()
	self:SetModel( "models/craphead_scripts/paramedic_essentials/recharge_station.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	
	self:SetRechargesLeft( CH_AdvMedic.Config.DefaultCharges )
end

function ENT:Use( ply )
	local cur_time = CurTime()
	local cur_wep = ply:GetActiveWeapon()

	if ( self.LastUsed or 0 ) > cur_time then
		return
	end
	self.LastUsed = cur_time + 1
		
	if not cur_wep then
		return
	end
	
	if not ply:CH_AdvMedic_IsParamedic() then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Only paramedics can use the recharge station!" ) )
		return
	end

	if cur_wep:GetClass() != "med_kit_advanced" then
		DarkRP.notify( ply, 2, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You need to equip the medkit to recharge it!" ) )
		return
	end
	
	if self:GetRechargesLeft() <= 0 then
		DarkRP.notify( ply, 2, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "There are no recharges available at this moment!" ) )
		return
	end
	
	if cur_wep:GetNWInt( "CH_AdvMedic_WeaponCharge" ) > CH_AdvMedic.Config.MinimumCharge then
		DarkRP.notify( ply, 2, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You can only recharge your medkit when it's under" ) .." ".. CH_AdvMedic.Config.MinimumCharge .."%" )
		return
	end
	
	-- All good. Charge it!
	cur_wep:SetNWInt( "CH_AdvMedic_WeaponCharge", 100 )
	DarkRP.notify( ply, 2, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your medkit has been fully recharged!" ) )
	
	-- Update charges left in the recharge station
	self:SetRechargesLeft( self:GetRechargesLeft() - 1 )
end

function ENT:OnTakeDamage( dmg )
	return 0
end