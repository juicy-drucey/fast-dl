/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.PrintName = "Refiner"
ENT.Author = "ClemensProduction aka Zerochain"
ENT.Information = "info"
ENT.Category = "Zeros RetroMiningSystem"

ENT.Model = "models/zerochain/props_mining/zrms_refiner.mdl"
ENT.GravelModel = "models/zerochain/props_mining/zrms_crushedgravel01.mdl"

ENT.AutomaticFrameAdvance = true
ENT.DisableDuplicator = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a6f74c3a898a8afac5e678d2e5f1471086507e768f0d31961c53cd0d44817e99

ENT.RefinerType = "Iron"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

ENT.WorkAmount = 5
ENT.RefineAmount = zrmine.config.RefiningAmount
ENT.RefiningTime = zrmine.config.Iron_RefiningTime
ENT.HoldAmount = zrmine.config.Refiner_Capacity

function ENT:SetupDataTables()

	self:NetworkVar("Entity", 1, "Basket")

	self:NetworkVar("Int", 0, "CurrentState")
	self:NetworkVar("Entity", 0, "ModuleChild")
	self:NetworkVar("Entity", 2, "ModuleParent")
	self:NetworkVar("Int", 2, "ConnectionPos")

	if (SERVER) then
		self:SetBasket(NULL)

		self:SetModuleChild(NULL)
		self:SetModuleParent(NULL)
		self:SetConnectionPos(-1)
		self:SetCurrentState(0)
	end

	self:NetworkVar("Float", 4, "Coal")
	self:NetworkVar("Float", 0, "Iron")
	self:NetworkVar("Float", 1, "Bronze")
	self:NetworkVar("Float", 2, "Silver")
	self:NetworkVar("Float", 3, "Gold")
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

	self:NetworkVar("Int", 10, "RefineAnim_Type")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f1849cde4e345dc510f53fbc77f4b3d19e9f7ae22a9a6747c929a9ca610e07ca

	if (SERVER) then
		self:SetRefineAnim_Type(-1)
	end
end
