/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName = "Fuel Buyer"
ENT.Category = "Zeros OilRush"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "Price_Mul")
	self:NetworkVar("String", 0, "NPCName")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2

	if (SERVER) then
		self:SetPrice_Mul(1)
		self:SetNPCName(zrush.config.FuelBuyer.names[math.random(#zrush.config.FuelBuyer.names)])
	end
end
