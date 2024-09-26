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

	return ent
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	local phys = self:GetPhysicsObject()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(true)
	end

	if (zrmine.config.Resource_DespawnTime ~= 0 and zrmine.config.Resource_DespawnTime ~= -1) then

		timer.Simple(zrmine.config.Resource_DespawnTime, function()
			if (IsValid(self)) then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2

				self:SetNoDraw(true)
				local aphys = self:GetPhysicsObject()

				if (aphys:IsValid()) then
					aphys:Wake()
					aphys:EnableMotion(false)
				end

				timer.Simple(2, function()
					if (IsValid(self)) then
						SafeRemoveEntity( self )
					end
				end)
			end
		end)
	end
	timer.Simple(0, function()
		if IsValid(self) then
			local r_type = self:GetResourceType()
			if (r_type == "Iron") then
				self:SetSkin(0)
			elseif (r_type == "Bronze") then
				self:SetSkin(1)
			elseif (r_type == "Silver") then
				self:SetSkin(2)
			elseif (r_type == "Gold") then
				self:SetSkin(3)
			elseif (r_type == "Coal") then
				self:SetSkin(4)
			end
		end
	end)
end

function ENT:StartTouch(ent)
	if not IsValid(ent) then return end
	if zrmine.f.CollisionCooldown(ent) then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2

	if zrmine.config.SharedOwnership == false and zrmine.f.OwnerID_Check(self,ent) == false then return end

	if ent:GetClass() == "zrms_crusher" then
		zrmine.f.Crusher_AddResource_GRAVEL(ent,self)
	elseif (ent:GetClass() == "zrms_gravelcrate") then
		zrmine.f.Gravelcrate_ResourceJunk(ent,self)
	end
end
