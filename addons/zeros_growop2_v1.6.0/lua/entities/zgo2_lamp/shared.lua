/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

ENT.Type                    = "anim"
ENT.Base                    = "base_anim"
ENT.AutomaticFrameAdvance   = false
ENT.PrintName               = "Lamp"
ENT.Author                  = "ZeroChain"
ENT.Category                = "Zeros GrowOP 2"
ENT.Spawnable               = true
ENT.AdminSpawnable          = false
ENT.Model                   = "models/zerochain/props_growop2/zgo2_sodium_lamp01.mdl"
ENT.RenderGroup             = RENDERGROUP_BOTH
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

function ENT:OnLightSwitch(ply)
    local trace = ply:GetEyeTrace()

	local switch_vec , switch_ang = zgo2.Lamp.GetUI_Switch(self)

    if zclib.util.InDistance(self:LocalToWorld(switch_vec), trace.HitPos, 4) then
        return true
    else
        return false
    end
end

function ENT:OnColorChange(ply)
    local trace = ply:GetEyeTrace()

	local color_vec , color_ang = zgo2.Lamp.GetUI_Color(self)

    if zclib.util.InDistance(self:LocalToWorld(color_vec), trace.HitPos, 4) then
        return true
    else
        return false
    end
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Power")
	self:NetworkVar("Bool", 0, "LightSwitch")

	self:NetworkVar("Int", 1, "LampID")
	self:NetworkVar("Vector", 0, "LampColor")

	self:NetworkVarNotify("LampColor", self.UpdateLightColorVar)

	if SERVER then
		self:SetPower(0)
		self:SetLightSwitch(false)
		self:SetLampID(1)
		local col = Color(255,220,150)
		self:SetLampColor(Vector(col.r, col.g, col.b))
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:UpdateLightColorVar( name, old, new )
	if name == "LampColor" then
		zgo2.Lamp.UpdateLightColorVar(self,new)
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

/*
	How much power does this machine need
*/
function ENT:GetPowerNeed()
	return zgo2.Lamp.GetPowerUsage(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
