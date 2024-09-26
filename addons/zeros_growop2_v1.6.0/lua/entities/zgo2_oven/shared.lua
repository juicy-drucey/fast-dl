/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

ENT.Type                    = "anim"
ENT.Base                    = "base_anim"
ENT.AutomaticFrameAdvance   = true
ENT.PrintName               = "Oven"
ENT.Author                  = "ZeroChain"
ENT.Category                = "Zeros GrowOP 2"
ENT.Spawnable               = true
ENT.AdminSpawnable          = false
ENT.Model                   = "models/zerochain/props_growop2/zgo2_oven.mdl"
ENT.RenderGroup             = RENDERGROUP_BOTH

function ENT:SetupDataTables()

    self:NetworkVar("Bool", 0, "IsBaking")

	self:NetworkVar("Int", 1, "EdibleID")
	self:NetworkVar("Int", 2, "WeedID")

    if (SERVER) then
		self:SetEdibleID(0)
        self:SetIsBaking(false)
		self:SetWeedID(-1)
    end
end

function ENT:OnRemoveButton(ply)
    local trace = ply:GetEyeTrace()

    local lp = self:WorldToLocal(trace.HitPos)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    if lp.x > -8.5 and lp.x < 0 and lp.y < 12 and lp.y > 11 and lp.z > 14 and lp.z < 18 then
        return true
    else
        return false
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

function ENT:OnStartButton(ply)
    local trace = ply:GetEyeTrace()

    local lp = self:WorldToLocal(trace.HitPos)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

    if lp.x > 2.5 and lp.x < 8 and lp.y < 7 and lp.y > 6 and lp.z > 24.7 and lp.z < 27.2 then
        return true
    else
        return false
    end
end
