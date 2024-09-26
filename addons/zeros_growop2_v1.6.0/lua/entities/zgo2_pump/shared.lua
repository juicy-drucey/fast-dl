/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

ENT.Type                    = "anim"
ENT.Base                    = "base_anim"
ENT.AutomaticFrameAdvance   = false
ENT.PrintName               = "Pump"
ENT.Author                  = "ZeroChain"
ENT.Category                = "Zeros GrowOP 2"
ENT.Spawnable               = true
ENT.AdminSpawnable          = false
ENT.Model                   = "models/zerochain/props_growop2/zgo2_pump.mdl"
ENT.RenderGroup             = RENDERGROUP_BOTH

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 1, "TurnedOn")
	self:NetworkVar("Int", 1, "Power")
	self:NetworkVar("Int", 2, "WaterTransferRate")
	if SERVER then
		self:SetTurnedOn(false)
		self:SetPower(0)
		self:SetWaterTransferRate(0)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:CanProperty(ply)
    return ply:IsSuperAdmin()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

function ENT:CanTool(ply, tab, str)
    return ply:IsSuperAdmin()
end

function ENT:CanDrive(ply)
    return false
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

ENT.SwitchPos = Vector(15.8, 5.3, 8.8)
function ENT:OnSwitch(ply)
    local trace = ply:GetEyeTrace()
	//debugoverlay.Sphere(self:LocalToWorld(lsw_vec),1,0.1,Color( 0, 255, 0 ),true)
    if zclib.util.InDistance(self:LocalToWorld(self.SwitchPos), trace.HitPos, 6) then
        return true
    else
        return false
    end
end

ENT.InputPos = Vector(7.6, -16, 5)
function ENT:OnConnect_Input(ply)
    local trace = ply:GetEyeTrace()
	//debugoverlay.Sphere(self:LocalToWorld(lsw_vec01),1,0.1,Color( 0, 255, 0 ),true)
    if zclib.util.InDistance(self:LocalToWorld(self.InputPos), trace.HitPos, 6) then
        return true
    else
        return false
    end
end

ENT.OutputPos = Vector(-9, 13.8, 20.3)
function ENT:OnConnect_Output(ply)
    local trace = ply:GetEyeTrace()
	//debugoverlay.Sphere(self:LocalToWorld(lsw_vec01),1,0.1,Color( 0, 255, 0 ),true)
    if zclib.util.InDistance(self:LocalToWorld(self.OutputPos), trace.HitPos, 6) then
        return true
    else
        return false
    end
end

/*
	How much power does this machine need
*/
function ENT:GetPowerNeed()
	return zgo2.config.Pump.PowerUsage
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
