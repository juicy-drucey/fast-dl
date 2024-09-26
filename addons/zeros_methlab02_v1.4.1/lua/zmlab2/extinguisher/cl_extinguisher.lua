/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

if not CLIENT then return end
zmlab2 = zmlab2 or {}
zmlab2.Extinguisher = zmlab2.Extinguisher or {}

net.Receive("zmlab2_Extinguisher_Use", function(len, ply)
    zclib.Debug_Net("zmlab2_Extinguisher_Use", len)
    local Tent = net.ReadEntity()
    if not IsValid(Tent) then return end
    //zmlab2.Extinguisher.EnablePointer(Machine)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    zclib.PointerSystem.Start(Tent,function()

        // OnInit
        zclib.PointerSystem.Data.MainColor = zmlab2.colors["blue01"]

        zclib.PointerSystem.Data.ActionName = zmlab2.language["Extinguish"]

    end,function()

        // OnLeftClick

        // Send the target to the SERVER
        net.Start("zmlab2_Extinguisher_Use")
        net.WriteEntity(zclib.PointerSystem.Data.Target)
        net.WriteEntity(Tent)
        net.SendToServer()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

        zclib.PointerSystem.Stop()
    end,function()

        // MainLogic

        // Catch the Target
        if IsValid(zclib.PointerSystem.Data.HitEntity) and zclib.PointerSystem.Data.HitEntity:GetClass() ~= "zmlab2_tent" then
            zclib.PointerSystem.Data.Target = zclib.PointerSystem.Data.HitEntity
        else
            zclib.PointerSystem.Data.Target = nil
        end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477

        // Update PreviewModel
        if IsValid(zclib.PointerSystem.Data.PreviewModel) then
            if IsValid(zclib.PointerSystem.Data.Target) then
                zclib.PointerSystem.Data.PreviewModel:SetColor(zclib.PointerSystem.Data.MainColor)
                zclib.PointerSystem.Data.PreviewModel:SetPos(zclib.PointerSystem.Data.Target:GetPos())
                zclib.PointerSystem.Data.PreviewModel:SetAngles(zclib.PointerSystem.Data.Target:GetAngles())
                zclib.PointerSystem.Data.PreviewModel:SetModel(zclib.PointerSystem.Data.Target:GetModel())
                zclib.PointerSystem.Data.PreviewModel:SetNoDraw(false)
            else
                zclib.PointerSystem.Data.PreviewModel:SetNoDraw(true)
            end
        end
    end)
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
