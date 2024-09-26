/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

ENT.Type                    = "anim"
ENT.Base                    = "base_anim"
ENT.AutomaticFrameAdvance   = true
ENT.PrintName               = "Weed Packer"
ENT.Author                  = "ZeroChain"
ENT.Category                = "Zeros GrowOP 2"
ENT.Spawnable               = true
ENT.AdminSpawnable          = false
ENT.Model                   = "models/zerochain/props_growop2/zgo2_weedpacker.mdl"
ENT.RenderGroup             = RENDERGROUP_OPAQUE
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "WeedID")
	self:NetworkVar("Int", 1, "Progress")
	self:NetworkVar("Int", 2, "WeedAmount")

	if SERVER then
		self:SetWeedID(0)
		self:SetProgress(0)
		self:SetWeedAmount(0)
	end
end

function ENT:CanProperty(ply)
    return ply:IsSuperAdmin()
end

function ENT:CanTool(ply, tab, str)
    return ply:IsSuperAdmin()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

function ENT:CanDrive(ply)
    return false
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

function ENT:GravGunPickupAllowed( ply )
	return false
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

function ENT:GravGunPunt( ply )
	return false
end

local lsw_vec01 = Vector(16, 0, 21)
function ENT:OnDrop(ply)
    local trace = ply:GetEyeTrace()

	//debugoverlay.Sphere(self:LocalToWorld(lsw_vec01),1,0.1,Color( 0, 255, 0 ),true)

    if zclib.util.InDistance(self:LocalToWorld(lsw_vec01), trace.HitPos, 15) then
        return true
    else
        return false
    end
end
