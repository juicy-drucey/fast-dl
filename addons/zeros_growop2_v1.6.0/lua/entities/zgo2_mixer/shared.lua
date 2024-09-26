/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

ENT.Type                    = "anim"
ENT.Base                    = "base_anim"
ENT.AutomaticFrameAdvance   = true
ENT.PrintName               = "Mixer"
ENT.Author                  = "ZeroChain"
ENT.Category                = "Zeros GrowOP 2"
ENT.Spawnable               = true
ENT.AdminSpawnable          = false
ENT.Model                   = "models/zerochain/props_growop2/zgo2_mixer.mdl"
ENT.RenderGroup             = RENDERGROUP_OPAQUE
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "HasBowl")
    self:NetworkVar("Bool", 1, "HasDough")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

    self:NetworkVar("Int", 0, "WeedID")
    self:NetworkVar("Int", 1, "WeedAmount")
    self:NetworkVar("Int", 2, "WeedTHC")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

    // 0 = idle, 1 = open , 2 = close , 3 = run
    self:NetworkVar("Int", 3, "WorkState")

	self:NetworkVar("Int", 4, "EdibleID")

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

    if (SERVER) then
		self:SetEdibleID(0)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

        self:SetWorkState(0)
        self:SetHasBowl(true)
        self:SetHasDough(false)

        self:SetWeedID(-1)
        self:SetWeedAmount(0)
        self:SetWeedTHC(0)
    end
end

function ENT:OnRemoveButton(ply)
    local trace = ply:GetEyeTrace()

    local lp = self:WorldToLocal(trace.HitPos)

    if lp.x > -12 and lp.x < 4 and lp.y < 12 and lp.y > 11 and lp.z > 9 and lp.z < 20 then
        return true
    else
        return false
    end
end
