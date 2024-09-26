/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2

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
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90

	return ent
end

function ENT:Initialize()
	self:SetModel(zrmine.config.MetalBuyer.model)
	self:SetSolid(SOLID_BBOX)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetHullType(HULL_HUMAN)
	self:SetUseType(SIMPLE_USE)
	self:SetMaxYawSpeed(90)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:CapabilitiesAdd(CAP_TURN_HEAD)
	self:DropToFloor()
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetUseType(SIMPLE_USE)

	timer.Simple(0.1, function()
		if not IsValid(self) then return end
		if not zrmine or not zrmine.f or not zrmine.f.BuyerNPC_Initialize then return end

		zrmine.f.BuyerNPC_Initialize(self)
	end)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function ENT:AcceptInput(key, ply)
	// Fixes the Xenin Pickup and Sell Exploit
	timer.Simple(0.2,function()
		if IsValid(self) and IsValid(ply) then
			zrmine.f.BuyerNPC_USE(self, ply, key)
		end
	end)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90
