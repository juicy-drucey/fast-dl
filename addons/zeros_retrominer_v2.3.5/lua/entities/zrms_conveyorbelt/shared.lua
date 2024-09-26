/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PrintName = "Conveyorbelt"
ENT.Author = "ClemensProduction aka Zerochain"
ENT.Information = "info"
ENT.Category = "Zeros RetroMiningSystem"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2

ENT.Model = "models/zerochain/props_mining/zrms_conveyorbelt.mdl"
ENT.GravelModel = "models/zerochain/props_mining/zrms_conveyorbelt_n_gravel.mdl"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6

ENT.GravelAnimTime = 6.6

ENT.AutomaticFrameAdvance = true
ENT.DisableDuplicator = false

ENT.TransportSpeed = 3
ENT.HoldAmount = zrmine.config.Belt_Capacity
ENT.TransportAmount = 5

function ENT:SetupDataTables()

	self:NetworkVar("Int", 0, "CurrentState")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	self:NetworkVar("Entity", 0, "ModuleChild")
	self:NetworkVar("Entity", 1, "ModuleParent")
	self:NetworkVar("Int", 2, "ConnectionPos")

	if (SERVER) then

		self:SetCurrentState(0)

		self:SetModuleChild(NULL)
		self:SetModuleParent(NULL)
		self:SetConnectionPos(-1)
	end


	self:NetworkVar("Float", 4, "Coal")
	self:NetworkVar("Float", 0, "Iron")
	self:NetworkVar("Float", 1, "Bronze")
	self:NetworkVar("Float", 2, "Silver")
	self:NetworkVar("Float", 3, "Gold")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	if SERVER then
		self:SetCoal(0)
		self:SetIron(0)
		self:SetBronze(0)
		self:SetSilver(0)
		self:SetGold(0)
	end

	// NW SETUP STUFF FOR GRAVEL ANIM
	zrmine.f.Gravel_SetupDataTables(self)
end
