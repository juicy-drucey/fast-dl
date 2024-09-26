/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PrintName = "DrillHole"
ENT.Author = "ClemensProduction aka Zerochain"
ENT.Information = "info"
ENT.Category = "Zeros OilRush"
ENT.Model = "models/zerochain/props_oilrush/zor_drillhole.mdl"
ENT.AutomaticFrameAdvance = true
function ENT:CanProperty(ply)
    return ply:IsSuperAdmin()
end

function ENT:CanTool(ply, tab, str)
    return ply:IsSuperAdmin()
end

function ENT:CanDrive(ply)
    return false
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Pipes")
	self:NetworkVar("Int", 1, "State")
	self:NetworkVar("Int", 2, "HoleType")
	self:NetworkVar("Int", 3, "Gas")
	self:NetworkVar("Int", 4, "OilAmount")
	self:NetworkVar("Int", 5, "NeededPipes")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

	self:NetworkVar("Float", 5, "ChaosEventBoost")

	if SERVER then
		self:SetPipes(0)
		self:SetState(-1)
		self:SetHoleType(-1)
		self:SetGas(-1)
		self:SetOilAmount(0)
		self:SetNeededPipes(0)

		self:SetChaosEventBoost(0)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

function ENT:HasBurner()
	if IsValid(self:GetParent()) and self:GetParent():GetClass() == "zrush_burner" then
		return true
	else
		return false
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22

function ENT:HasPump()
	if IsValid(self:GetParent()) and self:GetParent():GetClass() == "zrush_pump" then
		return true
	else
		return false
	end
end

function ENT:HasDrill()
	if IsValid(self:GetParent()) and self:GetParent():GetClass() == "zrush_drilltower" then
		return true
	else
		return false
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2
