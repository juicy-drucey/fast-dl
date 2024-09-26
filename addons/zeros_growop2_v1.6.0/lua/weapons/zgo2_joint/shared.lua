/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

SWEP.PrintName = "Joint" // The name of your SWEP
SWEP.Author = "ZeroChain" // Your name
SWEP.Instructions = "Hold LMB: Smoke Weed | Reload: Delete Joint | MMB: Drop / Share" // How do people use your SWEP?
SWEP.Contact = "https://www.gmodstore.com/users/76561198013322242" // How people should contact you if they find bugs, errors, etc
SWEP.Purpose = "Used to smoke weed." // What is the purpose of the SWEP?
SWEP.IconLetter	= "V"

SWEP.AutomaticFrameAdvance = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

SWEP.AdminSpawnable = false // Is the SWEP spawnable for admins?
SWEP.Spawnable = false // Can everybody spawn this SWEP? - If you want only admins to spawn it, keep this false and admin spawnable true.

SWEP.ViewModelFOV = 90 // How much of the weapon do you see?
SWEP.UseHands = true
SWEP.ViewModel = "models/zerochain/props_growop2/zgo2_joint_vm.mdl"
SWEP.WorldModel = "models/zerochain/props_growop2/zgo2_joint_wm.mdl"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb


SWEP.AutoSwitchTo = true // When someone picks up the SWEP, should it automatically change to your SWEP?
SWEP.AutoSwitchFrom = false // Should the weapon change to the a different SWEP if another SWEP is picked up?
SWEP.Slot = 3 // Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6)
SWEP.SlotPos = 1 // Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.HoldType = "slam" // How is the SWEP held? (Pistol SMG Grenade Melee)
SWEP.FiresUnderwater = false // Does your SWEP fire under water?
SWEP.Weight = 5 // Set the weight of your SWEP.
SWEP.DrawCrosshair = true // Do you want the SWEP to have a crosshair?
SWEP.Category = "Zeros GrowOP"
SWEP.DrawAmmo = false // Does the ammo show up when you are using it? True / False
SWEP.base = "weapon_base" //What your weapon is based on.

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.Recoil = 1
SWEP.Primary.Delay = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Recoil = 1
SWEP.Secondary.Delay = 1
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

function SWEP:SetWeedID() end
function SWEP:GetWeedID() end

function SWEP:SetWeedTHC() end
function SWEP:GetWeedTHC() end

function SWEP:SetWeedAmount() end
function SWEP:GetWeedAmount() end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

function SWEP:SetupDataTables()
    self:NetworkVar("Int", 1, "WeedID")
    self:NetworkVar("Int", 2, "WeedTHC")
    self:NetworkVar("Int", 3, "WeedAmount")
    self:NetworkVar("Bool", 0, "IsBusy")
    self:NetworkVar("Bool", 2, "IsBurning")
    self:NetworkVar("Bool", 3, "IsSmoking")

    if (SERVER) then
        self:SetWeedID(-1)
        self:SetWeedTHC(-1)
        self:SetWeedAmount(0)

        self:SetIsBurning(false)
        self:SetIsBusy(false)
        self:SetIsSmoking(false)
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
