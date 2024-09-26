/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "Melter"
ENT.Author = "ClemensProduction aka Zerochain"
ENT.Information = "info"
ENT.Category = "Zeros RetroMiningSystem"
ENT.Model = "models/zerochain/props_mining/zrms_melter.mdl"

ENT.AutomaticFrameAdvance = true
ENT.DisableDuplicator = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:SetupDataTables()

	self:NetworkVar("Float", 1, "CoalAmount")

	self:NetworkVar("Int", 0, "CurrentState")
	self:NetworkVar("Bool", 0, "IsLowered")

	self:NetworkVar("Float", 0, "ResourceAmount")
	self:NetworkVar("String", 1, "ResourceType")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821


	if (SERVER) then
		self:SetResourceAmount(0)
		self:SetCoalAmount(0)
		self:SetCurrentState(0)
		self:SetResourceType("Empty")
		self:SetIsLowered(false)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90
