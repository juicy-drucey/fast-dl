/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Model = "models/zerochain/props_methlab/zmlab2_tentkit.mdl"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "Tent"
ENT.Category = "Zeros Methlab 2"
ENT.RenderGroup = RENDERGROUP_OPAQUE
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:SetupDataTables()

    self:NetworkVar("Int", 1, "BuildState")
    self:NetworkVar("Int", 2, "BuildCompletion")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    self:NetworkVar("Int", 3, "TentID")

    self:NetworkVar("Int", 4, "ColorID")

    self:NetworkVar("Bool", 1, "IsPublic")

    self:NetworkVar("Int", 5, "LastExtinguish")


    if (SERVER) then
        self:SetTentID(-1)
        self:SetColorID(1)
		// 1237229141
        // Unfolded
        self:SetBuildState(-1)
        self:SetBuildCompletion(-1)

        self:SetIsPublic(false)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a

        self:SetLastExtinguish(0)
    end
end

function ENT:OnControllPanel(ply)
    if self:GetAttachment(1) == nil then return false end
    local trace = ply:GetEyeTrace()

    if trace.HitPos:Distance(self:GetAttachment(1).Pos) < 5 then
        return true
    else
        return false
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:OnLightButton(ply)
    if self:GetAttachment(1) == nil then return false end
    local attach = self:GetAttachment(1)
    local trace = ply:GetEyeTrace()
    if zclib.util.InDistance(attach.Pos - attach.Ang:Forward() * 5, trace.HitPos, 2) then
        return true
    else
        return false
    end
end

function ENT:OnExtinquisher(ply)
    if self:GetAttachment(1) == nil then return false end
    local attach = self:GetAttachment(1)
    local trace = ply:GetEyeTrace()
    if zclib.util.InDistance(attach.Pos, trace.HitPos, 2) then
        return true
    else
        return false
    end
end

function ENT:OnFoldButton(ply)
    if self:GetAttachment(1) == nil then return false end
    local attach = self:GetAttachment(1)
    local trace = ply:GetEyeTrace()

    //debugoverlay.Sphere(attach.Pos - attach.Ang:Forward() * 5,2,0.1,Color( 255, 255, 255 ),true)

    if zclib.util.InDistance(attach.Pos + attach.Ang:Forward() * 5, trace.HitPos, 2) then
        return true
    else
        return false
    end
end

function ENT:CanProperty(ply)
    return zclib.Player.IsAdmin(ply)
end

function ENT:CanTool(ply, tab, str)
    return str == "colour" or zclib.Player.IsAdmin(ply)
end

function ENT:CanDrive(ply)
    return zclib.Player.IsAdmin(ply)
end
