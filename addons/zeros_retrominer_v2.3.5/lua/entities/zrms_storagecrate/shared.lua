/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "Storage Crate"
ENT.Author = "ClemensProduction aka Zerochain"
ENT.Information = "info"
ENT.Category = "Zeros RetroMiningSystem"
ENT.Model = "models/Zerochain/props_mining/zrms_storagecrate.mdl"
ENT.AutomaticFrameAdvance = true
ENT.DisableDuplicator = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a6f74c3a898a8afac5e678d2e5f1471086507e768f0d31961c53cd0d44817e99

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "bIron")
	self:NetworkVar("Float", 1, "bBronze")
	self:NetworkVar("Float", 2, "bSilver")
	self:NetworkVar("Float", 3, "bGold")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	self:NetworkVar("Bool", 0, "IsClosed")

	if (SERVER) then
		self:SetbIron(0)
		self:SetbBronze(0)
		self:SetbSilver(0)
		self:SetbGold(0)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f1849cde4e345dc510f53fbc77f4b3d19e9f7ae22a9a6747c929a9ca610e07ca
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

		self:SetIsClosed(false)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a6f74c3a898a8afac5e678d2e5f1471086507e768f0d31961c53cd0d44817e99

function ENT:GetBarCount()
	return self:GetbIron() + self:GetbBronze() + self:GetbSilver() + self:GetbGold()
end
