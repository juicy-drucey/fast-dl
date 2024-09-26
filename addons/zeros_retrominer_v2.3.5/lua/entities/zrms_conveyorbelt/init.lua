/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (not tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create(self.ClassName)
	local angle = ply:GetAimVector():Angle()
	angle = Angle(0, angle.yaw, 0)
	angle:RotateAroundAxis(angle:Up(), -90)
	ent:SetAngles(angle)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	zrmine.f.SetOwner(ent, ply)

	return ent
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(true)
		phys:EnableDrag(true)
		phys:SetDragCoefficient(1)
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	self.PhysgunDisabled = false
	self:UseClientSideAnimation()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	zrmine.f.Belt_Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2

// Main function
function ENT:Think()
	if (self.FullInitialized == false) then return end

	if ((self.lastthink or -1) < CurTime()) then
		self.lastthink = CurTime() + 1
		zrmine.f.Belt_ModuleUpdate(self)
	end
end

// Damage Stuff
function ENT:OnTakeDamage(dmg)
	zrmine.f.Belt_OnTakeDamage(self,dmg)
end
