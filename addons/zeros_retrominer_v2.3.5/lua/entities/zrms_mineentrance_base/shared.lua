/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "Mining Entrance"
ENT.Author = "ClemensProduction aka Zerochain"
ENT.Information = "info"
ENT.Category = "Zeros RetroMiningSystem"
ENT.Model = "models/zerochain/props_mining/mining_entrance.mdl"
ENT.AutomaticFrameAdvance = true
ENT.DisableDuplicator = false

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 1, "HideCart")
	self:NetworkVar("Bool", 0, "IsClosed")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	self:NetworkVar("Int", 0, "CurrentState")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	self:NetworkVar("String", 1, "MineResourceType")
	self:NetworkVar("Entity", 0, "ConnectedOre")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a6f74c3a898a8afac5e678d2e5f1471086507e768f0d31961c53cd0d44817e99

	self:NetworkVar("Float", 0, "MinningTime")
	self:NetworkVar("Float", 1, "StartMinningTime")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	if (SERVER) then
		self:SetIsClosed(true)
		self:SetHideCart(true)
		self:SetCurrentState(0)
		self:SetMineResourceType("Nothing")
		self:SetConnectedOre(nil)
		self:SetMinningTime(-1)
		self:SetStartMinningTime(-1)
	end
end
