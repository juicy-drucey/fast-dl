/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

include("zrmine_config.lua")

SWEP.PrintName = "Builder" // The name of your SWEP
SWEP.Author = "ZeroChain" // Your name
SWEP.Instructions = "LMB - Build | RMB - Deconstruct | Reload - Switch Item" // How do people use your SWEP?
SWEP.Contact = "https://www.gmodstore.com/users/ZeroChain" // How people should contact you if they find bugs, errors, etc
SWEP.Purpose = "Used for Constructing a Pipeline." // What is the purpose of the SWEP?
SWEP.AdminSpawnable = true // Is the SWEP spawnable for admins?
SWEP.Spawnable = true // Can everybody spawn this SWEP? - If you want only admins to spawn it, keep this false and admin spawnable true.
SWEP.ViewModelFOV = 55 // How much of the weapon do you see?
--SWEP.ViewModel = "models/weapons/v_slam.mdl"
--SWEP.WorldModel = "models/weapons/c_slam.mdl"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90

SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

SWEP.AutoSwitchTo = false // When someone picks up the SWEP, should it automatically change to your SWEP?
SWEP.AutoSwitchFrom = true // Should the weapon change to the a different SWEP if another SWEP is picked up?
SWEP.Slot = 1 // Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6)
SWEP.SlotPos = 1 // Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.HoldType = "slam" // How is the SWEP held? (Pistol SMG Grenade Melee)
SWEP.FiresUnderwater = false // Does your SWEP fire under water?
SWEP.Weight = 5 // Set the weight of your SWEP.
SWEP.DrawCrosshair = true // Do you want the SWEP to have a crosshair?
SWEP.Category = "Zeros RetroMiningSystem"
SWEP.DrawAmmo = false // Does the ammo show up when you are using it? True / False
SWEP.base = "weapon_base" //What your weapon is based on.
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Recoil = 1
SWEP.Primary.Delay = 1
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Recoil = 1
SWEP.Secondary.Delay = 0.01
SWEP.UseHands = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "ItemSelected")
	self:NetworkVar("Int", 1, "ItemRotation")
	if (SERVER) then
		self:SetItemSelected(1)
		self:SetItemRotation(0)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
