/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	local ent = ents.Create(self.ClassName)
	if not IsValid(ent) then return end
	ent:SetPos(tr.HitPos + tr.HitNormal * 1)
	local angle = ply:GetAimVector():Angle()
	angle = Angle(0, angle.yaw, 0)
	angle:RotateAroundAxis(angle:Up(), 90)
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
	self:UseClientSideAnimation()
	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(true)
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 904975b3b3dbe3f4337208147d7caa58bdde3c3feca3828dba7cf4a7246a8723

	zmlab2.Table.Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477

function ENT:OnRemove()
	zmlab2.Table.OnRemove(self)
end

function ENT:StartTouch(other)
	timer.Simple(0,function()
		if IsValid(self) and IsValid(other) then
			zmlab2.Table.OnStartTouch(self, other)
		end
	end)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:AcceptInput(inputName, activator, caller, data)
	if inputName == "Use" and IsValid(activator) and activator:IsPlayer() and activator:Alive() then
		zmlab2.Table.OnUse(self, activator)
	end
end

function ENT:OnTakeDamage(dmginfo)
	zmlab2.Damage.OnTake(self, dmginfo)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
