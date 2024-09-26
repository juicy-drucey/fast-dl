/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = false
ENT.AdminSpawnable = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2

ENT.PrintName = "Ore - Random"
ENT.Author = "ClemensProduction aka Zerochain"
ENT.Information = "info"
ENT.Category = "Zeros RetroMiningSystem"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

ENT.Model = "models/zerochain/props_mining/zrms_resource_point.mdl"

ENT.DisableDuplicator = false

function ENT:SetupDataTables()
	self:NetworkVar("Float", 1, "Max_ResourceAmount")
	self:NetworkVar("Float", 0, "ResourceAmount")
	self:NetworkVar("String", 0, "ResourceType")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f1849cde4e345dc510f53fbc77f4b3d19e9f7ae22a9a6747c929a9ca610e07ca
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6

	if (SERVER) then
		self:SetResourceType("Random")
		self:SetResourceAmount(1000)
		self:SetMax_ResourceAmount(-1)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
