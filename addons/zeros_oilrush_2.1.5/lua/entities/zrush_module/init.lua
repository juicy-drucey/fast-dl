/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (not tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 30
	local ent = ents.Create(self.ClassName)
	local angle = ply:GetAimVector():Angle()
	angle = Angle(0, angle.yaw, 0)
	angle:RotateAroundAxis(angle:Up(), 180)
	ent:SetAngles(angle)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2

	return ent
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:UseClientSideAnimation()
end
