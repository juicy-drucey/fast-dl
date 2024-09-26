/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "Buyer NPC"
ENT.Author = "ClemensProduction aka Zerochain"
ENT.Information = "info"
ENT.Category = "Zeros RetroMiningSystem"
ENT.AutomaticFrameAdvance = true
ENT.DisableDuplicator = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "BuyRate")
	self:NetworkVar("Int", 1, "CurrentState")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a6f74c3a898a8afac5e678d2e5f1471086507e768f0d31961c53cd0d44817e99
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	if (SERVER) then
		self:SetBuyRate(100)
		self:SetCurrentState(0)
	end
end
