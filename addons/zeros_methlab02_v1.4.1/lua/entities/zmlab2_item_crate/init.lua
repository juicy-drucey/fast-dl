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
	ent:SetAngles(angle)
	ent:Spawn()
	ent:Activate()
	zclib.Player.SetOwner(ent, ply)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575

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
	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(true)
	end

	zmlab2.Crate.Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function ENT:OnRemove()
	zmlab2.Crate.OnRemove(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:StartTouch(other)
	zmlab2.Crate.OnStartTouch(self, other)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function ENT:AcceptInput(inputName, activator, caller, data)
	if inputName == "Use" and IsValid(activator) and activator:IsPlayer() and activator:Alive() then
		zmlab2.Crate.OnUse(self,activator)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function ENT:OnTakeDamage(dmginfo)
	zmlab2.Damage.OnTake(self, dmginfo)
end
