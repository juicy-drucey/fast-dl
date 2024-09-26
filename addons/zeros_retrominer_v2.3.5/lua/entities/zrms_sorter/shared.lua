/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PrintName = "Conveyorbelt - Filter"
ENT.Author = "ClemensProduction aka Zerochain"
ENT.Information = "info"
ENT.Category = "Zeros RetroMiningSystem"

ENT.Model = "models/zerochain/props_mining/zrms_conveyorbelt_sorter.mdl"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

ENT.AutomaticFrameAdvance = true
ENT.DisableDuplicator = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

ENT.SorterSpeed = 3
ENT.WorkAmount = 6
ENT.HoldAmount = 25
ENT.FilterType = "Coal" // What type of resource are we sorting out
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f1849cde4e345dc510f53fbc77f4b3d19e9f7ae22a9a6747c929a9ca610e07ca

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "CurrentState")
	self:NetworkVar("Entity", 0, "ModuleChild01")
	self:NetworkVar("Entity", 1, "ModuleChild02")
	self:NetworkVar("Entity", 2, "ModuleParent")
	self:NetworkVar("Int", 2, "ConnectionPos")

	if (SERVER) then
		self:SetModuleChild01(NULL)
		self:SetModuleChild02(NULL)
		self:SetModuleParent(NULL)
		self:SetConnectionPos(-1)
		self:SetCurrentState(0)
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	self:NetworkVar("Float", 4, "Coal")
	self:NetworkVar("Float", 0, "Iron")
	self:NetworkVar("Float", 1, "Bronze")
	self:NetworkVar("Float", 2, "Silver")
	self:NetworkVar("Float", 3, "Gold")

	if SERVER then
		self:SetCoal(0)
		self:SetIron(0)
		self:SetBronze(0)
		self:SetSilver(0)
		self:SetGold(0)
	end
end
