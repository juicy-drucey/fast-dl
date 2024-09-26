AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/sterling/retro_boombox.mdl" )
	self:SetUseType( SIMPLE_USE )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	
	self:SetPower( false )
	self:SetPlaying( true )
	self:SetFrequence( 1 )
	self:SetSoundLevel( 50 )

	RetroBoombox:ChangeColor( self, "main", self.MainColor )
	RetroBoombox:ChangeColor( self, "metalic", self.SecondaryColor )
	RetroBoombox:ChangeLightMode( self, 0 )
	
	self.IsBoombox = true
	self.BoomboxHealth = 100
end

function ENT:GetBoomboxOwner()
	local pOwner = IsValid( self.BoomboxOwner ) and self.BoomboxOwner or ( self.CPPIGetOwner and IsValid( self:CPPIGetOwner() ) ) and self:CPPIGetOwner() or ( self.Getowning_ent and IsValid( self:Getowning_ent() ) ) and self:Getowning_ent() or ( self:GetOwner() and type( self:GetOwner() ) == "Player" ) and self:GetOwner() 
	return pOwner
end

function ENT:SetBoomboxOwner( pPlayer )
	if not IsValid( pPlayer ) or not type( pPlayer) == "Player"  then return end

	if self.CPPISetOwner then
		self:CPPISetOwner( pPlayer )
	end
	if self.Setowning_ent then
		self:Setowning_ent( pPlayer )
	end

	self.BoomboxOwner = pPlayer
end

function ENT:Explode()
	if self.IsExploded then return end
	self.IsExploded = true

	local iRadius = 300

	local oEffectData = EffectData()
	oEffectData:SetOrigin( self:GetPos() )
	util.Effect( "Explosion", oEffectData, true, true )

	self:Ignite( 30 )
	self:SetPower( false )
	self.SetPower = function() end

	timer.Simple( 30, function() 
		if IsValid( self ) then
			self:Remove()
		end
	end )
end

function ENT:OnTakeDamage( oDmgInfos )
	if not RetroBoombox.Config.BoomboxCanBeDestroyed then return end
	
	self.BoomboxHealth = ( self.BoomboxHealth or 0 ) - ( oDmgInfos:GetDamage() or 0 )

	if self.BoomboxHealth <= 0 then
		self:Explode()
	end
end