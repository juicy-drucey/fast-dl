/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("zrmine_config.lua")

SWEP.Weight = 5

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self.LastSwitch = -1
	self.LastPrimary = -1
	self.LastSecondary = -1
end


// Build Entity
function SWEP:PrimaryAttack()
	if CurTime() < self.LastPrimary then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2

	zrmine.f.Swep_Primary(self.Owner,self)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f1849cde4e345dc510f53fbc77f4b3d19e9f7ae22a9a6747c929a9ca610e07ca

	self.LastPrimary = CurTime() + 0.5
end

// Deconstruct Entity
function SWEP:SecondaryAttack()
	if CurTime() < self.LastSecondary then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	zrmine.f.Swep_Secondary(self.Owner, self)

	self.LastSecondary = CurTime() + 0.5
end


function SWEP:Reload() end


function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
end

function SWEP:Equip()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self.Owner:SetAnimation(PLAYER_IDLE)
end

function SWEP:ShouldDropOnDie()
	return false
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
