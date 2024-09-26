/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Model = "models/zerochain/props_methlab/zmlab2_mixer.mdl"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "Mixer"
ENT.Category = "Zeros Methlab 2"
ENT.RenderGroup = RENDERGROUP_OPAQUE

function ENT:SetupDataTables()
    self:NetworkVar("Int", 1, "ProcessState")
    /*
        0 = Needs Barrel
        1 = Needs Acid
        2 = Press the Start Mix Button
        3 = Add Aluminium
        4 = Press the Start Mix Button
        5 = Add Exhaust pipe
        6 = Moving Acid (Loading)
        7 = Needs to be cleaned
    */

    self:NetworkVar("Int", 2, "MethQuality")
    self:NetworkVar("Int", 3, "NeedAmount")

    self:NetworkVar("Int", 5, "ErrorStart")
    self:NetworkVar("Int", 6, "ProcessStart")

    self:NetworkVar("Int", 7, "MethType")

    if (SERVER) then
        self:SetProcessState(-1)

        self:SetMethQuality(0)
        self:SetNeedAmount(0)

        self:SetErrorStart(-1)
        self:SetProcessStart(-1)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575

        self:SetMethType(1)
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a

function ENT:OnStart(ply)
    local trace = ply:GetEyeTrace()
    local lp = self:WorldToLocal(trace.HitPos)
    if lp.x > -10 and lp.x < 0 and lp.y < 15 and lp.y > 10 and lp.z > 27 and lp.z < 31 then
        return true
    else
        return false
    end
end

function ENT:OnMethType(ply)
    local trace = ply:GetEyeTrace()
    local lp = self:WorldToLocal(trace.HitPos)
    if lp.x > -10 and lp.x < 0 and lp.y < 15 and lp.y > 10 and lp.z > 32 and lp.z < 37 then
        return true
    else
        return false
    end
end

function ENT:OnErrorButton(ply)
    local trace = ply:GetEyeTrace()
    local lp = self:WorldToLocal(trace.HitPos)
    if lp.x > -10 and lp.x < 0 and lp.y < 15 and lp.y > 10 and lp.z > 28 and lp.z < 33.6 then
        return true
    else
        return false
    end
end

function ENT:OnCenterButton(ply)
    local trace = ply:GetEyeTrace()
    local lp = self:WorldToLocal(trace.HitPos)

    if lp.x > -10 and lp.x < 0 and lp.y < 15 and lp.y > 10 and lp.z > 25 and lp.z < 38 then
        return true
    else
        return false
    end
end




// Tell us if you allow to receive liquid
function ENT:AllowConnection(From_ent)
    if From_ent:GetClass() == "zmlab2_machine_furnace" and From_ent:GetProcessState() == 4 and self:GetProcessState() == 1 then
        return true
    else
        return false
    end
end

// Returns the start position and direction for a hose
function ENT:GetHose_In()
    local attach = self:GetAttachment(1)
    if attach == nil then return self:GetPos(),self:GetAngles() end
    local ang = attach.Ang
    ang:RotateAroundAxis(ang:Right(),180)

    return attach.Pos,ang
end


// Returns the start position and direction for a hose
function ENT:GetHose_Out()
    local attach = self:GetAttachment(2)
    if attach == nil then return self:GetPos(),self:GetAngles() end
    return attach.Pos,attach.Ang
end


                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:CanProperty(ply)
    return zclib.Player.IsAdmin(ply)
end

function ENT:CanTool(ply, tab, str)
    return zclib.Player.IsAdmin(ply)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477

function ENT:CanDrive(ply)
    return zclib.Player.IsAdmin(ply)
end
