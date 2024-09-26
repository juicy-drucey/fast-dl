--[[ INFO
#Defibrilator
models/craphead_scripts/paramedic_essentials/weapons/c_defibrilator.mdl
models/craphead_scripts/paramedic_essentials/weapons/w_defibrilator.mdl
FOV: 65
Hold type: duel
Skins: 0/1/2/3/4
Sequences:
(sequence_name       activity)
idle 		ACT_IDLE
use 		ACT_VM_PRIMARYATTACK
charge 	 	ACT_VM_SECONDARYATTACK
draw 		ACT_VM_DRAW
76561199237832821
--]]

if SERVER then
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= true
	SWEP.AutoSwitchFrom		= true
	AddCSLuaFile( "shared.lua" )
end

if CLIENT then
	SWEP.PrintName			= CH_AdvMedic.LangString( "Defibrillator" )
	SWEP.Author				= "Crap-Head"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	SWEP.DrawAmmo			= false
	SWEP.DrawWeaponInfoBox	= false
	SWEP.BounceWeaponIcon   = false
	SWEP.SwayScale			= 1.0
	SWEP.BobScale			= 1.0
end

SWEP.Author				= "Crap-Head"
SWEP.Instructions 		= CH_AdvMedic.LangString( "Left Click: Use defib (charge required), Right Click: Charge defib" )
SWEP.Category 			= "Paramedic Essentials"

SWEP.UseHands			= true
SWEP.ViewModelFOV		= 65

SWEP.ViewModel 				= "models/craphead_scripts/paramedic_essentials/weapons/c_defibrilator.mdl"
SWEP.WorldModel				= "models/craphead_scripts/paramedic_essentials/weapons/w_defibrilator.mdl"

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Range			= 120
SWEP.Primary.Recoil			= 4.6
SWEP.Primary.Damage			= 100
SWEP.Primary.Cone			= 0.005
SWEP.Primary.NumShots		= 1

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false	
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
	self:SetWeaponHoldType( "duel" )
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetSkin( 1 )
	self:SetNWInt( "CH_AdvMedic_DefibCharge", 0 )
	--[[
	timer.Simple( 0.25, function()
		if not IsValid( owner ) then
			return
		end
		
		local vm = owner:GetViewModel()
		vm:SetSubMaterial( 1, "models/craphead_scripts/paramedic_essentials/weapons/defib_scrn" )
	end )
	--]]
end

function SWEP:Deploy()
	local owner = self:GetOwner()
	self:SendWeaponAnim( ACT_VM_DRAW )
	
	timer.Simple( 1.2, function()
		if IsValid( self ) and IsValid( owner ) then
			if owner:GetActiveWeapon():GetClass() == "defibrillator_advanced" then
				self:SendWeaponAnim( ACT_IDLE )
			end
		end
	end )
	
	local vm = owner:GetViewModel()
	
	if self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 25 then -- First level
		vm:SetSubMaterial( 1, "models/craphead_scripts/paramedic_essentials/weapons/defib_scrn2" )
	elseif self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 50 then -- Second level
		vm:SetSubMaterial( 1, "models/craphead_scripts/paramedic_essentials/weapons/defib_scrn3" )
	elseif self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 75 then -- Third level
		vm:SetSubMaterial( 1, "models/craphead_scripts/paramedic_essentials/weapons/defib_scrn4" )
	elseif self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 100 then -- Fourth level
		vm:SetSubMaterial( 1, "models/craphead_scripts/paramedic_essentials/weapons/defib_scrn5" )
	end
	
	vm:SetPlaybackRate( 0.7 )
	
	return true
end

function SWEP:Holster( wep )
	if not IsFirstTimePredicted() then
		return
	end
	
	local owner = self:GetOwner()
	
	if not IsValid( owner ) then
		return
	end
	
	local vm = owner:GetViewModel()
	vm:SetSubMaterial( 1, nil )

	return true
end

function SWEP:OnRemove()
	local owner = self:GetOwner()
	
	if not IsValid( owner ) then
		return
	end
	
	local vm = owner:GetViewModel()
	if IsValid( vm ) then
		vm:SetSubMaterial( 1, nil )

		return true
	end
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + CH_AdvMedic.Config.DefibrillatorDelay )
	self:SetNextSecondaryFire( CurTime() + CH_AdvMedic.Config.DefibrillatorDelay )
	
	local owner = self:GetOwner()
	
    if self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 100 then
		local trace = util.GetPlayerTrace( owner )
		local tr = util.TraceLine( trace )
		
		local ent = tr.Entity
	
		if not IsValid( ent ) then
			return
		end
		
		if ent:GetPos():DistToSqr( owner:GetPos() ) > CH_AdvMedic.Config.ReviveDistanceToTarget then
			if SERVER then
				DarkRP.notify( owner, 1, 5, CH_AdvMedic.LangString( "You need to move closer to the body." ) )
			end
			return
		end
		
		if ent:GetNWBool( "CH_AdvMedic_RagdollIsCorpse" ) then
			self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			self:UpdateDefibCharge( true )
			
			timer.Simple( 1.2, function()
				if IsValid( self ) and IsValid( owner ) then
					if owner:GetActiveWeapon():GetClass() == "defibrillator_advanced" then
						self:SendWeaponAnim( ACT_IDLE )
					end
				end
			end )
			
			if SERVER then
				local chance = math.random( 1, 100 )
				
				-- If paramedic boost is active then set fail chance above max thus making the revival a 100% chance to succed
				if CH_BoostUpgrades and CH_BoostUpgrades.ParamedicEssentialBoost then
					chance = 101
				end
				
				if chance <= CH_AdvMedic.Config.RevivalFailChance then
					DarkRP.notify( owner, 1, 5, CH_AdvMedic.LangString( "Your attempt at reviving the player did not work. Recharge and try again!" ) )
					return 
				end
				
				local victim = ent:GetOwner()
				victim.CH_AdvMedic_WasRevived = true
				
				victim:Spawn()
				
				if IsValid( victim.CH_AdvMedic_DeathRagdoll ) then
					victim:SetPos( victim.CH_AdvMedic_DeathRagdoll:GetPos() )
				end
				
				for k, v in pairs( victim.WeaponsOnKilled ) do
					victim:Give( v )
				end
				
				victim:SetHealth( CH_AdvMedic.Config.HealthAfterRevival )
				
				DarkRP.notify( victim, 1, 5, CH_AdvMedic.LangString( "A paramedic has saved you from dying!" ) )
				DarkRP.notify( owner, 1, 5, CH_AdvMedic.LangString( "You have rescued the dying person!" ) )
				
				if victim.CH_AdvMedic_HasLifeAlert then
					DarkRP.notify( owner, 1, 5, "+ ".. DarkRP.formatMoney( CH_AdvMedic.Config.LifeAlertRevivalReward ) .." ".. CH_AdvMedic.LangString( "for responding to a life alert!" ) )
					owner:addMoney( CH_AdvMedic.Config.LifeAlertRevivalReward )
					
					-- XP Support
					CH_AdvMedic.LevelSupport( owner, CH_AdvMedic.Config.RevivePlayerLifeAlertXP, "XP rewarded." )
				else
					DarkRP.notify( owner, 1, 5, "+ ".. DarkRP.formatMoney( CH_AdvMedic.Config.RevivalReward ) .." ".. CH_AdvMedic.LangString( "for reviving a player!" ) )
					owner:addMoney( CH_AdvMedic.Config.RevivalReward )	
					
					-- XP Support
					CH_AdvMedic.LevelSupport( owner, CH_AdvMedic.Config.RevivePlayerXP, "XP rewarded." )
				end
				
				owner:EmitSound( "ambient/energy/zap3.wav", 100, 100 )
				owner:ViewPunch( Angle( math.Rand( -3, 3 ) * self.Primary.Recoil, math.Rand( -3, 3 ) * self.Primary.Recoil, 0) )
				
				hook.Run( "CH_AdvMedic_RevivePlayer", owner )
			end
		end
	else
		if SERVER then
			DarkRP.notify( owner, 1, 5, CH_AdvMedic.LangString( "Your defibrillator is not fully charged!" ) )
		end
	end
end

function SWEP:SecondaryAttack()
	self:SetNextPrimaryFire( CurTime() + CH_AdvMedic.Config.DefibrillatorDelay )
	self:SetNextSecondaryFire( CurTime() + CH_AdvMedic.Config.DefibrillatorDelay )
	
	local owner = self:GetOwner()
	
	if self:GetNWInt( "CH_AdvMedic_DefibCharge" ) >= 100 then
		if SERVER then
			DarkRP.notify( owner, 1, 5, CH_AdvMedic.LangString( "Your defibrillator is fully charged! It can be used to revive dead players now." ) )
		end
		return
	end

	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self:UpdateDefibCharge( false )
	
	timer.Simple( 1.2, function()
		if IsValid( self ) and IsValid( owner ) then
			if owner:GetActiveWeapon():GetClass() == "defibrillator_advanced" then
				self:SendWeaponAnim( ACT_IDLE )
			end
		end
	end )
end

function SWEP:UpdateDefibCharge( should_reset )
	local owner = self:GetOwner()
	
	if SERVER then
		if should_reset then
			self:SetNWInt( "CH_AdvMedic_DefibCharge", 0 )
			self:SetSkin( 0 )
			return
		end
		
		self:SetNWInt( "CH_AdvMedic_DefibCharge", self:GetNWInt( "CH_AdvMedic_DefibCharge" ) + CH_AdvMedic.Config.DefibUpdateCharge )
		
		if self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 25 then -- First level
			owner:EmitSound( "buttons/blip1.wav", 100, 100 )
			self:SetSkin( 1 )
		elseif self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 50 then -- Second level
			owner:EmitSound( "buttons/blip1.wav", 100, 100 )
			self:SetSkin( 2 )
		elseif self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 75 then -- Third level
			owner:EmitSound( "buttons/blip1.wav", 100, 100 )
			self:SetSkin( 3 )
		elseif self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 100 then -- Fourth level
			owner:EmitSound( "buttons/blip1.wav", 100, 100 )
			self:SetSkin( 4 )
		end
	end
	
	timer.Simple( 0.25, function()
		local vm = owner:GetViewModel()
		
		if should_reset then
			vm:SetSubMaterial( 1, nil )
			return
		end
		
		if self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 25 then -- First level
			vm:SetSubMaterial( 1, "models/craphead_scripts/paramedic_essentials/weapons/defib_scrn2" )
		elseif self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 50 then -- Second level
			vm:SetSubMaterial( 1, "models/craphead_scripts/paramedic_essentials/weapons/defib_scrn3" )
		elseif self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 75 then -- Third level
			vm:SetSubMaterial( 1, "models/craphead_scripts/paramedic_essentials/weapons/defib_scrn4" )
		elseif self:GetNWInt( "CH_AdvMedic_DefibCharge" ) == 100 then -- Fourth level
			vm:SetSubMaterial( 1, "models/craphead_scripts/paramedic_essentials/weapons/defib_scrn5" )
		end
	end )
end

local mat_crosshair = Material( "craphead_scripts/medic_ui/close.png" )

function SWEP:DoDrawCrosshair( x, y )
	local size = 16

	surface.SetDrawColor( color_white )
	surface.SetMaterial( mat_crosshair )
	surface.DrawTexturedRect( x, y, size, size )
	return true
end