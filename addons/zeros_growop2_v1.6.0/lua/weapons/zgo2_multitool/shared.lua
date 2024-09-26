/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

SWEP.PrintName = "Shop Tablet"
SWEP.Author = "ZeroChain"
SWEP.Instructions = ""
SWEP.Contact = ""
SWEP.Purpose = "Does a lot of things."
SWEP.AdminSpawnable = false
SWEP.Spawnable = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

SWEP.AutomaticFrameAdvance = true
SWEP.ViewModelFOV = 90
SWEP.ViewModel = "models/zerochain/props_growop2/zgo2_tablet_vm.mdl"
SWEP.WorldModel = "models/zerochain/props_growop2/zgo2_tablet.mdl"
SWEP.UseHands = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

//SWEP.AutoSwitchTo = false
//SWEP.AutoSwitchFrom = true
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.HoldType = "normal"
SWEP.FiresUnderwater = false
SWEP.Weight = 5
SWEP.DrawCrosshair = true
SWEP.Category = "Zeros GrowOP 2"
SWEP.DrawAmmo = false
SWEP.base = "weapon_base"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Recoil = 1
SWEP.Primary.Delay = 0.25

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Recoil = 1
SWEP.Secondary.Delay = 1
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("zerochain/zgo2/vgui/zgo2_multitool")
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
