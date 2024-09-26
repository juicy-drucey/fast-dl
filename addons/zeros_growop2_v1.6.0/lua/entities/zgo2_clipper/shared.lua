/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

ENT.Type                    = "anim"
ENT.Base                    = "base_anim"
ENT.AutomaticFrameAdvance   = true
ENT.PrintName               = "Clipper"
ENT.Author                  = "ZeroChain"
ENT.Category                = "Zeros GrowOP 2"
ENT.Spawnable               = true
ENT.AdminSpawnable          = false
ENT.Model                   = "models/zerochain/props_growop2/zgo2_weedcruncher.mdl"
ENT.RenderGroup             = RENDERGROUP_OPAQUE

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "WeedID")
	self:NetworkVar("Int", 1, "Progress")
	self:NetworkVar("Int", 2, "WeedAmount")
	self:NetworkVar("Int", 3, "StickCount")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

	self:NetworkVar("Bool", 1, "Spin")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

	self:NetworkVar("Bool", 2, "HasMotor")
	self:NetworkVar("Bool", 3, "MotorSwitch")

	self:NetworkVar("Int", 4, "Power")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	if SERVER then
		self:SetWeedID(0)
		self:SetSpin(false)
		self:SetProgress(0)
		self:SetWeedAmount(0)
		self:SetStickCount(0)
		self:SetHasMotor(false)
		self:SetPower(0)
		self:SetMotorSwitch(false)
	end
end

function ENT:CanProperty(ply)
    return ply:IsSuperAdmin()
end

function ENT:CanTool(ply, tab, str)
    return ply:IsSuperAdmin()
end

function ENT:CanDrive(ply)
    return false
end

function ENT:GravGunPickupAllowed( ply )
	return false
end

function ENT:GravGunPunt( ply )
	return false
end

local vec02 = Vector(4.2,-15,31.7)
function ENT:OnMotorSwitch(ply)
    local trace = ply:GetEyeTrace()
    if zclib.util.InDistance(self:LocalToWorld(vec02), trace.HitPos, 4) then
        return true
    else
        return false
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

/*
	How much power does this machine need
*/
function ENT:GetPowerNeed()
	return zgo2.config.Clipper.PowerUsage
end
