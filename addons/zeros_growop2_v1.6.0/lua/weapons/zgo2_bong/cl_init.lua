/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

include("shared.lua")
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true -- Do you want the SWEP to have a crosshair?

function SWEP:Initialize()
	zgo2.Bong.Initialize(self)
end

function SWEP:DrawHUD()
	zgo2.Bong.DrawHUD(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function SWEP:Think()
	zgo2.Bong.Think(self)
	self:SetNextClientThink(CurTime() + 0.5)
	return true
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 1)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 1)
end

function SWEP:Holster()
	zgo2.Bong.Holster(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

function SWEP:Deploy()
	zgo2.Bong.Deploy(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function SWEP:OnRemove()
	zgo2.Bong.OnRemove(self)
end

function SWEP:PreDrawViewModel(vm, weapon, ply)
	zgo2.Bong.PreDrawViewModel(self,vm, weapon, ply)
end

function SWEP:DrawWorldModel(flags)
	local BongTypeData = zgo2.Bong.GetTypeData(self:GetBongID())
	self:SetModel(BongTypeData.wm)
	self:DrawModel( flags )
	zgo2.Bong.UpdateTexture(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function SWEP:DrawWorldModelTranslucent(flags)
	local BongTypeData = zgo2.Bong.GetTypeData(self:GetBongID())
	self:SetModel(BongTypeData.wm)
	self:DrawModel( flags )
	zgo2.Bong.UpdateTexture(self)
end
