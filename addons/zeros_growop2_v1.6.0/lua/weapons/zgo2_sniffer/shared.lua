/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.PrintName = "Illegal product Sniffer" -- The name of your SWEP
SWEP.Author = "ZeroChain" -- Your name
SWEP.Instructions = "LMB - Sniff for weed." -- How do people use your SWEP?
SWEP.Contact = "https://www.gmodstore.com/users/76561198013322242" -- How people should contact you if they find bugs, errors, etc
SWEP.Purpose = "Detects illegal activity." -- What is the purpose of the SWEP?
SWEP.AdminSpawnable = true -- Is the SWEP spawnable for admins?
SWEP.Spawnable = true -- Can everybody spawn this SWEP? - If you want only admins to spawn it, keep this false and admin spawnable true.
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "rpg"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("zerochain/zgo2/vgui/zgo2_sniffer")
end

SWEP.AutoSwitchTo = true -- When someone picks up the SWEP, should it automatically change to your SWEP?
SWEP.AutoSwitchFrom = false -- Should the weapon change to the a different SWEP if another SWEP is picked up?
SWEP.Slot = 3 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6)
SWEP.SlotPos = 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.FiresUnderwater = false -- Does your SWEP fire under water?
SWEP.Weight = 5 -- Set the weight of your SWEP.
SWEP.DrawCrosshair = true -- Do you want the SWEP to have a crosshair?
SWEP.Category = "Zeros GrowOP 2"
SWEP.DrawAmmo = false -- Does the ammo show up when you are using it? True / False
SWEP.base = "weapon_base" --What your weapon is based on.
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.UseHands = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

function SWEP:DrawWorldModel()
end

function SWEP:PreDrawViewModel(vm)
	return true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function SWEP:Holster()
	if not SERVER then return true end
	self:GetOwner():DrawViewModel(true)
	self:GetOwner():DrawWorldModel(true)

	return true
end
