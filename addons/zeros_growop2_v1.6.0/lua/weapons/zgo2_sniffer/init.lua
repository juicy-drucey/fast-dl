/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

SWEP.Weight = 5

function SWEP:PrimaryAttack()
	zgo2.Sniffer.Primary(self:GetOwner())
	self:SetNextPrimaryFire(CurTime() + zgo2.config.Sniffer.interval)
	self:SetNextSecondaryFire(CurTime() + zgo2.config.Sniffer.interval)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function SWEP:SecondaryAttack()
	zgo2.Sniffer.Primary(self:GetOwner())
	self:SetNextPrimaryFire(CurTime() + zgo2.config.Sniffer.interval)
	self:SetNextSecondaryFire(CurTime() + zgo2.config.Sniffer.interval)
end

function SWEP:Reload()
end

function SWEP:Deploy()
	self:SetHoldType("normal")
	self:GetOwner():SetAnimation(PLAYER_IDLE)
	return true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function SWEP:ShouldDropOnDie()
	return false
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
