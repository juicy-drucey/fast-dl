/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 25
	local ent = ents.Create(self.ClassName)
	if not IsValid(ent) then return end
	ent:SetPos(SpawnPos)
	local angle = ply:GetAimVector():Angle()
	angle = Angle(0, angle.yaw, 0)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	ent:SetAngles(angle)
	ent:Spawn()
	ent:Activate()
	zclib.Player.SetOwner(ent, ply)
	return ent
end

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:UseClientSideAnimation()
	local phys = self:GetPhysicsObject()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(true)
	end
	zclib.EntityTracker.Add(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function ENT:OnRemove()
	zclib.EntityTracker.Remove(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
