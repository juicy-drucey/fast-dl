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
	angle:RotateAroundAxis(angle:Up(), 180)
	ent:SetAngles(angle)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	zrmine.f.SetOwner(ent, ply)
	return ent
end

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetCustomCollisionCheck(true)

	local phys = self:GetPhysicsObject()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(true)
	end

	self:UpdateVisuals()
	self.zrms_added = false
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f1849cde4e345dc510f53fbc77f4b3d19e9f7ae22a9a6747c929a9ca610e07ca

function ENT:AcceptInput(key, ply)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a6f74c3a898a8afac5e678d2e5f1471086507e768f0d31961c53cd0d44817e99
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2

	if ((self.lastUsed or CurTime()) <= CurTime()) and (key == "Use" and IsValid(ply) and ply:IsPlayer() and ply:Alive()) then
		self.lastUsed = CurTime() + 0.25

		if (zrmine.f.Player_IsMiner(ply) and zrmine.f.CanSteal(ply,self)) then
			ply:zrms_AddMetalBar(self:GetMetalType(), 1)

			zrmine.f.Notify(ply, "+" .. zrmine.f.GetOreTranslation(self:GetMetalType()) .. " Bar", 0)
			self:Remove()
		else
			zrmine.f.Notify(ply, zrmine.language.WrongJob, 1)
		end
	end
end

function ENT:UpdateVisuals()
	local btype = self:GetMetalType()

	if (btype == "Iron") then
		self:SetSkin(0)
	elseif (btype == "Bronze") then
		self:SetSkin(1)
	elseif (btype == "Silver") then
		self:SetSkin(2)
	elseif (btype == "Gold") then
		self:SetSkin(3)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6
