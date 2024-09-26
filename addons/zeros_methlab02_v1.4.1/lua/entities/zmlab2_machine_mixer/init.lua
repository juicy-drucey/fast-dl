/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create(self.ClassName)
	if not IsValid(ent) then return end
	ent:SetPos(SpawnPos)
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
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 904975b3b3dbe3f4337208147d7caa58bdde3c3feca3828dba7cf4a7246a8723

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(true)
	end
	zmlab2.Mixer.Initialize(self)
end

function ENT:OnRemove()
	zmlab2.Mixer.OnRemove(self)
end

function ENT:StartTouch(other)
	zmlab2.Mixer.OnStartTouch(self, other)
end

function ENT:AcceptInput(inputName, activator, caller, data)
	if inputName == "Use" and IsValid(activator) and activator:IsPlayer() and activator:Alive() then
		zmlab2.Mixer.OnUse(self,activator)
	end
end

function ENT:OnTakeDamage(dmginfo)
	zmlab2.Damage.OnTake(self, dmginfo)
end

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 904975b3b3dbe3f4337208147d7caa58bdde3c3feca3828dba7cf4a7246a8723

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821


/////////////////////////////////////////////////////////////////
/////////////////// PUMPING SYSTEM //////////////////////////////
/////////////////////////////////////////////////////////////////
// Get called when the Pumping System started unloading this Machine
function ENT:Unloading_Started()
	zmlab2.Mixer.Unloading_Started(self)
end

// Get called when the Pumping System finished unloading this Machine
function ENT:Unloading_Finished()
	zmlab2.Mixer.Unloading_Finished(self)
end

// Get called when the Pumping System started loading this Machine
function ENT:Loading_Started()
	zmlab2.Mixer.Loading_Started(self)
end

// Get called when the Pumping System finished loading this Machine
function ENT:Loading_Finished(From)
	zmlab2.Mixer.Loading_Finished(self,From)
end
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////
//////////////////// MINIGAME ///////////////////////////////////
/////////////////////////////////////////////////////////////////
function ENT:OnMiniGameComplete(Result)
	zmlab2.Mixer.MiniGame_Completed(self,Result)
end
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
