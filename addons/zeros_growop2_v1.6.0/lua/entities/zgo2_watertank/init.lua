/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 5
	local ang = (ply:GetPos() - SpawnPos):Angle()
	ang = Angle(0, 180 + ang.y, 0)
	local ent = ents.Create(self.ClassName)
	ent:SetPos(SpawnPos)
	ent:SetAngles(ang)
	ent:Spawn()
	ent:Activate()
	zclib.Player.SetOwner(ent, ply)

	return ent
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

function ENT:Initialize()
	zgo2.Destruction.SetupHealth(self)
	zgo2.Watertank.Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:AcceptInput(inputName, activator, caller, data)
	if inputName == "Use" and IsValid(activator) and activator:IsPlayer() and activator:Alive() then
		zgo2.Watertank.OnUse(self, activator)
	end
end

function ENT:OnTakeDamage(dmginfo)
	-- Make sure we're not already applying damage a second time
	-- This prevents infinite loops
	if not self.m_bApplyingDamage then
		self.m_bApplyingDamage = true
		self:TakeDamageInfo(dmginfo)
		zgo2.Destruction.OnDamaged(self, dmginfo)
		self.m_bApplyingDamage = false
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b
