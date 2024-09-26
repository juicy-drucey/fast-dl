/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

include("shared.lua")
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

function SWEP:Initialize()
	zgo2.Joint.Initialize(self)
end

function SWEP:DrawHUD()
	zgo2.Joint.DrawHUD(self)
end

function SWEP:Think()
	zgo2.Joint.Think(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 1)
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 1)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function SWEP:Holster()
	zgo2.Joint.Holster(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function SWEP:OnRemove()
	zgo2.Joint.OnRemove(self)
end
