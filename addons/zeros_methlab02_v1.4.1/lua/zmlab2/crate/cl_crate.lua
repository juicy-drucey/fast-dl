/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

if not CLIENT then return end
zmlab2 = zmlab2 or {}
zmlab2.Crate = zmlab2.Crate or {}

function zmlab2.Crate.Initialize(Crate)
    timer.Simple(0.1,function()
        if not IsValid(Crate) then return end
        Crate.Initialized = true
    end)
end

function zmlab2.Crate.Draw(Crate)

    if Crate.Initialized and zclib.util.InDistance(Crate:GetPos(), LocalPlayer():GetPos(), 500) then

        if zclib.Convar.Get("zmlab2_cl_drawui") == 1 then zmlab2.Meth.DrawHUD(Crate:GetPos() + Vector(0,0,25),0.1,Crate:GetMethType(),Crate:GetMethAmount(),Crate:GetMethQuality()) end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

        if Crate:GetMethAmount() ~= Crate.CurMethAmount then
            Crate.CurMethAmount = Crate:GetMethAmount()
            zmlab2.Crate.UpdateMethMaterial(Crate)
        end

        // Update the material once it gets drawn
        if Crate.LastDraw and CurTime() > (Crate.LastDraw + 0.1) then
            zmlab2.Crate.UpdateMethMaterial(Crate)
        end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575

        Crate.LastDraw = CurTime()
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 904975b3b3dbe3f4337208147d7caa58bdde3c3feca3828dba7cf4a7246a8723

function zmlab2.Crate.UpdateMethMaterial(Crate)
    //zclib.Debug("zmlab2.Crate.UpdateMethMaterial")

    if Crate:GetMethAmount() <= 0 then return end
    if Crate:GetMethType() <= 0 then return end
    local MethMat = zmlab2.Meth.GetMaterial(Crate:GetMethType(),Crate:GetMethQuality())
    Crate:SetSubMaterial(0, "!" .. MethMat)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358
