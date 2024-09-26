/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

ENT.Type                    = "anim"
ENT.Base                    = "base_anim"
ENT.AutomaticFrameAdvance   = false
ENT.PrintName               = "Seed"
ENT.Author                  = "ZeroChain"
ENT.Category                = "Zeros GrowOP 2"
ENT.Spawnable               = false
ENT.AdminSpawnable          = false
ENT.Model                   = "models/zerochain/props_growop2/zgo2_weedseeds.mdl"
ENT.RenderGroup             = RENDERGROUP_BOTH
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

function ENT:SetupDataTables()

	// Id to the plant config
	self:NetworkVar("Int", 0, "PlantID")
	self:NetworkVar("Int", 1, "Count")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

	if (SERVER) then
		self:SetPlantID(0)
		self:SetCount(zgo2.config.Seedbox.Count)
	end
end

function ENT:CanProperty(ply)
    return ply:IsSuperAdmin()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:CanTool(ply, tab, str)
    return ply:IsSuperAdmin()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function ENT:CanDrive(ply)
    return false
end
