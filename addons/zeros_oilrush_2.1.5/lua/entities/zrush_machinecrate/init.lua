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
	ent:SetAngles(angle)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	zclib.Player.SetOwner(ent, ply)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

	return ent
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:Initialize()
	zrush.Machinecrate.Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225

function ENT:AcceptInput(key, ply)
	if ((self.lastUsed or CurTime()) <= CurTime()) and (key == "Use" and IsValid(ply) and ply:IsPlayer() and ply:Alive()) then
		self.lastUsed = CurTime() + 0.25
		zrush.Machinecrate.OnUse(self, ply)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354
