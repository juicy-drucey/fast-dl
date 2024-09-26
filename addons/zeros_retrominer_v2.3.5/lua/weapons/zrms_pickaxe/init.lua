/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("zrmine_config.lua")
SWEP.Weight = 5
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6

--SWEP:Initialize\\
--Tells the script what to do when the player "Initializes" the SWEP.
function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	zrmine.f.Pickaxe_Initialize(self)
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)

	// Updates the viewmodel skin
	zrmine.f.Pickaxe_UpdateVMSkin(self,self.Owner)
end

function SWEP:PrimaryAttack()
	if not IsValid(self.Owner) then return end
	zrmine.f.Pickaxe_Primary(self.Owner,self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90

function SWEP:SecondaryAttack()
	if not IsValid(self.Owner) then return end
	zrmine.f.Pickaxe_Secondary(self.Owner, self)
end

--Tells the script what to do when the player "Initializes" the SWEP.
function SWEP:Equip()
	self:SendWeaponAnim(ACT_VM_DRAW) -- View model animation
	self.Owner:SetAnimation(PLAYER_IDLE) -- 3rd Person Animation
	zrmine.f.Pickaxe_UpdateLvlVar(self,self.Owner)
end

function SWEP:Reload()
end

function SWEP:ShouldDropOnDie()
	return false
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
