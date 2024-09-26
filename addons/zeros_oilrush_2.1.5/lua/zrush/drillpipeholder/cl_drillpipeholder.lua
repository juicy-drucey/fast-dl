/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

if (not CLIENT) then return end
zrush = zrush or {}
zrush.DrillpipeHolder = zrush.DrillpipeHolder or {}

function zrush.DrillpipeHolder.Initialize(DrillpipeHolder)
    DrillpipeHolder.ClientPipesRebuild = false
    zclib.EntityTracker.Add(DrillpipeHolder)
end

function zrush.DrillpipeHolder.OnRemove(DrillpipeHolder)
    zrush.DrillpipeHolder.RemovePipes(DrillpipeHolder)
    zclib.EntityTracker.Remove(DrillpipeHolder)
end

function zrush.DrillpipeHolder.Think(DrillpipeHolder)
    if zclib.util.InDistance(LocalPlayer():GetPos(), DrillpipeHolder:GetPos(), 1000) then
        if ((DrillpipeHolder.LastPipeCount or 0) ~= DrillpipeHolder:GetPipeCount()) or DrillpipeHolder.ClientPipesRebuild == false then
            zrush.DrillpipeHolder.RebuildPipes(DrillpipeHolder)
            DrillpipeHolder.LastPipeCount = DrillpipeHolder:GetPipeCount()
        end
    else
        zrush.DrillpipeHolder.RemovePipes(DrillpipeHolder)
        DrillpipeHolder.ClientPipesRebuild = false
    end
end

function zrush.DrillpipeHolder.RemovePipes(DrillpipeHolder)
    if DrillpipeHolder.Pipes == nil then DrillpipeHolder.Pipes = {} end
    for k, pipe in pairs(DrillpipeHolder.Pipes) do
        if IsValid(pipe) then
            zclib.ClientModel.Remove(pipe)
        end
    end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

    DrillpipeHolder.Pipes = {}
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2

function zrush.DrillpipeHolder.RebuildPipes(DrillpipeHolder)
    zrush.DrillpipeHolder.RemovePipes(DrillpipeHolder)

    for i = 1, DrillpipeHolder:GetPipeCount() do
        local attach = DrillpipeHolder:GetAttachment(i)

        if (attach) then
            local pipe = zclib.ClientModel.AddProp()

            if (IsValid(pipe)) then
                pipe:SetPos(attach.Pos)
                pipe:SetModel("models/zerochain/props_oilrush/zor_drillpipe.mdl")
                local ang = attach.Ang
                ang:RotateAroundAxis(DrillpipeHolder:GetForward(), 90)
                ang:RotateAroundAxis(DrillpipeHolder:GetRight(), 90)
                pipe:SetAngles(ang)
                pipe:Spawn()
                pipe:Activate()
                pipe:SetRenderMode(RENDERMODE_NORMAL)
                pipe:SetParent(DrillpipeHolder)
                table.insert(DrillpipeHolder.Pipes, pipe)
            end
        end
    end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

    DrillpipeHolder.ClientPipesRebuild = true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
